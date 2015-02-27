/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.Config;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.support.enums.PlateKeyEnum;
import com.cbra.support.enums.PlateTypeEnum;
import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.Asynchronous;
import javax.ejb.EJB;
import javax.ejb.Singleton;
import javax.ejb.LocalBean;
import javax.ejb.Schedule;
import javax.ejb.Startup;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import org.apache.commons.configuration.MapConfiguration;

/**
 * 配置信息服务
 *
 * @author yin.weilong
 */
@Singleton
@LocalBean
@Startup
public class ConfigService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    private static final Logger logger = Logger.getLogger(ConfigService.class.getName());

    @EJB
    private CbraService cbraService;

    @PostConstruct
    public void init() {
        loadConfig();
    }

    @Schedule(minute = "59", hour = "23") //每天晚上11:59执行
    public void reload() {
        loadConfig();
    }

    /**
     * 加载配置
     */
    private void loadConfig() {
        List<PlateTypeEnum> types = new LinkedList<PlateTypeEnum>();
        types.add(PlateTypeEnum.MENU);
        List<Plate> list = cbraService.getPlateList4Web(types);
        for (Plate plate : list) {
            if ("news_list".equalsIgnoreCase(plate.getPage())) {
                Config.newsList = cbraService.getPlateInformationList4Index(plate, 3);
                Config.newsList5 = cbraService.getPlateInformationList4Index(plate, 5);
            }
            if ("industry_list".equalsIgnoreCase(plate.getPage())) {
                Config.industryList = cbraService.getPlateInformationList4Index(plate, 3);
            }
            if ("three_party_offer".equalsIgnoreCase(plate.getPage())) {
                Config.offerListIndex = cbraService.findOfferList4Hot(plate, 5);
            }
            if ("material".equalsIgnoreCase(plate.getPage())) {
                Config.materialListIndex = cbraService.getPlateInformationList4Index(plate, 3);
            }
            if ("industrialization".equalsIgnoreCase(plate.getPage())) {
                Config.industrializationListIndex = cbraService.getPlateInformationList4Index(plate, 3);
            }
            if ("green".equalsIgnoreCase(plate.getPage())) {
                Config.greenListIndex = cbraService.getPlateInformationList4Index(plate, 3);
            }
            if ("bim".equalsIgnoreCase(plate.getPage())) {
                Config.bimListIndex = cbraService.getPlateInformationList4Index(plate, 3);
            }
        }
        Config.homeSAD = cbraService.getPlateInformationList4Index(PlateKeyEnum.HOME_SHUFFLING_AD_MENU, Integer.MAX_VALUE);
        List<PlateInformation> inforList = cbraService.getPlateInformationList4Index(PlateKeyEnum.HOME_AD_MENU, 1);
        if (inforList != null && !inforList.isEmpty()) {
            Config.homeAd = inforList.get(0);
        } else {
            Config.homeAd = new PlateInformation();
            Config.homeAd.setPicUrl("/ls/ls-2.jpg");
        }
        inforList = cbraService.getPlateInformationList4Index(PlateKeyEnum.HOME_ABOUT, 1);
        if (inforList != null && !inforList.isEmpty()) {
            Config.homeAbout = inforList.get(0);
        } else {
            Config.homeAbout = new PlateInformation();
            Config.homeAbout.setPicUrl("/ls/ls-1.jpg");
            Config.homeAbout.setIntroduction("我们本着构筑行业信誉，推动中国建筑行业进步的使命，怀着成为建筑业最具公信力专业平台的协会愿景以及为了体现诚实守信，平等互助和透明规范的协会价值，在21世纪全球聚焦中国迅速发展的今天成立我们的专业行业协会，任重而道远回顾过去的建筑发展历程， 中国建筑无论从设计理念的创新，建筑设计的优化，施工工艺的改良，新材料的应用以及建筑质量的维护都有了重大的突破！");
        }
        Config.homeStyle = cbraService.getPlateInformationList4Index(PlateKeyEnum.HOME_STYLE, 6);
        Config.homeExpert = cbraService.getPlateInformationList4Index(PlateKeyEnum.HOME_EXPERT, 6);

        inforList = cbraService.getPlateInformationList4Index(PlateKeyEnum.TOP_INTO, 1);
        if (inforList != null && !inforList.isEmpty()) {
            Config.topInto = inforList.get(0);
        } else {
            Config.topInto = new PlateInformation();
            Config.topInto.setPicUrl("/ls/3591G05OQF_m.jpg");
            Config.topInto.setIntroduction(" 和君集团的基本业务格局为：和君咨询+和君资本+和君商学，即以管理咨询为主体，以资本和商学教育为两翼的“一体两翼”模式。");
        }
        inforList = cbraService.getPlateInformationList4Index(PlateKeyEnum.TOP_STYLE, 1);
        if (inforList != null && !inforList.isEmpty()) {
            Config.topStyle = inforList.get(0);
        } else {
            Config.topStyle = new PlateInformation();
            Config.topStyle.setPicUrl("/ls/201409121234mjj8.jpg");
            Config.topStyle.setIntroduction("实现党建工作与企业经营管理的互动，努力为集团各项工作的健康发展提供坚强的组织保证");
        }
        Config.topEvent = cbraService.getPlateInformationList4Index(PlateKeyEnum.TOP_EVENT, 2);
        Config.topTrain = cbraService.getPlateInformationList4Index(PlateKeyEnum.TOP_TRAIN, 2);
        Config.topJoin = cbraService.getPlateInformationList4Index(PlateKeyEnum.TOP_JOIN, 2);
    }

}
