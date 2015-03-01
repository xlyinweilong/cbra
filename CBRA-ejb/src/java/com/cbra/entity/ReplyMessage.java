/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.enums.MessageSecretLevelEnum;
import com.cbra.support.enums.MessageTypeEnum;
import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 消息回复
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "reply_message")
@XmlRootElement
public class ReplyMessage implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Version
    private Integer version;
    @Basic(optional = false)
    @NotNull
    @Column(name = "create_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate = new Date();
    @Column(name = "type")
    @Enumerated(EnumType.STRING)
    private MessageTypeEnum type = MessageTypeEnum.PUBLISH_FROM_USER;
    @Column(name = "secret_level")
    @Enumerated(EnumType.STRING)
    private MessageSecretLevelEnum secretLevel = MessageSecretLevelEnum.PUBLIC;
    @JoinColumn(name = "account_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Account account;
    @JoinColumn(name = "sys_user_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private SysUser sysUser;
    @JoinColumn(name = "message_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Message message;
    @Lob
    @Size(max = 65535)
    @Column(name = "content")
    private String content;
    @Column(name = "target_url")
    private String targetUrl;
    @Basic(optional = false)
    @NotNull
    @Column(name = "deleted", nullable = false)
    private Boolean deleted = false;

    public String getUserName() {
        return "管理员";
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public ReplyMessage() {
    }

    public ReplyMessage(Long id) {
        this.id = id;
    }

    public MessageTypeEnum getType() {
        return type;
    }

    public void setType(MessageTypeEnum type) {
        this.type = type;
    }

    public MessageSecretLevelEnum getSecretLevel() {
        return secretLevel;
    }

    public void setSecretLevel(MessageSecretLevelEnum secretLevel) {
        this.secretLevel = secretLevel;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public SysUser getSysUser() {
        return sysUser;
    }

    public void setSysUser(SysUser sysUser) {
        this.sysUser = sysUser;
    }

    public String getTargetUrl() {
        return targetUrl;
    }

    public void setTargetUrl(String targetUrl) {
        this.targetUrl = targetUrl;
    }

    public Message getMessage() {
        return message;
    }

    public void setMessage(Message message) {
        this.message = message;
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
        if (!(object instanceof ReplyMessage)) {
            return false;
        }
        ReplyMessage other = (ReplyMessage) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.ReplyMessage[ id=" + id + " ]";
    }

}
