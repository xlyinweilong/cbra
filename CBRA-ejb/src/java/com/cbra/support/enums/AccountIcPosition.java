/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 产业链环节
 *
 * @author yin.weilong
 */
public enum AccountIcPosition {

    A("A", "业主"),
    B("B", "咨询公司"),
    C("C", "设计院"),
    D("D", "EPC总包商"),
    E("E", "施工承包商（施工总包）"),
    F("F", "施工承包商（专业分包总）"),
    G("G", "设备供应商"),
    H("H", "材料供应商（只供材料）"),
    I("I", "材料加服务"),
    J("J", "信息化企业"),
    K("K", "运营商"),
    Z("Z", "其他");

    private String key;
    private String name;

    AccountIcPosition(String key, String name) {
        this.key = key;
        this.name = name;
    }

    public static String getName(String key) {
        return AccountIcPosition.valueOf(key).getName();
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
