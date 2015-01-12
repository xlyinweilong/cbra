/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 语言
 *
 * @author yin.weilong
 */
public enum LanguageType {

    ZH, EN;

    public String getLanguageMean() {
        switch (this) {
            case EN:
                return "英语";
            default:
                return "中文";
        }
    }

}
