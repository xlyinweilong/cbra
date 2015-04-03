/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.Config;
import com.cbra.entity.Account;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.support.Tools;
import com.cbra.support.enums.AccountStatus;
import com.cbra.support.enums.PlateKeyEnum;
import com.cbra.support.enums.PlateTypeEnum;
import com.unionpay.acp.sdk.SDKConfig;
import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.Asynchronous;
import javax.ejb.EJB;
import javax.ejb.EJBContext;
import javax.ejb.Singleton;
import javax.ejb.LocalBean;
import javax.ejb.Schedule;
import javax.ejb.ScheduleExpression;
import javax.ejb.Startup;
import javax.ejb.Timeout;
import javax.ejb.Timer;
import javax.ejb.TimerService;
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
    private EmailService emailService;
    @EJB
    private CbraService cbraService;
    @EJB
    private AccountService accountService;

    @PostConstruct
    public void init() {
        cbraService.loadConfig();
        //加载银联在线配置文件
        SDKConfig.getConfig().loadPropertiesFromSrc();// 从classpath加载acp_sdk.properties文件
    }

    @Schedule(minute = "59", hour = "23") //每天晚上11:59执行
    public void reload() {
        cbraService.loadConfig();
    }

    @Schedule(minute = "00", hour = "09") //每天上午9点
    public void sendEmailMembershipIsAboutToExpire() {
        TypedQuery<Account> query = em.createQuery("SELECT a FROM Account a WHERE a.status = :status AND a.payDate > :nowDate2 AND a.payDate < :nowDate and a.deleted = false", Account.class);
        query.setParameter("nowDate", Tools.addDay(new Date(), 8)).setParameter("nowDate2", Tools.addDay(new Date(), 7)).setParameter("status", AccountStatus.MEMBER);
        for (Account account : query.getResultList()) {
            this.sendEmailMembershipIsAboutToExpire(account, account.getUserLanguage().toString());
        }
    }

    private void sendEmailMembershipIsAboutToExpire(Account account, String language) {
        String toEmail = account.getEmail();
        if (language == null || (!language.equalsIgnoreCase("zh") && !language.equalsIgnoreCase("en"))) {
            language = "zh";
        }
        language = language.toLowerCase();
        String fromDisplayName = "zh".equalsIgnoreCase(language) ? "筑誉建筑联合会" : "CBRA";
        String fromEmail = Config.FROM_EMAIL;
        String templateFile = "account_about_expire_" + language + ".html";
        String subject = "zh".equalsIgnoreCase(language) ? " 【用户即将过期】 " : " Withdraw Request Processed - YUAN RMB ";
        Map model = new HashMap();
        model.put("account", account);
        emailService.send(fromDisplayName, fromEmail, toEmail, subject, templateFile, model, null, null);
    }

}
