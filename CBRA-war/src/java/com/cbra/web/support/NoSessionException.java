/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web.support;

/**
 *
 * @author HUXIAOFENG
 */
public class NoSessionException extends Exception {

    /**
     * Creates a new instance of <code>NoSessionException</code> without detail message.
     */
    public NoSessionException() {
    }

    /**
     * Constructs an instance of <code>NoSessionException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public NoSessionException(String msg) {
        super(msg);
    }
}
