
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.service;

import com.cbra.entity.SysMenu;
import com.cbra.entity.SysRole;
import com.cbra.entity.SysRoleUser;
import com.cbra.entity.SysUser;
import com.cbra.support.Tools;
import com.cbra.support.enums.SysMenuPopedomEnum;
import com.cbra.support.enums.SysUserTypeEnum;
import com.cbra.support.exception.AccountNotExistException;
import com.cbra.support.exception.EjbMessageException;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Logger;
import javax.ejb.Stateless;
import javax.ejb.LocalBean;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

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
     * 通过帐号获得后台用户对象
     *
     * @param account
     * @return
     */
    public SysUser findByAccpunt(String account) {
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
        SysUser user = this.findByAccpunt(account);
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
    
    public SysMenu createSysMenu(){
        SysMenu sm = new SysMenu();
        em.persist(sm);
        return sm;
    }
    
    /**
     * 根据ID删除菜单
     *
     * @param ids
     */
    public void deleteSysMenuById(Long... ids) {
//        TypedQuery<SysMenu> query = em.createQuery("SELECT sm FROM SysMenu sm WHERE sm.level = :level ORDER BY sm.sortIndex asc", SysMenu.class);
//        query.setParameter("level", level);
//        return query.getResultList();
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

    public List<SysMenu> updateSysMenuList4Level(String level) {
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
    public List<SysMenu> findSysMenuListByParentId(String pid) {
        TypedQuery<SysMenu> query = em.createQuery("SELECT sm FROM SysMenu sm WHERE sm.parentMenu is not null AND sm.parentMenu.id = :pid ORDER BY sm.sortIndex asc", SysMenu.class);
        query.setParameter("pid", pid);
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
