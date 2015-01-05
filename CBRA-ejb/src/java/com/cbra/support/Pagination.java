package com.cbra.support;

import java.util.List;

/**
 * 分页实体
 *
 * @author yin.weilong
 * @param <T>
 */
public class Pagination<T> {

    /**
     * 当前页号
     */
    private int currentPage = 1;

    /**
     * 每页要显示的记录数
     */
    private int pageSize = 15;

    /**
     * 总记录数
     */
    private int totalRows = 0;

    /**
     * 总页数
     */
    private int totalPages = 1;

    /**
     * 符合分页条件的数据列表
     */
    private List<T> data;

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalRows() {
        return totalRows;
    }

    public void setTotalRows(int totalRows) {
        this.totalRows = totalRows;
    }

    public List<T> getData() {
        return data;
    }

    public void setData(List<T> data2) {
        this.data = data2;
    }

    /**
     * 计算出总页数
     *
     * @return 总页数
     */
    public int getTotalPages() {
        if (totalRows <= 0) {
            return 1;
        } else {
            return (this.totalRows + this.pageSize - 1) / this.pageSize;
        }
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    /**
     * 计算分页记录起始下标
     *
     * @return
     */
    public int getStartIndex() {
        return (this.getCurrentPage() - 1) * (this.getPageSize());
    }
}
