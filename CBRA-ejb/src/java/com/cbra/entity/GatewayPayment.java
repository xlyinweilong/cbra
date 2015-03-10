/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cbra.entity;

import com.cbra.support.enums.GatewayPaymentSourceEnum;
import com.cbra.support.enums.GatewayPaymentStatusEnum;
import com.cbra.support.enums.PaymentGatewayTypeEnum;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 * 支付网关
 *
 * @author yin.weilong
 */
@Entity
@Table(name = "gateway_payment")
@XmlRootElement
public class GatewayPayment implements Serializable {

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
    @Basic(optional = false)
    @NotNull
    @Column(name = "gateway_amount", nullable = false, precision = 22, scale = 2)
    private BigDecimal gatewayAmount = new BigDecimal(0);
    @Enumerated(EnumType.STRING)
    @Column(name = "gateway_type", nullable = false, length = 255)
    private PaymentGatewayTypeEnum gatewayType;
    @Column(name = "gateway_sub_type")
    private Integer gatewaySubType;
    @Column(name = "gateway_sub_type_string")
    private String gatewaySubTypeString;
    //支付状态：成功、失败、审核
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false, length = 255)
    private GatewayPaymentStatusEnum status = GatewayPaymentStatusEnum.PAYMENT_PENDING;
    @Enumerated(EnumType.STRING)
    @Column(name = "source", nullable = false, length = 255)
    private GatewayPaymentSourceEnum source = GatewayPaymentSourceEnum.WEB;
    @Column(name = "payment_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date paymentDate = null;
    @Size(max = 2048)
    @Column(name = "payment_gateway_msg", length = 2048)
    private String paymentGatewayMsg;
    @JoinColumn(name = "order_id", referencedColumnName = "id")
    @ManyToOne
    private OrderCollection orderCollection;
    @JoinColumn(name = "order_service_id", referencedColumnName = "id")
    @ManyToOne
    private OrderCbraService orderCbraService;
    @Basic(optional = false)
    @NotNull
    @Column(name = "deleted", nullable = false)
    private Boolean deleted = false;

    public boolean isSuccess() {
        if (status.equals(GatewayPaymentStatusEnum.PAYMENT_SUCCESS)) {
            return true;
        }
        return false;
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

    public OrderCbraService getOrderCbraService() {
        return orderCbraService;
    }

    public void setOrderCbraService(OrderCbraService orderCbraService) {
        this.orderCbraService = orderCbraService;
    }

    public GatewayPayment() {
    }

    public GatewayPayment(Long id) {
        this.id = id;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public BigDecimal getGatewayAmount() {
        return gatewayAmount;
    }

    public void setGatewayAmount(BigDecimal gatewayAmount) {
        this.gatewayAmount = gatewayAmount;
    }

    public PaymentGatewayTypeEnum getGatewayType() {
        return gatewayType;
    }

    public void setGatewayType(PaymentGatewayTypeEnum gatewayType) {
        this.gatewayType = gatewayType;
    }

    public Integer getGatewaySubType() {
        return gatewaySubType;
    }

    public void setGatewaySubType(Integer gatewaySubType) {
        this.gatewaySubType = gatewaySubType;
    }

    public String getGatewaySubTypeString() {
        return gatewaySubTypeString;
    }

    public void setGatewaySubTypeString(String gatewaySubTypeString) {
        this.gatewaySubTypeString = gatewaySubTypeString;
    }

    public GatewayPaymentStatusEnum getStatus() {
        return status;
    }

    public void setStatus(GatewayPaymentStatusEnum status) {
        this.status = status;
    }

    public GatewayPaymentSourceEnum getSource() {
        return source;
    }

    public void setSource(GatewayPaymentSourceEnum source) {
        this.source = source;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentGatewayMsg() {
        return paymentGatewayMsg;
    }

    public void setPaymentGatewayMsg(String paymentGatewayMsg) {
        this.paymentGatewayMsg = paymentGatewayMsg;
    }

    public OrderCollection getOrderCollection() {
        return orderCollection;
    }

    public void setOrderCollection(OrderCollection orderCollection) {
        this.orderCollection = orderCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof GatewayPayment)) {
            return false;
        }
        GatewayPayment other = (GatewayPayment) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.cbra.entity.GatewayPayment[ id=" + id + " ]";
    }

}
