/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

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

}
