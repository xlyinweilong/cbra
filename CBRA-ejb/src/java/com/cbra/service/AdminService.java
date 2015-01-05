
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.entity.SysMenu;
import com.cbra.entity.SysRoleUser;
import com.cbra.entity.SysUser;
import com.cbra.support.ResultList;
import com.cbra.support.Tools;
import com.cbra.support.enums.SysMenuPopedomEnum;
import com.cbra.support.enums.SysUserTypeEnum;
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
     * 创建后台用户
     *
     * @param account
     * @param name
     * @param passwd
     * @param adminType
     * @return
     */
    public SysUser createSysUser(String account, String name, String passwd, SysUserTypeEnum adminType) {
        SysUser ua = new SysUser();
        em.persist(ua);
        em.flush();
        return ua;
    }

    /**
     * 通过ID删除后台用户
     *
     * @param id
     */
    public void deleteSysUser(Long... id) {
//        SysUser ua = this.findById(id);
//        ua.setDeleted(Boolean.TRUE);
//        em.merge(ua);
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
    public SysMenu createSysMenu(Long id, Long pid, String name, String url, SysMenuPopedomEnum popedom) {
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
            if (id == null) {
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
            List<SysRoleUser> sysRoleUserList = su.getSysRoleUserList();
            List<Long> sysRoleIds = new LinkedList<>();
            sysRoleUserList.stream().forEach((sysRoleUser) -> {
                sysRoleIds.add(sysRoleUser.getSysRole().getId());
            });
            TypedQuery<SysMenu> query = em.createQuery("SELECT srm.sysMenu FROM SysRoleMenu srm WHERE srm.sysRole.id IN :sysRoleIds AND srm.sysMenu.level = :level AND srm.sysMenu.popedom = :popedom ORDER BY srm.sysMenu.sortIndex asc", SysMenu.class);
            query.setParameter("sysRoleIds", sysRoleIds).setParameter("level", level).setParameter("popedom", popedom);
            return query.getResultList();
        }
    }

}
