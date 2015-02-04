package com.cbra.entity;

import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.LanguageType;
import java.io.Serializable;
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
    @Size(max = 2)
    @Column(name = "language", length = 2)
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
    @Size(max = 255)
    @Column(name = "ic_position_others", length = 255)
    //产业链位置其他信息
    private String icPositionOthers;
    @Column(name = "deleted")
    private boolean deleted = false;
    @Column(name = "approval_information")
    //审批信息
    private String approvalInformation ;

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

    public String getIcPositionOthers() {
        return icPositionOthers;
    }

    public void setIcPositionOthers(String icPositionOthers) {
        this.icPositionOthers = icPositionOthers;
    }

    public String getApprovalInformation() {
        return approvalInformation;
    }

    public void setApprovalInformation(String approvalInformation) {
        this.approvalInformation = approvalInformation;
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
