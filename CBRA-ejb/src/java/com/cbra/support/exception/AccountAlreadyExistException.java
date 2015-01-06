/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.exception;

/**
 * 账户已经存在异常
 *
 * @author Yin.Weilong
 */
public class AccountAlreadyExistException extends Exception {

    /**
     * Creates a new instance of <code>AlreadyPaidException</code> without detail message.
     */
    public AccountAlreadyExistException() {
    }

    /**
     * Constructs an instance of <code>AlreadyPaidException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public AccountAlreadyExistException(String msg) {
        super(msg);
    }
}
