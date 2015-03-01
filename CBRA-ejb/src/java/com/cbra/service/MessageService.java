
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
import javax.persistence.TypedQuery;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;

/**
 * 信息服务层
 *
 * @author yin.weilong
 */
@Stateless
@LocalBean
public class MessageService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    private static final Logger logger = Logger.getLogger(MessageService.class.getName());

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
    public List<Message> getPlateList4Web(List<PlateTypeEnum> types) {
        TypedQuery<Message> query = em.createQuery("SELECT message FROM Message message WHERE message.plateType IN :types ORDER BY plate.sortIndex ASC", Message.class);
        query.setParameter("types", types);
        return query.getResultList();
    }

    /**
     * 用户创建信息
     * 
     * @param account
     * @param plateId
     * @param content
     * @param targetUrl
     * @param fundCollectionId
     * @param plateInfoId
     * @param offerId
     * @param secretLevelEnum
     * @return 
     */
    public Message createMessageFromUser(Account account, Long plateId, String content,String targetUrl, Long fundCollectionId, Long plateInfoId, Long offerId, MessageSecretLevelEnum secretLevelEnum) {
        Message message = new Message();
        message.setAccount(account);
        message.setContent(content);
        message.setSecretLevel(secretLevelEnum);
        message.setPlate(adminService.findPlateById(plateId));
        message.setTargetUrl(targetUrl);
        if (fundCollectionId != null) {
            message.setFundCollection(adminService.findCollectionById(fundCollectionId));
        }
        if (plateInfoId != null) {
            message.setPlateInformation(adminService.findPlateInformationById(plateInfoId));
        }
        if (offerId != null) {
            message.setOffer(adminService.findOfferById(offerId));
        }
        em.persist(message);
        return message;
    }
    
}
