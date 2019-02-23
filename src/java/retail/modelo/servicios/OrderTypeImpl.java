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
import retail.modelo.entidades.OrderType;
import retail.modelo.servicios.interfaces.OrderTypeDAO;

/**
 *
 * @author anthony
 */
public class OrderTypeImpl implements OrderTypeDAO{
    @Override
    public void insertOrderType(OrderType orderType) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(orderType);
        tx.commit();
        session.close();
    }

    @Override
    public void deleteOrderType(OrderType orderType) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(orderType);
        tx.commit();
        session.close();
    }

    @Override
    public void updateOrderType(OrderType orderType) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(orderType);
        tx.commit();
        session.close();
    }
    
    @Override
    public OrderType getOrderTypeById(int orderTypeId) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        OrderType orderType = (OrderType)session.get(OrderType.class, orderTypeId);
        session.close();
        return orderType;
    }
    
    @Override
    public List<OrderType> getOrderTypes() throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from OrderType");
        List<OrderType> orderTypes = query.list();
        return orderTypes;
    }
}
