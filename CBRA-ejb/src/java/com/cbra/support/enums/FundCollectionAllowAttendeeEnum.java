/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 允许的参加者
 *
 * @author yin.weilong
 */
public enum FundCollectionAllowAttendeeEnum {

    PUBLIC,//开放
    ALL_MEMBERS,//所有会员
    ONLY_COMPANY;//仅限企业会员

    public String getMean(){
        switch (this) {
            case PUBLIC:
                return "会员非会员均可参加";
            case ALL_MEMBERS:
                return "仅限会员参加";
            case ONLY_COMPANY:
                return "仅限企业会员参加";
        }
        return null;
    }

}
