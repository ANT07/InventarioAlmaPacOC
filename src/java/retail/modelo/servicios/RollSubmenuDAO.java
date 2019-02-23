/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;



import java.util.List;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.CriteriaSpecification;
import org.hibernate.criterion.Restrictions;
import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.entidades.RollSubmenu;

/**
 *
 * @author anthony
 */
public class RollSubmenuDAO {
    public void insertarRollSubmenu(RollSubmenu rollSubmenu){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.save(rollSubmenu);
        transaction.commit();
        session.close();     
    }
    
    public List<RollSubmenu> obtenerRollSubmenus(){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery("from RollSubmenu");
        List<RollSubmenu> rollSubmenus = query.list();
//        session.close();     
        return rollSubmenus;
    }
    
    public void eliminarRollSubmenu(RollSubmenu rollSubmenu){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.delete(rollSubmenu);
        transaction.commit();
        session.close();     
    }
    
    public void actualizarRollSubmenu(RollSubmenu rollSubmenu){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(rollSubmenu);
        transaction.commit();
        session.close();     
    }
    
    public RollSubmenu obtenerRollSubmenu(int id){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        RollSubmenu menu = (RollSubmenu)session.get(RollSubmenu.class,
                id);
        transaction.commit();
        session.close();
        return menu;
    }
    
    public List<RollSubmenu> obtenerRollSubmenusActivar(Integer [] ids){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Criteria criteria = session.createCriteria(RollSubmenu.class);
        criteria.add(Restrictions.in("rollSubmenuId",
                ids));
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        List lista = criteria.list();
        session.close();
        return lista;
    }
}
