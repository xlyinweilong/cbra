/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

import java.util.ResourceBundle;

/**
 * 产业链环节
 *
 * @author yin.weilong
 */
public enum AccountIcPosition {

    A("A", "GLOBAL_业主"),
    B("B", "GLOBAL_咨询公司"),
    C("C", "GLOBAL_设计院"),
    D("D", "GLOBAL_EPC总包商"),
    E("E", "GLOBAL_施工承包商(施工总包)"),
    F("F", "GLOBAL_施工承包商(施工分包)"),
    G("G", "GLOBAL_设备供应商"),
    H("H", "GLOBAL_材料供应商(只供材料)"),
    I("I", "GLOBAL_材料加服务"),
    J("J", "GLOBAL_信息化企业"),
    K("K", "GLOBAL_运营商"),
    Z("Z", "GLOBAL_其他");

    private String key;
    private String name;

    AccountIcPosition(String key, String name) {
        this.key = key;
        this.name = name;
    }

    public static String getName(String key, ResourceBundle bundle) {
        return bundle.getString(AccountIcPosition.valueOf(key).getName());
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
    
    public String getNameString() {
        return name.replaceAll("GLOBAL_", "");
    }

}
