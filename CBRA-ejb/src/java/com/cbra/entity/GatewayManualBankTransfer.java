/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 银行转账申请记录
 *
 * @author yin
 */
@Entity
@Table(name = "gateway_manual_bank_transfer")
@XmlRootElement
public class GatewayManualBankTransfer implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Long id;
    @Version
    private Integer version;
    @Basic(optional = false)
    @NotNull
    @Column(name = "create_date", nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate = new Date();
    @JoinColumn(name = "gateway_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private GatewayPayment gatewayPayment;
    @JoinColumn(name = "order_collection_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private OrderCollection orderCollection;
    @JoinColumn(name = "order_service_id", referencedColumnName = "id")
    @ManyToOne(fetch = FetchType.LAZY)
    private OrderCbraService orderCbraService;
    @Column(name = "message")
    private String message;
    @NotNull
    @Column(name = "deleted", nullable = false)
    private Boolean deleted = false;

    public OrderCbraService getOrderCbraService() {
        return orderCbraService;
    }

    public void setOrderCbraService(OrderCbraService orderCbraService) {
        this.orderCbraService = orderCbraService;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Integer getVersion() {
        return version;
    }

    public void setVersion(Integer version) {
        this.version = version;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public GatewayPayment getGatewayPayment() {
        return gatewayPayment;
    }

    public void setGatewayPayment(GatewayPayment gatewayPayment) {
        this.gatewayPayment = gatewayPayment;
    }

    public OrderCollection getOrderCollection() {
        return orderCollection;
    }

    public void setOrderCollection(OrderCollection orderCollection) {
        this.orderCollection = orderCollection;
    }

}
