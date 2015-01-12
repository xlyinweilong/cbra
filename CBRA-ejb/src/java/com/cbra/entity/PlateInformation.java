/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.PlateKeyEnum;
import java.io.Serializable;
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
    private int visitCount = 0;
    @Basic(optional = false)
    @NotNull
    @Column(name = "is_top")
    private boolean isTop = false;
    @Column(name = "target")
    private String target;
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
    @JoinColumn(name = "plate_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Plate plate = null;
    @OneToOne(cascade = {CascadeType.ALL}, mappedBy = "plateInformation", fetch = FetchType.EAGER)
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

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getVisitCount() {
        return visitCount;
    }

    public void setVisitCount(int visitCount) {
        this.visitCount = visitCount;
    }

    public boolean isIsTop() {
        return isTop;
    }

    public void setIsTop(boolean isTop) {
        this.isTop = isTop;
    }

    public String getTarget() {
        return target;
    }

    public void setTarget(String target) {
        this.target = target;
    }

    public String getTitle() {
        return title;
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
