/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

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
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 后台用户
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "sys_user")
@XmlRootElement
public class SysUser implements Serializable {

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
    @Column(name = "admin_type", nullable = false, length = 255)
    private SysUserTypeEnum adminType = SysUserTypeEnum.ORDINARY;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "account")
    private String account;
    @Basic(optional = false)
    @Size(max = 255)
    @Column(name = "name")
    private String name;
    @Basic(optional = false)
    @Size(max = 255)
    @Column(name = "passwd")
    private String passwd;
    @Basic(optional = false)
    @NotNull
    @Column(name = "deleted", nullable = false)
    private Boolean deleted = false;
    @OneToMany(mappedBy = "sysUser", targetEntity = SysRoleUser.class, fetch = FetchType.LAZY)
    private List<SysRoleUser> sysRoleUserList = null;

    public SysUser() {
    }

    public SysUser(Long id) {
        this.id = id;
    }

    public SysUser(Long id, String account) {
        this.id = id;
        this.account = account;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    public String getPasswd() {
        return passwd;
    }

    public void setPasswd(String passwd) {
        this.passwd = passwd;
    }

    public SysUserTypeEnum getAdminType() {
        return adminType;
    }

    public void setAdminType(SysUserTypeEnum adminType) {
        this.adminType = adminType;
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

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public List<SysRoleUser> getSysRoleUserList() {
        return sysRoleUserList;
    }

    public void setSysRoleUserList(List<SysRoleUser> sysRoleUserList) {
        this.sysRoleUserList = sysRoleUserList;
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
        if (!(object instanceof SysUser)) {
            return false;
        }
        SysUser other = (SysUser) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.SysUser[ id=" + id + " ]";
    }

}
