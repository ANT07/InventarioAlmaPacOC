/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.util.List;
import retail.modelo.entidades.OrderType;

/**
 *
 * @author anthony
 */
public interface OrderTypeDAO {
    public void insertOrderType(OrderType orderType) throws Exception;
    public void deleteOrderType(OrderType orderType) throws Exception;
    public void updateOrderType(OrderType orderType) throws Exception;
    public OrderType getOrderTypeById(int orderTypeId) throws Exception;
    public List<OrderType> getOrderTypes() throws Exception;
}
