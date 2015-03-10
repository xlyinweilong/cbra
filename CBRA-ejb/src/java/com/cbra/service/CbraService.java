
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.Config;
import com.cbra.entity.Account;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.FundCollection;
import com.cbra.entity.Message;
import com.cbra.entity.Offer;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.entity.SubCompanyAccount;
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
import com.cbra.support.enums.PlateAuthEnum;
import com.cbra.support.enums.PlateKeyEnum;
import com.cbra.support.enums.PlateTypeEnum;
import com.cbra.support.enums.UserPosition;
import com.cbra.support.exception.AccountAlreadyExistException;
import com.cbra.support.exception.AccountNotExistException;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
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
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

/**
 * CBRA服务层
 *
 * @author yin.weilong
 */
@Stateless
@LocalBean
public class CbraService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    private static final Logger logger = Logger.getLogger(CbraService.class.getName());

    @EJB
    private EmailService emailService;
    @EJB
    private AdminService adminService;

    // **********************************************************************
    // ************* PUBLIC METHODS *****************************************
    // **********************************************************************
    /**
     * 获取plate
     *
     * @param types
     * @return
     */
    public List<Plate> getPlateList4Web(List<PlateTypeEnum> types) {
        TypedQuery<Plate> query = em.createQuery("SELECT plate FROM Plate plate WHERE plate.plateType IN :types ORDER BY plate.sortIndex ASC", Plate.class);
        query.setParameter("types", types);
        return query.getResultList();
    }

    /**
     * 获取plateId包含的SearchInfo
     *
     * @param ids
     * @param searchText
     * @param pageIndex
     * @param maxPerPage
     * @return
     */
    public ResultList<SearchInfo> findSearch(List<Long> ids, String searchText, int pageIndex, int maxPerPage) {
        StringBuilder sb = new StringBuilder();
        sb.append("(");
        for (Long id : ids) {
            sb.append(id);
            sb.append(",");
        }
        sb.delete(sb.length() - 1, sb.length());
        sb.append(")");
        ResultList<SearchInfo> resultList = new ResultList<>();
        Query countQuery = em.createNativeQuery("SELECT SUM(t.id) FROM (SELECT COUNT(plateInfo.id) as id FROM plate_information plateInfo WHERE plateInfo.plate_id IN " + sb.toString() + " AND plateInfo.title LIKE '%" + searchText + "%' UNION ALL SELECT COUNT(fundCollection.id) as id FROM fund_collection fundCollection WHERE fundCollection.plate_id IN " + sb.toString() + " AND fundCollection.title LIKE '%" + searchText + "%' UNION ALL SELECT COUNT(o.id) as id FROM offer o WHERE o.plate_id IN " + sb.toString() + " AND o.position LIKE '%" + searchText + "%') AS t");
        Long totalCount = ((BigDecimal) countQuery.getSingleResult()).longValue();
        resultList.setTotalCount(totalCount.intValue());
        Query query = em.createNativeQuery("SELECT plateInfo.id as id,plateInfo.title as title,plateInfo.plate_id as plateId,plateInfo.introduction as introduction FROM plate_information plateInfo WHERE plateInfo.plate_id IN " + sb.toString() + " AND plateInfo.title LIKE '%" + searchText + "%' UNION ALL SELECT fundCollection.id as id,fundCollection.title as title,fundCollection.plate_id as plateId,fundCollection.event_location as introduction FROM fund_collection fundCollection WHERE fundCollection.plate_id IN " + sb.toString() + " AND fundCollection.title LIKE '%" + searchText + "%' UNION ALL SELECT o.id as id,o.position as title,o.plate_id as plateId,o.city as introduction FROM offer o WHERE o.plate_id IN " + sb.toString() + " AND o.position LIKE '%" + searchText + "%'");
        int startIndex = (pageIndex - 1) * maxPerPage;
        query.setFirstResult(startIndex);
        query.setMaxResults(maxPerPage);
        resultList.setPageIndex(pageIndex);
        resultList.setStartIndex(startIndex);
        resultList.setMaxPerPage(maxPerPage);
        List<SearchInfo> list = new LinkedList<>();
        for (Object object : query.getResultList()) {
            SearchInfo si = new SearchInfo();
            Object[] o = (Object[]) object;
            si.setId((Long) o[0]);
            si.setTitle((String) o[1]);
            si.setPlateId((Long) o[2]);
            si.setIntroduction((String) o[3]);
            list.add(si);
        }
        resultList.addAll(list);
        return resultList;
    }

    /**
     * 获取热门新闻
     *
     * @param plate
     * @param maxResults
     * @return
     */
    public List<PlateInformation> getPlateInformationList4Hot(Plate plate, int maxResults) {
        TypedQuery<PlateInformation> query = em.createQuery("SELECT plateInfo FROM PlateInformation plateInfo WHERE plateInfo.plate = :plate AND plateInfo.deleted = false ORDER BY plateInfo.visitCount DESC", PlateInformation.class);
        query.setParameter("plate", plate);
        query.setMaxResults(maxResults);
        return query.getResultList();
    }

    /**
     * 获取热门新闻
     *
     * @param plate
     * @param maxResults
     * @return
     */
    public List<PlateInformation> getPlateInformationList4Index(Plate plate, int maxResults) {
        TypedQuery<PlateInformation> query = em.createQuery("SELECT plateInfo FROM PlateInformation plateInfo WHERE plateInfo.plate = :plate AND plateInfo.deleted = false ORDER BY plateInfo.pushDate DESC", PlateInformation.class);
        query.setParameter("plate", plate);
        query.setMaxResults(maxResults);
        return query.getResultList();
    }

    /**
     * 获取热门活动
     *
     * @param plate
     * @param maxResults
     * @return
     */
    public List<FundCollection> getFundCollectionList4Web(Plate plate, int maxResults) {
        TypedQuery<FundCollection> query = em.createQuery("SELECT fundCollection FROM FundCollection fundCollection WHERE fundCollection.plate = :plate AND fundCollection.deleted = false ORDER BY fundCollection.statusBeginDate DESC", FundCollection.class);
        query.setParameter("plate", plate);
        query.setMaxResults(maxResults);
        return query.getResultList();
    }

    /**
     * 获取首页信息
     *
     * @param plateKeyEnum
     * @param maxResults
     * @return
     */
    public List<PlateInformation> getPlateInformationList4Index(PlateKeyEnum plateKeyEnum, int maxResults) {
        TypedQuery<PlateInformation> query = em.createQuery("SELECT plateInfo FROM PlateInformation plateInfo WHERE plateInfo.plate.plateKey = :plateKeyEnum AND plateInfo.deleted = false ORDER BY plateInfo.pushDate DESC", PlateInformation.class);
        query.setParameter("plateKeyEnum", plateKeyEnum);
        query.setMaxResults(maxResults);
        return query.getResultList();
    }

    /**
     * 获取OFFER
     *
     * @param plate
     * @param maxResults
     * @return
     */
    public List<Offer> findOfferList4Hot(Plate plate, int maxResults) {
        TypedQuery<Offer> query = em.createQuery("SELECT offer FROM Offer offer WHERE offer.plate = :plate AND offer.deleted = false ORDER BY offer.pushDate DESC", Offer.class);
        query.setParameter("plate", plate);
        query.setMaxResults(maxResults);
        return query.getResultList();
    }

    /**
     * 获取前沿领域信息
     *
     * @param plateIds
     * @param maxResults
     * @return
     */
    public List<PlateInformation> findPlateInformationList4Hot(List<Long> plateIds, int maxResults) {
        TypedQuery<PlateInformation> query = em.createQuery("SELECT plateInfo FROM PlateInformation plateInfo WHERE plateInfo.plate.id IN :plateIds AND plateInfo.deleted = false ORDER BY plateInfo.pushDate DESC", PlateInformation.class);
        query.setParameter("plateIds", plateIds);
        query.setMaxResults(maxResults);
        return query.getResultList();
    }

    /**
     * 获取权限
     *
     * @param plate
     * @param account
     * @return
     */
    public PlateAuthEnum getPlateAuthEnum(Plate plate, Account account) {
        Account user = account;
        if (user != null && user instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) account).getCompanyAccount();
            account = user;
        }
        if (account == null) {
            return plate.getTouristAuth();
        } else if (!AccountStatus.MEMBER.equals(account.getStatus())) {
            return plate.getTouristAuth();
        } else if (account instanceof CompanyAccount) {
            return plate.getCompanyAuth();
        } else if (account instanceof UserAccount) {
            return plate.getUserAuth();
        } else {
            return plate.getTouristAuth();
        }
    }

    /**
     * 获取权限
     *
     * @param fundCollection
     * @param account
     * @return
     */
    public PlateAuthEnum getPlateAuthEnum(FundCollection fundCollection, Account account) {
        Account user = account;
        if (user != null && user instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) account).getCompanyAccount();
        }
        if (user == null) {
            return fundCollection.getTouristAuth();
        } else if (!AccountStatus.MEMBER.equals(user.getStatus())) {
            return fundCollection.getTouristAuth();
        } else if (user instanceof CompanyAccount) {
            return fundCollection.getCompanyAuth();
        } else if (user instanceof UserAccount) {
            return fundCollection.getUserAuth();
        } else {
            return fundCollection.getTouristAuth();
        }
    }

    /**
     * 获取账户能否报名活动
     *
     * @param fundCollection
     * @param account
     * @return
     */
    public boolean getAccountCanSignUpEvent(FundCollection fundCollection, Account account) {
        Account user = account;
        if (user != null && user instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) account).getCompanyAccount();
            account = user;
        }
        if (account == null || !AccountStatus.MEMBER.equals(account.getStatus())) {
            switch (fundCollection.getAllowAttendee()) {
                case PUBLIC:
                    return true;
                default:
                    return false;
            }
        } else if (account instanceof CompanyAccount) {
            return true;
        } else if (account instanceof UserAccount) {
            switch (fundCollection.getAllowAttendee()) {
                case PUBLIC:
                case ALL_MEMBERS:
                    return true;
                default:
                    return false;
            }
        } else {
            switch (fundCollection.getAllowAttendee()) {
                case PUBLIC:
                    return true;
                default:
                    return false;
            }
        }
    }

    /**
     * 获取信息
     *
     * @param plateInfo
     * @param account
     * @return
     */
    public List<Message> findMessageList(PlateInformation plateInfo, Account account) {
        Account user = account;
        if (user != null && user instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) account).getCompanyAccount();
            account = user;
        }
        List<MessageSecretLevelEnum> secretLevel = new LinkedList<>();
        TypedQuery<Message> query;
        if (account == null) {
            query = em.createQuery("SELECT message FROM Message message WHERE message.plateInformation = :plateInfo AND message.deleted = false AND message.secretLevel =:secretLevel ORDER BY message.createDate DESC", Message.class);
            query.setParameter("plateInfo", plateInfo).setParameter("secretLevel", MessageSecretLevelEnum.PUBLIC);
        } else if (account instanceof CompanyAccount) {
            secretLevel.add(MessageSecretLevelEnum.PUBLIC);
            secretLevel.add(MessageSecretLevelEnum.ALL_USER);
            secretLevel.add(MessageSecretLevelEnum.ONLY_COMPANY);
            query = em.createQuery("SELECT message FROM Message message WHERE message.plateInformation = :plateInfo AND message.deleted = false AND (message.secretLevel IN :secretLevelList OR (message.secretLevel =:secretLevel AND message.account = :account)) ORDER BY message.createDate DESC", Message.class);
            query.setParameter("plateInfo", plateInfo).setParameter("secretLevelList", secretLevel).setParameter("secretLevel", MessageSecretLevelEnum.PRIVATE).setParameter("account", account);
        } else {
            secretLevel.add(MessageSecretLevelEnum.PUBLIC);
            secretLevel.add(MessageSecretLevelEnum.ALL_USER);
            query = em.createQuery("SELECT message FROM Message message WHERE message.plateInformation = :plateInfo AND message.deleted = false AND (message.secretLevel IN :secretLevelList OR (message.secretLevel =:secretLevel AND message.account = :account)) ORDER BY message.createDate DESC", Message.class);
            query.setParameter("plateInfo", plateInfo).setParameter("secretLevel", MessageSecretLevelEnum.PRIVATE).setParameter("account", account);
        }
        return query.getResultList();
    }

    /**
     * 获取信息
     *
     * @param fundCollection
     * @param type
     * @param account
     * @return
     */
    public List<Message> findMessageList(FundCollection fundCollection, MessageTypeEnum type, Account account) {
        Account user = account;
        if (user != null && user instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) account).getCompanyAccount();
            account = user;
        }
        List<MessageSecretLevelEnum> secretLevel = new LinkedList<>();
        TypedQuery<Message> query;
        if (account == null) {
            query = em.createQuery("SELECT message FROM Message message WHERE message.fundCollection = :fundCollection AND message.deleted = false AND message.secretLevel =:secretLevel ORDER BY message.createDate DESC", Message.class);
            query.setParameter("fundCollection", fundCollection).setParameter("secretLevel", MessageSecretLevelEnum.PUBLIC);
        } else if (account instanceof CompanyAccount) {
            secretLevel.add(MessageSecretLevelEnum.PUBLIC);
            secretLevel.add(MessageSecretLevelEnum.ALL_USER);
            secretLevel.add(MessageSecretLevelEnum.ONLY_COMPANY);
            query = em.createQuery("SELECT message FROM Message message WHERE message.fundCollection = :fundCollection AND message.deleted = false AND (message.secretLevel IN :secretLevelList OR (message.secretLevel =:secretLevel AND message.account = :account)) ORDER BY message.createDate DESC", Message.class);
            query.setParameter("fundCollection", fundCollection).setParameter("secretLevelList", secretLevel).setParameter("secretLevel", MessageSecretLevelEnum.PRIVATE).setParameter("account", account);
        } else {
            secretLevel.add(MessageSecretLevelEnum.PUBLIC);
            secretLevel.add(MessageSecretLevelEnum.ALL_USER);
            query = em.createQuery("SELECT message FROM Message message WHERE message.fundCollection = :fundCollection AND message.deleted = false AND (message.secretLevel IN :secretLevelList OR (message.secretLevel =:secretLevel AND message.account = :account)) ORDER BY message.createDate DESC", Message.class);
            query.setParameter("fundCollection", fundCollection).setParameter("secretLevel", MessageSecretLevelEnum.PRIVATE).setParameter("account", account);
        }
        return query.getResultList();
    }

    /**
     * 获取信息
     *
     * @param offer
     * @param type
     * @param account
     * @return
     */
    public List<Message> findMessageList(Offer offer, MessageTypeEnum type, Account account) {
        Account user = account;
        if (user != null && user instanceof SubCompanyAccount) {
            user = ((SubCompanyAccount) account).getCompanyAccount();
            account = user;
        }
        List<MessageSecretLevelEnum> secretLevel = new LinkedList<>();
        TypedQuery<Message> query;
        if (account == null) {
            query = em.createQuery("SELECT message FROM Message message WHERE message.offer = :offer AND message.type = :type AND message.deleted = false AND message.secretLevel =:secretLevel ORDER BY message.createDate DESC", Message.class);
            query.setParameter("offer", offer).setParameter("type", type).setParameter("secretLevel", MessageSecretLevelEnum.PUBLIC);
        } else if (account instanceof CompanyAccount) {
            secretLevel.add(MessageSecretLevelEnum.PUBLIC);
            secretLevel.add(MessageSecretLevelEnum.ALL_USER);
            secretLevel.add(MessageSecretLevelEnum.ONLY_COMPANY);
            query = em.createQuery("SELECT message FROM Message message WHERE message.offer = :offer AND message.type = :type AND message.deleted = false AND (message.secretLevel IN :secretLevelList OR (message.secretLevel =:secretLevel AND message.account = :account)) ORDER BY message.createDate DESC", Message.class);
            query.setParameter("offer", offer).setParameter("type", type).setParameter("secretLevelList", secretLevel).setParameter("secretLevel", MessageSecretLevelEnum.PRIVATE).setParameter("account", account);
        } else {
            secretLevel.add(MessageSecretLevelEnum.PUBLIC);
            secretLevel.add(MessageSecretLevelEnum.ALL_USER);
            query = em.createQuery("SELECT message FROM Message message WHERE message.offer = :offer AND message.type = :type AND message.deleted = false AND (message.secretLevel IN :secretLevelList OR (message.secretLevel =:secretLevel AND message.account = :account)) ORDER BY message.createDate DESC", Message.class);
            query.setParameter("offer", offer).setParameter("type", type).setParameter("secretLevel", MessageSecretLevelEnum.PRIVATE).setParameter("account", account);
        }
        return query.getResultList();
    }

    /**
     * 异步曾加访问数量
     *
     * @param plateInfoId
     */
    @Asynchronous
    public void addPlateVisitCount(Long plateInfoId) {
        PlateInformation plateInfo = adminService.findPlateInformationById(plateInfoId);
        plateInfo.setVisitCount(plateInfo.getVisitCount() + 1L);
        em.merge(plateInfo);
    }
}
