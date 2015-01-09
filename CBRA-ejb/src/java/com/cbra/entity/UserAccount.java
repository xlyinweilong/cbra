/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.UserAccountTypeEnum;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 用户账户
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "user_account")
@XmlRootElement
public class UserAccount implements Serializable {

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
    /**
     * 帐号（手机号）
     */
    private String account;
    @Size(max = 255)
    @Column(name = "name", length = 255)
    private String name;
    @Size(max = 255)
    /**
     *验证URL 
     */
    @Column(name = "verify_url", length = 255)
    private String verifyUrl;
    @Size(max = 2)
    @Column(name = "language", length = 2)
    @Enumerated(EnumType.STRING)
    /**
     * 语言
     */
    private LanguageType language = LanguageType.ZH;
    @Enumerated(EnumType.STRING)
    /**
     * 帐号类型
     */
    @Basic(optional = false)
    @Column(name = "account_type", nullable = false, length = 255)
    private UserAccountTypeEnum accountType = UserAccountTypeEnum.USER;
    @Size(max = 255)
    @Column(name = "person_card_front", length = 255)
    /**
     * 身份证文件正面URL
     */
    private String personCardFront;
    @Size(max = 255)
    @Column(name = "person_card_back", length = 255)
    /**
     * 身份证文件背面URL
     */
    private String personCardBack;
    @Size(max = 255)
    @Column(name = "person_id", length = 255)
    /**
     * 身份证号
     */
    private String personId;
    @Size(max = 255)
    @Column(name = "organization_id", length = 255)
    /**
     * 组织机构代码号
     */
    private String organizationID;
    @Size(max = 255)
    @Column(name = "organization_card_url", length = 255)
    /**
     * 企业资质照片
     */
    private String organizationCardUrl;
    @Size(max = 255)
    @Column(name = "email")
    /**
     * 邮件
     */
    private String email;
    
    public UserAccount() {
    }

    public UserAccount(Long id) {
        this.id = id;
    }

    public UserAccount(Long id, String account) {
        this.id = id;
        this.account = account;
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

    public LanguageType getLanguage() {
        return language;
    }

    public void setLanguage(LanguageType language) {
        this.language = language;
    }

    public UserAccountTypeEnum getAccountType() {
        return accountType;
    }

    public void setAccountType(UserAccountTypeEnum accountType) {
        this.accountType = accountType;
    }

    public String getPersonCardFront() {
        return personCardFront;
    }

    public void setPersonCardFront(String personCardFront) {
        this.personCardFront = personCardFront;
    }

    public String getPersonCardBack() {
        return personCardBack;
    }

    public void setPersonCardBack(String personCardBack) {
        this.personCardBack = personCardBack;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public String getOrganizationID() {
        return organizationID;
    }

    public void setOrganizationID(String organizationID) {
        this.organizationID = organizationID;
    }

    public String getOrganizationCardUrl() {
        return organizationCardUrl;
    }

    public void setOrganizationCardUrl(String organizationCardUrl) {
        this.organizationCardUrl = organizationCardUrl;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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
        if (!(object instanceof UserAccount)) {
            return false;
        }
        UserAccount other = (UserAccount) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.UserAccount[ id=" + id + " ]";
    }

}
