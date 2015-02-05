/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 公司性质
 *
 * @author yin.weilong
 */
public enum CompanyNatureEnum {

    SOLELY_STATE_OWNED,
    STATE_OWNED_HOLDING,
    SINO_FOREIGN_JOINT_VENTURE,
    PRIVATE_ENTERPRISE,
    NON_PROFIT_ORGANIZATION,
    LISTED_COMPANY,
    OTHERS;

    public String getMean() {
        switch (this) {
            case SOLELY_STATE_OWNED:
                return "国有独资";
            case STATE_OWNED_HOLDING:
                return "国有控股";
            case SINO_FOREIGN_JOINT_VENTURE:
                return "中外合资/合作";
            case PRIVATE_ENTERPRISE:
                return "私营/民营企业";
            case NON_PROFIT_ORGANIZATION:
                return "非营利机构";
            case LISTED_COMPANY:
                return "上市公司";
            case OTHERS:
                return "其他";
            default:
                return "其他";
        }
    }

}