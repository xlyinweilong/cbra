/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.enums.MessageSecretLevelEnum;
import com.cbra.support.enums.MessageTypeEnum;
import com.cbra.support.enums.OrderStatusEnum;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 收款订单
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "order_collection")
@XmlRootElement
public class OrderCollection implements Serializable{

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;
    @Version
    private Integer version;
    @Basic(optional = false)
    @NotNull
    @Column(name = "create_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate = new Date();
    //订单结束时间：成功、失败、失效等结束状态
    @Column(name = "end_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date endDate;
    //订单序列号
    @Size(max = 100)
    @Column(name = "serial_id")
    private String serialId;
    //订单状态
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 20)
    private OrderStatusEnum status = OrderStatusEnum.INIT;
    //订单总额
    @Basic(optional = false)
    @NotNull
    @Column(name = "amount")
    private BigDecimal amount = BigDecimal.ZERO;
    @Basic(optional = false)
    @NotNull
    @Column(name = "deleted")
    private boolean deleted = false;
    @JoinColumn(name = "owner_id", referencedColumnName = "id")
    @ManyToOne(optional = true)
    private UserAccount owner;
    @JoinColumn(name = "collection_id", referencedColumnName = "id", nullable = false)
    @ManyToOne(optional = false)
    private FundCollection fundCollection;

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OrderCollection)) {
            return false;
        }
        OrderCollection other = (OrderCollection) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.Message[ id=" + id + " ]";
    }

}