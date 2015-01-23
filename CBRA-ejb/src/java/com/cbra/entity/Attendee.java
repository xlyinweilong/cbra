/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 参会人的信息
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "attendee")
@XmlRootElement
public class Attendee implements Serializable {

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
    @Size(max = 255)
    @Column(name = "name")
    private String name;
    @Size(max = 255)
    @Column(name = "mobile_phone")
    private String mobilePhone;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 255)
    @Column(name = "email")
    private String email;
    @Size(max = 255)
    @Column(name = "company")
    private String company;
    @Size(max = 255)
    @Column(name = "position")
    private String position;
    @Size(max = 255)
    @Column(name = "city")
    private String city;
    @ManyToOne
    @JoinColumn(name = "user_account_id", referencedColumnName = "id")
    private UserAccount userAccount;
    @OneToOne(cascade = {CascadeType.ALL}, mappedBy = "attendee", fetch = FetchType.LAZY)
    private FundCollectionTicket fundCollectionTicket;
    @OneToOne(cascade = {CascadeType.ALL}, mappedBy = "attendee", fetch = FetchType.LAZY)
    private OrderCollectionItem orderCollectionItem;
    @ManyToOne
    @JoinColumn(name = "fund_collection_id", referencedColumnName = "id")
    private FundCollectionTicket fundCollection;
    @Basic(optional = false)
    @NotNull
    @Column(name = "deleted", nullable = false)
    private Boolean deleted = false;
    
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

    public Attendee() {
    }

    public Attendee(Long id) {
        this.id = id;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobilePhone() {
        return mobilePhone;
    }

    public void setMobilePhone(String mobilePhone) {
        this.mobilePhone = mobilePhone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public UserAccount getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(UserAccount userAccount) {
        this.userAccount = userAccount;
    }

    public FundCollectionTicket getFundCollectionTicket() {
        return fundCollectionTicket;
    }

    public void setFundCollectionTicket(FundCollectionTicket fundCollectionTicket) {
        this.fundCollectionTicket = fundCollectionTicket;
    }

    public FundCollectionTicket getFundCollection() {
        return fundCollection;
    }

    public void setFundCollection(FundCollectionTicket fundCollection) {
        this.fundCollection = fundCollection;
    }

    public OrderCollectionItem getOrderCollectionItem() {
        return orderCollectionItem;
    }

    public void setOrderCollectionItem(OrderCollectionItem orderCollectionItem) {
        this.orderCollectionItem = orderCollectionItem;
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
        if (!(object instanceof Attendee)) {
            return false;
        }
        Attendee other = (Attendee) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.Attendee[ id=" + id + " ]";
    }

}
