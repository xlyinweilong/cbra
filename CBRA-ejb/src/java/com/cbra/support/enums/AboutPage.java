/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * about页
 *
 * @author yin.weilong
 */
public enum AboutPage {

    MEMBERSHIP_APPLICATION("MEMBERSHIP_APPLICATION", "业主", "业主",1),
    JOIN_REG("JOIN_REG", "咨询公司", "咨询公司",2),
    JOIN_REG_C("C", "设计院", "设计院",3),
    QUARTERS("D", "EPC总包商", "EPC总包商",4),
    QUARTERS_DETAILS("E", "施工承包商（施工总包）", "施工承包商（施工总包）",5),
    RECRUIT("K", "运营商", "运营商",11),
    COOPERATION("K", "运营商", "运营商",11),
    IDEA("K", "运营商", "运营商",11),
    PATTERN("K", "运营商", "运营商",11),
    COURSE("K", "运营商", "运营商",11),
    SPEECH("K", "运营商", "运营商",11),
    DECLARATION("K", "运营商", "运营商",11),
    CONTACT_US("K", "运营商", "运营商",11),
    THREE_PARTY_OFFER("K", "运营商", "运营商",11);

    private String key;
    private String name;
    private String enName;
    private int value;

    AboutPage(String key, String name,String enName,int value) {
        this.key = key;
        this.name = name;
        this.value = value;
    }

    public static String getName(String key) {
        return AboutPage.valueOf(key).getName();
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
