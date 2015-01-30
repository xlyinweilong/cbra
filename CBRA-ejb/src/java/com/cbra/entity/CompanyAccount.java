package com.cbra.entity;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Lob;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 公司账户
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "company_account")
@DiscriminatorValue("COMPANY")
@XmlRootElement
public class CompanyAccount extends Account {

    @Column(name = "company_create_date")
    @Temporal(TemporalType.TIMESTAMP)
    // 创立时间
    private Date companyCreateDate;
    @Size(max = 255)
    @Column(name = "legal_person", length = 255)
    //企业法人
    private String legalPerson;
    @Size(max = 255)
    @Column(name = "nature", length = 255)
    //企业性质
    private String nature;
    @Size(max = 255)
    @Column(name = "scale", length = 255)
    //规模
    private String scale;
    @Size(max = 255)
    @Column(name = "web_side", length = 255)
    //网站
    private String webSide;
    @Size(max = 255)
    @Column(name = "enterprise_qality_grading", length = 255)
    //企业资质等级
    private String enterpriseQalityGrading;
    @Column(name = "authentication_date")
    @Temporal(TemporalType.TIMESTAMP)
    //主项资质发证时间
    private Date authenticationDate;
    @Size(max = 255)
    @Column(name = "production_license_number", length = 255)
    //产许可证编号
    private String productionLicenseNumber;
    @Column(name = "production_license_valid_date")
    @Temporal(TemporalType.TIMESTAMP)
    //安全生产许可证有效期
    private Date productionLicenseValidDate;
    @Lob
    @Size(max = 65535)
    @Column(name = "field")
    //目标客户或擅长领域
    private String field;
    @Size(max = 255)
    @Column(name = "business_license", length = 255)
    //上传企业营业执照副本（彩色加盖公章）
    private String businessLicenseUrl;

    public Date getCompanyCreateDate() {
        return companyCreateDate;
    }

    public void setCompanyCreateDate(Date companyCreateDate) {
        this.companyCreateDate = companyCreateDate;
    }

    public String getLegalPerson() {
        return legalPerson;
    }

    public void setLegalPerson(String legalPerson) {
        this.legalPerson = legalPerson;
    }

    public String getNature() {
        return nature;
    }

    public void setNature(String nature) {
        this.nature = nature;
    }

    public String getScale() {
        return scale;
    }

    public void setScale(String scale) {
        this.scale = scale;
    }

    public String getWebSide() {
        return webSide;
    }

    public void setWebSide(String webSide) {
        this.webSide = webSide;
    }

    public String getEnterpriseQalityGrading() {
        return enterpriseQalityGrading;
    }

    public void setEnterpriseQalityGrading(String enterpriseQalityGrading) {
        this.enterpriseQalityGrading = enterpriseQalityGrading;
    }

    public Date getAuthenticationDate() {
        return authenticationDate;
    }

    public void setAuthenticationDate(Date authenticationDate) {
        this.authenticationDate = authenticationDate;
    }

    public String getProductionLicenseNumber() {
        return productionLicenseNumber;
    }

    public void setProductionLicenseNumber(String productionLicenseNumber) {
        this.productionLicenseNumber = productionLicenseNumber;
    }

    public Date getProductionLicenseValidDate() {
        return productionLicenseValidDate;
    }

    public void setProductionLicenseValidDate(Date productionLicenseValidDate) {
        this.productionLicenseValidDate = productionLicenseValidDate;
    }

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }

    public String getBusinessLicenseUrl() {
        return businessLicenseUrl;
    }

    public void setBusinessLicenseUrl(String businessLicenseUrl) {
        this.businessLicenseUrl = businessLicenseUrl;
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
        if (!(object instanceof CompanyAccount)) {
            return false;
        }
        CompanyAccount other = (CompanyAccount) object;
        if ((this.getId() == null && other.getId() != null) || (this.getId() != null && !this.getId().equals(other.getId()))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.CompanyAccount[ id=" + getId() + " ]";
    }

}
