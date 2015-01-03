/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web.support;

/**
 *
 * @author HUXIAOFENG
 */
public class BadPostActionException extends Exception {

    /**
     * Creates a new instance of <code>BadPostActionException</code> without detail message.
     */
    public BadPostActionException() {
    }

    /**
     * Constructs an instance of <code>BadPostActionException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public BadPostActionException(String msg) {
        super(msg);
    }
}
