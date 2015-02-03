/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 用户状态
 *
 * @author yin.weilong
 */
public enum AccountStatus {

    PENDING_FOR_APPROVAL,//待审批
    APPROVAL_REJECT,//审批拒绝
    ASSOCIATE_MEMBER,//准会员
    MEMBER;//会员

    public String getMean() {
        switch (this) {
            case PENDING_FOR_APPROVAL:
                return "待审批";
            case APPROVAL_REJECT:
                return "审批拒绝";
            case ASSOCIATE_MEMBER:
                return "准会员";
            case MEMBER:
                return "正式会员";
            default:
                return "";
        }
    }

}
