/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.enums.SysMenuPopedomEnum;
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
 * 后台菜单
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "sys_menu")
@XmlRootElement
public class SysMenu implements Serializable {

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
    @Column(name = "popedom", nullable = false, length = 255)
    private SysMenuPopedomEnum popedom = SysMenuPopedomEnum.COMMON;
    @Basic(optional = false)
    @Size(max = 255)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @Size(max = 255)
    @Column(name = "url")
    private String url;
    @JoinColumn(name = "parent_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false, fetch = FetchType.LAZY)
    private SysMenu parentMenu = null;
    @Basic(optional = false)
    @Column(name = "sort_index")
    private Integer sortIndex = 0;
    @Basic(optional = false)
    @Column(name = "level")
    private Integer level = 1;

    public SysMenu() {
    }

    public SysMenu(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public SysMenuPopedomEnum getPopedom() {
        return popedom;
    }

    public void setPopedom(SysMenuPopedomEnum popedom) {
        this.popedom = popedom;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public SysMenu getParentMenu() {
        return parentMenu;
    }

    public void setParentMenu(SysMenu parentMenu) {
        this.parentMenu = parentMenu;
    }

    public Integer getSortIndex() {
        return sortIndex;
    }

    public void setSortIndex(Integer sortIndex) {
        this.sortIndex = sortIndex;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
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
        if (!(object instanceof SysMenu)) {
            return false;
        }
        SysMenu other = (SysMenu) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.SysMenu[ id=" + id + " ]";
    }

}
