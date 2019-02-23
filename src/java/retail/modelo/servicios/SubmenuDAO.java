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
import retail.modelo.entidades.SubMenu;

/**
 *
 * @author anthony
 */
public class SubmenuDAO {
    public void insertarSubMenu(SubMenu submenu){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.save(submenu);
        transaction.commit();
        session.close();     
    }
    
    public List<SubMenu> obtenerSubMenus(){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Query query = session.createQuery("from SubMenu");
        List<SubMenu> submenus = query.list();
        session.close();     
        return submenus;
    }
    
    public void eliminarSubMenu(SubMenu submenu){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.delete(submenu);
        transaction.commit();
        session.close();     
    }
    
    public void actualizarSubMenu(SubMenu submenu){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        session.update(submenu);
        transaction.commit();
        session.close();     
    }
    
    public SubMenu obtenerSubMenu(int id){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Transaction transaction = session.beginTransaction();
        SubMenu menu = (SubMenu)session.get(SubMenu.class,
                id);
        transaction.commit();
        session.close();
        return menu;
    }
    public List<SubMenu> obtenerSubmenuByMenu(int menu,int rollId){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Criteria criteria = session.createCriteria(SubMenu.class);
        criteria.createAlias("menu",
                "menu");
        criteria.add(Restrictions.eq("menu.menuId",
                menu));
        Criteria criteriaRollSubmenu = criteria.createCriteria("rollSubmenus");
        criteriaRollSubmenu.add(Restrictions.eq("estado",
                1));
                criteriaRollSubmenu.createAlias("roll",
                "roll");
        criteriaRollSubmenu.add(Restrictions.eq("roll.rollId",
                rollId));
        
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        List<SubMenu> subMenus = criteria.list();
        return subMenus;
    }
    
    public List<SubMenu> obtenerSubmenuByRoll(int rollId){
        Session session = NewHibernateUtil.getSessionFactory().openSession();
        Criteria criteria = session.createCriteria(SubMenu.class);
        criteria.createAlias("menu",
                "menu");
        Criteria criteriaRollSubmenu = criteria.createCriteria("rollSubmenus");
        criteriaRollSubmenu.add(Restrictions.eq("estado",
                1));
        criteriaRollSubmenu.createAlias("roll",
                "roll");
        criteriaRollSubmenu.add(Restrictions.eq("roll.rollId",
                rollId));
        
        criteria.setResultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY);
        List<SubMenu> subMenus = criteria.list();
        return subMenus;
    }
}
