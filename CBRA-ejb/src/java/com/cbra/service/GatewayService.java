
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.Config;
import com.cbra.entity.Account;
import com.cbra.entity.Attendee;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.FundCollection;
import com.cbra.entity.GatewayManualBankTransfer;
import com.cbra.entity.GatewayPayment;
import com.cbra.entity.Message;
import com.cbra.entity.Offer;
import com.cbra.entity.OrderCbraService;
import com.cbra.entity.OrderCollection;
import com.cbra.entity.OrderCollectionItem;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.entity.SubCompanyAccount;
import com.cbra.entity.SysUser;
import com.cbra.entity.UserAccount;
import com.cbra.support.FileUploadItem;
import com.cbra.support.ResultList;
import com.cbra.support.SearchInfo;
import com.cbra.support.Tools;
import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.CompanyNatureEnum;
import com.cbra.support.enums.CompanyScaleEnum;
import com.cbra.support.enums.GatewayPaymentSourceEnum;
import com.cbra.support.enums.GatewayPaymentStatusEnum;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.MessageSecretLevelEnum;
import com.cbra.support.enums.MessageTypeEnum;
import com.cbra.support.enums.OrderStatusEnum;
import com.cbra.support.enums.PaymentGatewayTypeEnum;
import com.cbra.support.enums.PlateAuthEnum;
import com.cbra.support.enums.PlateKeyEnum;
import com.cbra.support.enums.PlateTypeEnum;
import com.cbra.support.enums.SysUserTypeEnum;
import com.cbra.support.enums.UserPosition;
import com.cbra.support.exception.AccountAlreadyExistException;
import com.cbra.support.exception.AccountNotExistException;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import javax.ejb.Asynchronous;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

/**
 * 支付网关服务层
 *
 * @author yin.weilong
 */
@Stateless
@LocalBean
public class GatewayService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    private static final Logger logger = Logger.getLogger(GatewayService.class.getName());

    @EJB
    private EmailService emailService;
    @EJB
    private AdminService adminService;
    @EJB
    private OrderService orderService;

    // **********************************************************************
    // ************* PUBLIC METHODS *****************************************
    // **********************************************************************
    /**
     * 创建支付网关
     *
     * @param orderCollection
     * @param source
     * @param gatewayType
     * @return
     */
    public GatewayPayment createGatewayPayment(OrderCollection orderCollection, GatewayPaymentSourceEnum source, PaymentGatewayTypeEnum gatewayType) {
        GatewayPayment gatewayPayment = new GatewayPayment();
        gatewayPayment.setGatewayAmount(orderCollection.getAmount());
        gatewayPayment.setGatewayType(gatewayType);
        gatewayPayment.setOrderCollection(orderCollection);
        gatewayPayment.setSource(source);
        em.persist(gatewayPayment);
        em.flush();
        orderCollection.setGatewayPayment(gatewayPayment);
        em.merge(orderCollection);
        em.flush();
        return gatewayPayment;
    }

    /**
     * 创建支付网关
     *
     * @param orderCbraService
     * @param source
     * @param gatewayType
     * @return
     */
    public GatewayPayment createGatewayPayment(OrderCbraService orderCbraService, GatewayPaymentSourceEnum source, PaymentGatewayTypeEnum gatewayType) {
        GatewayPayment gatewayPayment = new GatewayPayment();
        gatewayPayment.setGatewayAmount(orderCbraService.getAmount());
        gatewayPayment.setGatewayType(gatewayType);
        gatewayPayment.setSource(source);
        gatewayPayment.setOrderCbraService(orderCbraService);
        em.persist(gatewayPayment);
        em.flush();
        orderCbraService.setLastGatewayPayment(gatewayPayment);
        em.merge(orderCbraService);
        em.flush();
        return gatewayPayment;
    }

    /**
     * 根据ID获取网关
     *
     * @param id
     * @return
     */
    public GatewayPayment findGatewayPaymentById(Long id) {
        return em.find(GatewayPayment.class, id);
    }

    /**
     * 创建银行转账
     *
     * @param gatewayPayment
     * @return
     */
    public GatewayManualBankTransfer createBankTransfer(GatewayPayment gatewayPayment) {
        GatewayManualBankTransfer bt = new GatewayManualBankTransfer();
        bt.setGatewayPayment(gatewayPayment);
        if (gatewayPayment.getOrderCollection() != null) {
            bt.setOrderCollection(gatewayPayment.getOrderCollection());
            em.persist(bt);
            OrderCollection order = gatewayPayment.getOrderCollection();
            order.setStatus(OrderStatusEnum.PENDING_PAYMENT_CONFIRM);
            em.merge(order);
        } else if (gatewayPayment.getOrderCbraService() != null) {
            bt.setOrderCbraService(gatewayPayment.getOrderCbraService());
            em.persist(bt);
            OrderCbraService order = gatewayPayment.getOrderCbraService();
            order.setStatus(OrderStatusEnum.PENDING_PAYMENT_CONFIRM);
            order.setLastGatewayPayment(gatewayPayment);
            em.merge(order);
        }
        return bt;
    }

    /**
     * 确认银行转账
     *
     * @param id
     */
    public void confirmBankTransfer(Long id) {
        GatewayManualBankTransfer bankTransfer = em.find(GatewayManualBankTransfer.class, id);
        GatewayPayment gatewayPayment = bankTransfer.getGatewayPayment();
        gatewayPayment.setPaymentDate(new Date());
        gatewayPayment.setPaymentGatewayMsg("银行转账成功！");
        gatewayPayment.setStatus(GatewayPaymentStatusEnum.PAYMENT_SUCCESS);
        em.merge(gatewayPayment);
        if (bankTransfer.getOrderCollection() != null) {
            OrderCollection order = bankTransfer.getOrderCollection();
            order.setEndDate(new Date());
            order.setStatus(OrderStatusEnum.SUCCESS);
            em.merge(order);
            //生成票
            orderService.sendOrderSuccessEmail(order);
        } else if (bankTransfer.getOrderCbraService() != null) {
            OrderCbraService order = bankTransfer.getOrderCbraService();
            order.setEndDate(new Date());
            order.setStatus(OrderStatusEnum.SUCCESS);
            em.merge(order);
            orderService.sendOrderSuccessEmail(order);
            Account account = order.getOwner();
            account.setStatus(AccountStatus.MEMBER);
            em.merge(account);
        }
    }

    public GatewayPayment setPaymentResult(String gatewayId, boolean result, String msg) {
        GatewayPayment gatewayPayment = this.findGatewayPaymentById(Long.parseLong(gatewayId));
        gatewayPayment.setPaymentDate(new Date());
        gatewayPayment.setPaymentGatewayMsg(msg);
        OrderCollection orderCollection = gatewayPayment.getOrderCollection();
        OrderCbraService orderCbraService = gatewayPayment.getOrderCbraService();
        if (result) {
            gatewayPayment.setStatus(GatewayPaymentStatusEnum.PAYMENT_SUCCESS);
            if (orderCollection != null) {
                orderCollection.setEndDate(new Date());
                orderCollection.setStatus(OrderStatusEnum.SUCCESS);
                orderService.sendOrderSuccessEmail(orderCollection);
            }
            if (orderCbraService != null) {
                orderCbraService.setEndDate(new Date());
                Account account = orderCbraService.getOwner();
                account.setPayDate(Tools.addYear(new Date(), 1));
                account.setStatus(AccountStatus.MEMBER);
                em.merge(account);
                orderCbraService.setStatus(OrderStatusEnum.SUCCESS);
            }
        } else {
            gatewayPayment.setStatus(GatewayPaymentStatusEnum.PAYMENT_CANCELED);
            if (orderCollection != null) {
                orderCollection.setStatus(OrderStatusEnum.FAILURE);
            }
            if (orderCbraService != null) {
                orderCbraService.setStatus(OrderStatusEnum.FAILURE);
            }
        }
        if (orderCollection != null) {
            em.merge(orderCollection);
        }
        if (orderCbraService != null) {
            em.merge(orderCbraService);
        }
        em.merge(gatewayPayment);
        return gatewayPayment;
    }

    // **********************************************************************
    // ************* SEND EMAIL METHODS *****************************************
    // **********************************************************************
}
