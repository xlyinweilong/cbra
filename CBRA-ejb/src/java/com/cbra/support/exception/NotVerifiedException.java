/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.yoopay.support.exception;

/**
 *
 * @author WangShuai
 */
public class NotVerifiedException extends Exception{
     /**
     * Creates a new instance of <code>AlreadyPaidException</code> without detail message.
     */
    public NotVerifiedException() {
    }

    /**
     * Constructs an instance of <code>AlreadyPaidException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public NotVerifiedException(String msg) {
        super(msg);
    }
}
