/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web.support;

/**
 *
 * @author HUXIAOFENG
 */
public class BadPageException extends Exception {

    /**
     * Creates a new instance of <code>BadPageException</code> without detail message.
     */
    public BadPageException() {
    }

    /**
     * Constructs an instance of <code>BadPageException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public BadPageException(String msg) {
        super(msg);
    }
}
