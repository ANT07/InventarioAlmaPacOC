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
import retail.modelo.entidades.Provider;
import retail.modelo.servicios.interfaces.ProviderDAO;

/**
 *
 * @author anthony
 */
public class ProviderImpl implements ProviderDAO{

    @Override
    public void insertProvider(Provider provider) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(provider);
        tx.commit();
        session.close();
    }

    @Override
    public void deleteProvider(Provider provider) throws Exception {
                Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.delete(provider);
            tx.commit();
        } catch (Exception e) {
            tx.rollback();
            throw e;
        } finally {
            if (session != null) {
                session.close();
            }
        }

    }

    @Override
    public void updateProvider(Provider provider) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(provider);
        tx.commit();
        session.close();
    }
    
    @Override
    public Provider getProviderById(int providerId) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Provider provider = (Provider)session.get(Provider.class, providerId);
        session.close();
        return provider;
    }
    
    @Override
    public List<Provider> getProviders() throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Provider");
        List<Provider> providers = query.list();
        return providers;
    }

    /*public List<Object []> getProviders() throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createSQLQuery("select * from provider");
        List<Object []> providers = query.list();

        return providers;
    }*/

}
