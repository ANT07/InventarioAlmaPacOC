/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.util.List;
import retail.modelo.entidades.OrderDetail;
import retail.modelo.entidades.OrderDetailId;

/**
 *
 * @author anthony
 */
public interface OrderDetailDAO {
    public void insertOrderDetail(OrderDetail orderDetail) throws Exception;
    public void deleteOrderDetail(OrderDetail orderDetail) throws Exception;
    public void updateOrderDetail(OrderDetail orderDetail) throws Exception;
    public OrderDetail getOrderDetailById(OrderDetailId orderDetailId) throws Exception;
    public List<OrderDetail> getOrderDetails() throws Exception;
}
