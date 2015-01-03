/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support;

/**
 *
 * @author WangShuai
 */
public class FileUploadItem {
    //上传前文件名信息
    //origFileName = origFileBaseName + origFileExt
    private String origFileName;
    private String origFileBaseName;
    private String origFileExtName;
    //上传后文件名信息
    private String uploadFileName;
    private String uploadFullPath;
    private long fileSize;
    //上传域name
    private String fieldName;

    public String getFieldName() {
        return fieldName;
    }

    public void setFieldName(String fieldName) {
        this.fieldName = fieldName;
    }

    public long getFileSize() {
        return fileSize;
    }

    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }

    public String getOrigFileBaseName() {
        return origFileBaseName;
    }

    public void setOrigFileBaseName(String origFileBaseName) {
        this.origFileBaseName = origFileBaseName;
    }

    public String getOrigFileExtName() {
        return origFileExtName;
    }

    public void setOrigFileExtName(String origFileExtName) {
        this.origFileExtName = origFileExtName;
    }

    public String getOrigFileName() {
        return origFileName;
    }

    public void setOrigFileName(String origFileName) {
        this.origFileName = origFileName;
    }

    public String getUploadFileName() {
        return uploadFileName;
    }

    public void setUploadFileName(String uploadFileName) {
        this.uploadFileName = uploadFileName;
    }

    public String getUploadFullPath() {
        return uploadFullPath;
    }

    public void setUploadFullPath(String uploadFullPath) {
        this.uploadFullPath = uploadFullPath;
    }
    
    
}
