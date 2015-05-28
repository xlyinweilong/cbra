
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
import java.util.logging.Level;
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
public class AccountService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    private static final Logger logger = Logger.getLogger(AccountService.class.getName());

    @EJB
    private EmailService emailService;
    @EJB
    private OrderService orderService;

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
        if (user == null || user.getStatus().equals(AccountStatus.APPROVAL_REJECT)) {
            throw new AccountNotExistException();
        }
        if (Tools.md5(passwd).equalsIgnoreCase(user.getPasswd())) {
            return user;
        }
        return null;
    }

    /**
     * 获取到期的用户
     *
     * @return
     */
    public List<Account> findAccountExpireList() {
        return this.findAccountExpireList(new Date());
    }

    public List<Account> findAccountExpireList(Date date) {
        TypedQuery<Account> query = em.createQuery("SELECT a FROM Account a WHERE a.status = :status AND a.payDate < :nowDate and a.deleted = false", Account.class);
        query.setParameter("nowDate", date).setParameter("status", AccountStatus.MEMBER);
        return query.getResultList();
    }

    /**
     * 通过公司账户获取子账户
     *
     * @param companyAccount
     * @return
     */
    public List<SubCompanyAccount> getSubCompanyAccountList(CompanyAccount companyAccount) {
        TypedQuery<SubCompanyAccount> query = em.createQuery("SELECT a FROM SubCompanyAccount a WHERE a.companyAccount = :companyAccount and a.deleted = false", SubCompanyAccount.class);
        query.setParameter("companyAccount", companyAccount);
        return query.getResultList();
    }

    /**
     * 保存上传文件到临时文件夹，临时文件夹定时会被清理
     *
     * @param item
     * @return
     */
    public String setUploadFileToTemp(FileUploadItem item) {
        String savePath = Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_TEMP;
        File saveDirFile1 = new File(savePath);
        if (!saveDirFile1.exists()) {
            saveDirFile1.mkdirs();
        }
        String filename = Tools.formatDate(new Date(), "yyyyMMddHHmmss" + "_" + Tools.generateRandomNumber(5)) + "." + FilenameUtils.getExtension(item.getUploadFileName());
        Tools.setUploadFile(item, savePath + "/", filename);
        return Config.HTTP_URL_BASE + Config.FILE_UPLOAD_TEMP + "/" + filename;
    }

    /**
     * 删除账户
     *
     * @param ids
     */
    public void deleteAccountByIds(String[] ids) {
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            Account account = em.find(Account.class, Long.parseLong(id));
            account.setDeleted(Boolean.TRUE);
            em.merge(account);
        }
    }

    /**
     * 删除银行转账
     *
     * @param ids
     */
    public void deleteBankTransferByIds(String... ids) {
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            GatewayManualBankTransfer bankTransfer = em.find(GatewayManualBankTransfer.class, Long.parseLong(id));
            bankTransfer.setDeleted(Boolean.TRUE);
            em.merge(bankTransfer);
        }
    }

    /**
     * 设置公司账户子账户
     *
     * @param account
     * @param passwd
     * @param name
     * @param email
     * @param language
     * @param address
     * @param zipCode
     * @param icPosition
     * @param companyAccount
     * @return
     * @throws AccountAlreadyExistException
     */
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

    /**
     * 更新个人资料
     *
     * @param id
     * @param item
     * @param enName
     * @param up
     * @param others
     * @param company
     * @param workingYear
     * @param workExperience
     * @param projectExperience
     * @param address
     * @param zipCode
     * @param icPosition
     * @param email
     * @return
     */
    public UserAccount updateUserAccount(Long id, FileUploadItem item, String enName, UserPosition up, String others, String company, Integer workingYear, String workExperience, String projectExperience, String address, String zipCode, String icPosition, String email) {
        UserAccount user = (UserAccount) this.findById(id);
        user.setCompany(company);
        user.setEnName(enName);
        user.setPosition(up);
        user.setPositionOthers(others);
        user.setWorkExperience(workExperience);
        user.setWorkingYear(workingYear);
        user.setProjectExperience(projectExperience);
        user.setIcPosition(icPosition);
        user.setAddress(address);
        user.setZipCode(zipCode);
        user.setEmail(email);
        //上传文件
        if (item != null) {
            String savePath = Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_ACCOUNT_HEAD_IMAGE;
            File saveDirFile1 = new File(savePath);
            if (!saveDirFile1.exists()) {
                saveDirFile1.mkdirs();
            }
            String filename = Tools.formatDate(new Date(), "yyyyMMddHHmmss" + "_" + Tools.generateRandomNumber(5)) + "." + FilenameUtils.getExtension(item.getUploadFileName());
            Tools.setUploadFile(item, savePath + "/", filename);
            user.setHeadImageUrl("/" + Config.FILE_UPLOAD_ACCOUNT_HEAD_IMAGE + "/" + filename);
        }
        em.merge(user);
        return user;
    }

    /**
     * 上传头像
     *
     * @param uid
     * @param iamge
     * @param suffix
     * @return
     */
    public Account uploadHearIamge(Long uid, String iamge, String suffix) {
        Account uccount = em.find(Account.class, uid);
        String savePath = Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_ACCOUNT_HEAD_IMAGE;
        File saveDirFile1 = new File(savePath);
        if (!saveDirFile1.exists()) {
            saveDirFile1.mkdirs();
        }
        String filename = Tools.formatDate(new Date(), "yyyyMMddHHmmss") + "_" + Tools.generateRandomNumber(5) + "." + suffix;
        try {
            Tools.generateImage(iamge, savePath + "/" + filename);
        } catch (Exception ex) {
            Logger.getLogger(AccountService.class.getName()).log(Level.SEVERE, null, ex);
        }
        uccount.setHeadImageUrl("/" + Config.FILE_UPLOAD_ACCOUNT_HEAD_IMAGE + "/" + filename);
        em.merge(uccount);
        return uccount;
    }

    /**
     * 更新公司用户
     *
     * @param id
     * @param item
     * @param scale
     * @param address
     * @param zipCode
     * @param icPosition
     * @return
     */
    public CompanyAccount updateCompanyAccount(Long id, FileUploadItem item, CompanyScaleEnum scale, String address, String zipCode, String icPosition) {
        CompanyAccount company = (CompanyAccount) this.findById(id);
        company.setScale(scale);
        company.setIcPosition(icPosition);
        company.setAddress(address);
        company.setZipCode(zipCode);
        //上传文件
        if (item != null) {
            String savePath = Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_ACCOUNT_HEAD_IMAGE;
            File saveDirFile1 = new File(savePath);
            if (!saveDirFile1.exists()) {
                saveDirFile1.mkdirs();
            }
            String filename = Tools.formatDate(new Date(), "yyyyMMddHHmmss" + "_" + Tools.generateRandomNumber(5)) + "." + FilenameUtils.getExtension(item.getUploadFileName());
            Tools.setUploadFile(item, savePath + "/", filename);
            company.setHeadImageUrl("/" + Config.FILE_UPLOAD_ACCOUNT_HEAD_IMAGE + "/" + filename);
        }
        em.merge(company);
        return company;
    }

    /**
     * 注册用户
     *
     * @param account
     * @param name
     * @param email
     * @param language
     * @param address
     * @param zipCode
     * @param icPosition
     * @param enName
     * @param personCardFront
     * @param personCardBack
     * @param workingYear
     * @param company
     * @param position
     * @param others
     * @param workExperience
     * @param projectExperience
     * @return
     * @throws AccountAlreadyExistException
     * @throws IOException
     */
    public UserAccount signupUser(String account, String name, String email, String language, String address, String zipCode, String icPosition,
            String enName, String personCardFront, String personCardBack, int workingYear, String company,
            UserPosition position, String others, String workExperience, String projectExperience) throws AccountAlreadyExistException, IOException {
        Account ua = this.findByAccount(account);
        UserAccount user;
        if (ua == null) {
            user = new UserAccount();
        } else if (ua.getStatus().equals(AccountStatus.APPROVAL_REJECT)) {
            user = (UserAccount) ua;
        } else {
            throw new AccountAlreadyExistException();
        }
        user.setCreateDate(new Date());
        user.setStatus(AccountStatus.PENDING_FOR_APPROVAL);
        user.setAccount(account);
        user.setName(name);
        user.setAddress(address);
        user.setEmail(email);
        user.setIcPosition(icPosition);
        try {
            user.setUserLanguage(LanguageType.valueOf(language));
        } catch (Exception e) {
            user.setUserLanguage(LanguageType.ZH);
        }
        user.setZipCode(zipCode);
        user.setCompany(company);
        user.setEnName(enName);
        //处理图片
        personCardBack = personCardBack.substring(Config.HTTP_URL_BASE.length() + Config.FILE_UPLOAD_TEMP.length() + 1);
        FileUtils.copyFile(new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_TEMP + "/" + personCardBack), new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_ACCOUNT + "/" + personCardBack));
        FileUtils.deleteQuietly(new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_TEMP + "/" + personCardBack));
        user.setPersonCardBack("/" + Config.FILE_UPLOAD_ACCOUNT + "/" + personCardBack);
        personCardFront = personCardFront.substring(Config.HTTP_URL_BASE.length() + Config.FILE_UPLOAD_TEMP.length() + 1);
        FileUtils.copyFile(new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_TEMP + "/" + personCardFront), new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_ACCOUNT + "/" + personCardFront));
        FileUtils.deleteQuietly(new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_TEMP + "/" + personCardFront));
        user.setPersonCardFront("/" + Config.FILE_UPLOAD_ACCOUNT + "/" + personCardFront);
        user.setPosition(position);
        user.setPositionOthers(others);
        user.setProjectExperience(projectExperience);
        user.setWorkExperience(workExperience);
        user.setWorkingYear(workingYear);
        String verifyUrl = getUniqueAccountVerifyUrl();
        user.setVerifyUrl(verifyUrl);
        em.persist(user);
        return user;
    }

    /**
     * 设置附属账户密码
     *
     * @param id
     * @param parentId
     * @param account
     * @param passwd
     * @throws AccountAlreadyExistException
     */
    public void setSubCompany(Long id, Long parentId, String account, String passwd) throws AccountAlreadyExistException {
        SubCompanyAccount sub;
        Account a = this.findByAccount(account);
        if (id == null) {
            sub = new SubCompanyAccount();
            if (a != null) {
                throw new AccountAlreadyExistException();
            }
        } else {
            sub = (SubCompanyAccount) this.findById(id);
            if (a != null && !a.getAccount().equals(sub.getAccount())) {
                throw new AccountAlreadyExistException();
            }
        }
        CompanyAccount ca = (CompanyAccount) this.findById(parentId);
        sub.setCompanyAccount(ca);
        sub.setPasswd(Tools.md5(passwd));
        sub.setAccount(account);
        if (id == null) {
            em.persist(sub);
        } else {
            em.merge(sub);
        }
    }

    /**
     * 修改密码
     *
     * @param id
     * @param newpasswd
     */
    public void changePasswd(Long id, String newpasswd) {
        Account account = this.findById(id);
        account.setPasswd(Tools.md5(newpasswd));
        em.merge(account);
    }

    /**
     * 更新用户信息
     *
     * @param id
     * @param account
     * @param passwd
     * @param name
     * @param email
     * @param address
     * @param zipCode
     * @param icPosition
     * @param enName
     * @param workingYear
     * @param company
     * @param position
     * @param others
     * @param workExperience
     * @param projectExperience
     * @return
     * @throws AccountAlreadyExistException
     */
    public UserAccount updateUserAccount(Long id, String account, String passwd, String name, String email, String address, String zipCode, String icPosition,
            String enName, Integer workingYear, String company,
            UserPosition position, String others, String workExperience, String projectExperience) throws AccountAlreadyExistException {
        Account ua = this.findByAccount(account);
        UserAccount user;
        if (ua != null && !ua.getId().equals(id)) {
            throw new AccountAlreadyExistException();
        }
        user = (UserAccount) this.findById(id);
        if (Tools.isNotBlank(passwd)) {
            user.setPasswd(Tools.md5(passwd));
        }
        user.setAccount(account);
        user.setName(name);
        user.setAddress(address);
        user.setEmail(email);
        user.setIcPosition(icPosition);
        user.setZipCode(zipCode);
        user.setCompany(company);
        user.setEnName(enName);
        user.setPosition(position);
        user.setPositionOthers(others);
        user.setProjectExperience(projectExperience);
        user.setWorkExperience(workExperience);
        user.setWorkingYear(workingYear);
        return em.merge(user);
    }

    /**
     * 公司账户更新
     *
     * @param id
     * @param account
     * @param passwd
     * @param name
     * @param email
     * @param address
     * @param zipCode
     * @param icPosition
     * @param companyCreateDate
     * @param legalPerson
     * @param webSide
     * @param enterpriseQalityGrading
     * @param authenticationDate
     * @param productionLicenseNumber
     * @param productionLicenseValidDate
     * @param nature
     * @param natureOthers
     * @param scale
     * @return
     * @throws AccountAlreadyExistException
     */
    public CompanyAccount updateCompanyAccount(Long id, String account, String passwd, String name, String email, String address, String zipCode, String icPosition,
            Date companyCreateDate, String legalPerson, String webSide, String enterpriseQalityGrading, Date authenticationDate, String productionLicenseNumber, Date productionLicenseValidDate,
            CompanyNatureEnum nature, String natureOthers, CompanyScaleEnum scale) throws AccountAlreadyExistException {
        Account ua = this.findByAccount(account);
        CompanyAccount company;
        if (ua != null && !ua.getId().equals(id)) {
            throw new AccountAlreadyExistException();
        }
        company = (CompanyAccount) this.findById(id);
        if (Tools.isNotBlank(passwd)) {
            company.setPasswd(Tools.md5(passwd));
        }
        company.setAccount(account);
        company.setName(name);
        company.setAddress(address);
        company.setEmail(email);
        company.setIcPosition(icPosition);
        company.setZipCode(zipCode);
        company.setCompanyCreateDate(companyCreateDate);
        company.setLegalPerson(legalPerson);
        company.setWebSide(webSide);
        company.setEnterpriseQalityGrading(enterpriseQalityGrading);
        company.setAuthenticationDate(authenticationDate);
        company.setProductionLicenseNumber(productionLicenseNumber);
        company.setProductionLicenseValidDate(productionLicenseValidDate);
        company.setNature(nature);
        company.setNatureOthers(natureOthers);
        company.setScale(scale);
        return em.merge(company);
    }

    /**
     * 公司账户注册
     *
     * @param account
     * @param name
     * @param email
     * @param language
     * @param address
     * @param zipCode
     * @param icPosition
     * @param legalPerson
     * @param companyCreateDate
     * @param nature
     * @param natureOthers
     * @param scale
     * @param webSide
     * @param enterpriseQalityGrading
     * @param authenticationDate
     * @param productionLicenseNumber
     * @param productionLicenseValidDateStart
     * @param productionLicenseValidDate
     * @param field
     * @param businessLicenseUrl
     * @param qualificationCertificateUrl
     * @param qalityCode
     * @return
     * @throws AccountAlreadyExistException
     * @throws IOException
     */
    public CompanyAccount signupCompany(String account, String name, String email, String language, String address, String zipCode, String icPosition,
            String legalPerson, Date companyCreateDate, CompanyNatureEnum nature, String natureOthers, CompanyScaleEnum scale, String webSide, String enterpriseQalityGrading,
            Date authenticationDate, String productionLicenseNumber, Date productionLicenseValidDateStart, Date productionLicenseValidDate, String field,
            String businessLicenseUrl, String qualificationCertificateUrl, String qalityCode) throws AccountAlreadyExistException, IOException {
        Account user = this.findByAccount(account);
        CompanyAccount company;
        if (user == null) {
            company = new CompanyAccount();
        } else if (user.getStatus().equals(AccountStatus.APPROVAL_REJECT)) {
            company = (CompanyAccount) user;
        } else {
            throw new AccountAlreadyExistException();
        }
        company.setCreateDate(new Date());
        company.setStatus(AccountStatus.PENDING_FOR_APPROVAL);
        company.setQalityCode(qalityCode);
        company.setAccount(account);
        company.setName(name);
        company.setAddress(address);
        company.setEmail(email);
        company.setIcPosition(icPosition);
        company.setCompanyCreateDate(companyCreateDate);
        company.setZipCode(zipCode);
        company.setAuthenticationDate(authenticationDate);
        company.setEnterpriseQalityGrading(enterpriseQalityGrading);
        company.setField(field);
        try {
            company.setUserLanguage(LanguageType.valueOf(language));
        } catch (Exception e) {
            company.setUserLanguage(LanguageType.ZH);
        }
        company.setLegalPerson(legalPerson);
        company.setNature(nature);
        company.setNatureOthers(natureOthers);
        company.setProductionLicenseNumber(productionLicenseNumber);
//        company.
        company.setProductionLicenseValidDate(productionLicenseValidDate);
        company.setScale(scale);
        company.setWebSide(webSide);
        //处理图片
        businessLicenseUrl = businessLicenseUrl.substring(Config.HTTP_URL_BASE.length() + Config.FILE_UPLOAD_TEMP.length() + 1);
        FileUtils.copyFile(new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_TEMP + "/" + businessLicenseUrl), new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_ACCOUNT + "/" + businessLicenseUrl));
        FileUtils.deleteQuietly(new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_TEMP + "/" + businessLicenseUrl));
        company.setBusinessLicenseUrl("/" + Config.FILE_UPLOAD_ACCOUNT + "/" + businessLicenseUrl);
        if (Tools.isNotBlank(qualificationCertificateUrl)) {
            qualificationCertificateUrl = qualificationCertificateUrl.substring(Config.HTTP_URL_BASE.length() + Config.FILE_UPLOAD_TEMP.length() + 1);
            FileUtils.copyFile(new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_TEMP + "/" + qualificationCertificateUrl), new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_ACCOUNT + "/" + qualificationCertificateUrl));
            FileUtils.deleteQuietly(new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_TEMP + "/" + qualificationCertificateUrl));
            company.setQualificationCertificateUrl("/" + Config.FILE_UPLOAD_ACCOUNT + "/" + qualificationCertificateUrl);
        }
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
        String sql = "FROM CompanyAccount c WHERE c.deleted = false ";
        if (map.containsKey("searchName")) {
            sql += "AND c.name LIKE :searchName";
        }
        TypedQuery<Long> countQuery = em.createQuery("SELECT COUNT(c) " + sql + " ORDER BY c.createDate DESC", Long.class);
        if (map.containsKey("searchName")) {
            countQuery.setParameter("searchName", "%" + map.get("searchName").toString() + "%");
        }
        Long totalCount = countQuery.getSingleResult();
        resultList.setTotalCount(totalCount.intValue());
        TypedQuery<CompanyAccount> query = em.createQuery("SELECT c " + sql + " ORDER BY c.createDate DESC", CompanyAccount.class);
        if (map.containsKey("searchName")) {
            query.setParameter("searchName", "%" + map.get("searchName").toString() + "%");
        }
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
        String sql = "FROM UserAccount u WHERE u.deleted = false ";
        if (map.containsKey("searchName")) {
            sql += "AND u.name LIKE :searchName";
        }
        TypedQuery<Long> countQuery = em.createQuery("SELECT COUNT(u) " + sql + " ORDER BY u.createDate DESC", Long.class);
        if (map.containsKey("searchName")) {
            countQuery.setParameter("searchName", "%" + map.get("searchName").toString() + "%");
        }
        Long totalCount = countQuery.getSingleResult();
        resultList.setTotalCount(totalCount.intValue());
        TypedQuery<UserAccount> query = em.createQuery("SELECT u " + sql + " ORDER BY u.createDate DESC", UserAccount.class);
        if (map.containsKey("searchName")) {
            query.setParameter("searchName", "%" + map.get("searchName").toString() + "%");
        }
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
        account.setApprovalInformation(message);
        if (AccountStatus.APPROVAL_REJECT.equals(status)) {
            //发送拒绝邮件
            this.sendAccountApprovalFail(account, message);
        } else if (AccountStatus.ASSOCIATE_MEMBER.equals(status)) {
            //生成随机密码
            String passwd = Tools.generateRandom8Chars();
            account.setPasswd(Tools.md5(passwd));
            //发送成功邮件
            this.sendAccountApprovalSuccess(account, passwd);
        }
        em.merge(account);
        return account;
    }

    /**
     * 审批订单
     *
     * @param id
     * @param status
     * @param message
     * @return
     */
    public OrderCollection approvalOrder(Long id, OrderStatusEnum status, String message) {
        OrderCollection order = orderService.findOrderCollectionById(id);
        order.setStatus(status);
        if (OrderStatusEnum.APPROVAL_REJECT.equals(status)) {
            //发送拒绝邮件
//            this.sendOrderApprovalFail(order, message);
        } else if (OrderStatusEnum.PENDING_PAYMENT.equals(status)) {
            if (order.getAmount().compareTo(BigDecimal.ZERO) == 0) {
                order.setEndDate(new Date());
                order.setStatus(OrderStatusEnum.SUCCESS);
                //生成票
                orderService.createFundCollectionTicketByOrder(order);
                //发送门票邮件
                orderService.sendOrderSuccessEmail(order);
            } else {
                //发送审批成功邮件
//                this.sendOrderApprovalSuccess(order);
            }
        }
        em.merge(order);
        return order;
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
     * 发送密码连接
     *
     * @param account
     * @param language
     */
    public void sendResetPasswdURLEmail(Account account, String language) {
        String url = this.getUniqueAccountRepasswdUrl(account.getId());
        account.setRepasswdUrl(url);
        account.setRepasswdDate(new Date());
        em.merge(account);
        //发送邮件
        this.sendRepasswd(account, language);
    }

    /**
     * 密码重置
     *
     * @param account
     * @param passwd
     */
    public void resetPassword(Account account, String passwd) {
        account.setPasswd(Tools.md5(passwd));
        account.setRepasswdDate(new Date());
        em.merge(account);
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
     * 根据重置密码URL获取用户
     *
     * @param repasswdUrl
     * @return
     */
    public Account findByRepasswdUrl(String repasswdUrl) {
        Account user = null;
        try {
            TypedQuery<Account> query = em.createQuery("SELECT a FROM Account a WHERE a.repasswdUrl = :repasswdUrl and a.deleted = false", Account.class);
            query.setParameter("repasswdUrl", repasswdUrl);
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
     * 生成唯一的验证URL（算法有待提高）
     *
     * @param id
     * @return
     */
    private String getUniqueAccountRepasswdUrl(Long id) {
        int maxCount = 10;
        String repasswdUrl = Tools.generateRandom8Chars(id);
        int i = 1;
        for (; i < maxCount && isExistAccountByRepasswdUrl(repasswdUrl); i++) {
            repasswdUrl = Tools.generateRandom8Chars(id);
        }
        if (i >= 10) {
            throw new RuntimeException("System Error");
        }
        return repasswdUrl;
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

    /**
     * 账户是否存在
     *
     * @param verifyUrl
     * @return
     */
    private boolean isExistAccountByRepasswdUrl(String repasswdUrl) {
        Account account = findByRepasswdUrl(repasswdUrl);
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
     * @param passwd
     */
    private void sendAccountApprovalSuccess(Account account, String passwd) {
        String language = account.getUserLanguage().toString();
        String toEmail = account.getEmail();
        if (language == null || (!language.equalsIgnoreCase("zh") && !language.equalsIgnoreCase("en"))) {
            language = "zh";
        }
        language = language.toLowerCase();
        String fromDisplayName = "zh".equalsIgnoreCase(language) ? "筑誉建筑联合会" : "CBRA";
        String fromEmail = Config.FROM_EMAIL;
        String templateFile = "account_approval_success_" + language + ".html";
        String subject = "zh".equalsIgnoreCase(language) ? " 【CBRA】筑誉建筑联合会入会申请审核结果通知 " : " Withdraw Request Processed - YUAN RMB ";
        Map model = new HashMap();
        model.put("account", account);
        model.put("passwd", passwd);
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
        String fromDisplayName = "zh".equalsIgnoreCase(language) ? "筑誉建筑联合会" : "CBRA";
        String fromEmail = Config.FROM_EMAIL;
        String templateFile = "account_approval_fail_" + language + ".html";
        String subject = "zh".equalsIgnoreCase(language) ? " 【CBRA】筑誉建筑联合会入会申请审核结果通知 " : " Withdraw Request Processed - YUAN RMB ";
        Map model = new HashMap();
        model.put("account", account);
        if (Tools.isNotBlank(message)) {
            model.put("message", message);
            model.put("showMessage", true);
        }
        emailService.send(fromDisplayName, fromEmail, toEmail, subject, templateFile, model, null, null);
    }

    /**
     * 发送订单审批成功邮件
     *
     * @param account
     */
    private void sendOrderApprovalSuccess(OrderCollection order) {
        String language = null;
        String toEmail = null;
        String name = null;
        if (order.getOwner() == null) {
            language = order.getFundCollection().getEventLanguage().toString();
            Attendee attendee = orderService.findAttendeeByOrder(order.getId()).get(0);
            toEmail = attendee.getEmail();
            name = attendee.getName();
        } else {
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
        String templateFile = "order_approval_success_" + language + ".html";
        String subject = "zh".equalsIgnoreCase(language) ? " 【订单审批成功通知】 " : " Withdraw Request Processed - YUAN RMB ";
        Map model = new HashMap();
        model.put("order", order);
        model.put("baseLink", Config.HTTP_URL_BASE);
        model.put("name", name);
        emailService.send(fromDisplayName, fromEmail, toEmail, subject, templateFile, model, null, null);
    }

    /**
     * 发送订单审批拒绝邮件
     *
     * @param account
     * @param message
     */
    private void sendOrderApprovalFail(OrderCollection order, String message) {
        String language = null;
        String toEmail = null;
        String name = null;
        if (order.getOwner() == null) {
            language = order.getFundCollection().getEventLanguage().toString();
            Attendee attendee = orderService.findAttendeeByOrder(order.getId()).get(0);
            toEmail = attendee.getEmail();
            name = attendee.getName();
        } else {
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
        String templateFile = "order_approval_fail_" + language + ".html";
        String subject = "zh".equalsIgnoreCase(language) ? " 【订单审批失败通知】 " : " Withdraw Request Processed - YUAN RMB ";
        Map model = new HashMap();
        model.put("order", order);
        model.put("name", name);
        model.put("baseLink", Config.HTTP_URL_BASE);
        if (Tools.isNotBlank(message)) {
            model.put("message", message);
            model.put("showMessage", true);
        }
        emailService.send(fromDisplayName, fromEmail, toEmail, subject, templateFile, model, null, null);
    }

    /**
     * 发送重置密码邮件
     *
     * @param account
     */
    private void sendRepasswd(Account account, String language) {
        String toEmail = account.getEmail();
        if (language == null || (!language.equalsIgnoreCase("zh") && !language.equalsIgnoreCase("en"))) {
            language = "zh";
        }
        language = language.toLowerCase();
        String fromDisplayName = "zh".equalsIgnoreCase(language) ? "筑誉建筑联合会" : "CBRA";
        String fromEmail = Config.FROM_EMAIL;
        String templateFile = "account_reset_passwd_" + language + ".html";
        String subject = "zh".equalsIgnoreCase(language) ? " 【密码找回通知】 " : " Withdraw Request Processed - YUAN RMB ";
        Map model = new HashMap();
        model.put("account", account);
        model.put("linkUrl", Config.HTTP_URL_BASE + "account/reset_passwd?key=" + account.getRepasswdUrl());
        emailService.send(fromDisplayName, fromEmail, toEmail, subject, templateFile, model, null, null);
    }
}
