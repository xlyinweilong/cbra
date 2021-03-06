/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.Tools;
import com.cbra.support.enums.FundCollectionAllowAttendeeEnum;
import com.cbra.support.enums.FundCollectionLanaguageEnum;
import com.cbra.support.enums.PlateAuthEnum;
import java.io.Serializable;
import java.math.BigDecimal;
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
import javax.persistence.Transient;
import javax.persistence.UniqueConstraint;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 活动讲座收款
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "fund_collection", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"web_id"}),
    @UniqueConstraint(columnNames = {"serial_id"})})
@XmlRootElement
public class FundCollection implements Serializable {

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
    @Column(name = "web_id", length = 255)
    private String webId;
    @Column(name = "serial_id", length = 255)
    private String serialId;
    //报名开始时间
    @Column(name = "status_begin_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date statusBeginDate = null;
    //报名截至时间
    @Column(name = "status_end_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date statusEndDate = null;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "title", nullable = false, length = 255)
    private String title;
    @Lob
    @Column(name = "detail_desc_html")
    private String detailDescHtml;
    @Column(name = "event_begin_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date eventBeginDate = null;
    @Column(name = "event_end_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date eventEndDate = null;
    @Column(name = "checkin_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date checkinDate = null;
    @Column(name = "event_host")
    private String eventHost;
    @Column(name = "event_host_desc")
    private String eventHostDesc;
    @Column(name = "event_map_url")
    private String eventMapUrl;
    @Enumerated(EnumType.STRING)
    @Column(name = "allow_attendee", nullable = false, length = 255)
    private FundCollectionAllowAttendeeEnum allowAttendee = FundCollectionAllowAttendeeEnum.PUBLIC;
    @Enumerated(EnumType.STRING)
    @Column(name = "event_language", nullable = false, length = 255)
    private FundCollectionLanaguageEnum eventLanguage = FundCollectionLanaguageEnum.ZH;
    @Size(max = 1023)
    @Column(name = "event_location", length = 1023)
    private String eventLocation;
    @Column(name = "visit_count")
    private Long visitCount = 0l;
    @Column(name = "paid_amount", precision = 22, scale = 2)
    private BigDecimal paidAmount = new BigDecimal(0);
    @Column(name = "tourist_price", precision = 22, scale = 2)
    private BigDecimal touristPrice = null;
    @Column(name = "user_price", precision = 22, scale = 2)
    private BigDecimal userPrice = null;
    @Column(name = "company_price", precision = 22, scale = 2)
    private BigDecimal companyPrice = null;
    @Column(name = "each_company_free_count")
    private int eachCompanyFreeCount = 0;
    @NotNull
    @Column(name = "deleted", nullable = false)
    private Boolean deleted = false;
    @Enumerated(EnumType.STRING)
    @Column(name = "plate_auth", length = 255)
    private PlateAuthEnum touristAuth;
    @Enumerated(EnumType.STRING)
    @Column(name = "user_auth", length = 255)
    private PlateAuthEnum userAuth;
    @Enumerated(EnumType.STRING)
    @Column(name = "company_auth", length = 255)
    private PlateAuthEnum companyAuth;
    @JoinColumn(name = "plate_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Plate plate = null;
    @Column(name = "image_url", length = 255)
    private String imageUrl;
    @Lob
    @Size(max = 65535)
    @Column(name = "introduction")
    //手机端简介
    private String introduction;
    @Column(name = "introduction_image_url")
    //手机端简介图片
    private String introductionImageUrl;
    @Transient
    private String detailsUrl;

    public String getDetailsUrl() {
        return detailsUrl;
    }

    public void setDetailsUrl(String detailsUrl) {
        this.detailsUrl = detailsUrl;
    }

    public String getStatus() {
        Date now = new Date();
        if (now.before(statusBeginDate)) {
            return "报名未开始";
        } else if (now.after(statusEndDate)) {
            return "报名已经结束";
        } else {
            return "报名中";
        }
    }

    public String getStatusCode() {
        Date now = new Date();
        if (now.before(statusBeginDate)) {
            return "0";
        } else if (now.after(statusEndDate)) {
            return "2";
        } else {
            return "1";
        }
    }

    public boolean getStatusBoolean() {
        Date now = new Date();
        if (now.before(statusBeginDate)) {
            return false;
        } else if (now.after(statusEndDate)) {
            return false;
        } else {
            return true;
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

    public FundCollection() {
    }

    public FundCollection(Long id) {
        this.id = id;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public String getWebId() {
        return webId;
    }

    public void setWebId(String webId) {
        this.webId = webId;
    }

    public String getSerialId() {
        return serialId;
    }

    public void setSerialId(String serialId) {
        this.serialId = serialId;
    }

    public String getTitle() {
        return title;
    }

    public String getTitleIndex() {
        if (title.length() > 15) {
            return title.substring(0, 14) + "...";
        }
        return title;
    }

    public String getTitleIndexStr3() {
        if (title.length() > 15) {
            return title.substring(0, 14) + "...";
        }
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetailDescHtml() {
        return detailDescHtml;
    }

    public void setDetailDescHtml(String detailDescHtml) {
        this.detailDescHtml = detailDescHtml;
    }

    public Date getEventBeginDate() {
        return eventBeginDate;
    }

    public String getEventBeginDateString() {
        return Tools.formatDate(eventBeginDate, "yyyy年MM月dd日");
    }

    public String getEventBeginDateIndexString() {
        return Tools.formatDate(eventBeginDate, "MM-dd");
    }

    public void setEventBeginDate(Date eventBeginDate) {
        this.eventBeginDate = eventBeginDate;
    }

    public Date getEventEndDate() {
        return eventEndDate;
    }

    public void setEventEndDate(Date eventEndDate) {
        this.eventEndDate = eventEndDate;
    }

    public Date getCheckinDate() {
        return checkinDate;
    }

    public void setCheckinDate(Date checkinDate) {
        this.checkinDate = checkinDate;
    }

    public String getEventHost() {
        return eventHost;
    }

    public void setEventHost(String eventHost) {
        this.eventHost = eventHost;
    }

    public String getEventHostDesc() {
        return eventHostDesc;
    }

    public void setEventHostDesc(String eventHostDesc) {
        this.eventHostDesc = eventHostDesc;
    }

    public String getEventMapUrl() {
        return eventMapUrl;
    }

    public void setEventMapUrl(String eventMapUrl) {
        this.eventMapUrl = eventMapUrl;
    }

    public FundCollectionAllowAttendeeEnum getAllowAttendee() {
        return allowAttendee;
    }

    public void setAllowAttendee(FundCollectionAllowAttendeeEnum allowAttendee) {
        this.allowAttendee = allowAttendee;
    }

    public FundCollectionLanaguageEnum getEventLanguage() {
        return eventLanguage;
    }

    public void setEventLanguage(FundCollectionLanaguageEnum eventLanguage) {
        this.eventLanguage = eventLanguage;
    }

    public String getEventLocation() {
        return eventLocation;
    }

    public void setEventLocation(String eventLocation) {
        this.eventLocation = eventLocation;
    }

    public Long getVisitCount() {
        return visitCount;
    }

    public void setVisitCount(Long visitCount) {
        this.visitCount = visitCount;
    }

    public BigDecimal getPaidAmount() {
        return paidAmount;
    }

    public void setPaidAmount(BigDecimal paidAmount) {
        this.paidAmount = paidAmount;
    }

    public BigDecimal getTouristPrice() {
        return touristPrice;
    }

    public void setTouristPrice(BigDecimal touristPrice) {
        this.touristPrice = touristPrice;
    }

    public BigDecimal getUserPrice() {
        return userPrice;
    }

    public void setUserPrice(BigDecimal userPrice) {
        this.userPrice = userPrice;
    }

    public BigDecimal getCompanyPrice() {
        return companyPrice;
    }

    public void setCompanyPrice(BigDecimal companyPrice) {
        this.companyPrice = companyPrice;
    }

    public PlateAuthEnum getTouristAuth() {
        return touristAuth;
    }

    public void setTouristAuth(PlateAuthEnum touristAuth) {
        this.touristAuth = touristAuth;
    }

    public PlateAuthEnum getUserAuth() {
        return userAuth;
    }

    public void setUserAuth(PlateAuthEnum userAuth) {
        this.userAuth = userAuth;
    }

    public PlateAuthEnum getCompanyAuth() {
        return companyAuth;
    }

    public void setCompanyAuth(PlateAuthEnum companyAuth) {
        this.companyAuth = companyAuth;
    }

    public Plate getPlate() {
        return plate;
    }

    public void setPlate(Plate plate) {
        this.plate = plate;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Date getStatusBeginDate() {
        return statusBeginDate;
    }

    public void setStatusBeginDate(Date statusBeginDate) {
        this.statusBeginDate = statusBeginDate;
    }

    public Date getStatusEndDate() {
        return statusEndDate;
    }

    public void setStatusEndDate(Date statusEndDate) {
        this.statusEndDate = statusEndDate;
    }

    public int getEachCompanyFreeCount() {
        return eachCompanyFreeCount;
    }

    public void setEachCompanyFreeCount(int eachCompanyFreeCount) {
        this.eachCompanyFreeCount = eachCompanyFreeCount;
    }

    public String getIntroduction() {
        return introduction;
    }

    public String getIntroductionString() {
        if (introduction != null) {
            if (introductionImageUrl == null) {
                if (introduction.length() > 100) {
                    return introduction.substring(0, 99) + "...";
                }
            } else {
                if (introduction.length() > 50) {
                    return introduction.substring(0, 49) + "...";
                }
            }
        }
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public String getIntroductionImageUrl() {
        return introductionImageUrl;
    }

    public void setIntroductionImageUrl(String introductionImageUrl) {
        this.introductionImageUrl = introductionImageUrl;
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
        if (!(object instanceof FundCollection)) {
            return false;
        }
        FundCollection other = (FundCollection) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.FundCollection[ id=" + id + " ]";
    }

}
