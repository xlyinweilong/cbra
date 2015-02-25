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
    HOME_AD_MENU,//广告图
    HOME_ABOUT,//首页关于
    HOME_STYLE,//首页会员风采
    HOME_EXPERT,//首页专家
    ABOUT, CONTACT_US,
    NEWS,//新闻
    OFFER,//招聘
    EVENT,//活动
    COMMITTEE;//人物

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
        list.add(OFFER);
        list.add(EVENT);
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
        list.add(EVENT);
        list.add(COMMITTEE);
        return list;
    }
}
