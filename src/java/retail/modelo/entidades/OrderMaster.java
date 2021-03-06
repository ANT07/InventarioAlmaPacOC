package retail.modelo.entidades;
// Generated 02-18-2019 03:12:08 PM by Hibernate Tools 4.3.1


import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * OrderMaster generated by hbm2java
 */
public class OrderMaster  implements java.io.Serializable {


     private String orderid;
     private Department department;
     private OrderType orderType;
     private Provider provider;
     private Vendedor vendedor;
     private Date orderdate;
     private String ordercoment;
     private Float ordertotal;
     private Set orderDetails = new HashSet(0);

    public OrderMaster() {
    }

	
    public OrderMaster(String orderid, Department department, OrderType orderType, Provider provider, Vendedor vendedor) {
        this.orderid = orderid;
        this.department = department;
        this.orderType = orderType;
        this.provider = provider;
        this.vendedor = vendedor;
    }
    public OrderMaster(String orderid, Department department, OrderType orderType, Provider provider, Vendedor vendedor, Date orderdate, String ordercoment, Float ordertotal, Set orderDetails) {
       this.orderid = orderid;
       this.department = department;
       this.orderType = orderType;
       this.provider = provider;
       this.vendedor = vendedor;
       this.orderdate = orderdate;
       this.ordercoment = ordercoment;
       this.ordertotal = ordertotal;
       this.orderDetails = orderDetails;
    }
   
    public String getOrderid() {
        return this.orderid;
    }
    
    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }
    public Department getDepartment() {
        return this.department;
    }
    
    public void setDepartment(Department department) {
        this.department = department;
    }
    public OrderType getOrderType() {
        return this.orderType;
    }
    
    public void setOrderType(OrderType orderType) {
        this.orderType = orderType;
    }
    public Provider getProvider() {
        return this.provider;
    }
    
    public void setProvider(Provider provider) {
        this.provider = provider;
    }
    public Vendedor getVendedor() {
        return this.vendedor;
    }
    
    public void setVendedor(Vendedor vendedor) {
        this.vendedor = vendedor;
    }
    public Date getOrderdate() {
        return this.orderdate;
    }
    
    public void setOrderdate(Date orderdate) {
        this.orderdate = orderdate;
    }
    public String getOrdercoment() {
        return this.ordercoment;
    }
    
    public void setOrdercoment(String ordercoment) {
        this.ordercoment = ordercoment;
    }
    public Float getOrdertotal() {
        return this.ordertotal;
    }
    
    public void setOrdertotal(Float ordertotal) {
        this.ordertotal = ordertotal;
    }
    public Set getOrderDetails() {
        return this.orderDetails;
    }
    
    public void setOrderDetails(Set orderDetails) {
        this.orderDetails = orderDetails;
    }




}


