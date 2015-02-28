/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 活动语言
 *
 * @author yin.weilong
 */
public enum FundCollectionLanaguageEnum {

    ZH, EN;
    public String getMean(){
        switch (this) {
            case ZH:
                return "中文";
            case EN:
                return "英文";
        }
        return null;
    }
}
