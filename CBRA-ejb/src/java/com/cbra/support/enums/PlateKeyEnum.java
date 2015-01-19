/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * 板块KEY
 *
 * @author yin.weilong
 */
public enum PlateKeyEnum {

    HOME_NAVIGATION,//首页标签
    HOME_SHUFFLING_AD_MENU,//广告轮播图
    ABOUT, CONTACT_US,
    NEWS,//新闻
    MEMBER, COMMITTEE;

    /**
     * 获取需要配置权限的栏目
     *
     * @return
     */
    public static List<PlateKeyEnum> getNeedAuthority() {
        List<PlateKeyEnum> list = new ArrayList<>();
        list.add(HOME_NAVIGATION);
        list.add(ABOUT);
        list.add(CONTACT_US);
        list.add(NEWS);
        list.add(MEMBER);
        list.add(COMMITTEE);
        return list;
    }

    /**
     * 获取可以留言的栏目
     *
     * @return
     */
    public static List<PlateKeyEnum> getLeaveMessage() {
        List<PlateKeyEnum> list = new ArrayList<>();
        list.add(CONTACT_US);
        list.add(NEWS);
        list.add(MEMBER);
        list.add(COMMITTEE);
        return list;
    }
}
