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
import retail.modelo.entidades.Traslado;
import retail.modelo.servicios.interfaces.TrasladoDAO;

/**
 *
 * @author William Vasquez
 */
public class ServiciosTraslado implements TrasladoDAO{

    @Override
    public void insertarTraslado(Traslado traslado)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(traslado);
        tx.commit();
        session.close();
    }

    public void eliminarTraslado(Traslado traslado)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(traslado);
        tx.commit();
        session.close();
    }

    public void actualizarTraslado(Traslado traslado)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(traslado);
        tx.commit();
        session.close();
    }

    public List<Traslado> obtenerTraslado()
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Traslado");
        List<Traslado> traslados = query.list();
        session.close();
        return traslados;
    }

    public Traslado obtenerTrasladoById(int id)
            throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Traslado traslados = (Traslado) session.get(Traslado.class,
                id);
        session.close();
        return traslados;
    }

}
