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
import retail.modelo.entidades.Menu;
import retail.modelo.conexion.NewHibernateUtil;

/**
 *
 * @author anthony
 */
public class MenuDAO {
    public void insertarMenu(Menu menu){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.save(menu);
        transaction.commit();
        session.close();     
    }
    
    public List<Menu> obtenerMenus(){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery("from Menu m \n" +
"left join fetch m.subMenus \n" +
"order by m.menuId ");
        query.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        List<Menu> menus = query.list();
        session.close();     
        return menus;
    }
    
    public void eliminarMenu(Menu menu){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.delete(menu);
        transaction.commit();
        session.close();     
    }
    
    public void actualizarMenu(Menu menu){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(menu);
        transaction.commit();
        session.close();     
    }
    
    public Menu obtenerMenu(int id){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        Menu menu = (Menu)session.get(Menu.class,
                id);
        transaction.commit();
        session.close();
        return menu;
    }
    
    public List<Menu> obtenerMenuByRoll(int roll){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Criteria criteria = session.createCriteria(Menu.class);
        Criteria criteriaSubmenu = criteria.createCriteria("subMenus");
        Criteria criteriaRollSubmenu = criteriaSubmenu.createCriteria(
                "rollSubmenus");
        criteriaRollSubmenu.createAlias("roll",
                "roll");
        criteriaRollSubmenu.add(Restrictions.eq("estado",
        1));
        criteriaRollSubmenu.add(Restrictions.eq("roll.rollId",
                roll));

        
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        List<Menu> menus = criteria.list();
        return menus;
    }
}
