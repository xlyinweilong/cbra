/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.yoopay.support.exception;

/**
 *
 * @author HUXIAOFENG
 */
public class FundCollectionStatusException extends Exception {

    /**
     * Creates a new instance of <code>FundCollectionStatusException</code> without detail message.
     */
    public FundCollectionStatusException() {
    }

    /**
     * Constructs an instance of <code>FundCollectionStatusException</code> with the specified detail message.
     * @param msg the detail message.
     */
    public FundCollectionStatusException(String msg) {
        super(msg);
    }
}
