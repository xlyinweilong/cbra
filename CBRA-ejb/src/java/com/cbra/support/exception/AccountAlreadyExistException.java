/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.yoopay.support.exception;

/**
 *
 * @author HUXIAOFENG
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
