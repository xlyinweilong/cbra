
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import cn.yoopay.support.exception.ImageConvertException;
import com.cbra.Config;
import com.cbra.entity.Account;
import com.cbra.entity.FundCollection;
import com.cbra.entity.GatewayManualBankTransfer;
import com.cbra.entity.Message;
import com.cbra.entity.Offer;
import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.entity.PlateInformationContent;
import com.cbra.entity.ReplyMessage;
import com.cbra.entity.SysMenu;
import com.cbra.entity.SysRole;
import com.cbra.entity.SysRoleMenu;
import com.cbra.entity.SysUser;
import com.cbra.support.FileUploadItem;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.enums.FundCollectionAllowAttendeeEnum;
import com.cbra.support.enums.FundCollectionLanaguageEnum;
import com.cbra.support.enums.LanguageType;
import com.cbra.support.enums.MessageSecretLevelEnum;
import com.cbra.support.enums.MessageTypeEnum;
import com.cbra.support.enums.OrderStatusEnum;
import com.cbra.support.enums.PlateAuthEnum;
import com.cbra.support.enums.PlateKeyEnum;
import com.cbra.support.enums.PlateTypeEnum;
import com.cbra.support.enums.SysMenuPopedomEnum;
import com.cbra.support.enums.SysUserTypeEnum;
import com.cbra.support.exception.AccountAlreadyExistException;
import com.cbra.support.exception.AccountNotExistException;
import com.cbra.support.exception.EjbMessageException;
import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaBuilder.In;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;

/**
 * 后台用户服务层
 *
 * @author yin.weilong
 */
@Stateless
@LocalBean
public class AdminService {

    @PersistenceContext(unitName = "CBRA-ejbPU")
    private EntityManager em;
    private static final Logger logger = Logger.getLogger(AdminService.class.getName());

    @EJB
    private EmailService emailService;

    // **********************************************************************
    // ************* PUBLIC METHODS *****************************************
    // **********************************************************************
    /**
     * 通过ID获得后台用户对象
     *
     * @param id
     * @return
     */
    public SysUser findById(Long id) {
        return em.find(SysUser.class, id);
    }

    /**
     * 通过ID获取菜单
     *
     * @param id
     * @return
     */
    public SysMenu findSysMenuById(Long id) {
        return em.find(SysMenu.class, id);
    }

    /**
     * 通过ID获取角色
     *
     * @param id
     * @return
     */
    public SysRole findSysRoleById(Long id) {
        return em.find(SysRole.class, id);
    }

    /**
     * 通过ID获取板块
     *
     * @param id
     * @return
     */
    public Plate findPlateById(Long id) {
        return em.find(Plate.class, id);
    }

    /**
     * 获取用户列表
     *
     * @param map
     * @param pageIndex
     * @param maxPerPage
     * @param list
     * @param page
     * @return
     */
    public ResultList<SysUser> findSysUserList(Map<String, Object> map, int pageIndex, int maxPerPage, Boolean list, Boolean page) {
        ResultList<SysUser> resultList = new ResultList<>();
        CriteriaBuilder builder = em.getCriteriaBuilder();
        CriteriaQuery<SysUser> query = builder.createQuery(SysUser.class);
        Root root = query.from(SysUser.class);
        List<Predicate> criteria = new ArrayList<>();
        criteria.add(builder.equal(root.get("adminType"), SysUserTypeEnum.ORDINARY));
        criteria.add(builder.equal(root.get("deleted"), false));
        if (map.containsKey("name")) {
            criteria.add(builder.like(root.get("name"), map.get("name").toString()));
        }
        try {
            if (list == null || !list) {
                CriteriaQuery<Long> countQuery = builder.createQuery(Long.class);
                countQuery.select(builder.count(root));
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    countQuery.where(criteria.get(0));
                } else {
                    countQuery.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                Long totalCount = em.createQuery(countQuery).getSingleResult();
                resultList.setTotalCount(totalCount.intValue());
            }
            if (list == null || list) {
                query = query.select(root);
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    query.where(criteria.get(0));
                } else {
                    query.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                query.orderBy(builder.desc(root.get("createDate")));
                TypedQuery<SysUser> typeQuery = em.createQuery(query);
                if (page != null && page) {
                    int startIndex = (pageIndex - 1) * maxPerPage;
                    typeQuery.setFirstResult(startIndex);
                    typeQuery.setMaxResults(maxPerPage);
                    resultList.setPageIndex(pageIndex);
                    resultList.setStartIndex(startIndex);
                    resultList.setMaxPerPage(maxPerPage);
                }
                List<SysUser> dataList = typeQuery.getResultList();
                resultList.addAll(dataList);
            }
        } catch (NoResultException ex) {
        }
        return resultList;
    }

    /**
     * 获取银行转账列表
     *
     * @param map
     * @param pageIndex
     * @param maxPerPage
     * @param list
     * @param page
     * @return
     */
    public ResultList<GatewayManualBankTransfer> findGatewayManualBankTransferList(Map<String, Object> map, int pageIndex, int maxPerPage, Boolean list, Boolean page) {
        ResultList<GatewayManualBankTransfer> resultList = new ResultList<>();
        CriteriaBuilder builder = em.getCriteriaBuilder();
        CriteriaQuery<GatewayManualBankTransfer> query = builder.createQuery(GatewayManualBankTransfer.class);
        Root root = query.from(GatewayManualBankTransfer.class);
        List<Predicate> criteria = new ArrayList<>();
        criteria.add(builder.equal(root.get("deleted"), false));
        if (map.containsKey("status")) {
            criteria.add(builder.equal(root.get("orderCollection").get("status"), map.get("status")));
        }
        if (map.containsKey("statuss")) {
            In in = builder.in(root.get("orderCollection").get("status"));
            List<OrderStatusEnum> statuss = (List<OrderStatusEnum>) map.get("statuss");
            for (OrderStatusEnum status : statuss) {
                in.value(status);
            }
            criteria.add(in);
        }
        if (map.containsKey("serviceStatus")) {
            criteria.add(builder.equal(root.get("orderCbraService").get("status"), map.get("serviceStatus")));
        }
        if (map.containsKey("serviceStatuss")) {
            In in = builder.in(root.get("orderCbraService").get("status"));
            List<OrderStatusEnum> statuss = (List<OrderStatusEnum>) map.get("serviceStatuss");
            for (OrderStatusEnum status : statuss) {
                in.value(status);
            }
            criteria.add(in);
        }
        try {
            if (list == null || !list) {
                CriteriaQuery<Long> countQuery = builder.createQuery(Long.class);
                countQuery.select(builder.count(root));
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    countQuery.where(criteria.get(0));
                } else {
                    countQuery.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                Long totalCount = em.createQuery(countQuery).getSingleResult();
                resultList.setTotalCount(totalCount.intValue());
            }
            if (list == null || list) {
                query = query.select(root);
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    query.where(criteria.get(0));
                } else {
                    query.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                query.orderBy(builder.desc(root.get("createDate")));
                TypedQuery<GatewayManualBankTransfer> typeQuery = em.createQuery(query);
                if (page != null && page) {
                    int startIndex = (pageIndex - 1) * maxPerPage;
                    typeQuery.setFirstResult(startIndex);
                    typeQuery.setMaxResults(maxPerPage);
                    resultList.setPageIndex(pageIndex);
                    resultList.setStartIndex(startIndex);
                    resultList.setMaxPerPage(maxPerPage);
                }
                List<GatewayManualBankTransfer> dataList = typeQuery.getResultList();
                resultList.addAll(dataList);
            }
        } catch (NoResultException ex) {
        }
        return resultList;
    }

    /**
     * 获取用户列表
     *
     * @param pageIndex
     * @param maxPerPage
     * @return
     */
    public ResultList<SysUser> findSysUserList(int pageIndex, int maxPerPage) {
        ResultList<SysUser> resultList = new ResultList<>();
        TypedQuery<Long> countQuery = em.createQuery("SELECT COUNT(ua) FROM SysUser ua WHERE ua.deleted = false ORDER BY ua.createDate DESC", Long.class);
        Long totalCount = countQuery.getSingleResult();
        resultList.setTotalCount(totalCount.intValue());
        TypedQuery<SysUser> query = em.createQuery("SELECT ua FROM SysUser ua WHERE ua.deleted = false ORDER BY ua.createDate DESC", SysUser.class);
        int startIndex = (pageIndex - 1) * maxPerPage;
        query.setFirstResult(startIndex);
        query.setMaxResults(maxPerPage);
        resultList.setPageIndex(pageIndex);
        resultList.setStartIndex(startIndex);
        resultList.setMaxPerPage(maxPerPage);
        resultList.addAll(query.getResultList());
        return resultList;
    }

    /**
     * 通过帐号获得后台用户对象
     *
     * @param account
     * @return
     */
    public SysUser findByAccount(String account) {
        SysUser user = null;
        try {
            TypedQuery<SysUser> query = em.createQuery("SELECT ua FROM SysUser ua WHERE ua.account = :account and ua.deleted = false", SysUser.class);
            query.setParameter("account", account);
            user = query.getSingleResult();
        } catch (NoResultException ex) {
            user = null;
        }
        return user;
    }

    /**
     * 后台用户登录
     *
     * @param account
     * @param password
     * @return
     * @throws EjbMessageException
     * @throws AccountNotExistException
     */
    public SysUser login(String account, String password) throws EjbMessageException, AccountNotExistException {
        SysUser user = this.findByAccount(account);
        if (user == null) {
            throw new AccountNotExistException("账户不存在！");
        } else if (!user.getPasswd().equals(Tools.md5(password))) {
            throw new EjbMessageException("密码错误！");
        }
        return user;
    }

    /**
     * 修改密码
     *
     * @param sysUser
     * @param name
     * @param oldpasswd
     * @param newpasswd
     * @return
     * @throws EjbMessageException
     */
    public SysUser repasswd(SysUser sysUser, String name, String oldpasswd, String newpasswd) throws EjbMessageException {
        sysUser.setName(name);
        if (!(Tools.md5(oldpasswd).equals(sysUser.getPasswd()))) {
            throw new EjbMessageException("原密码错误！");
        }
        sysUser.setPasswd(Tools.md5(newpasswd));
        em.merge(sysUser);
        return sysUser;
    }

    /**
     * 创建后台用户
     *
     * @param id
     * @param account
     * @param name
     * @param passwd
     * @param adminType
     * @param roleId
     * @return
     * @throws AccountAlreadyExistException
     */
    public SysUser createOrUpdateSysUser(Long id, String account, String name, String passwd, SysUserTypeEnum adminType, Long roleId) throws AccountAlreadyExistException {
        boolean isCreare = true;
        SysUser ua = new SysUser();
        SysUser findUser = this.findByAccount(account);
        if (id != null) {
            isCreare = false;
            ua = this.findById(id);
            if (findUser != null && !ua.getAccount().equals(account)) {
                throw new AccountAlreadyExistException("账户已经存在");
            }
        } else {
            if (findUser != null) {
                throw new AccountAlreadyExistException("账户已经存在");
            }
        }
        ua.setAccount(account);
        ua.setName(name);
        ua.setSysRole(this.findSysRoleById(roleId));
        if (id == null && passwd == null) {
            ua.setPasswd(Tools.md5("111111"));
        } else if (id == null || passwd != null) {
            ua.setPasswd(Tools.md5(passwd));
        }
        ua.setAdminType(adminType);
        if (isCreare) {
            em.persist(ua);
        } else {
            em.merge(ua);
        }
        return ua;
    }

    /**
     * 通过ID删除后台用户
     *
     * @param ids
     */
    public void deleteSysUser(String... ids) {
        for (String id : ids) {
            if (StringUtils.isBlank(id)) {
                continue;
            }
            SysUser ua = this.findById(Long.parseLong(id));
            ua.setDeleted(Boolean.TRUE);
            em.merge(ua);
        }
    }

    /**
     * 创建菜单
     *
     * @param id
     * @param pid
     * @param name
     * @param url
     * @param popedom
     * @return
     */
    public SysMenu createOrUpdateSysMenu(Long id, Long pid, String name, String url, SysMenuPopedomEnum popedom) {
        boolean isCreare = true;
        SysMenu sm = new SysMenu();
        if (id != null) {
            isCreare = false;
            sm = this.findSysMenuById(id);
        }
        sm.setName(name);
        sm.setPopedom(popedom);
        sm.setUrl(url);
        if (pid != null) {
            sm.setLevel(2);
            sm.setParentMenu(this.findSysMenuById(pid));
        } else {
            sm.setLevel(1);
        }
        if (isCreare) {
            sm.setSortIndex(99);
            em.persist(sm);
        } else {
            em.merge(sm);
        }
        return sm;
    }

    /**
     * 根据ID删除菜单
     *
     * @param ids
     */
    public void deleteSysMenuById(String... ids) {
        for (String id : ids) {
            if (StringUtils.isBlank(id)) {
                continue;
            }
            SysMenu sm = em.find(SysMenu.class, Long.parseLong(id));
            if (sm.getLevel() == 1) {
                for (SysMenu subSysMenu : this.findSysMenuListByParentId(sm.getId())) {
                    em.remove(subSysMenu);
                }
                em.flush();
            }
            em.remove(sm);
        }
    }

    /**
     * 排序菜单
     *
     * @param ids
     */
    public void sortSysMenuById(String... ids) {
        int i = 0;
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            SysMenu sm = em.find(SysMenu.class, Long.parseLong(id));
            sm.setSortIndex(i++);
            em.merge(sm);
        }
    }

    /**
     * 根据层次获取菜单
     *
     * @param level
     * @return
     */
    public List<SysMenu> findSysMenuListByLevel(Integer level) {
        TypedQuery<SysMenu> query = em.createQuery("SELECT sm FROM SysMenu sm WHERE sm.level = :level ORDER BY sm.sortIndex asc", SysMenu.class);
        query.setParameter("level", level);
        return query.getResultList();
    }

    /**
     * 根据类别获取菜单
     *
     * @param popedom
     * @return
     */
    public List<SysMenu> findSysMenuListByPopedom(SysMenuPopedomEnum popedom) {
        TypedQuery<SysMenu> query = em.createQuery("SELECT sm FROM SysMenu sm  WHERE sm.popedom = :popedom ORDER BY sm.sortIndex asc", SysMenu.class);
        query.setParameter("popedom", popedom);
        return query.getResultList();
    }

    /**
     * 获取子集的菜单
     *
     * @param pid
     * @return
     */
    public List<SysMenu> findSysMenuListByParentId(Long pid) {
        TypedQuery<SysMenu> query = null;
        if (pid == null) {
            query = em.createQuery("SELECT sm FROM SysMenu sm WHERE sm.parentMenu is null ORDER BY sm.sortIndex asc", SysMenu.class);
        } else {
            query = em.createQuery("SELECT sm FROM SysMenu sm WHERE sm.parentMenu.id = :pid ORDER BY sm.sortIndex asc", SysMenu.class);
            query.setParameter("pid", pid);
        }
        return query.getResultList();
    }

    /**
     * 根据用户ID获取菜单
     *
     * @param uid
     * @param level
     * @return
     */
    public List<SysMenu> findSysMenuByUserId(Long uid, Integer level) {
        SysUser su = this.findById(uid);
        SysMenuPopedomEnum popedom = SysMenuPopedomEnum.COMMON;
        if (SysUserTypeEnum.SYSTEM.equals(su.getAdminType())) {
            popedom = SysMenuPopedomEnum.SUPER;
            TypedQuery<SysMenu> query = em.createQuery("SELECT sm FROM SysMenu sm WHERE sm.level = :level AND sm.popedom = :popedom ORDER BY sm.sortIndex asc", SysMenu.class);
            query.setParameter("level", level).setParameter("popedom", popedom);
            return query.getResultList();
        } else {
            SysRole sr = su.getSysRole();
            if (sr == null) {
                return new ArrayList<>();
            }
            TypedQuery<SysMenu> query = em.createQuery("SELECT srm.sysMenu FROM SysRoleMenu srm WHERE srm.sysRole.id = :roleId AND srm.sysMenu.level = :level AND srm.sysMenu.popedom = :popedom ORDER BY srm.sysMenu.sortIndex asc", SysMenu.class);
            query.setParameter("roleId", sr.getId()).setParameter("level", level).setParameter("popedom", popedom);
            return query.getResultList();
        }
    }

    /**
     * 创建角色
     *
     * @param id
     * @param name
     * @return
     */
    public SysRole createOrUpdateSysRole(Long id, String name) {
        boolean isCreare = true;
        SysRole sr = new SysRole();
        if (id != null) {
            isCreare = false;
            sr = this.findSysRoleById(id);
        }
        sr.setName(name);
        if (isCreare) {
            sr.setSortIndex(99);
            em.persist(sr);
        } else {
            em.merge(sr);
        }
        return sr;
    }

    /**
     * 根据ID删除角色
     *
     * @param ids
     */
    public void deleteSysRoleById(String... ids) {
        for (String id : ids) {
            if (StringUtils.isBlank(id)) {
                continue;
            }
            SysRole sr = em.find(SysRole.class, Long.parseLong(id));
            em.remove(sr);
        }
    }

    /**
     * 排序角色
     *
     * @param ids
     */
    public void sortSysRoleById(String... ids) {
        int i = 0;
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            SysRole sr = em.find(SysRole.class, Long.parseLong(id));
            sr.setSortIndex(i++);
            em.merge(sr);
        }
    }

    /**
     * 获取角色列表
     *
     * @return
     */
    public List<SysRole> findSysRoleListAll() {
        TypedQuery<SysRole> query = em.createQuery("SELECT sr FROM SysRole sr ORDER BY sr.sortIndex asc", SysRole.class);
        return query.getResultList();
    }

    /**
     * 创建角色菜单
     *
     * @param mid
     * @param roleIds
     */
    public void createOrUpdateSysRoleMenu(Long mid, String... roleIds) {
        //delete all
        this.deleteSysRoleMenuByMenuId(mid);
        SysMenu sm = this.findSysMenuById(mid);
        for (String roleId : roleIds) {
            if (StringUtils.isBlank(roleId)) {
                continue;
            }
            SysRoleMenu srm = new SysRoleMenu();
            srm.setSysMenu(sm);
            srm.setSysRole(this.findSysRoleById(Long.parseLong(roleId)));
            em.persist(srm);
            em.flush();
        }
    }

    /**
     * 根据ID删除角色菜单
     *
     * @param menuId
     * @param roleIds
     */
    public void deleteSysRoleMenu(Long menuId, List<Long> roleIds) {
        String removeHql = "DELETE FROM SysRoleMenu srm WHERE srm.sysMenu.id = :menuId AND srm.sysRole.id IN :roleIds";
        Query query = em.createQuery(removeHql).setParameter("menuId", menuId).setParameter("roleIds", roleIds);
        query.executeUpdate();
    }

    /**
     * 根据菜单删除角色菜单
     *
     * @param menuId
     */
    public void deleteSysRoleMenuByMenuId(Long menuId) {
        String removeHql = "DELETE FROM SysRoleMenu srm WHERE srm.sysMenu.id = :menuId";
        Query query = em.createQuery(removeHql).setParameter("menuId", menuId);
        query.executeUpdate();
    }

    /**
     * 根据菜单获取角色列表
     *
     * @param menuId
     * @return
     */
    public List<SysRole> findSysRoleListByMenuId(Long menuId) {
        TypedQuery<SysRole> query = em.createQuery("SELECT srm.sysRole FROM SysRoleMenu srm WHERE srm.sysMenu.id = :menuId ORDER BY srm.sysRole.sortIndex asc", SysRole.class);
        query.setParameter("menuId", menuId);
        return query.getResultList();
    }

    /**
     * 根据栏目
     *
     * @param ids
     */
    public void deletePlateByIds(String... ids) {
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            Plate plate = em.find(Plate.class, Long.parseLong(id));
            em.remove(plate);
        }
    }

    /**
     * 获取板块
     *
     * @return
     */
    public List<Plate> findPlateList() {
        TypedQuery<Plate> query = em.createQuery("SELECT p FROM Plate p ORDER BY p.sortIndex ASC", Plate.class);
        return query.getResultList();
    }

    /**
     * 获取权限面板
     *
     * @return
     */
    public List<Plate> findPlateAuthList() {
        List<PlateKeyEnum> authList = PlateKeyEnum.getNeedAuthority();
        TypedQuery<Plate> query = em.createQuery("SELECT p FROM Plate p WHERE p.plateKey IN :authList ORDER BY p.sortIndex ASC", Plate.class);
        query.setParameter("authList", authList);
        return query.getResultList();
    }

    /**
     * 获取消息面板
     *
     * @return
     */
    public List<Plate> findPlateMessageList() {
        List<PlateKeyEnum> authList = PlateKeyEnum.getLeaveMessage();
        TypedQuery<Plate> query = em.createQuery("SELECT p FROM Plate p WHERE p.plateKey IN :authList ORDER BY p.sortIndex ASC", Plate.class);
        query.setParameter("authList", authList);
        return query.getResultList();
    }

    /**
     * 更新权限
     *
     * @param id
     * @param touristAuthEnum
     * @param userAuthEnum
     * @param companyAuthEnum
     * @return
     */
    public Plate updatePlateAuth(Long id, PlateAuthEnum touristAuthEnum, PlateAuthEnum userAuthEnum, PlateAuthEnum companyAuthEnum) {
        Plate plate = this.findPlateById(id);
        plate.setCompanyAuth(companyAuthEnum);
        plate.setUserAuth(userAuthEnum);
        plate.setTouristAuth(touristAuthEnum);
        em.merge(plate);
        return plate;
    }

    /**
     * 根据父获取板块
     *
     * @param parentPlateId
     * @return
     */
    public List<Plate> findPlateListByParentId(Long parentPlateId) {
        TypedQuery<Plate> query = null;
        if (parentPlateId == null) {
            query = em.createQuery("SELECT p FROM Plate p WHERE p.parentPlate is null ORDER BY p.sortIndex ASC", Plate.class);
        } else {
            query = em.createQuery("SELECT p FROM Plate p WHERE p.parentPlate.id = :parentPlateId ORDER BY p.sortIndex ASC", Plate.class);
            query.setParameter("parentPlateId", parentPlateId);
        }
        return query.getResultList();
    }

    /**
     * 创建板块
     *
     * @param id
     * @param name
     * @param enName
     * @param type
     * @param key
     * @param page
     * @param pid
     * @return
     */
    public Plate createOrUpdatePlate(Long id, String name, String enName, PlateTypeEnum type, PlateKeyEnum key, String page, Long pid) {
        boolean isCreare = true;
        Plate plate = new Plate();
        if (id != null) {
            isCreare = false;
            plate = this.findPlateById(id);
        }
        plate.setName(name);
        plate.setEnName(enName);
        plate.setPlateKey(key);
        plate.setPlateType(type);
        if (isCreare) {
            plate.setSortIndex(99);
        }
        plate.setPage(page);
        if (pid != null) {
            plate.setParentPlate(this.findPlateById(pid));
        }
        if (isCreare) {
            em.persist(plate);
        } else {
            em.merge(plate);
        }
        return plate;
    }

    /**
     * 根据KEY获取板块
     *
     * @param key
     * @return
     */
    public List<Plate> findPlateByKey(PlateKeyEnum key) {
        TypedQuery<Plate> query = em.createQuery("SELECT p FROM Plate p WHERE p.plateKey = :key ORDER BY p.sortIndex ASC", Plate.class);
        query.setParameter("key", key);
        return query.getResultList();
    }

    /**
     * 排序栏目
     *
     * @param ids
     */
    public void sortPlateById(String... ids) {
        int i = 0;
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            Plate plate = em.find(Plate.class, Long.parseLong(id));
            plate.setSortIndex(i++);
            em.merge(plate);
        }
    }

    /**
     * 根据ID获取栏目信息
     *
     * @param id
     * @return
     */
    public PlateInformation findPlateInformationById(Long id) {
        return em.find(PlateInformation.class, id);
    }

    /**
     * 根据ID获取栏目信息
     *
     * @param id
     * @return
     */
    public PlateInformation findPlateInformationByIdFetchContent(Long id) {
        PlateInformation pi = em.find(PlateInformation.class, id);
        if (pi != null) {
            pi.setPlateInformationContent(this.findContentByPlateInformation(id));
        }
        return pi;
    }

    /**
     * 根据ID获取offer
     *
     * @param id
     * @return
     */
    public Offer findOfferById(Long id) {
        return em.find(Offer.class, id);
    }

    /**
     * 根据ID获取活动
     *
     * @param id
     * @return
     */
    public FundCollection findCollectionById(Long id) {
        return em.find(FundCollection.class, id);
    }

    /**
     * 根据栏目信息获取内容
     *
     * @param plateInformationId
     * @return
     */
    public PlateInformationContent findContentByPlateInformation(Long plateInformationId) {
        TypedQuery<PlateInformationContent> query = em.createQuery("SELECT p FROM PlateInformationContent p WHERE p.plateInformation.id = :plateInformationId", PlateInformationContent.class);
        query.setParameter("plateInformationId", plateInformationId);
        PlateInformationContent pic = null;
        try {
            pic = query.getSingleResult();
        } catch (NoResultException ex) {
            pic = null;
        }
        return pic;
    }

    /**
     * 获取栏目信息
     *
     * @param map
     * @param pageIndex
     * @param maxPerPage
     * @param list
     * @param page
     * @return
     */
    public ResultList<PlateInformation> findPlateInformationList(Map<String, Object> map, int pageIndex, int maxPerPage, Boolean list, Boolean page) {
        ResultList<PlateInformation> resultList = new ResultList<>();
        CriteriaBuilder builder = em.getCriteriaBuilder();
        CriteriaQuery<PlateInformation> query = builder.createQuery(PlateInformation.class);
        Root root = query.from(PlateInformation.class);
        List<Predicate> criteria = new ArrayList<>();
        criteria.add(builder.equal(root.get("deleted"), false));
        if (map.containsKey("plateId")) {
            criteria.add(builder.equal(root.get("plate").get("id"), (Long) map.get("plateId")));
        }
        try {
            if (list == null || !list) {
                CriteriaQuery<Long> countQuery = builder.createQuery(Long.class);
                countQuery.select(builder.count(root));
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    countQuery.where(criteria.get(0));
                } else {
                    countQuery.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                Long totalCount = em.createQuery(countQuery).getSingleResult();
                resultList.setTotalCount(totalCount.intValue());
            }
            if (list == null || list) {
                query = query.select(root);
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    query.where(criteria.get(0));
                } else {
                    query.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                query.orderBy(builder.desc(root.get("pushDate")));
                TypedQuery<PlateInformation> typeQuery = em.createQuery(query);
                if (page != null && page) {
                    int startIndex = (pageIndex - 1) * maxPerPage;
                    typeQuery.setFirstResult(startIndex);
                    typeQuery.setMaxResults(maxPerPage);
                    resultList.setPageIndex(pageIndex);
                    resultList.setStartIndex(startIndex);
                    resultList.setMaxPerPage(maxPerPage);
                }
                List<PlateInformation> dataList = typeQuery.getResultList();
                resultList.addAll(dataList);
            }
        } catch (NoResultException ex) {
        }
        return resultList;
    }

    public ResultList<PlateInformation> findPlateInformationList(Map<String, Object> map, int pageIndex, int maxPerPage) {
        ResultList<PlateInformation> resultList = new ResultList<>();
        String hql = "SELECT COUNT(c) FROM PlateInformation c WHERE c.plate.id IN :ids AND c.deleted = false ORDER BY c.createDate DESC";
        TypedQuery<Long> countQuery = em.createQuery(hql, Long.class);
        countQuery.setParameter("ids", map.get("ids"));
        Long totalCount = countQuery.getSingleResult();
        resultList.setTotalCount(totalCount.intValue());
        hql = "SELECT c FROM PlateInformation c WHERE c.plate.id IN :ids AND c.deleted = false ORDER BY c.createDate DESC";
        TypedQuery<PlateInformation> query = em.createQuery(hql, PlateInformation.class);
        query.setParameter("ids", map.get("ids"));
        int startIndex = (pageIndex - 1) * maxPerPage;
        query.setFirstResult(startIndex);
        query.setMaxResults(maxPerPage);
        resultList.setPageIndex(pageIndex);
        resultList.setStartIndex(startIndex);
        resultList.setMaxPerPage(maxPerPage);
        resultList.addAll(query.getResultList());
        return resultList;
    }

    /**
     * 获取招聘列表
     *
     * @param map
     * @param pageIndex
     * @param maxPerPage
     * @param list
     * @param page
     * @return
     */
    public ResultList<Offer> findOfferList(Map<String, Object> map, int pageIndex, int maxPerPage, Boolean list, Boolean page) {
        ResultList<Offer> resultList = new ResultList<>();
        CriteriaBuilder builder = em.getCriteriaBuilder();
        CriteriaQuery<Offer> query = builder.createQuery(Offer.class);
        Root root = query.from(Offer.class);
        List<Predicate> criteria = new ArrayList<>();
        criteria.add(builder.equal(root.get("deleted"), false));
        if (map.containsKey("plateId")) {
            criteria.add(builder.equal(root.get("plate").get("id"), (Long) map.get("plateId")));
        }
        try {
            if (list == null || !list) {
                CriteriaQuery<Long> countQuery = builder.createQuery(Long.class);
                countQuery.select(builder.count(root));
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    countQuery.where(criteria.get(0));
                } else {
                    countQuery.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                Long totalCount = em.createQuery(countQuery).getSingleResult();
                resultList.setTotalCount(totalCount.intValue());
            }
            if (list == null || list) {
                query = query.select(root);
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    query.where(criteria.get(0));
                } else {
                    query.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                query.orderBy(builder.desc(root.get("pushDate")));
                TypedQuery<Offer> typeQuery = em.createQuery(query);
                if (page != null && page) {
                    int startIndex = (pageIndex - 1) * maxPerPage;
                    typeQuery.setFirstResult(startIndex);
                    typeQuery.setMaxResults(maxPerPage);
                    resultList.setPageIndex(pageIndex);
                    resultList.setStartIndex(startIndex);
                    resultList.setMaxPerPage(maxPerPage);
                }
                List<Offer> dataList = typeQuery.getResultList();
                resultList.addAll(dataList);
            }
        } catch (NoResultException ex) {
        }
        return resultList;
    }

    public ResultList<Offer> findOfferList(Map<String, Object> map, int pageIndex, int maxPerPage) {
        ResultList<Offer> resultList = new ResultList<>();
        String hql = "SELECT COUNT(c) FROM Offer c WHERE c.plate.id IN :ids AND c.deleted = false ORDER BY c.createDate DESC";
        TypedQuery<Long> countQuery = em.createQuery(hql, Long.class);
        countQuery.setParameter("ids", map.get("ids"));
        Long totalCount = countQuery.getSingleResult();
        resultList.setTotalCount(totalCount.intValue());
        hql = "SELECT c FROM Offer c WHERE c.plate.id IN :ids AND c.deleted = false ORDER BY c.createDate DESC";
        TypedQuery<Offer> query = em.createQuery(hql, Offer.class);
        query.setParameter("ids", map.get("ids"));
        int startIndex = (pageIndex - 1) * maxPerPage;
        query.setFirstResult(startIndex);
        query.setMaxResults(maxPerPage);
        resultList.setPageIndex(pageIndex);
        resultList.setStartIndex(startIndex);
        resultList.setMaxPerPage(maxPerPage);
        resultList.addAll(query.getResultList());
        return resultList;
    }

    /**
     * 获取活动列表
     *
     * @param map
     * @param pageIndex
     * @param maxPerPage
     * @param list
     * @param page
     * @return
     */
    public ResultList<FundCollection> findCollectionList(Map<String, Object> map, int pageIndex, int maxPerPage, Boolean list, Boolean page) {
        ResultList<FundCollection> resultList = new ResultList<>();
        CriteriaBuilder builder = em.getCriteriaBuilder();
        CriteriaQuery<FundCollection> query = builder.createQuery(FundCollection.class);
        Root root = query.from(FundCollection.class);
        List<Predicate> criteria = new ArrayList<>();
        criteria.add(builder.equal(root.get("deleted"), false));
        if (map.containsKey("plateId")) {
            criteria.add(builder.equal(root.get("plate").get("id"), (Long) map.get("plateId")));
        }
        if (map.containsKey("nearFutre")) {
            criteria.add(builder.greaterThan(root.get("statusEndDate"), (Date) map.get("nearFutre")));
        }
        if (map.containsKey("period")) {
            criteria.add(builder.lessThan(root.get("statusEndDate"), (Date) map.get("period")));
        }
        if (map.containsKey("mobile")) {
            criteria.add(builder.isNotNull(root.get("introduction")));
        }
        if (map.containsKey("baomingzhong")) {
            criteria.add(builder.lessThan(root.get("statusBeginDate"), (Date) map.get("baomingzhong")));
            criteria.add(builder.greaterThan(root.get("statusEndDate"), (Date) map.get("baomingzhong")));
        }
        if (map.containsKey("weikaishi")) {
            criteria.add(builder.greaterThan(root.get("statusBeginDate"), (Date) map.get("weikaishi")));
        }
        try {
            if (list == null || !list) {
                CriteriaQuery<Long> countQuery = builder.createQuery(Long.class);
                countQuery.select(builder.count(root));
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    countQuery.where(criteria.get(0));
                } else {
                    countQuery.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                Long totalCount = em.createQuery(countQuery).getSingleResult();
                resultList.setTotalCount(totalCount.intValue());
            }
            if (list == null || list) {
                query = query.select(root);
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    query.where(criteria.get(0));
                } else {
                    query.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                query.orderBy(builder.desc(root.get("createDate")));
                TypedQuery<FundCollection> typeQuery = em.createQuery(query);
                if (page != null && page) {
                    int startIndex = (pageIndex - 1) * maxPerPage;
                    typeQuery.setFirstResult(startIndex);
                    typeQuery.setMaxResults(maxPerPage);
                    resultList.setPageIndex(pageIndex);
                    resultList.setStartIndex(startIndex);
                    resultList.setMaxPerPage(maxPerPage);
                }
                List<FundCollection> dataList = typeQuery.getResultList();
                resultList.addAll(dataList);
            }
        } catch (NoResultException ex) {
        }
        return resultList;
    }

    /**
     * 根据ID获取信息
     *
     * @param id
     * @return
     */
    public Message findMessageById(Long id) {
        return em.find(Message.class, id);
    }

    /**
     * 根据ID获取信息回复
     *
     * @param id
     * @return
     */
    public ReplyMessage findReplyMessageById(Long id) {
        return em.find(ReplyMessage.class, id);
    }

    /**
     * 获取消息列表
     *
     * @param map
     * @param pageIndex
     * @param maxPerPage
     * @param list
     * @param page
     * @return
     */
    public ResultList<Message> findMessageList(Map<String, Object> map, int pageIndex, int maxPerPage, Boolean list, Boolean page) {
        ResultList<Message> resultList = new ResultList<>();
        CriteriaBuilder builder = em.getCriteriaBuilder();
        CriteriaQuery<Message> query = builder.createQuery(Message.class);
        Root root = query.from(Message.class);
        List<Predicate> criteria = new ArrayList<>();
        criteria.add(builder.equal(root.get("deleted"), false));
        if (map.containsKey("plateId")) {
            criteria.add(builder.equal(root.get("plate").get("id"), (Long) map.get("plateId")));
        }
        try {
            if (list == null || !list) {
                CriteriaQuery<Long> countQuery = builder.createQuery(Long.class);
                countQuery.select(builder.count(root));
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    countQuery.where(criteria.get(0));
                } else {
                    countQuery.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                Long totalCount = em.createQuery(countQuery).getSingleResult();
                resultList.setTotalCount(totalCount.intValue());
            }
            if (list == null || list) {
                query = query.select(root);
                if (criteria.isEmpty()) {
                    throw new RuntimeException("no criteria");
                } else if (criteria.size() == 1) {
                    query.where(criteria.get(0));
                } else {
                    query.where(builder.and(criteria.toArray(new Predicate[0])));
                }
                query.orderBy(builder.desc(root.get("createDate")));
                TypedQuery<Message> typeQuery = em.createQuery(query);
                if (page != null && page) {
                    int startIndex = (pageIndex - 1) * maxPerPage;
                    typeQuery.setFirstResult(startIndex);
                    typeQuery.setMaxResults(maxPerPage);
                    resultList.setPageIndex(pageIndex);
                    resultList.setStartIndex(startIndex);
                    resultList.setMaxPerPage(maxPerPage);
                }
                List<Message> dataList = typeQuery.getResultList();
                resultList.addAll(dataList);
            }
        } catch (NoResultException ex) {
        }
        return resultList;
    }

    /**
     * 删除信息
     *
     * @param ids
     */
    public void deleteMessageByIds(String... ids) {
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            Message message = em.find(Message.class, Long.parseLong(id));
            message.setDeleted(Boolean.TRUE);
            em.merge(message);
        }
    }

    /**
     * 根据菜单删除角色菜单
     *
     * @param ids
     */
    public void deletePlateInformationByIds(String... ids) {
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            PlateInformation plateInfo = em.find(PlateInformation.class, Long.parseLong(id));
            plateInfo.setDeleted(Boolean.TRUE);
            em.merge(plateInfo);
        }
    }

    /**
     * 删除活动
     *
     * @param ids
     */
    public void deleteFundCollectionByIds(String... ids) {
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            FundCollection collection = em.find(FundCollection.class, Long.parseLong(id));
            collection.setDeleted(Boolean.TRUE);
            em.merge(collection);
        }
    }

    /**
     * 删除招聘信息
     *
     * @param ids
     */
    public void deleteOfferByIds(String... ids) {
        for (String id : ids) {
            if (id == null) {
                continue;
            }
            Offer offer = em.find(Offer.class, Long.parseLong(id));
            offer.setDeleted(Boolean.TRUE);
            em.merge(offer);
        }
    }

    /**
     * 根据栏目获取栏目信息
     *
     * @param plateId
     * @param language
     * @return
     */
    public PlateInformation findPlateInformationByPlateId(Long plateId, LanguageType language) {
        TypedQuery<PlateInformation> query = em.createQuery("SELECT p FROM PlateInformation p WHERE p.plate.id = :plateId AND p.language = :language ORDER BY p.createDate DESC", PlateInformation.class);
        query.setParameter("plateId", plateId);
        query.setParameter("language", language);
        List<PlateInformation> list = query.getResultList();
        if (list == null || list.isEmpty()) {
            return null;
        }
        return list.get(0);
    }

    /**
     * 创建或者更新栏目信息
     *
     * @param plateId
     * @param content
     * @param pushDate
     * @param languageTypeEnum
     * @return
     */
    public PlateInformation createOrUpdatePlateInformation(Long plateId, String content, Date pushDate, LanguageType languageTypeEnum) {
        PlateInformation plateInfo = this.findPlateInformationByPlateId(plateId, languageTypeEnum);
        boolean isCreare = true;
        if (plateInfo != null) {
            isCreare = false;
        } else {
            plateInfo = new PlateInformation();
        }
        plateInfo.setLanguage(languageTypeEnum);
        plateInfo.setPushDate(pushDate);
        if (isCreare) {
            plateInfo.setPlate(this.findPlateById(plateId));
        }
        if (isCreare) {
            em.persist(plateInfo);
            em.flush();
        } else {
            em.merge(plateInfo);
        }
        PlateInformationContent pic = this.findContentByPlateInformation(plateInfo.getId());
        if (pic == null) {
            pic = new PlateInformationContent();
            pic.setPlateInformation(plateInfo);
            pic.setContent(content);
            em.persist(pic);
        } else {
            pic.setContent(content);
            em.merge(pic);
        }
        return plateInfo;
    }

    /**
     * 创建或者更新栏目信息
     *
     * @param id
     * @param plateId
     * @param title
     * @param introduction
     * @param content
     * @param pushDate
     * @param languageTypeEnum
     * @param item
     * @return
     */
    public PlateInformation createOrUpdatePlateInformation(Long id, Long plateId, String title, String introduction, String content, Date pushDate, LanguageType languageTypeEnum, String navUrl, FileUploadItem item) {
        PlateInformation plateInfo = new PlateInformation();
        boolean isCreare = true;
        if (id != null) {
            isCreare = false;
            plateInfo = this.findPlateInformationById(id);
        }
        plateInfo.setLanguage(languageTypeEnum);
        plateInfo.setPushDate(pushDate);
        plateInfo.setTitle(title);
        plateInfo.setNavUrl(navUrl);
        plateInfo.setIntroduction(introduction);
        if (item != null) {
            File saveDirFile = new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_PLATE);
            if (!saveDirFile.exists()) {
                saveDirFile.mkdirs();
            }
            String iamgeName = System.currentTimeMillis() + "_" + Tools.generateRandomNumber(3) + item.getOrigFileExtName();
            Tools.setUploadFile(item, Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_PLATE + "/", iamgeName);
            plateInfo.setPicUrl("/" + Config.FILE_UPLOAD_PLATE + "/" + iamgeName);
        }
        if (plateId != null && isCreare) {
            plateInfo.setPlate(this.findPlateById(plateId));
        }
        if (isCreare) {
            em.persist(plateInfo);
            em.flush();
        } else {
            em.merge(plateInfo);
        }
        if (plateInfo.getPlateInformationContent() == null) {
            PlateInformationContent pic = new PlateInformationContent();
            pic.setPlateInformation(plateInfo);
            pic.setContent(content);
            em.persist(pic);
        } else {
            PlateInformationContent pic = plateInfo.getPlateInformationContent();
            pic.setContent(content);
            em.merge(pic);
        }
        return plateInfo;
    }

    /**
     * 创建或者更新栏目信息
     *
     * @param id
     * @param plateId
     * @param title
     * @param introduction
     * @param pushDate
     * @param navUrl
     * @param languageTypeEnum
     * @param item
     * @return
     */
    public PlateInformation createOrUpdatePlateInformation(Long id, Long plateId, String title, String introduction, Date pushDate, String navUrl, LanguageType languageTypeEnum, FileUploadItem item) {
        PlateInformation plateInfo = new PlateInformation();
        boolean isCreare = true;
        if (id != null) {
            isCreare = false;
            plateInfo = this.findPlateInformationById(id);
        }
        plateInfo.setLanguage(languageTypeEnum);
        plateInfo.setPushDate(pushDate);
        plateInfo.setTitle(title);
        plateInfo.setIntroduction(introduction);
        plateInfo.setNavUrl(navUrl);
        if (item != null) {
            File saveDirFile = new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_PLATE);
            if (!saveDirFile.exists()) {
                saveDirFile.mkdirs();
            }
            String iamgeName = System.currentTimeMillis() + "_" + Tools.generateRandomNumber(3) + item.getOrigFileExtName();
            Tools.setUploadFile(item, Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_PLATE + "/", iamgeName);
            plateInfo.setPicUrl("/" + Config.FILE_UPLOAD_PLATE + "/" + iamgeName);
        }
        if (plateId != null && isCreare) {
            plateInfo.setPlate(this.findPlateById(plateId));
        }
        if (isCreare) {
            em.persist(plateInfo);
            em.flush();
        } else {
            em.merge(plateInfo);
        }
        return plateInfo;
    }

    /**
     * 创建更新招聘
     *
     * @param id
     * @param plateId
     * @param pushDate
     * @param position
     * @param depart
     * @param city
     * @param station
     * @param count
     * @param monthly
     * @param description
     * @param duty
     * @param competence
     * @param age
     * @param gender
     * @param englishLevel
     * @param education
     * @param languageTypeEnum
     * @return
     */
    public Offer createOrUpdateOffer(Long id, Long plateId, Date pushDate, String position, String depart, String city,
            String station, String count, String monthly, String description, String duty, String competence, String age, String gender, String englishLevel, String education, LanguageType languageTypeEnum) {
        Offer offer = new Offer();
        boolean isCreare = true;
        if (id != null) {
            isCreare = false;
            offer = this.findOfferById(id);
        }
        offer.setLanguageType(languageTypeEnum);
        offer.setPushDate(pushDate);
        offer.setAge(age);
        offer.setCity(city);
        offer.setCompetence(competence);
        offer.setCount(count);
        offer.setDepart(depart);
        offer.setDescription(description);
        offer.setDuty(duty);
        offer.setEducation(education);
        offer.setEnglishLevel(englishLevel);
        offer.setGender(gender);
        offer.setMonthly(monthly);
        offer.setStation(station);
        offer.setPosition(position);
        if (plateId != null && isCreare) {
            offer.setPlate(this.findPlateById(plateId));
        }
        if (isCreare) {
            em.persist(offer);
            em.flush();
            offer.setCode(Tools.generateRandom8Chars(offer.getId()));
            em.merge(offer);
        } else {
            em.merge(offer);
        }
        return offer;
    }

    /**
     * 创建更新活动
     *
     * @param id
     * @param plateId
     * @param statusBeginDate
     * @param statusEndDate
     * @param eventBeginDate
     * @param eventEndDate
     * @param checkinDate
     * @param title
     * @param detailDescHtml
     * @param allowAttendee
     * @param eventLanguage
     * @param eventLocation
     * @param touristPrice
     * @param userPrice
     * @param companyPrice
     * @param eachCompanyFreeCount
     * @param touristAuth
     * @param userAuth
     * @param companyAuth
     * @param mobileIntroduction
     * @param fileUploadItem
     * @param fileUploadItem2
     * @return
     */
    public FundCollection createOrUpdateFundCollection(Long id, Long plateId, Date statusBeginDate, Date statusEndDate, Date eventBeginDate, Date eventEndDate, Date checkinDate, String title,
            String detailDescHtml, FundCollectionAllowAttendeeEnum allowAttendee, FundCollectionLanaguageEnum eventLanguage, String eventLocation, BigDecimal touristPrice, BigDecimal userPrice, BigDecimal companyPrice, int eachCompanyFreeCount,
            PlateAuthEnum touristAuth, PlateAuthEnum userAuth, PlateAuthEnum companyAuth, String mobileIntroduction, FileUploadItem fileUploadItem, FileUploadItem fileUploadItem2) {
        FundCollection fundCollection = new FundCollection();
        boolean isCreare = true;
        if (id != null) {
            isCreare = false;
            fundCollection = em.find(FundCollection.class, id);
        }
        fundCollection.setIntroduction(mobileIntroduction);
        fundCollection.setAllowAttendee(allowAttendee);
        fundCollection.setCheckinDate(checkinDate);
        fundCollection.setCompanyAuth(companyAuth);
        fundCollection.setCompanyPrice(companyPrice);
        fundCollection.setDetailDescHtml(detailDescHtml);
        fundCollection.setEachCompanyFreeCount(eachCompanyFreeCount);
        fundCollection.setEventBeginDate(eventBeginDate);
        fundCollection.setEventEndDate(eventEndDate);
        fundCollection.setEventLanguage(eventLanguage);
        fundCollection.setEventLocation(eventLocation);
        fundCollection.setStatusBeginDate(statusBeginDate);
        fundCollection.setStatusEndDate(statusEndDate);
        fundCollection.setTitle(title);
        fundCollection.setTouristAuth(touristAuth);
        fundCollection.setTouristPrice(touristPrice);
        fundCollection.setUserAuth(userAuth);
        fundCollection.setUserPrice(userPrice);
        if (fileUploadItem != null) {
            File saveDirFile = new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_PLATE);
            if (!saveDirFile.exists()) {
                saveDirFile.mkdirs();
            }
            String iamgeName = System.currentTimeMillis() + "_" + Tools.generateRandomNumber(3) + fileUploadItem.getOrigFileExtName();
            Tools.setUploadFile(fileUploadItem, Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_PLATE + "/", iamgeName);
            fundCollection.setImageUrl("/" + Config.FILE_UPLOAD_PLATE + "/" + iamgeName);
        }
        if (fileUploadItem2 != null) {
            File saveDirFile = new File(Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_PLATE);
            if (!saveDirFile.exists()) {
                saveDirFile.mkdirs();
            }
            String iamgeName = System.currentTimeMillis() + "_" + Tools.generateRandomNumber(3) + fileUploadItem2.getOrigFileExtName();
            Tools.setUploadFile(fileUploadItem2, Config.FILE_UPLOAD_DIR + Config.FILE_UPLOAD_PLATE + "/", iamgeName);
            fundCollection.setIntroductionImageUrl("/" + Config.FILE_UPLOAD_PLATE + "/" + iamgeName);
        }
        if (plateId != null && isCreare) {
            fundCollection.setPlate(this.findPlateById(plateId));
        }
        if (isCreare) {
            em.persist(fundCollection);
            em.flush();
        } else {
            em.merge(fundCollection);
        }
        return fundCollection;
    }

    /**
     * HTML编辑器删除文件
     *
     * @param sysUser
     * @param filename
     */
    public void doHtmlEditorFileDel(SysUser sysUser, String filename) {
        Long filedirL1 = sysUser.getId() / (10000L);
        String fileFullPath = Config.FILE_UPLOAD_DIR + Config.HTML_EDITOR_UPLOAD + "/" + filedirL1.toString() + "/" + sysUser.getId() + "/" + filename;
        try {
            FileUtils.deleteQuietly(new File(fileFullPath));
        } catch (Exception e) {
        }
    }

    /**
     * HTML编辑器管理文件
     *
     * @param sysUser
     * @param dirName
     * @param path
     * @param order
     * @return
     */
    public Map doHtmlEditorFileManager(SysUser sysUser, String dirName, String path, String order) {
        Long filedirL1 = sysUser.getId() / (10000L);
        String rootPath = Config.FILE_UPLOAD_DIR + Config.HTML_EDITOR_UPLOAD + "/" + filedirL1.toString() + "/" + sysUser.getId();
        String rootUrl = Config.HTTP_URL_BASE + "/" + Config.HTML_EDITOR_UPLOAD + "/" + filedirL1.toString() + "/" + sysUser.getId();
        if (dirName != null) {
            if (!Arrays.<String>asList(new String[]{"image", "flash", "media", "file"}).contains(dirName)) {
                return null;
            }
            rootPath += "/";
            rootUrl += "/";
            File saveDirFile = new File(rootPath);
            if (!saveDirFile.exists()) {
                saveDirFile.mkdirs();
            }
        }
        //根据path参数，设置各路径和URL
        String currentPath = rootPath + path;
        String currentUrl = rootUrl + path;
        String currentDirPath = path;
        String moveupDirPath = "";
        if (!"".equals(path)) {
            String str = currentDirPath.substring(0, currentDirPath.length() - 1);
            moveupDirPath = str.lastIndexOf("/") >= 0 ? str.substring(0, str.lastIndexOf("/") + 1) : "";
        }
        //排序形式，name or size or type
        //不允许使用..移动到上一级目录
        if (path.indexOf("..") >= 0) {
            return null;
        }
        //最后一个字符不是/
        if (!"".equals(path) && !path.endsWith("/")) {
            return null;
        }
        List<Hashtable> fileList = this.getFileInformation(currentPath);
        if ("size".equals(order)) {
            Collections.sort(fileList, new SizeComparator());
        } else if ("type".equals(order)) {
            Collections.sort(fileList, new TypeComparator());
        } else {
            Collections.sort(fileList, new NameComparator());
        }
        Map map = new HashMap();
        map.put("moveup_dir_path", moveupDirPath);
        map.put("current_dir_path", currentDirPath);
        map.put("current_url", currentUrl);
        map.put("total_count", fileList.size());
        map.put("file_list", fileList);
        return map;
    }

    /**
     * HTML编辑器保存上传文件
     *
     * @param item
     * @param sysUser
     * @param dirName
     * @return
     * @throws ImageConvertException
     */
    public String setHtmlEditorUploadFile(FileUploadItem item, SysUser sysUser, String dirName) throws ImageConvertException {
        Long filedirL1 = sysUser.getId() / (10000L);
        String savePath = Config.FILE_UPLOAD_DIR + Config.HTML_EDITOR_UPLOAD + "/" + filedirL1.toString();
        File saveDirFile1 = new File(savePath);
        if (!saveDirFile1.exists()) {
            saveDirFile1.mkdirs();
        }
        savePath += "/" + sysUser.getId();
        File saveDirFile2 = new File(savePath);
        if (!saveDirFile2.exists()) {
            saveDirFile2.mkdirs();
        }
        String filename = sysUser.getId() + "_" + Tools.formatDate(new Date(), "yyyyMMddHHmmss" + "_" + Tools.generateRandomNumber(3)) + "." + FilenameUtils.getExtension(item.getUploadFileName());
        Tools.setUploadFile(item, savePath + "/", filename);
        return Config.HTTP_URL_BASE + "/" + Config.HTML_EDITOR_UPLOAD + "/" + filedirL1.toString() + "/" + sysUser.getId() + "/" + filename;
    }

    /**
     * 创建回复
     *
     * @param id
     * @param mid
     * @param sysUser
     * @param content
     * @param secretLevelEnum
     * @return
     */
    public ReplyMessage createOrUpdateReplyMessage(Long id, Long mid, SysUser sysUser, String content, MessageSecretLevelEnum secretLevelEnum) {
        ReplyMessage replyMessage = new ReplyMessage();
        if (id != null) {
            replyMessage = em.find(ReplyMessage.class, id);
        }
        Message target = em.find(Message.class, mid);
        replyMessage.setMessage(target);
        replyMessage.setContent(content);
        replyMessage.setSysUser(sysUser);
        replyMessage.setSecretLevel(secretLevelEnum);
        replyMessage.setTargetUrl(target.getTargetUrl());
        if (id == null) {
            em.persist(replyMessage);
        } else {
            em.merge(replyMessage);
        }
        return replyMessage;
    }

    // **********************************************************************
    // ************* PRIVATE METHODS *****************************************
    // **********************************************************************
    /**
     * HTML编辑器方法
     *
     * @param currentPath
     * @return
     */
    private List<Hashtable> getFileInformation(String currentPath) {
        String[] fileTypes = new String[]{"gif", "jpg", "jpeg", "png", "bmp"};
        //目录不存在或不是目录
        File currentPathFile = new File(currentPath);
        if (!currentPathFile.isDirectory()) {
            return null;
        }
        //遍历目录取的文件信息
        List<Hashtable> fileList = new ArrayList<Hashtable>();
        if (currentPathFile.listFiles() != null) {
            for (File file : currentPathFile.listFiles()) {
                Hashtable<String, Object> hash = new Hashtable<String, Object>();
                String fileName = file.getName();
                if (file.isDirectory()) {
                    hash.put("is_dir", true);
                    hash.put("has_file", (file.listFiles() != null));
                    hash.put("filesize", 0L);
                    hash.put("is_photo", false);
                    hash.put("filetype", "");
                } else if (file.isFile()) {
                    String fileExt = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
                    hash.put("is_dir", false);
                    hash.put("has_file", false);
                    hash.put("filesize", file.length());
                    hash.put("is_photo", Arrays.<String>asList(fileTypes).contains(fileExt));
                    hash.put("filetype", fileExt);
                }
                hash.put("filename", fileName);
                hash.put("datetime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(file.lastModified()));
                fileList.add(hash);
            }
        }
        return fileList;
    }

    private class NameComparator implements Comparator {

        public int compare(Object a, Object b) {
            Hashtable hashA = (Hashtable) a;
            Hashtable hashB = (Hashtable) b;
            if (((Boolean) hashA.get("is_dir")) && !((Boolean) hashB.get("is_dir"))) {
                return -1;
            } else if (!((Boolean) hashA.get("is_dir")) && ((Boolean) hashB.get("is_dir"))) {
                return 1;
            } else {
                return ((String) hashA.get("filename")).compareTo((String) hashB.get("filename"));
            }
        }
    }

    private class SizeComparator implements Comparator {

        public int compare(Object a, Object b) {
            Hashtable hashA = (Hashtable) a;
            Hashtable hashB = (Hashtable) b;
            if (((Boolean) hashA.get("is_dir")) && !((Boolean) hashB.get("is_dir"))) {
                return -1;
            } else if (!((Boolean) hashA.get("is_dir")) && ((Boolean) hashB.get("is_dir"))) {
                return 1;
            } else {
                if (((Long) hashA.get("filesize")) > ((Long) hashB.get("filesize"))) {
                    return 1;
                } else if (((Long) hashA.get("filesize")) < ((Long) hashB.get("filesize"))) {
                    return -1;
                } else {
                    return 0;
                }
            }
        }
    }

    private class TypeComparator implements Comparator {

        public int compare(Object a, Object b) {
            Hashtable hashA = (Hashtable) a;
            Hashtable hashB = (Hashtable) b;
            if (((Boolean) hashA.get("is_dir")) && !((Boolean) hashB.get("is_dir"))) {
                return -1;
            } else if (!((Boolean) hashA.get("is_dir")) && ((Boolean) hashB.get("is_dir"))) {
                return 1;
            } else {
                return ((String) hashA.get("filetype")).compareTo((String) hashB.get("filetype"));
            }
        }
    }

}
