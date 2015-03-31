
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
import com.cbra.entity.FundCollectionTicket;
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
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.MessageSecretLevelEnum;
import com.cbra.support.enums.MessageTypeEnum;
import com.cbra.support.enums.OrderStatusEnum;
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
 * 订单服务层
 *
 * @author yin.weilong
 */
@Stateless
@LocalBean
public class OrderService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    private static final Logger logger = Logger.getLogger(OrderService.class.getName());

    @EJB
    private EmailService emailService;
    @EJB
    private AdminService adminService;

    // **********************************************************************
    // ************* PUBLIC METHODS *****************************************
    // **********************************************************************
    /**
     * 获取支付账户成功的订单
     *
     * @param account
     * @param pageIndex
     * @param maxPerPage
     * @return
     */
    public ResultList<OrderCbraService> findOrderCbraServiceList(Account account, int pageIndex, int maxPerPage) {
        ResultList<OrderCbraService> resultList = new ResultList<>();
        TypedQuery<Long> countQuery = em.createQuery("SELECT COUNT(o) FROM OrderCbraService o WHERE o.owner =:owner AND o.deleted = false ORDER BY o.createDate DESC", Long.class);
        countQuery.setParameter("owner", account);
        Long totalCount = countQuery.getSingleResult();
        resultList.setTotalCount(totalCount.intValue());
        TypedQuery<OrderCbraService> query = em.createQuery("SELECT distinct(o) FROM OrderCbraService o WHERE o.owner =:owner AND o.deleted = false ORDER BY o.createDate DESC", OrderCbraService.class);
        query.setParameter("owner", account);
        int startIndex = (pageIndex - 1) * maxPerPage;
        query.setFirstResult(startIndex);
        query.setMaxResults(maxPerPage);
        resultList.setPageIndex(pageIndex);
        resultList.setStartIndex(startIndex);
        resultList.setMaxPerPage(maxPerPage);
        resultList.addAll(query.getResultList());
        return resultList;
    }

    /**
     * 创建收款订单
     *
     * @param account
     * @param fundCollection
     * @param attendeeeObjs
     * @return
     */
    public OrderCollection createOrderCollection(Account account, FundCollection fundCollection, Map<String, Object> attendeeeObjs) {
        OrderCollection oc = new OrderCollection();
        oc.setSerialId(this.getUniqueSerialId());
        oc.setStatus(OrderStatusEnum.PENDING_FOR_APPROVAL);
        oc.setFundCollection(fundCollection);
        oc.setOwner(account);
        if (account == null) {
            oc.setAmount(fundCollection.getTouristPrice());
            if (attendeeeObjs != null) {
                for (Map.Entry<String, Object> itemEntry : attendeeeObjs.entrySet()) {
                    Attendee attendee = (Attendee) itemEntry.getValue();
                    attendee.setCreateDate(new Date());
                    attendee.setDeleted(Boolean.FALSE);
                    attendee.setFundCollection(fundCollection);
                    attendee.setUserAccount(null);
                    attendee.setOrderCollection(oc);
                    em.persist(attendee);
                }
                oc.setAmount(fundCollection.getTouristPrice());
            }
        } else if (account instanceof UserAccount) {
            UserAccount user = (UserAccount) account;
            Attendee attendee = new Attendee();
            attendee.setFundCollection(fundCollection);
            attendee.setUserAccount(account);
            attendee.setOrderCollection(oc);
            attendee.setCompany(user.getCompany());
            attendee.setEmail(user.getEmail());
            attendee.setMobilePhone(user.getAccount());
            attendee.setName(user.getName());
            attendee.setPosition(user.getPosition().getMean());
            em.persist(attendee);
            account.setEnrolledCount(account.getEnrolledCount() + 1);
            em.merge(account);
            if (user.getStatus().equals(AccountStatus.MEMBER)) {
                oc.setAmount(fundCollection.getUserPrice());
            } else {
                oc.setAmount(fundCollection.getTouristPrice());
            }
        } else if (account instanceof CompanyAccount || account instanceof SubCompanyAccount) {
            if (account instanceof SubCompanyAccount) {
                account = ((SubCompanyAccount) account).getCompanyAccount();
            }
            account.setEnrolledCount(account.getEnrolledCount() + 1);
            em.merge(account);
            if (attendeeeObjs != null) {
                for (Map.Entry<String, Object> itemEntry : attendeeeObjs.entrySet()) {
                    Attendee attendee = (Attendee) itemEntry.getValue();
                    attendee.setCreateDate(new Date());
                    attendee.setDeleted(Boolean.FALSE);
                    attendee.setFundCollection(fundCollection);
                    attendee.setUserAccount(account);
                    attendee.setOrderCollection(oc);
                    em.persist(attendee);
                }
                if (account.getStatus().equals(AccountStatus.MEMBER)) {
                    int size = attendeeeObjs.keySet().size();
                    if (fundCollection.getEachCompanyFreeCount() - size >= 0) {
                        oc.setAmount(BigDecimal.ZERO);
                    } else {
                        int payCount = size - fundCollection.getEachCompanyFreeCount();
                        oc.setAmount(fundCollection.getCompanyPrice().multiply(new BigDecimal(payCount)));
                    }
                    oc.setAmount(fundCollection.getUserPrice());
                } else {
                    oc.setAmount(fundCollection.getTouristPrice());
                }
            }
        } else {
            throw new RuntimeException();
        }
        em.persist(oc);
        return oc;
    }

    /**
     * 创建订单
     *
     * @param account
     * @return
     */
    public OrderCbraService createOrderService(Account account) {
        OrderCbraService oc = new OrderCbraService();
        if (account instanceof UserAccount) {
            oc.setAmount(Config.MEMBERSHIP_FEE);
        } else {
            oc.setAmount(Config.MEMBERSHIP_FEE_COMPANY);
        }
        oc.setSerialId(this.getUniqueServiceSerialId());
        oc.setStatus(OrderStatusEnum.PENDING_FOR_APPROVAL);
        oc.setOwner(account);
        em.persist(oc);
        return oc;
    }

    /**
     * 获取订单集合
     *
     * @param map
     * @param pageIndex
     * @param maxPerPage
     * @param list
     * @param page
     * @return
     */
    public ResultList<OrderCollection> findOrderCollectionList(Map<String, Object> map, int pageIndex, int maxPerPage, Boolean list, Boolean page) {
        ResultList<OrderCollection> resultList = new ResultList<>();
        CriteriaBuilder builder = em.getCriteriaBuilder();
        CriteriaQuery<OrderCollection> query = builder.createQuery(OrderCollection.class);
        Root root = query.from(OrderCollection.class);
        List<Predicate> criteria = new ArrayList<>();
        criteria.add(builder.equal(root.get("deleted"), false));
        if (map.containsKey("fundCollectionId")) {
            criteria.add(builder.equal(root.get("fundCollection").get("id"), map.get("fundCollectionId")));
        }
        if (map.containsKey("owner")) {
            criteria.add(builder.equal(root.get("owner"), map.get("owner")));
        }
        if (map.containsKey("status")) {
            criteria.add(builder.equal(root.get("status"), map.get("status")));
        }
        try {
            if (list == null || !list) {
                CriteriaQuery<Long> countQuery = builder.createQuery(Long.class);
                countQuery.select(builder.count(root));
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    countQuery.where(criteria.get(0));
                } else {
                    countQuery.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                Long totalCount = em.createQuery(countQuery).getSingleResult();
                resultList.setTotalCount(totalCount.intValue());
            }
            if (list == null || list) {
                query = query.select(root);
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    query.where(criteria.get(0));
                } else {
                    query.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                query.orderBy(builder.desc(root.get("createDate")));
                TypedQuery<OrderCollection> typeQuery = em.createQuery(query);
                if (page != null && page) {
                    int startIndex = (pageIndex - 1) * maxPerPage;
                    typeQuery.setFirstResult(startIndex);
                    typeQuery.setMaxResults(maxPerPage);
                    resultList.setPageIndex(pageIndex);
                    resultList.setStartIndex(startIndex);
                    resultList.setMaxPerPage(maxPerPage);
                }
                List<OrderCollection> dataList = typeQuery.getResultList();
                resultList.addAll(dataList);
            }
        } catch (NoResultException ex) {
        }
        return resultList;
    }
    
    public ResultList<OrderCbraService> findOrderCbraServiceList(Map<String, Object> map, int pageIndex, int maxPerPage, Boolean list, Boolean page) {
        ResultList<OrderCbraService> resultList = new ResultList<>();
        CriteriaBuilder builder = em.getCriteriaBuilder();
        CriteriaQuery<OrderCbraService> query = builder.createQuery(OrderCbraService.class);
        Root root = query.from(OrderCbraService.class);
        List<Predicate> criteria = new ArrayList<>();
        criteria.add(builder.equal(root.get("deleted"), false));
        if (map.containsKey("owner")) {
            criteria.add(builder.equal(root.get("owner"), map.get("owner")));
        }
        if (map.containsKey("status")) {
            criteria.add(builder.equal(root.get("status"), map.get("status")));
        }
        try {
            if (list == null || !list) {
                CriteriaQuery<Long> countQuery = builder.createQuery(Long.class);
                countQuery.select(builder.count(root));
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    countQuery.where(criteria.get(0));
                } else {
                    countQuery.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                Long totalCount = em.createQuery(countQuery).getSingleResult();
                resultList.setTotalCount(totalCount.intValue());
            }
            if (list == null || list) {
                query = query.select(root);
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    query.where(criteria.get(0));
                } else {
                    query.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                query.orderBy(builder.desc(root.get("createDate")));
                TypedQuery<OrderCbraService> typeQuery = em.createQuery(query);
                if (page != null && page) {
                    int startIndex = (pageIndex - 1) * maxPerPage;
                    typeQuery.setFirstResult(startIndex);
                    typeQuery.setMaxResults(maxPerPage);
                    resultList.setPageIndex(pageIndex);
                    resultList.setStartIndex(startIndex);
                    resultList.setMaxPerPage(maxPerPage);
                }
                List<OrderCbraService> dataList = typeQuery.getResultList();
                resultList.addAll(dataList);
            }
        } catch (NoResultException ex) {
        }
        return resultList;
    }

    /**
     * 根据订单号获取
     *
     * @param serialId
     * @return
     */
    public OrderCollection findOrderCollectionSerialId(String serialId) {
        OrderCollection orderCollection = null;
        try {
            TypedQuery<OrderCollection> query = em.createQuery("SELECT o FROM OrderCollection o WHERE o.serialId = :serialId and o.deleted = false", OrderCollection.class);
            query.setParameter("serialId", serialId);
            orderCollection = query.getSingleResult();
        } catch (NoResultException ex) {
            orderCollection = null;
        }
        return orderCollection;
    }

    /**
     * 获取会费支付订单
     *
     * @param serialId
     * @return
     */
    public OrderCbraService findOrderCbraServiceSerialId(String serialId) {
        OrderCbraService orderCbraService = null;
        try {
            TypedQuery<OrderCbraService> query = em.createQuery("SELECT o FROM OrderCbraService o WHERE o.serialId = :serialId and o.deleted = false", OrderCbraService.class);
            query.setParameter("serialId", serialId);
            orderCbraService = query.getSingleResult();
        } catch (NoResultException ex) {
            orderCbraService = null;
        }
        return orderCbraService;
    }

    /**
     * 根据ID获取订单
     *
     * @param id
     * @return
     */
    public OrderCollection findOrderCollectionById(Long id) {
        return em.find(OrderCollection.class, id);
    }

    /**
     * 根据订单获取参会者
     *
     * @param orderId
     * @return
     */
    public List<Attendee> findAttendeeByOrder(Long orderId) {
        TypedQuery<Attendee> query = em.createQuery("SELECT a FROM Attendee a WHERE a.orderCollection.id = :orderId and a.deleted = false", Attendee.class);
        query.setParameter("orderId", orderId);
        return query.getResultList();
    }

    /**
     * 设置活动票
     *
     * @param order
     */
    @Asynchronous
    public void createFundCollectionTicketByOrder(OrderCollection order) {
        List<Attendee> attendeeList = this.findAttendeeByOrder(order.getId());
        FundCollection fundCollection = order.getFundCollection();
        long i = 0l;
        String ticketHead = this.getUniqueTicketBarcodeHead();
        for (Attendee attendee : attendeeList) {
            FundCollectionTicket ticket = new FundCollectionTicket();
            ticket.setFundCollection(fundCollection);
            String barcode = ticketHead + i + Tools.generateRandomNumber(4);
            ticket.setBarcodeHead(ticketHead);
            ticket.setBarcode(barcode);
            i++;
            ticket.setAttendee(attendee);
            ticket.setOrderCollection(order);
            em.persist(ticket);
            em.flush();
            attendee.setFundCollectionTicket(ticket);
            em.merge(attendee);
        }
    }

    /**
     * 根据barcode获取票
     *
     * @param barcode
     * @return
     */
    public FundCollectionTicket findFundCollectionTicketByBarcode(String barcode) {
        TypedQuery<FundCollectionTicket> query = em.createQuery("SELECT f FROM FundCollectionTicket f WHERE f.barcode = :barcode AND f.deleted = false AND f.invalid = false", FundCollectionTicket.class);
        query.setParameter("barcode", barcode);
        FundCollectionTicket ticket = null;
        try {
            ticket = query.getSingleResult();
        } catch (NoResultException e) {
            ticket = null;
        }
        return ticket;
    }

    /**
     * 根据订单获取门票
     *
     * @param orderId
     * @return
     */
    public List<FundCollectionTicket> findFundCollectionTicketListByOrderId(Long orderId) {
        TypedQuery<FundCollectionTicket> query = em.createQuery("SELECT f FROM FundCollectionTicket f WHERE f.orderCollection.id = :orderId and f.deleted = false AND f.invalid = false", FundCollectionTicket.class);
        query.setParameter("orderId", orderId);
        return query.getResultList();
    }

    /**
     * 发送订单成功邮件
     *
     * @param order
     */
    public void sendOrderSuccessEmail(OrderCollection order) {
        this.createFundCollectionTicketByOrder(order);
        String language = null;
        String toEmail = null;
        String name = null;
        if (order.getOwner() == null) {
            language = order.getFundCollection().getEventLanguage().toString();
            Attendee attendee = this.findAttendeeByOrder(order.getId()).get(0);
            toEmail = attendee.getEmail();
            name = attendee.getName();
        } else {
            Account account = order.getOwner();
            account.setJoinedCount(account.getJoinedCount() + 1);
            em.merge(account);
            language = order.getOwner().getUserLanguage().toString();
            toEmail = order.getOwner().getEmail();
            name = order.getOwner().getName();
        }
        if (language == null || (!language.equalsIgnoreCase("zh") && !language.equalsIgnoreCase("en"))) {
            language = "zh";
        }
        language = language.toLowerCase();
        String fromDisplayName = "zh".equalsIgnoreCase(language) ? "筑誉建筑联合会" : "CBRA";
        String fromEmail = Config.FROM_EMAIL;
        String templateFile = "order_success_" + language + ".html";
        String subject = "zh".equalsIgnoreCase(language) ? " 【订单成功通知】 " : " Withdraw Request Processed - YUAN RMB ";
        Map model = new HashMap();
        model.put("order", order);
        model.put("name", name);
        model.put("ticketList", this.findFundCollectionTicketListByOrderId(order.getId()));
        model.put("baseLink", Config.HTTP_URL_BASE);
        emailService.send(fromDisplayName, fromEmail, toEmail, subject, templateFile, model, null, null);
    }

    /**
     * 发送订单成功邮件
     *
     * @param order
     */
    public void sendOrderSuccessEmail(OrderCbraService order) {
        String language = order.getOwner().getUserLanguage().toString();
        String toEmail = order.getOwner().getEmail();
        String name = order.getOwner().getName();
        if (language == null || (!language.equalsIgnoreCase("zh") && !language.equalsIgnoreCase("en"))) {
            language = "zh";
        }
        language = language.toLowerCase();
        String fromDisplayName = "zh".equalsIgnoreCase(language) ? "筑誉建筑联合会" : "CBRA";
        String fromEmail = Config.FROM_EMAIL;
        String templateFile = "order_service_success_" + language + ".html";
        String subject = "zh".equalsIgnoreCase(language) ? " 【会员费支付成功通知】 " : " Withdraw Request Processed - YUAN RMB ";
        Map model = new HashMap();
        model.put("order", order);
        model.put("name", name);
        emailService.send(fromDisplayName, fromEmail, toEmail, subject, templateFile, model, null, null);
    }

    // **********************************************************************
    // ************* PRIVATE METHODS *****************************************
    // **********************************************************************
    /**
     * 生成唯一的订单号（算法有待提高）
     *
     * @return
     */
    private String getUniqueSerialId() {
        int maxCount = 10;
        String serialId = Tools.generateRandom8Chars();
        int i = 1;
        for (; i < maxCount && isExistOrderCollectionSerialId(serialId); i++) {
            serialId = Tools.generateRandom8Chars();
        }
        if (i >= 10) {
            throw new RuntimeException("System Error");
        }
        return serialId;
    }

    /**
     * 生成唯一的订单号
     *
     * @return
     */
    private String getUniqueServiceSerialId() {
        int maxCount = 10;
        String serialId = Tools.generateRandom8Chars();
        int i = 1;
        for (; i < maxCount && isExistOrderCbraServiceSerialId(serialId); i++) {
            serialId = Tools.generateRandom8Chars();
        }
        if (i >= 10) {
            throw new RuntimeException("System Error");
        }
        return serialId;
    }

    /**
     * 生成唯一的号码头
     *
     * @return
     */
    private String getUniqueTicketBarcodeHead() {
        int maxCount = 10;
        String serialId = Tools.generateRandom8Chars();
        int i = 1;
        for (; i < maxCount && isExistFundCollectionTicketBarcodeHead(serialId); i++) {
            serialId = Tools.generateRandom8Chars();
        }
        if (i >= 10) {
            throw new RuntimeException("System Error");
        }
        return serialId;
    }

    /**
     * 订单号是否存在
     *
     * @param serialId
     * @return
     */
    private boolean isExistOrderCollectionSerialId(String serialId) {
        OrderCollection orderCollection = findOrderCollectionSerialId(serialId);
        if (orderCollection == null) {
            return false;
        }
        return true;
    }

    /**
     * 订单是否存在
     *
     * @param serialId
     * @return
     */
    private boolean isExistOrderCbraServiceSerialId(String serialId) {
        OrderCbraService orderCbraService = findOrderCbraServiceSerialId(serialId);
        if (orderCbraService == null) {
            return false;
        }
        return true;
    }

    /**
     * 号码头是否存在
     *
     * @param barcodeHead
     * @return
     */
    private boolean isExistFundCollectionTicketBarcodeHead(String barcodeHead) {
        TypedQuery<FundCollectionTicket> query = em.createQuery("SELECT f FROM FundCollectionTicket f WHERE f.barcodeHead = :barcodeHead and f.deleted = false", FundCollectionTicket.class);
        query.setParameter("barcodeHead", barcodeHead);
        if (query.getResultList() == null || query.getResultList().size() < 1) {
            return false;
        }
        return true;
    }

}
