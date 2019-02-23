/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.servicios.interfaces.DetalleCompraDAO;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import retail.modelo.entidades.Detallecompra;

;

/**
 *
 * @author William Vasquez
 */
public class ServiciosDetalleCompra implements DetalleCompraDAO {

    public void insertarDetallecompra(Detallecompra detalleCompra)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(detalleCompra);
        tx.commit();
        session.close();
    }

    public void eliminarDetallecompra(Detallecompra detalleCompra)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(detalleCompra);
        tx.commit();
        session.close();
    }

    public void actualizarDetallecompra(Detallecompra detalleCompra)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(detalleCompra);
        tx.commit();
        session.close();
    }

    public List<Detallecompra> obtenerDetallecompra()
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Detallecompra");
        session.close();
        return query.list();
    }

    public Detallecompra obtenerDetallecompraById(int id)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Detallecompra detalleCompras = (Detallecompra) session.get(
                Detallecompra.class,
                id);
        session.close();
        return detalleCompras;
    }

    public List<Detallecompra> obtenerDetallecomprasByCompra(int idCompra) {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Criteria criteriaDetalleCompra = session.createCriteria(Detallecompra.class);
        Criteria criteriaCompra = criteriaDetalleCompra.createCriteria(
                "compra");
        criteriaCompra.add(Restrictions.idEq(idCompra));
        return criteriaDetalleCompra.list();
    }

}
