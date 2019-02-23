/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.util.List;
import retail.modelo.entidades.OrderMaster;

/**
 *
 * @author anthony
 */
public interface OrderMarsterDAO {
    
        public void insertOrderMaster(OrderMaster orderMaster) throws Exception;
        public void deleteOrderMaster(OrderMaster orderMaster) throws Exception;
        public void updateOrderMaster(OrderMaster orderMaster) throws Exception;
        public OrderMaster getOrderMasterById(String orderMasterId) throws Exception;
        public List<OrderMaster> getOrderMasters() throws Exception;
}
