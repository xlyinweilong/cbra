/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.yoopay.support.exception;

/**
 *
 * @author Yin.Weilong
 */
public class AccountNotExistException extends Exception {

    public AccountNotExistException(String message) {
        super(message);
    }

    public AccountNotExistException() {
    }
}
