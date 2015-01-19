/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.enums.PlateAuthEnum;
import com.cbra.support.enums.PlateKeyEnum;
import com.cbra.support.enums.PlateTypeEnum;
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
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 栏目板块
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "plate")
@XmlRootElement
public class Plate implements Serializable {

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
    @Enumerated(EnumType.STRING)
    @Column(name = "plate_key", length = 255)
    private PlateKeyEnum plateKey;
    @Enumerated(EnumType.STRING)
    @Column(name = "plate_type", nullable = false)
    private PlateTypeEnum plateType;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "en_name")
    private String enName;
    @JoinColumn(name = "parent_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Plate parentPlate = null;
    @Basic(optional = false)
    @Column(name = "sort_index")
    private Integer sortIndex = 0;
    @Enumerated(EnumType.STRING)
    @Column(name = "plate_auth", length = 255)
    private PlateAuthEnum touristAuth;
    @Enumerated(EnumType.STRING)
    @Column(name = "user_auth", length = 255)
    private PlateAuthEnum userAuth;
    @Enumerated(EnumType.STRING)
    @Column(name = "company_auth", length = 255)
    private PlateAuthEnum companyAuth;
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

    public PlateKeyEnum getPlateKey() {
        return plateKey;
    }

    public void setPlateKey(PlateKeyEnum plateKey) {
        this.plateKey = plateKey;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Plate getParentPlate() {
        return parentPlate;
    }

    public void setParentPlate(Plate parentPlate) {
        this.parentPlate = parentPlate;
    }

    public PlateTypeEnum getPlateType() {
        return plateType;
    }

    public void setPlateType(PlateTypeEnum plateType) {
        this.plateType = plateType;
    }
     public String getEnName() {
        return enName;
    }

    public void setEnName(String enName) {
        this.enName = enName;
    }

    public Integer getSortIndex() {
        return sortIndex;
    }

    public void setSortIndex(Integer sortIndex) {
        this.sortIndex = sortIndex;
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

    public Plate() {
    }

    public Plate(Long id) {
        this.id = id;
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
        if (!(object instanceof Plate)) {
            return false;
        }
        Plate other = (Plate) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.Plate[ id=" + id + " ]";
    }

}
