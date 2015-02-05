
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.entity.Account;
import com.cbra.entity.CompanyAccount;
import com.cbra.entity.SubCompanyAccount;
import com.cbra.entity.UserAccount;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.CompanyNatureEnum;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.exception.AccountAlreadyExistException;
import com.cbra.support.exception.AccountNotExistException;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;
import javax.ejb.EJB;
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

    @EJB
    private EmailService emailService;

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

    /**
     * 删除账户
     *
     * @param ids
     */
    public void deleteAccountByIds(String... ids) {
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            Account account = em.find(Account.class, Long.parseLong(id));
            account.setDeleted(Boolean.TRUE);
            em.merge(account);
        }
    }

    public SubCompanyAccount setSubCompanyAccount(String account, String passwd, String name, String email, String language, String address, String zipCode, String icPosition,
            CompanyAccount companyAccount) throws AccountAlreadyExistException {
        Account ua = this.findByAccount(account);
        SubCompanyAccount sub;
        if (ua == null) {
            sub = new SubCompanyAccount();
        } else {
            throw new AccountAlreadyExistException();
        }
        sub.setName(name);
        sub.setPasswd(Tools.md5(passwd));
        sub.setAddress(address);
        sub.setEmail(email);
        sub.setIcPosition(icPosition);
        sub.setUserLanguage(LanguageType.valueOf(name));
        sub.setZipCode(zipCode);
        sub.setCompanyAccount(companyAccount);
        em.persist(sub);
        return sub;
    }

    public UserAccount signupCompany(String account, String passwd, String name, String email, String language, String address, String zipCode, String icPosition,
            String enName, String personCardFront, String personCardBack, String personId, Date workingDate, String company,
            String position, String workExperience, String projectExperience) throws AccountAlreadyExistException {
        Account ua = this.findByAccount(account);
        UserAccount user;
        if (ua == null) {
            user = new UserAccount();
        } else {
            throw new AccountAlreadyExistException();
        }
        user.setName(name);
        user.setPasswd(Tools.md5(passwd));
        user.setAddress(address);
        user.setEmail(email);
        user.setIcPosition(icPosition);
        user.setUserLanguage(LanguageType.valueOf(name));
        user.setZipCode(zipCode);
        user.setCompany(company);
        user.setEnName(enName);
        user.setPersonCardBack(personCardBack);
        user.setPersonCardFront(personCardFront);
        user.setPersonId(personId);
        user.setPosition(position);
        user.setProjectExperience(projectExperience);
        user.setWorkExperience(workExperience);
        user.setWorkingDate(workingDate);
        String verifyUrl = getUniqueAccountVerifyUrl();
        user.setVerifyUrl(verifyUrl);
        em.persist(user);
        return user;
    }

    public CompanyAccount signupCompany(String account, String passwd, String name, String email, String language, String address, String zipCode, String icPosition,
            String legalPerson, Date companyCreateDate, CompanyNatureEnum nature, String scale, String webSide, String enterpriseQalityGrading,
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
        company.setVerifyUrl(verifyUrl);
        em.persist(company);
        return company;
    }

    /**
     * 获取公司账户的子账户数量
     *
     * @param companyAccountId
     * @return
     */
    public Long getSubCountByCompany(Long companyAccountId) {
        Long totalCount = null;
        try {
            TypedQuery<Long> query = em.createQuery("SELECT COUNT(s) FROM SubCompanyAccount s WHERE s.companyAccount.id = :companyAccountId and s.deleted = false", Long.class);
            query.setParameter("companyAccountId", companyAccountId);
            totalCount = query.getSingleResult();
        } catch (NoResultException ex) {
            totalCount = null;
        }
        return totalCount;
    }

    /**
     * 获取公司用户列表
     *
     * @param map
     * @param pageIndex
     * @param maxPerPage
     * @return
     */
    public ResultList<CompanyAccount> findCompanyList(Map<String, Object> map, int pageIndex, int maxPerPage) {
        ResultList<CompanyAccount> resultList = new ResultList<>();
        TypedQuery<Long> countQuery = em.createQuery("SELECT COUNT(c) FROM CompanyAccount c WHERE c.deleted = false ORDER BY c.createDate DESC", Long.class);
        Long totalCount = countQuery.getSingleResult();
        resultList.setTotalCount(totalCount.intValue());
        TypedQuery<CompanyAccount> query = em.createQuery("SELECT c FROM CompanyAccount c WHERE c.deleted = false ORDER BY c.createDate DESC", CompanyAccount.class);
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
     * 获取个人用户列表
     *
     * @param map
     * @param pageIndex
     * @param maxPerPage
     * @return
     */
    public ResultList<UserAccount> findUserList(Map<String, Object> map, int pageIndex, int maxPerPage) {
        ResultList<UserAccount> resultList = new ResultList<>();
        TypedQuery<Long> countQuery = em.createQuery("SELECT COUNT(u) FROM UserAccount u WHERE u.deleted = false ORDER BY u.createDate DESC", Long.class);
        Long totalCount = countQuery.getSingleResult();
        resultList.setTotalCount(totalCount.intValue());
        TypedQuery<UserAccount> query = em.createQuery("SELECT u FROM UserAccount u WHERE u.deleted = false ORDER BY u.createDate DESC", UserAccount.class);
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
     * 获取账户
     *
     * @param id
     * @return
     */
    public Account findById(Long id) {
        return em.find(Account.class, id);
    }

    /**
     * 审批账户
     *
     * @param id
     * @param status
     * @param message
     * @return
     */
    public Account approvalAccount(Long id, AccountStatus status, String message) {
        Account account = this.findById(id);
        account.setStatus(status);
        if (AccountStatus.APPROVAL_REJECT.equals(status)) {
            //发送拒绝邮件
            this.sendAccountApprovalFail(account, message);
        } else if (AccountStatus.ASSOCIATE_MEMBER.equals(status)) {
            //生成随机密码
            String passwd = Tools.generateRandom8Chars();
            account.setPasswd(passwd);
            //发送成功邮件
            this.sendAccountApprovalSuccess(account);
        }
        em.merge(account);
        return account;
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
     * 生成唯一的验证URL（算法有待提高）
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

    // **********************************************************************
    // ************* SEND EMAIL METHODS *****************************************
    // **********************************************************************
    /**
     * 发送注册成功邮件
     *
     * @param account
     */
    private void sendAccountApprovalSuccess(Account account) {
        String language = account.getUserLanguage().toString();
        String toEmail = account.getEmail();
        if (language == null || (!language.equalsIgnoreCase("zh") && !language.equalsIgnoreCase("en"))) {
            language = "zh";
        }
        language = language.toLowerCase();
        String fromDisplayName = "zh".equalsIgnoreCase(language) ? "友付" : "Yoopay";
        String fromEmail = "withdraw@yoopay.cn";
        String templateFile = "account_approval_success_" + language + ".html";
        String subject = "zh".equalsIgnoreCase(language) ? " 【账户注册成功通知】 " : " Withdraw Request Processed - YUAN RMB ";
        Map model = new HashMap();
        model.put("account", account);
        emailService.send(fromDisplayName, fromEmail, toEmail, subject, templateFile, model, null, null);
    }

    /**
     * 发送注册失败邮件
     *
     * @param account
     */
    private void sendAccountApprovalFail(Account account, String message) {
        String language = account.getUserLanguage().toString();
        String toEmail = account.getEmail();
        if (language == null || (!language.equalsIgnoreCase("zh") && !language.equalsIgnoreCase("en"))) {
            language = "zh";
        }
        language = language.toLowerCase();
        String fromDisplayName = "zh".equalsIgnoreCase(language) ? "友付" : "Yoopay";
        String fromEmail = "withdraw@yoopay.cn";
        String templateFile = "account_approval_fail_" + language + ".html";
        String subject = "zh".equalsIgnoreCase(language) ? " 【账户注册失败通知】 " : " Withdraw Request Processed - YUAN RMB ";
        Map model = new HashMap();
        model.put("account", account);
        if (Tools.isNotBlank(message)) {
            model.put("message", message);
            model.put("showMessage", true);
        }
        emailService.send(fromDisplayName, fromEmail, toEmail, subject, templateFile, model, null, null);
    }
}