/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.web.support;

import java.util.HashMap;

/**
 * 返回信息封装类
 *
 * @author yin.weilong
 */
public class PostResult {

    private boolean success = true;
    private String singleSuccessMsg;
    private String singleErrorMsg;
    private HashMap<String, String> errorMsgs = new HashMap<String, String>();
    private String redirectUrl;
    private Object object;

    public PostResult(boolean success, String singleMsg) {
        this.success = success;
        if (success) {
            this.singleSuccessMsg = singleMsg;
        } else {
            this.singleErrorMsg = singleMsg;
        }
    }

    public PostResult(boolean success, String singleMsg, String redirectUrl) {
        this(success, singleMsg);
        this.redirectUrl = redirectUrl;
    }

    public void addErrorMsg(String key, String msg) {
        this.success = false;
        errorMsgs.put(key, msg);
    }

    public String getRedirectUrl() {
        return redirectUrl;
    }

    public void setRedirectUrl(String redirectUrl) {
        this.redirectUrl = redirectUrl;
    }

    /**
     * @return the success
     */
    public boolean isSuccess() {
        return success;
    }

    /**
     * @param success the success to set
     */
    public void setSuccess(boolean success) {
        this.success = success;
    }

    /**
     * @return the singleSuccessMsg
     */
    public String getSingleSuccessMsg() {
        return singleSuccessMsg;
    }

    /**
     * @param singleSuccessMsg the singleSuccessMsg to set
     */
    public void setSingleSuccessMsg(String singleSuccessMsg) {
        this.success = true;
        this.singleSuccessMsg = singleSuccessMsg;
    }

    /**
     * @return the singleErrorMsg
     */
    public String getSingleErrorMsg() {
        return singleErrorMsg;
    }

    /**
     * @param singleErrorMsg the singleErrorMsg to set
     */
    public void setSingleErrorMsg(String singleErrorMsg) {
        this.success = false;
        this.singleErrorMsg = singleErrorMsg;
    }

    /**
     * @return the errorMsgs
     */
    public HashMap getErrorMsgs() {
        return errorMsgs;
    }

    /**
     * @param errorMsgs the errorMsgs to set
     */
    public void setErrorMsgs(HashMap errorMsgs) {
        this.success = false;
        this.errorMsgs = errorMsgs;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

}
