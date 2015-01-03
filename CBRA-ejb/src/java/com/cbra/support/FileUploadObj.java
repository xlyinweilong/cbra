/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.support;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

/**
 *
 * @author WangShuai
 */
public class FileUploadObj extends LinkedHashMap {

    private double maxSizeMB;
    private LinkedList<FileUploadItem> fileList = new LinkedList<FileUploadItem>();

    //Form Field
    public String[] getFormFieldArray(String key) {
        Object o = this.get(key);
        if (o instanceof String) {
            return new String[]{(String) o};
        }
        return (String[]) this.get(key);
    }

    public String getFormField(String key) {
        return (String) this.get(key);
    }

    public Long getLongFormField(String key) {
        try {
            return Long.parseLong(this.getFormField(key));
        } catch (NumberFormatException e) {
            return null;
        }
    }

    public Date getDateFormField(String key, String style) {
        try {
            return Tools.parseDate(this.getFormField(key), style);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    public Double getDoubleFormField(String key) {
        try {
            return Double.parseDouble(this.getFormField(key));
        } catch (NumberFormatException e) {
            return null;
        } catch (NullPointerException ne) {
            return null;
        }
    }

    public Boolean getBooleanFormField(String key) {
        try {
            return Boolean.parseBoolean(this.getFormField(key));
        } catch (NumberFormatException e) {
            return null;
        }
    }

    public Boolean optBooleanFormField(String key, boolean opt) {
        try {
            return Boolean.parseBoolean(this.getFormField(key));
        } catch (NumberFormatException e) {
            return opt;
        }
    }

    public BigDecimal optBigDecimalFormField(String key, BigDecimal opt) {
        String sValue = getFormField(key);
        if (sValue == null) {
            return opt;
        }
        try {
            return new BigDecimal(sValue);
        } catch (NumberFormatException ex) {
            return opt;
        }
    }
    
    public Integer getIntegerFormField(String key) {
        try {
            return Integer.parseInt(this.getFormField(key));
        } catch (NumberFormatException e) {
            return null;
        }
    }

    public void putFormField(String key, String value) {
        this.put(key, value);
    }

    public String[] putToFormFieldArray(String key, String value) {
        Collection list = new HashSet();
        Object oValue = this.get(key);
        String[] old = null;
        if (oValue instanceof String) {
            old = new String[]{(String) oValue};
        } else {
            old = (String[]) oValue;
        }
        if (old != null) {
            String[] arr = (String[]) old;
            list.addAll(Arrays.asList(arr));
        }
        list.add(value);
        String[] toArray = (String[]) list.toArray(new String[0]);
        this.put(key, toArray);
        return toArray;
    }

    public FileUploadItem getFileField(String key) {
        return (FileUploadItem) this.get(key);
    }

    public void putFileField(String key, FileUploadItem value) {
        this.put(key, value);
    }

    public void addFileUploadItem(FileUploadItem e) {
        fileList.add(e);
    }

    public List<FileUploadItem> getFileList() {
        return fileList;
    }

    public double getMaxSizeMB() {
        return maxSizeMB;
    }

    public void setMaxSizeMB(double maxSizeMB) {
        this.maxSizeMB = maxSizeMB;
    }

    private Map<String, Object> fuzzySearchByKey(Map<String, Object> map, String skey) {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        for (Map.Entry<String, Object> entry : (Set<Map.Entry>) map) {
            String key = entry.getKey();
            if (key.indexOf(skey) != -1) {
                resultMap.put(key, entry.getValue());
            }
        }
        return resultMap;
    }

    public static void main(String[] args) {
        FileUploadObj f = new FileUploadObj();
        //System.out.println(f.getIndexStr("register_question[0]"));

    }
}
