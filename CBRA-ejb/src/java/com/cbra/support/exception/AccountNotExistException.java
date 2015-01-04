/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.exception;

/**
 * 账户不存在异常
 *
 * @author Yin.Weilong
 */
public class AccountNotExistException extends Exception {

    public AccountNotExistException(String message) {
        super(message);
    }

    public AccountNotExistException() {
    }
}
