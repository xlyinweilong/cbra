/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support;

/**
 *
 * @author chenjianlin
 */
public class NoPermException extends Exception {

    public NoPermException() {
    }

    public NoPermException(String msg) {
        super(msg);
    }
}
