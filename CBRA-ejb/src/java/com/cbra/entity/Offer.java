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
import com.cbra.support.enums.PlateTypeEnum;
import java.io.Serializable;
import java.util.Calendar;
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
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 招聘
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "offer")
@XmlRootElement
public class Offer implements Serializable {

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
    @JoinColumn(name = "plate_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private Plate plate = null;
    @Column(name = "name", length = 255)
    //名称
    private String name;
    @Column(name = "en_name", length = 255)
    //英文名
    private String enName;
    @Column(name = "mobile", length = 255)
    //手机
    private String mobile;
    @Column(name = "email", length = 255)
    //email
    private String email;
    @Column(name = "obtain", length = 255)
    //从来年限
    private String obtain;
    @Column(name = "company", length = 255)
    //公司
    private String company;
    @Column(name = "address", length = 255)
    //地址
    private String address;
    @Column(name = "zip_code", length = 255)
    //邮编
    private String zipCode;
    @Column(name = "position", length = 255)
    //职位
    private String position;
    @Column(name = "code", length = 255)
    //编码
    private String code;
    @Column(name = "depart", length = 255)
    //部门
    private String depart;
    @Column(name = "city", length = 255)
    //地区
    private String city;
    @Column(name = "station", length = 255)
    //岗位
    private String station;
    @Column(name = "count", length = 255)
    //人数
    private String count;
    @Column(name = "monthly", length = 255)
    //月薪
    private String monthly;
    @Lob
    @Column(name = "description")
    //描述,经验
    private String description;
    @Lob
    @Column(name = "duty")
    //职责
    private String duty;
    @Lob
    @Column(name = "competence")
    //资格
    private String competence;
    @Column(name = "age")
    //年龄
    private String age;
    @Column(name = "gender")
    //性别
    private String gender;
    @Column(name = "english_level")
    //英语等级
    private String englishLevel;
    @Column(name = "education")
    //学历
    private String education;
    @Column(name = "language", length = 2)
    @Enumerated(EnumType.STRING)
    private LanguageType languageType = LanguageType.ZH;
    @Basic(optional = false)
    @NotNull
    @Column(name = "push_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date pushDate = new Date();
    @Column(name = "deleted")
    private boolean deleted = false;

    public String getPositionIndexStr() {
        if (position.length() > 15) {
            return position.substring(0, 14) + "...";
        }
        return position;
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

    public Plate getPlate() {
        return plate;
    }

    public void setPlate(Plate plate) {
        this.plate = plate;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDepart() {
        return depart;
    }

    public void setDepart(String depart) {
        this.depart = depart;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public String getCount() {
        return count;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public String getMonthly() {
        return monthly;
    }

    public void setMonthly(String monthly) {
        this.monthly = monthly;
    }

    public String getDescription() {
        return description;
    }

    public String getDescriptionHtml() {
        return Tools.getEscapedBrHtml(description);
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDuty() {
        return duty;
    }

    public String getDutyHtml() {
        return Tools.getEscapedBrHtml(duty);
    }

    public void setDuty(String duty) {
        this.duty = duty;
    }

    public String getCompetence() {
        return competence;
    }

    public String getCompetenceHtml() {
        return Tools.getEscapedBrHtml(competence);
    }

    public void setCompetence(String competence) {
        this.competence = competence;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public LanguageType getLanguageType() {
        return languageType;
    }

    public void setLanguageType(LanguageType languageType) {
        this.languageType = languageType;
    }

    public String getEnglishLevel() {
        return englishLevel;
    }

    public void setEnglishLevel(String englishLevel) {
        this.englishLevel = englishLevel;
    }

    public String getEducation() {
        return education;
    }

    public void setEducation(String education) {
        this.education = education;
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

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEnName() {
        return enName;
    }

    public void setEnName(String enName) {
        this.enName = enName;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getObtain() {
        return obtain;
    }

    public void setObtain(String obtain) {
        this.obtain = obtain;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
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
        if (!(object instanceof Offer)) {
            return false;
        }
        Offer other = (Offer) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.Offer[ id=" + id + " ]";
    }

}
