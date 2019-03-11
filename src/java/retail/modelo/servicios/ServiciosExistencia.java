/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;

import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.servicios.interfaces.ExistenciaDAO;
import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import retail.modelo.entidades.Existencia;

/**
 *
 * @author William Vasquez
 */
public class ServiciosExistencia implements ExistenciaDAO {

    public void insertarExistencia(Existencia existencia)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(existencia);
        tx.commit();
        session.close();
    }

    public void eliminarExistencia(Existencia existencia)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(existencia);
        tx.commit();
        session.close();
    }

    public void actualizarExistencia(Existencia existencia)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(existencia);
        tx.commit();
        session.close();
    }

    public List<Existencia> obtenerExistencias()
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Existencia");
        List<Existencia> existenciaes = query.list();
        session.close();
        return existenciaes;
    }

    public Existencia obtenerExistenciaById(int id)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Existencia existencias = (Existencia) session.get(Existencia.class,
                id);
        session.close();
        return existencias;
    }

    public Existencia obtenerExistenciaByProductoByDepartamento(int codigoProducto, int idDepartamento)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Criteria criteriaExistencia = session.createCriteria(Existencia.class);
        criteriaExistencia.createAlias("departamento", "dep");
        criteriaExistencia.createAlias("producto", "p");
        criteriaExistencia.add(Restrictions.eq("dep.departmentid", idDepartamento));
        criteriaExistencia.add(Restrictions.eq("p.codigoProducto", codigoProducto));
        Existencia existencia = (Existencia) criteriaExistencia.list().get(0);
        session.close();
        return existencia;
    }

}
