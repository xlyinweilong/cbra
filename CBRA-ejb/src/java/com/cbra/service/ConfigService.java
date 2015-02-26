/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.ejb.Asynchronous;
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
    
    @PostConstruct
    public void init() {
        loadConfig();
    }

    @Schedule(minute = "59", hour = "23") //每天晚上11:59执行
    public void reload() {
        loadConfig();
    }


    private void loadConfig() {
    }

}
