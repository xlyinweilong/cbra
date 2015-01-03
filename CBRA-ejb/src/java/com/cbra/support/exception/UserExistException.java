/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.yoopay.support.exception;

/**
 *
 * @author HUXIAOFENG
 */
public class UserExistException extends Exception {

    /**
     * Creates a new instance of <code>UserExistException</code> without detail message.
     */
    public UserExistException() {
    }

    /**
     * Constructs an instance of <code>UserExistException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public UserExistException(String msg) {
        super(msg);
    }
}
