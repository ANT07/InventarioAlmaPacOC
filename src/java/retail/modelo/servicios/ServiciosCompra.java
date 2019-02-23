/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import retail.modelo.conexion.NewHibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import retail.modelo.entidades.Compra;
import retail.modelo.servicios.interfaces.CompraDAO;

/**
 *
 * @author William Vasquez
 */
public class ServiciosCompra implements CompraDAO{

    public void insertarCompra(Compra compra)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(compra);
        tx.commit();
        session.close();
    }

    public void eliminarCompra(Compra compra)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(compra);
        tx.commit();
        session.close();
    }

    public void actualizarCompra(Compra compra)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(compra);
        tx.commit();
        session.close();
    }

    public List<Compra> obtenerCompra()
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Compra");
        return query.list();
    }

    public Compra obtenerCompraById(int id)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Compra compras = (Compra) session.get(Compra.class,
                id);
        session.close();
        return compras;
    }

}
