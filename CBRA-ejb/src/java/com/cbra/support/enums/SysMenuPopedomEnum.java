/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 菜单分类
 *
 * @author yin.weilong
 */
public enum SysMenuPopedomEnum {

    COMMON, SUPER;

    /**
     * 获取中文意思
     *
     * @param popedom
     * @return
     */
    public String getMean(SysMenuPopedomEnum popedom) {
        switch (popedom) {
            case SUPER:
                return "超级管理员菜单";
            default:
                return "普通菜单";
        }
    }
}
