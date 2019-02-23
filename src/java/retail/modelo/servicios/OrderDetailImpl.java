/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.entidades.OrderDetail;
import retail.modelo.entidades.OrderDetailId;
import retail.modelo.servicios.interfaces.OrderDetailDAO;

/**
 *
 * @author anthony
 */
public class OrderDetailImpl implements OrderDetailDAO{
    
    @Override
    public void insertOrderDetail(OrderDetail orderDetail) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(orderDetail);
        tx.commit();
        session.close();
    }

    @Override
    public void deleteOrderDetail(OrderDetail orderDetail) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(orderDetail);
        tx.commit();
        session.close();
    }

    @Override
    public void updateOrderDetail(OrderDetail orderDetail) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(orderDetail);
        tx.commit();
        session.close();
    }
    
    @Override
    public OrderDetail getOrderDetailById(OrderDetailId orderDetailId) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        OrderDetail orderDetail = (OrderDetail)session.get(OrderDetail.class, orderDetailId);
        session.close();
        return orderDetail;
    }
    
    @Override
    public List<OrderDetail> getOrderDetails() throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from OrderDetail");
        List<OrderDetail> orderDetails = query.list();
        return orderDetails;
    }
}
