/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support;

import java.util.LinkedList;

/**
 * 分页
 *
 * @author yin.weilong
 */
public class ResultList<E> extends LinkedList<E> {

    private int totalCount;
    private int maxPerPage;
    private int pageIndex;
    private int startIndex;

    public int getTotalPageCount() {
        int totalPageCount = 0;
        if (getMaxPerPage() > 0 && getTotalCount() > 0) {
            totalPageCount = (int) Math.ceil((double) getTotalCount() / (double) getMaxPerPage());
        }
        return totalPageCount;
    }

    /**
     * @return the totalCount
     */
    public int getTotalCount() {
        return totalCount;
    }

    /**
     * @param totalCount the totalCount to set
     */
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    /**
     * @return the maxPerPage
     */
    public int getMaxPerPage() {
        return maxPerPage;
    }

    /**
     * @param maxPerPage the maxPerPage to set
     */
    public void setMaxPerPage(int maxPerPage) {
        this.maxPerPage = maxPerPage;
    }

    /**
     * @return the pageIndex
     */
    public int getPageIndex() {
        return pageIndex;
    }

    /**
     * @param pageIndex the pageIndex to set
     */
    public void setPageIndex(int pageIndex) {
        this.pageIndex = pageIndex;
    }

    /**
     * @return the startIndex
     */
    public int getStartIndex() {
        return startIndex;
    }

    /**
     * @param startIndex the startIndex to set
     */
    public void setStartIndex(int startIndex) {
        this.startIndex = startIndex;
    }
}
