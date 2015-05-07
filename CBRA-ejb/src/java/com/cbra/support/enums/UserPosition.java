/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

import java.util.ResourceBundle;
import javax.servlet.jsp.jstl.fmt.LocalizationContext;

/**
 * 用户岗位
 *
 * @author yin.weilong
 */
public enum UserPosition {

    CHAIRMAN,//董事长
    GENERAL,//总经理
    PROJECT,//项目经理
    CONSTRUCTION,//施工经理
    MARKETING,//营销经理
    DB,//市场开拓经理
    DESIGNER,//设计师
    ENGINEER,
    NO;//工程师

    public String getMean(ResourceBundle bundle) {
        switch (this) {
            case CHAIRMAN:
                return bundle.getString("GLOBAL_董事长");
            case GENERAL:
                return bundle.getString("GLOBAL_总经理");
            case PROJECT:
                return bundle.getString("GLOBAL_项目经理");
            case CONSTRUCTION:
                return bundle.getString("GLOBAL_施工经理");
            case MARKETING:
                return bundle.getString("GLOBAL_营销经理");
            case DB:
                return bundle.getString("GLOBAL_市场开拓经理");
            case DESIGNER:
                return bundle.getString("GLOBAL_设计师");
            case ENGINEER:
                return bundle.getString("GLOBAL_工程师");
            case NO:
                return bundle.getString("GLOBAL_暂无职务");
            default:
                return bundle.getString("GLOBAL_其他");
        }
    }

    public String getMean() {
        switch (this) {
            case CHAIRMAN:
                return "董事长";
            case GENERAL:
                return "总经理";
            case PROJECT:
                return "项目经理";
            case CONSTRUCTION:
                return "施工经理";
            case MARKETING:
                return "营销经理";
            case DB:
                return "市场开拓经理";
            case DESIGNER:
                return "设计师";
            case ENGINEER:
                return "工程师";
            case NO:
                return "暂无职务";
            default:
                return "其他";
        }
    }
}
