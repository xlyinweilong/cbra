/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

import java.util.ResourceBundle;

/**
 * 员工人数(企业规模)
 *
 * @author yin.weilong
 */
public enum CompanyScaleEnum {

    LARGE,
    MIDDLE,
    SMALL,
    MINIATURE;

    public String getMean() {
        switch (this) {
            case LARGE:
                return "大于1000人";
            case MIDDLE:
                return "300到1000人";
            case SMALL:
                return "20到300人";
            case MINIATURE:
                return "20人以下";
            default:
                return null;
        }
    }
    
    public String getMean(ResourceBundle bundle) {
        switch (this) {
            case LARGE:
                return bundle.getString("GLOBAL_大于1000人");
            case MIDDLE:
                return bundle.getString("GLOBAL_300到1000人");
            case SMALL:
                return bundle.getString("GLOBAL_20到300人");
            case MINIATURE:
                return bundle.getString("GLOBAL_20人以下");
            default:
                return null;
        }
    }

}
