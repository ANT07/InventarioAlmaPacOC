/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.servicios.interfaces.VendedorDAO;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import retail.modelo.entidades.Vendedor;

/**
 *
 * @author William Vasquez
 */
public class ServiciosVendedor implements VendedorDAO{

    public void insertarVendedor(Vendedor vendedor)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(vendedor);
        tx.commit();
        session.close();
    }

    public void eliminarVendedor(Vendedor vendedor)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(vendedor);
        tx.commit();
        session.close();
    }

    public void actualizarVendedor(Vendedor vendedor)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(vendedor);
        tx.commit();
        session.close();
    }

    public List<Vendedor> obtenerVendedores()
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Vendedor");
        List<Vendedor> vendedores = query.list();
        session.close();
        return vendedores;
    }

    public Vendedor obtenerVendedorById(int id)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Vendedor vendedors = (Vendedor) session.get(Vendedor.class,
                id);
        session.close();
        return vendedors;
    }

}
