/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.enums.UserPosition;
import java.util.Date;
import java.util.ResourceBundle;
import javax.persistence.Column;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
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

    @Column(name = "en_name", length = 255)
    //英文名
    private String enName;
    @Column(name = "person_card_front", length = 255)
    //身份证文件正面URL
    private String personCardFront;
    @Column(name = "person_card_back", length = 255)
    //身份证文件背面URL
    private String personCardBack;
    @Column(name = "person_id", length = 255)
    //身份证号
    private String personId;
    @Column(name = "working_year")
    //从业年限
    private int workingYear;
    @Column(name = "company")
    //公司
    private String company;
    @Column(name = "position")
    @Enumerated(EnumType.STRING)
    //职务
    private UserPosition position;
    @Column(name = "position_others", length = 255)
    //职务
    private String positionOthers;
    @Lob
    @Column(name = "work_experience")
    //工作经验
    private String workExperience;
    @Lob
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

    public int getWorkingYear() {
        return workingYear;
    }

    public void setWorkingYear(int workingYear) {
        this.workingYear = workingYear;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public UserPosition getPosition() {
        return position;
    }

    public void setPosition(UserPosition position) {
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

    public String getPositionOthers() {
        return positionOthers;
    }

    public void setPositionOthers(String positionOthers) {
        this.positionOthers = positionOthers;
    }

    public String getPositionString(ResourceBundle bundle) {
        if (position == null) {
            return positionOthers;
        } else {
            return position.getMean(bundle);
        }
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
