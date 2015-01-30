/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support.exception;

/**
 * 邮件异常
 *
 * @author Yin.Weilong
 */
public class EmailException extends Exception {

    /**
     * Creates a new instance of <code>AlreadyPaidException</code> without detail message.
     */
    public EmailException() {
    }

    /**
     * Constructs an instance of <code>AlreadyPaidException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public EmailException(String msg) {
        super(msg);
    }
}
