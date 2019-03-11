/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.servicios.interfaces.DetalleVentaDAO;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import retail.modelo.entidades.Detalleventa;

;

/**
 *
 * @author William Vasquez
 */
public class ServiciosDetalleVenta implements DetalleVentaDAO {

    public void insertarDetalleventa(Detalleventa detalleVenta)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(detalleVenta);
        tx.commit();
        session.close();
    }

    public void eliminarDetalleventa(Detalleventa detalleVenta)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(detalleVenta);
        tx.commit();
        session.close();
    }

    public void actualizarDetalleventa(Detalleventa detalleVenta)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(detalleVenta);
        tx.commit();
        session.close();
    }

    public List<Detalleventa> obtenerDetalleventa()
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Detalleventa");
        session.close();
        return query.list();
    }

    public Detalleventa obtenerDetalleventaById(int id)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Detalleventa detalleVentas = (Detalleventa) session.get(
                Detalleventa.class,
                id);
        session.close();
        return detalleVentas;
    }

    public List<Detalleventa> obtenerDetalleventasByIdVenta(int idVenta) {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Criteria criteriaDetalleVenta = session.createCriteria(
                Detalleventa.class);
        Criteria criteriaVenta = criteriaDetalleVenta.createCriteria(
                "ventas");
        criteriaVenta.add(Restrictions.eq("idVenta",
                idVenta));
        criteriaDetalleVenta.setFetchMode("producto", FetchMode.JOIN);
        List<Detalleventa> detalleVentas = criteriaDetalleVenta.list();
        return detalleVentas;
    }

}
