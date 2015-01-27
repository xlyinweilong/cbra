package com.cbra.entity;

import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 公司账户子账户
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "sub_company_account")
@DiscriminatorValue("SUB_COMPANY")
@XmlRootElement
public class SubCompanyAccount extends Account {

    @JoinColumn(name = "company_account", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    //主账户
    private CompanyAccount companyAccount;

    public CompanyAccount getCompanyAccount() {
        return companyAccount;
    }

    public void setCompanyAccount(CompanyAccount companyAccount) {
        this.companyAccount = companyAccount;
    }
    
    @Override
    public int hashCode() {
        int hash = 0;
        hash += (getId() != null ? getId().hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SubCompanyAccount)) {
            return false;
        }
        SubCompanyAccount other = (SubCompanyAccount) object;
        if ((this.getId() == null && other.getId() != null) || (this.getId() != null && !this.getId().equals(other.getId()))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.SubCompanyAccount[ id=" + getId() + " ]";
    }

}
