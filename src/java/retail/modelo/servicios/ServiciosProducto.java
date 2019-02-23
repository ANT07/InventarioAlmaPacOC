/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.servicios.interfaces.ProductoDAO;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import retail.modelo.entidades.Producto;
;

/**
 *
 * @author William Vasquez
 */
public class ServiciosProducto implements ProductoDAO{

    public void insertarProducto(Producto producto)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(producto);
        tx.commit();
        session.close();
    }

    public void eliminarProducto(Producto producto)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(producto);
        tx.commit();
        session.close();
    }

    public void actualizarProducto(Producto producto)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(producto);
        tx.commit();
        session.close();
    }

    public List<Producto> obtenerProducto()
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Producto");
        List<Producto> productos = query.list();
        session.close();
        return productos;
    }

    public Producto obtenerProductoById(int id)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Producto productos = (Producto) session.get(Producto.class,
                id);
        session.close();
        return productos;
    }

}
