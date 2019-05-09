/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.servicios.interfaces.ProductoDAO;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Restrictions;
import org.hibernate.sql.JoinType;
import retail.modelo.entidades.Existencia;
import retail.modelo.entidades.Producto;

;

/**
 *
 * @author William Vasquez
 */
public class ServiciosProducto implements ProductoDAO {

    public Existencia getExistenciaByCodigo(int codigoProducto, int idBodega) {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Criteria criteria = session.createCriteria(Existencia.class);
        criteria.createAlias("departamento", "dep");
        criteria.add(Restrictions.eq("dep.departmentid", idBodega));
        criteria.createAlias("producto", "p");
        criteria.add(Restrictions.eq("p.codigoProducto", codigoProducto));
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        Existencia existencia = (Existencia) criteria.list().get(0);
        return existencia;
    }

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
        Session session = null;
        Transaction tx = null;
        try {
            SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
            session = sessionFactory.openSession();
            tx = session.beginTransaction();
            session.delete(producto);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();
            }
            throw e;
        } finally {
            System.out.println("Finally");
            if (session != null) {
                session.close();
            }
        }
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

//    public List<Object []> obtenerProducto_ExistenciaVentas(int codigoProducto){
//        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
//        Session session = sessionFactory.openSession();
//        Producto productos = (Producto) session.get(Producto.class,
//                id);
//        session.close();
//        return productos;
//    }
}
