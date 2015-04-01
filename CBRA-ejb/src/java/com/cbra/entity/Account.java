package com.cbra.entity;

import com.cbra.support.Tools;
import com.cbra.support.enums.AccountIcPosition;
import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.LanguageType;
import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 用户账户抽象类
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "account")
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorColumn(name = "type", discriminatorType = DiscriminatorType.STRING)
@XmlRootElement
public abstract class Account implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "create_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate = new Date();
    @Version
    private Integer version;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "account")
    //帐号
    private String account;
    @Basic(optional = false)
    @NotNull
    @Column(name = "status")
    @Enumerated(EnumType.STRING)
    //状态
    private AccountStatus status = AccountStatus.PENDING_FOR_APPROVAL;
    @Column(name = "pay_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date payDate;
    @Column(name = "passwd")
    //密码
    private String passwd;
    @Size(max = 255)
    @Column(name = "name", length = 255)
    //名称
    private String name;
    @Size(max = 255)
    //验证URL 
    @Column(name = "verify_url", length = 255)
    private String verifyUrl;
    //验证时间
    @Column(name = "verify_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date verifyDate;
    @Column(name = "user_language", length = 255)
    @Enumerated(EnumType.STRING)
    //账户默认语言
    private LanguageType userLanguage = LanguageType.ZH;
    @Size(max = 255)
    @Column(name = "email")
    //邮件
    private String email;
    @Size(max = 255)
    @Column(name = "address")
    //地址
    private String address;
    @Size(max = 255)
    @Column(name = "zipCode")
    //邮编
    private String zipCode;
    @Size(max = 255)
    @Column(name = "ic_position", length = 255)
    //产业链位置
    private String icPosition;
    @Column(name = "deleted")
    private boolean deleted = false;
    @Column(name = "approval_information")
    //审批信息
    private String approvalInformation;
    @Column(name = "head_image_url")
    //头像
    private String headImageUrl;
    @Column(name = "enrolled_count")
    //已报名活动
    private int enrolledCount = 0;
    @Column(name = "joined_count")
    //已参加活动
    private int joinedCount = 0;
    //找回密码
    @Column(name = "re_passwd_url", length = 255)
    private String repasswdUrl;
    //连接创建时间
    @Column(name = "re_passwd_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date repasswdDate;
    //loginCode
    @Column(name = "login_code")
    private String loginCode;

    public String getIcPositionString() {
        if (Tools.isBlank(icPosition)) {
            return null;
        }
        StringBuilder sb = new StringBuilder();
        String[] ics = icPosition.split("_");
        for (String ic : ics) {
            if (Tools.isNotBlank(ic)) {
                sb.append(AccountIcPosition.getName(ic));
                sb.append(",");
            }
        }
        return sb.substring(0, sb.length() - 1);
    }

    /**
     * 获取TYPE
     *
     * @return
     */
    public String getType() {
        if (this instanceof CompanyAccount) {
            return "COMPANY";
        } else if (this instanceof UserAccount) {
            return "USER";
        } else {
            return "SUB_COMPANY";
        }
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getVerifyUrl() {
        return verifyUrl;
    }

    public void setVerifyUrl(String verifyUrl) {
        this.verifyUrl = verifyUrl;
    }

    public Date getVerifyDate() {
        return verifyDate;
    }

    public void setVerifyDate(Date verifyDate) {
        this.verifyDate = verifyDate;
    }

    public LanguageType getUserLanguage() {
        return userLanguage;
    }

    public void setUserLanguage(LanguageType userLanguage) {
        this.userLanguage = userLanguage;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getIcPosition() {
        return icPosition;
    }

    public void setIcPosition(String icPosition) {
        this.icPosition = icPosition;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public AccountStatus getStatus() {
        return status;
    }

    public void setStatus(AccountStatus status) {
        this.status = status;
    }

    public String getApprovalInformation() {
        return approvalInformation;
    }

    public void setApprovalInformation(String approvalInformation) {
        this.approvalInformation = approvalInformation;
    }

    public String getHeadImageUrl() {
        return headImageUrl;
    }

    public String getHeadImageUrlWithDefault() {
        return headImageUrl;
    }

    public void setHeadImageUrl(String headImageUrl) {
        this.headImageUrl = headImageUrl;
    }

    public int getEnrolledCount() {
        return enrolledCount;
    }

    public void setEnrolledCount(int enrolledCount) {
        this.enrolledCount = enrolledCount;
    }

    public int getJoinedCount() {
        return joinedCount;
    }

    public void setJoinedCount(int joinedCount) {
        this.joinedCount = joinedCount;
    }

    public int getCreateYear() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(createDate);
        return calendar.get(Calendar.YEAR);
    }

    public String getRepasswdUrl() {
        return repasswdUrl;
    }

    public void setRepasswdUrl(String repasswdUrl) {
        this.repasswdUrl = repasswdUrl;
    }

    public Date getRepasswdDate() {
        return repasswdDate;
    }

    public void setRepasswdDate(Date repasswdDate) {
        this.repasswdDate = repasswdDate;
    }

    public String getLoginCode() {
        return loginCode;
    }

    public void setLoginCode(String loginCode) {
        this.loginCode = loginCode;
    }

    public Date getPayDate() {
        return payDate;
    }

    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Account)) {
            return false;
        }
        Account other = (Account) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.Account[ id=" + id + " ]";
    }

}
