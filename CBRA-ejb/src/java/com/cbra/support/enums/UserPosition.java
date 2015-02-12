/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

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
    ENGINEER;//工程师

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
            default:
                return "其他";
        }
    }

}
