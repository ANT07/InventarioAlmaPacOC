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
import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.entidades.Roll;

/**
 *
 * @author anthony
 */
public class RollDAO {
    public void insertarRoll(Roll roll){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.save(roll);
        transaction.commit();
        session.close();     
    }
    
    public List<Roll> obtenerRolls(){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery("from Roll");
        List<Roll> rolls = query.list();
//        session.close();     
        return rolls;
    }
    
    public void eliminarRoll(Roll roll){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.delete(roll);
        transaction.commit();
        session.close();     
    }
    
    public void actualizarRoll(Roll roll){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(roll);
        transaction.commit();
        session.close();     
    }
    
    public Roll obtenerRoll(int id){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        Roll menu = (Roll)session.get(Roll.class,
                id);
        transaction.commit();
        session.close();
        return menu;
    }
}
