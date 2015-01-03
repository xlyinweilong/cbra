
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import java.io.IOException;
import cn.yoopay.support.exception.YpLinkAlreadyExistException;
import cn.yoopay.support.exception.*;
import com.cbra.entity.UserAccount;
import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.Asynchronous;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author HUXIAOFENG
 */
@Stateless
@LocalBean
public class UserAccountService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    private static final Logger logger = Logger.getLogger(UserAccountService.class.getName());

    // **********************************************************************
    // ************* PUBLIC METHODS *****************************************
    // **********************************************************************
    // ******************************API ******************************//
//    public UserAccount getUserForLogin(String email, String passwd) {
//        email = email.toLowerCase();
//        UserAccount user = this.findByEmail(email);
//        if (null != user && null != passwd) {
//            if (user.isEnabled() && Tools.md5(passwd).equals(user.getPasswd())) {
//                //密码验证成功
//                if (Tools.isNotBlank(user.getInitPlainPasswd())) {
//                    user.setInitPlainPasswd(null);
//                    user = em.merge(user);
//                }
//                return user;
//            }
//        }
//        return null;
//    }
    public UserAccount findById(Long id) {
        return em.find(UserAccount.class, id);
    }

    public UserAccount findByVerifyUrl(String verifyUrl) {
        UserAccount user = null;
        try {
            TypedQuery<UserAccount> query = em.createNamedQuery("UserAccount.findByVerifyUrl", UserAccount.class);
            query.setParameter("verifyUrl", verifyUrl);
            user = query.getSingleResult();
        } catch (NoResultException ex) {
            user = null;
        }

        return user;
    }

    public UserAccount findByYpLinkId(String ypLinkId) {
        UserAccount user = null;
        try {
            TypedQuery<UserAccount> query = em.createNamedQuery("UserAccount.findByYpLinkId", UserAccount.class);
            query.setParameter("ypLinkId", ypLinkId);
            user = query.getSingleResult();
        } catch (NoResultException ex) {
            user = null;
        }
        return user;
    }

    public UserAccount setLanguage(Long uid, String language) {
        UserAccount userAccount = this.findById(uid);
        userAccount.setLanguage(language);
        return em.merge(userAccount);
    }

}
