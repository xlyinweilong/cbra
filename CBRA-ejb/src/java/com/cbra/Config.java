/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra;

import com.cbra.entity.FundCollection;
import com.cbra.entity.Offer;
import com.cbra.entity.PlateInformation;
import com.cbra.support.PathUtil;
import java.math.BigDecimal;
import java.util.List;

/**
 * 配置信息
 *
 * @author yin
 */
public class Config {

    private Config() {
    }
    public static final BigDecimal MEMBERSHIP_FEE = new BigDecimal("800");

    public static final BigDecimal MEMBERSHIP_FEE_COMPANY = new BigDecimal("10000");

    public static final String PAYGATE_ALIPAY_NOTIFY_URL = "http://www.cbra.com/paygate/alipay_notify";

    public static final String PAYGATE_ALIPAY_RETURN_URL = "http://www.cbra.com/paygate/alipay_return";

//    public static final String FILE_UPLOAD_DIR = "f:/cbrd/";
    public static final String FILE_UPLOAD_DIR = "/home/cbra/glassfish4/glassfish/domains/domain1/cbra/data/";
    public static final String HTML_EDITOR_UPLOAD = "html_editor_upload";

    public static final String FILE_UPLOAD_TEMP = "temp";

    public static final String FILE_UPLOAD_PLATE = "plate";

    public static final String FILE_UPLOAD_ACCOUNT = "account_ic";

    public static final String FILE_UPLOAD_ACCOUNT_HEAD_IMAGE = "account_head_image";

//    public static final String FILE_UPLOAD_TEMP_DIR = "f:/test";
    public static final String FILE_UPLOAD_TEMP_DIR = "/home/cbra/glassfish4/glassfish/domains/domain1/cbra/test/";
//    public static final String HTTP_URL_BASE = "http://127.0.0.1:8080/";

    public static final String HTTP_URL_BASE = "http://www.cbra.com/";
    //持久信息

    public static List<FundCollection> eventListIndex = null;

    public static List<PlateInformation> newsList = null;

    public static List<PlateInformation> newsList5 = null;

    public static List<PlateInformation> industryList = null;

    public static List<Offer> offerListIndex = null;

    public static List<PlateInformation> materialListIndex = null;

    public static List<PlateInformation> industrializationListIndex = null;

    public static List<PlateInformation> greenListIndex = null;

    public static List<PlateInformation> bimListIndex = null;

    public static List<PlateInformation> homeSAD = null;

    public static PlateInformation homeAd = null;

    public static PlateInformation homeAbout = null;

    public static List<PlateInformation> homeStyle = null;

    public static List<PlateInformation> homeExpert = null;

    public static PlateInformation homeNews = null;
    
    public static PlateInformation topInto = null;

    public static PlateInformation topStyle = null;

    public static List<PlateInformation> topEvent = null;

    public static List<PlateInformation> topTrain = null;

    public static List<PlateInformation> topJoin = null;
    
    public static List<FundCollection> eventListIndexEn = null;

    public static List<PlateInformation> newsListEn = null;

    public static List<PlateInformation> newsList5En = null;

    public static List<PlateInformation> industryListEn = null;

    public static List<Offer> offerListIndexEn = null;

    public static List<PlateInformation> materialListIndexEn = null;

    public static List<PlateInformation> industrializationListIndexEn = null;

    public static List<PlateInformation> greenListIndexEn = null;

    public static List<PlateInformation> bimListIndexEn = null;

    public static List<PlateInformation> homeSADEn = null;

    public static PlateInformation homeAdEn = null;

    public static PlateInformation homeAboutEn = null;

    public static List<PlateInformation> homeStyleEn = null;

    public static List<PlateInformation> homeExpertEn = null;

    public static PlateInformation homeNewsEn = null;
    
    public static PlateInformation topIntoEn = null;

    public static PlateInformation topStyleEn = null;

    public static List<PlateInformation> topEventEn = null;

    public static List<PlateInformation> topTrainEn = null;

    public static List<PlateInformation> topJoinEn = null;
}
