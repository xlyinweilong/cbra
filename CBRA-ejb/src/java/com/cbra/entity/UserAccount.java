/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
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
 * 个人账户
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "user_account")
@DiscriminatorValue("USER")
@XmlRootElement
public class UserAccount extends Account {

    @Size(max = 255)
    @Column(name = "en_name", length = 255)
    //英文名
    private String enName;
    @Size(max = 255)
    @Column(name = "person_card_front", length = 255)
    //身份证文件正面URL
    private String personCardFront;
    @Size(max = 255)
    @Column(name = "person_card_back", length = 255)
    //身份证文件背面URL
    private String personCardBack;
    @Size(max = 255)
    @Column(name = "person_id", length = 255)
    //身份证号
    private String personId;
    @Column(name = "working_date")
    @Temporal(TemporalType.TIMESTAMP)
    //从业开始时间
    private Date workingDate;
    @Size(max = 255)
    @Column(name = "company", length = 255)
    //公司
    private String company;
    @Size(max = 255)
    @Column(name = "position", length = 255)
    //职务
    private String position;
    @Lob
    @Size(max = 65535)
    @Column(name = "work_experience")
    //工作经验
    private String workExperience;
    @Lob
    @Size(max = 65535)
    @Column(name = "project_experience")
    //项目经验
    private String projectExperience;

    public String getEnName() {
        return enName;
    }

    public void setEnName(String enName) {
        this.enName = enName;
    }

    public String getPersonCardFront() {
        return personCardFront;
    }

    public void setPersonCardFront(String personCardFront) {
        this.personCardFront = personCardFront;
    }

    public String getPersonCardBack() {
        return personCardBack;
    }

    public void setPersonCardBack(String personCardBack) {
        this.personCardBack = personCardBack;
    }

    public String getPersonId() {
        return personId;
    }

    public void setPersonId(String personId) {
        this.personId = personId;
    }

    public Date getWorkingDate() {
        return workingDate;
    }

    public void setWorkingDate(Date workingDate) {
        this.workingDate = workingDate;
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

    public String getWorkExperience() {
        return workExperience;
    }

    public void setWorkExperience(String workExperience) {
        this.workExperience = workExperience;
    }

    public String getProjectExperience() {
        return projectExperience;
    }

    public void setProjectExperience(String projectExperience) {
        this.projectExperience = projectExperience;
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
        if (!(object instanceof UserAccount)) {
            return false;
        }
        UserAccount other = (UserAccount) object;
        if ((getId() == null && other.getId() != null) || (getId() != null && !getId().equals(other.getId()))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.UserAccount[ id=" + getId() + " ]";
    }

}
