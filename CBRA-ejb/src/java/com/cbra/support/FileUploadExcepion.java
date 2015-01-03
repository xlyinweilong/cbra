/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support;

/**
 *
 * @author WangShuai
 */
public class FileUploadExcepion extends Exception {

    /**
     * Creates a new instance of <code>AlreadyPaidException</code> without detail message.
     */
    public FileUploadExcepion() {
    }

    /**
     * Constructs an instance of <code>AlreadyPaidException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public FileUploadExcepion(String msg) {
        super(msg);
    }
}
