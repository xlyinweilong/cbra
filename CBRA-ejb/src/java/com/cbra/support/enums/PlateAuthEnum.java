/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * 菜单权限
 *
 * @author yin.weilong
 */
public enum PlateAuthEnum {

    ONLY_VIEW,//仅可见
    NO_VIEW,//
    VIEW_AND_REPAY;

    public String getAuthMean() {
        switch (this) {
            case ONLY_VIEW:
                return "仅可见";
            case NO_VIEW:
                return "详细不可见";
            case VIEW_AND_REPAY:
                return "可见可留言";
            default:
                return "详细不可见";
        }
    }

}
