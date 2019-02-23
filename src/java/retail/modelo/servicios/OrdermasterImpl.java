/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.entidades.OrderMaster;
import retail.modelo.servicios.interfaces.OrderMarsterDAO;

/**
 *
 * @author anthony
 */
public class OrdermasterImpl implements OrderMarsterDAO {
    
     @Override
    public void insertOrderMaster(OrderMaster orderMaster) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(orderMaster);
        tx.commit();
        session.close();
    }

    @Override
    public void deleteOrderMaster(OrderMaster orderMaster) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(orderMaster);
        tx.commit();
        session.close();
    }

    @Override
    public void updateOrderMaster(OrderMaster orderMaster) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(orderMaster);
        tx.commit();
        session.close();
    }
    
    @Override
    public OrderMaster getOrderMasterById(String orderMasterId) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        OrderMaster orderMaster = (OrderMaster)session.get(OrderMaster.class, orderMasterId);
        session.close();
        return orderMaster;
    }
    

    public List<OrderMaster> getOrderMastersDesc() throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from OrderMaster order by orderid desc");
        query.setMaxResults(50);
        List<OrderMaster> orderMasters = query.list();
        return orderMasters;
    }
    
    @Override
    public List<OrderMaster> getOrderMasters() throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from OrderMaster ");
        List<OrderMaster> orderMasters = query.list();
        return orderMasters;
    }
    
    
    public List<OrderMaster> busquedaOrdenes(OrderMaster example){
        Criteria criteria = NewHibernateUtil.getSessionFactory().openSession().createCriteria(
                OrderMaster.class);
        
        criteria.add(Restrictions.like("orderid",
                example.getOrderid(),MatchMode.ANYWHERE));
        criteria.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        return criteria.list();
    }
}
