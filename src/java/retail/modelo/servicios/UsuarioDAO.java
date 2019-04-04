/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;


import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.CriteriaSpecification;
import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.entidades.Usuario;

/**
 *
 * @author anthony
 */
public class UsuarioDAO {
    public void insertarUsuario(Usuario usuario){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.save(usuario);
        transaction.commit();
        session.close();     
    }
    
    public List<Usuario> obtenerUsuarios(){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery("from Usuario ");
        query.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        List<Usuario> usuarios = query.list();    
        return usuarios;
    }
    
    public void eliminarUsuario(Usuario usuario){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.delete(usuario);
        transaction.commit();
        session.close();     
    }
    
    public void actualizarUsuario(Usuario usuario){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(usuario);
        transaction.commit();
        session.close();     
    }
    
    public Usuario obtenerUsuario(String id){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        //Transaction transaction = session.beginTransaction();
        Usuario usuario = (Usuario)session.get(Usuario.class,
                id);
        //transaction.commit();
        session.close();
        return usuario;
    }
}
