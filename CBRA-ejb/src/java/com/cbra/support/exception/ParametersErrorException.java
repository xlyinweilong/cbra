/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.yoopay.support.exception;

public class ParametersErrorException extends Exception {

    /**
     * Creates a new instance of <code>UserExistException</code> without detail message.
     */
    public ParametersErrorException() {
    }

    /**
     * Constructs an instance of <code>UserExistException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public ParametersErrorException(String msg) {
        super(msg);
    }
}
