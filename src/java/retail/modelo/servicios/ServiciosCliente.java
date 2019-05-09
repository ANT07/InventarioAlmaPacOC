/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.servicios.interfaces.ClienteDAO;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import retail.modelo.entidades.Clientes;

/**
 *
 * @author William Vasquez
 */
public class ServiciosCliente implements ClienteDAO{

    @Override
    public void insertarClientes(Clientes cliente)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(cliente);
        tx.commit();
        session.close();
    }

    public void eliminarClientes(Clientes cliente)
            throws Exception {
                Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.delete(cliente);
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

    public void actualizarClientes(Clientes cliente)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(cliente);
        tx.commit();
        session.close();
    }

    public List<Clientes> obtenerClientes()
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Clientes");
        List<Clientes> clientes = query.list();
        session.close();
        return clientes;
    }

    public Clientes obtenerClientesById(int id)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Clientes clientes = (Clientes) session.get(Clientes.class,
                id);
        session.close();
        return clientes;
    }

}
