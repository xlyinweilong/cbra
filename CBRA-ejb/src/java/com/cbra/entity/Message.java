/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.enums.MessageSecretLevelEnum;
import com.cbra.support.enums.MessageTypeEnum;
import com.cbra.support.enums.PlateKeyEnum;
import com.cbra.support.enums.SysUserTypeEnum;
import java.io.Serializable;
import java.util.Date;
import java.util.List;
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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 消息模块
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "message")
@XmlRootElement
public class Message implements Serializable {

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
    @JoinColumn(name = "plate_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Plate plate;
    @JoinColumn(name = "plate_information_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private PlateInformation plateInformation;
    @JoinColumn(name = "offer_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Offer offer;
    @JoinColumn(name = "fundCollection_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private FundCollection fundCollection;
    @JoinColumn(name = "account_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Account account;
    @JoinColumn(name = "message_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Message message;
    @Lob
    @Size(max = 65535)
    @Column(name = "content")
    private String content;
    @Basic(optional = false)
    @NotNull
    @Column(name = "deleted", nullable = false)
    private Boolean deleted = false;
    @OneToMany(mappedBy = "message", targetEntity = Message.class)
    private List<Message> messageList;

    public String getUserName() {
        if (account == null) {
            if (type.equals(MessageTypeEnum.REPLAY_FROM_ADMIN)) {
                return "管理员";
            }
            return "用户";
        } else {
            return account.getName();
        }
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

    public Message() {
    }

    public Message(Long id) {
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

    public Plate getPlate() {
        return plate;
    }

    public void setPlate(Plate plate) {
        this.plate = plate;
    }

    public PlateInformation getPlateInformation() {
        return plateInformation;
    }

    public void setPlateInformation(PlateInformation plateInformation) {
        this.plateInformation = plateInformation;
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

    public Message getMessage() {
        return message;
    }

    public void setMessage(Message message) {
        this.message = message;
    }

    public List<Message> getMessageList() {
        return messageList;
    }

    public void setMessageList(List<Message> messageList) {
        this.messageList = messageList;
    }

    public Offer getOffer() {
        return offer;
    }

    public void setOffer(Offer offer) {
        this.offer = offer;
    }

    public FundCollection getFundCollection() {
        return fundCollection;
    }

    public void setFundCollection(FundCollection fundCollection) {
        this.fundCollection = fundCollection;
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
        if (!(object instanceof Message)) {
            return false;
        }
        Message other = (Message) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.Message[ id=" + id + " ]";
    }

}
