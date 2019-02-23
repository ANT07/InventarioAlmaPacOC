/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import java.util.Date;
import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.servicios.interfaces.VentaDAO;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import retail.modelo.entidades.Ventas;

/**
 *
 * @author William Vasquez
 */
public class ServiciosVenta implements VentaDAO {

    public void insertarVentas(Ventas venta)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(venta);
        tx.commit();
        session.close();
    }

    public void eliminarVentas(Ventas venta)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(venta);
        tx.commit();
        session.close();
    }

    public void actualizarVentas(Ventas venta)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(venta);
        tx.commit();
        session.close();
    }

    public List<Ventas> obtenerVentas()
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Ventas");
        return query.list();
    }

    public Ventas obtenerVentasById(int id)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Ventas ventas = (Ventas) session.get(Ventas.class,
                id);
        session.close();
        return ventas;
    }

    public List<Ventas> obtenerVentasByVendedor(int id) {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Criteria criteriaVenta = session.createCriteria(Ventas.class);
        Criteria criteriaVendedor = criteriaVenta.createCriteria("vendedor");
        criteriaVendedor.add(Restrictions.idEq(id));
        return criteriaVenta.list();
    }

    public List<Ventas> obtenerVentasByCliente(int id) {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Criteria criteriaVenta = session.createCriteria(Ventas.class);
        Criteria criteriaCliente = criteriaVenta.createCriteria("clientes");
        criteriaCliente.add(Restrictions.idEq(id));
        return criteriaVenta.list();
    }

    public List<Ventas> obtenerVentasByFecha(Date fecha) {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Criteria criteriaVenta = session.createCriteria(Ventas.class);
        criteriaVenta.add(Restrictions.eq("fechaVenta",
                fecha));
        return criteriaVenta.list();
    }

}
