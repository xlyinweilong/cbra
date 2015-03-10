/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 允许的参加者
 *
 * @author yin.weilong
 */
public enum OrderStatusEnum {

    //0.初始化 1.待审批 2.审批拒绝 3.待支付 4.待确认 5.支付成功 6.支付失败 7.失效(退款) 8.支付超时
    INIT, PENDING_FOR_APPROVAL, APPROVAL_REJECT, PENDING_PAYMENT, PENDING_PAYMENT_CONFIRM, SUCCESS, FAILURE, INVALID, PAYMENT_TIMEOUT;

    public String getMean() {
        switch (this) {
            case INIT:
                return "初始化";
            case PENDING_FOR_APPROVAL:
                return "待审批";
            case APPROVAL_REJECT:
                return "审批拒绝";
            case PENDING_PAYMENT:
                return "待支付";
            case PENDING_PAYMENT_CONFIRM:
                return "支付待确认";
            case SUCCESS:
                return "支付成功";
            case FAILURE:
                return "支付失败";
            case INVALID:
                return "失效(退款)";
            case PAYMENT_TIMEOUT:
                return "支付超时";
            default:
                return null;
        }
    }

}
