/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.Config;
import com.cbra.entity.Account;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.support.enums.AccountStatus;
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
    @EJB
    private AccountService accountService;

    @PostConstruct
    public void init() {
        cbraService.loadConfig();
    }

    @Schedule(minute = "59", hour = "23") //每天晚上11:59执行
    public void reload() {
        cbraService.loadConfig();
    }

}
