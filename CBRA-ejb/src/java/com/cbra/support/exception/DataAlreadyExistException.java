/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.yoopay.support.exception;

/**
 *
 * @author Yin.Weilong
 */
public class DataAlreadyExistException extends Exception {

    public DataAlreadyExistException(String message) {
        super(message);
    }

    public DataAlreadyExistException() {
    }
}
