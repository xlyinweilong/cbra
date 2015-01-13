/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.enums;

/**
 * 消息性质
 *
 * @author yin.weilong
 */
public enum MessageTypeEnum {

    PUBLISH_FROM_USER,//用户发布
    REPLAY_FROM_USER,//用户回复
    REPLAY_FROM_SYSTEM,//系统回复
    REPLAY_FROM_ADMIN,//管理员回复
}
