
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.entity.Account;
import com.cbra.entity.CompanyAccount;
import com.cbra.support.Tools;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.exception.AccountAlreadyExistException;
import com.cbra.support.exception.AccountNotExistException;
import java.util.Date;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

/**
 * 账户服务层
 *
 * @author yin.weilong
 */
@Stateless
@LocalBean
public class AccountService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    private static final Logger logger = Logger.getLogger(AccountService.class.getName());

    // **********************************************************************
    // ************* PUBLIC METHODS *****************************************
    // **********************************************************************
    /**
     * 登录
     *
     * @param account
     * @param passwd
     * @return
     * @throws AccountNotExistException
     */
    public Account getAccountForLogin(String account, String passwd) throws AccountNotExistException {
        Account user = this.findByAccount(account);
        if (user == null) {
            throw new AccountNotExistException();
        }
        if (!user.getPasswd().equalsIgnoreCase(Tools.md5(passwd))) {
            return user;
        }
        return null;
    }

    public CompanyAccount signupCompany(String account, String passwd, String name, String email, String language, String address, String zipCode, String icPosition,
            String legalPerson, Date companyCreateDate, String nature, String scale, String webSide, String enterpriseQalityGrading,
            Date authenticationDate, String productionLicenseNumber, Date productionLicenseValidDate, String field) throws AccountAlreadyExistException {
        Account user = this.findByAccount(account);
        CompanyAccount company;
        if (user == null) {
            company = new CompanyAccount();
        } else {
            throw new AccountAlreadyExistException();
        }
        company.setName(name);
        company.setPasswd(Tools.md5(passwd));
        company.setAddress(address);
        company.setEmail(email);
        company.setIcPosition(icPosition);
        company.setUserLanguage(LanguageType.valueOf(name));
        company.setZipCode(zipCode);
        company.setAuthenticationDate(authenticationDate);
        // company.setBusinessLicenseUrl(webSide);
        company.setEnterpriseQalityGrading(enterpriseQalityGrading);
        company.setField(field);
        company.setLegalPerson(legalPerson);
        company.setNature(nature);
        company.setProductionLicenseNumber(productionLicenseNumber);
        company.setProductionLicenseValidDate(productionLicenseValidDate);
        company.setScale(scale);
        company.setWebSide(webSide);
        String verifyUrl = getUniqueAccountVerifyUrl();
        user.setVerifyUrl(verifyUrl);
        em.persist(company);
        return company;
    }

    /**
     * 获取账户
     *
     * @param id
     * @return
     */
    public Account findById(Long id) {
        return em.find(Account.class, id);
    }

    /**
     * 根据账户获取账户
     *
     * @param account
     * @return
     */
    public Account findByAccount(String account) {
        Account user = null;
        try {
            TypedQuery<Account> query = em.createQuery("SELECT a FROM Account a WHERE a.account = :account and a.deleted = false", Account.class);
            query.setParameter("account", account);
            user = query.getSingleResult();
        } catch (NoResultException ex) {
            user = null;
        }
        return user;
    }

    /**
     * 根据验证URL获取用户
     *
     * @param verifyUrl
     * @return
     */
    public Account findByVerifyUrl(String verifyUrl) {
        Account user = null;
        try {
            TypedQuery<Account> query = em.createQuery("SELECT a FROM Account a WHERE a.verifyUrl = :verifyUrl and a.deleted = false", Account.class);
            query.setParameter("verifyUrl", verifyUrl);
            user = query.getSingleResult();
        } catch (NoResultException ex) {
            user = null;
        }
        return user;
    }

    /**
     * 设置账户语言
     *
     * @param uid
     * @param language
     * @return
     */
    public Account setLanguage(Long uid, String language) {
        Account account = this.findById(uid);
        try {
            account.setUserLanguage(LanguageType.valueOf(language));
        } catch (Exception e) {
        }
        return em.merge(account);
    }

    // **********************************************************************
    // ************* PRIVATE METHODS *****************************************
    // **********************************************************************
    /**
     * 生成唯一的验证URL
     *
     * @return
     */
    private String getUniqueAccountVerifyUrl() {
        int maxCount = 10;
        String verifyUrl = Tools.generateRandom8Chars();
        int i = 1;
        for (; i < maxCount && isExistAccount(verifyUrl); i++) {
            verifyUrl = Tools.generateRandom8Chars();
        }
        if (i >= 10) {
            throw new RuntimeException("System Error");
        }
        return verifyUrl;
    }

    /**
     * 账户是否存在
     *
     * @param verifyUrl
     * @return
     */
    private boolean isExistAccount(String verifyUrl) {
        Account account = findByVerifyUrl(verifyUrl);
        if (account == null) {
            return false;
        }
        return true;
    }

}
