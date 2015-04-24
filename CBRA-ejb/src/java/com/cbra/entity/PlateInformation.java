/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.Tools;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.PlateAuthEnum;
import com.cbra.support.enums.PlateKeyEnum;
import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 栏目信息
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "plate_information")
@XmlRootElement
public class PlateInformation implements Serializable {

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
    @Basic(optional = false)
    @NotNull
    @Column(name = "visit_count")
    private long visitCount = 0l;
    @Basic(optional = false)
    @NotNull
    @Column(name = "is_top")
    private boolean isTop = false;
    @Column(name = "name")
    private String name;
    @Column(name = "title")
    private String title;
    @Column(name = "nav_url")
    private String navUrl;
    @Column(name = "pic_url")
    private String picUrl;
    @Lob
    @Size(max = 65535)
    @Column(name = "introduction")
    private String introduction;
    @Column(name = "link_url")
    private String linkUrl;
    @JoinColumn(name = "plate_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Plate plate = null;
    @OneToOne(cascade = {CascadeType.ALL}, mappedBy = "plateInformation", fetch = FetchType.LAZY)
    private PlateInformationContent plateInformationContent = null;
    @Column(name = "language", length = 2)
    @Enumerated(EnumType.STRING)
    private LanguageType language = LanguageType.ZH;
    @Basic(optional = false)
    @NotNull
    @Column(name = "push_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date pushDate = new Date();
    @Basic(optional = false)
    @NotNull
    @Column(name = "deleted", nullable = false)
    private Boolean deleted = false;
    @Column(name = "order_index")
    private Integer orderIndex = 0;
    @Enumerated(EnumType.STRING)
    @Column(name = "tourist_auth", length = 255)
    private PlateAuthEnum touristAuth;
    @Enumerated(EnumType.STRING)
    @Column(name = "user_auth", length = 255)
    private PlateAuthEnum userAuth;
    @Enumerated(EnumType.STRING)
    @Column(name = "company_auth", length = 255)
    private PlateAuthEnum companyAuth;
    @Transient
    private String detailsUrl;

    public String getDetailsUrl() {
        return detailsUrl;
    }

    public void setDetailsUrl(String detailsUrl) {
        this.detailsUrl = detailsUrl;
    }

    public Long getId() {
        return id;
    }

    public Integer getOrderIndex() {
        return orderIndex;
    }

    public void setOrderIndex(Integer orderIndex) {
        this.orderIndex = orderIndex;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public long getVisitCount() {
        return visitCount;
    }

    public void setVisitCount(long visitCount) {
        this.visitCount = visitCount;
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

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl;
    }

    public boolean isIsTop() {
        return isTop;
    }

    public void setIsTop(boolean isTop) {
        this.isTop = isTop;
    }

    public String getTitle() {
        return Tools.getEscapedHtml(title);
    }

    public String getTitleIndexStr() {
        if (title.length() > 25) {
            return title.substring(0, 24) + "...";
        }
        return title;
    }

    public String getTitleIndexStr2() {
        if (title.length() > 20) {
            return title.substring(0, 19) + "...";
        }
        return title;
    }

    public String getTitleIndexStr3() {
        if (title.length() > 18) {
            return title.substring(0, 17) + "...";
        }
        return title;
    }

    public boolean isNewPushDate() {
        Calendar cal = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();
        cal2.setTime(pushDate);
        if (cal.get(Calendar.MONTH) == cal2.get(Calendar.MONTH) && cal.get(Calendar.YEAR) == cal2.get(Calendar.YEAR)) {
            return true;
        }
        return false;
    }

    public PlateInformationContent getPlateInformationContent() {
        return plateInformationContent;
    }

    public void setPlateInformationContent(PlateInformationContent plateInformationContent) {
        this.plateInformationContent = plateInformationContent;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getNavUrl() {
        return navUrl;
    }

    public void setNavUrl(String navUrl) {
        this.navUrl = navUrl;
    }

    public String getPicUrl() {
        return picUrl;
    }

    public void setPicUrl(String picUrl) {
        this.picUrl = picUrl;
    }

    public String getIntroduction() {
        return introduction;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public Plate getPlate() {
        return plate;
    }

    public Date getPushDate() {
        return pushDate;
    }

    public String getPushDateString() {
        return Tools.formatDate(pushDate, "yyyy年MM月dd日");
    }

    public void setPushDate(Date pushDate) {
        this.pushDate = pushDate;
    }

    public void setPlate(Plate plate) {
        this.plate = plate;
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

    public LanguageType getLanguage() {
        return language;
    }

    public void setLanguage(LanguageType language) {
        this.language = language;
    }

    public PlateInformation() {
    }

    public PlateInformation(Long id) {
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PlateInformation)) {
            return false;
        }
        PlateInformation other = (PlateInformation) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.PlateInformation[ id=" + id + " ]";
    }

}
