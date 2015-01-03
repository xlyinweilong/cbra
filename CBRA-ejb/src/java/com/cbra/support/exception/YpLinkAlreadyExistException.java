/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.yoopay.support.exception;

/**
 *
 * @author WangShuai
 */
public class YpLinkAlreadyExistException extends Exception {

    public YpLinkAlreadyExistException() {
    }

    public YpLinkAlreadyExistException(String msg) {
        super(msg);
    }
}