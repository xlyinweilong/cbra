
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.Config;
import com.cbra.entity.Account;
import com.cbra.entity.Attendee;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.GatewayManualBankTransfer;
import com.cbra.entity.OrderCollection;
import com.cbra.entity.Plate;
import com.cbra.entity.SubCompanyAccount;
import com.cbra.entity.UserAccount;
import com.cbra.support.FileUploadItem;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.CompanyNatureEnum;
import com.cbra.support.enums.CompanyScaleEnum;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.OrderStatusEnum;
import com.cbra.support.enums.UserPosition;
import com.cbra.support.exception.AccountAlreadyExistException;
import com.cbra.support.exception.AccountNotExistException;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

/**
 * 账户服务层
 *
 * @author yin.weilong
 */
@Stateless
@LocalBean
public class MobileService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    private static final Logger logger = Logger.getLogger(MobileService.class.getName());
    @EJB
    private AccountService accountService;
    @EJB
    private EmailService emailService;
    @EJB
    private OrderService orderService;

    // **********************************************************************
    // ************* PUBLIC METHODS *****************************************
    // **********************************************************************
    public Account findByLoginCode(String loginCode) {
        Account user = null;
        try {
            TypedQuery<Account> query = em.createQuery("SELECT a FROM Account a WHERE a.loginCode = :loginCode and a.deleted = false", Account.class);
            query.setParameter("loginCode", loginCode);
            user = query.getSingleResult();
        } catch (NoResultException ex) {
            user = null;
        }
        return user;
    }

    private String createLoginCode(Long id) {
        return Tools.md5(id + "_" + System.currentTimeMillis() + "_" + Tools.generateRandom8Chars());
    }

    public String getUniqueLoginCode(Long id) {
        int maxCount = 10;
        String loginCode = this.createLoginCode(id);
        int i = 1;
        for (; i < maxCount && findByLoginCode(loginCode) != null; i++) {
            loginCode = this.createLoginCode(id);
        }
        if (i >= 10) {
            throw new RuntimeException("System Error");
        }
        return loginCode;
    }

    public Account getAccountForLoginMobile(String account, String passwd) throws AccountNotExistException {
        Account user = accountService.findByAccount(account);
        if (user == null || user.getStatus().equals(AccountStatus.APPROVAL_REJECT)) {
            throw new AccountNotExistException();
        }
        if (Tools.md5(passwd).equalsIgnoreCase(user.getPasswd())) {
            user.setLoginCode(this.getUniqueLoginCode(user.getId()));
            em.merge(user);
            return user;
        }
        return null;
    }

    public Plate findPlateByPage(String page) {
        Plate plate = null;
        try {
            TypedQuery<Plate> query = em.createQuery("SELECT a FROM Plate a WHERE a.page = :page", Plate.class);
            query.setParameter("page", page);
            plate = query.getSingleResult();
        } catch (NoResultException ex) {
            plate = null;
        }
        return plate;
    }

}
