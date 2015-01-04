/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.exception;

/**
 * EJB 层抛出的消息异常，需要WEB层捕获
 * 
 * @author yin.weilong
 */
public class EjbMessageException extends Exception {

    public EjbMessageException() {
    }

    public EjbMessageException(String msg) {
        super(msg);
    }
}
