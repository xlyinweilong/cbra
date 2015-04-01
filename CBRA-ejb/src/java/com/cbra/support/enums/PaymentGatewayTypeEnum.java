/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 网关类型
 *
 * @author yin.weilong
 */
public enum PaymentGatewayTypeEnum {

    ALIPAY,
    ALIPAY_BANK,
    BANK_TRANSFER;

    public String getMean() {
        switch (this) {
            case ALIPAY:
                return "支付宝";
            case ALIPAY_BANK:
                return "支付宝网银";
            case BANK_TRANSFER:
                return "其他支付方式";
            default:
                return null;
        }
    }

}
