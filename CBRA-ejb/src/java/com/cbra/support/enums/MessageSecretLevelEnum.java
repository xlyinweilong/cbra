/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 消息保密级别
 *
 * @author yin.weilong
 */
public enum MessageSecretLevelEnum {

    PUBLIC,//公开的
    ALL_USER,//所有用户可见
    ONLY_COMPANY,//公司用户可见
    PRIVATE;//只能自己看见

    public String getMean() {
        switch (this) {
            case PUBLIC:
                return "公开的";
            case ALL_USER:
                return "所有用户可见";
            case ONLY_COMPANY:
                return "公司用户可见";
            case PRIVATE:
                return "只能自己看见";
        }
        return null;
    }
}
