
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.entity.Plate;
import com.cbra.entity.PlateInformation;
import com.cbra.entity.SysMenu;
import com.cbra.entity.SysRole;
import com.cbra.entity.SysRoleMenu;
import com.cbra.entity.SysUser;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.enums.PlateKeyEnum;
import com.cbra.support.enums.PlateTypeEnum;
import com.cbra.support.enums.SysMenuPopedomEnum;
import com.cbra.support.enums.SysUserTypeEnum;
import com.cbra.support.exception.AccountAlreadyExistException;
import com.cbra.support.exception.AccountNotExistException;
import com.cbra.support.exception.EjbMessageException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
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
     * 根据菜单删除角色菜单
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
     * @param pid
     * @return
     */
    public Plate createOrUpdatePlate(Long id, String name, String enName, PlateTypeEnum type, PlateKeyEnum key, Long pid) {
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
        plate.setSortIndex(99);
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
    public Plate findPlateByKey(PlateKeyEnum key) {
        Plate plate = null;
        try {
            TypedQuery<Plate> query = em.createQuery("SELECT p FROM Plate p WHERE p.plateKey = :key", Plate.class);
            query.setParameter("key", key);
            plate = query.getSingleResult();
        } catch (NoResultException ex) {
            plate = null;
        }
        return plate;
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
}
