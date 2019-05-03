/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.conexion;


import java.io.File;
import listener.ContextListener;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * Hibernate Utility class with a convenient method to get Session Factory
 * object.
 *
 * @author anthony
 */
public class NewHibernateUtil {

    private static  SessionFactory sessionFactory;
    
    public NewHibernateUtil() {
        try {
            // Create the SessionFactory from standard (hibernate.cfg.xml) 
            // config file.
            String path = ContextListener.application.getRealPath("/WEB-INF/files/hibernate.cfg.xml");
            sessionFactory = new Configuration().configure(new File(path)).buildSessionFactory();
        } catch (Throwable ex) {
            // Log the exception. 
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }
    
    
    public static SessionFactory getSessionFactory() {
        if(sessionFactory == null){
             NewHibernateUtil utils = new NewHibernateUtil();
        }
        return sessionFactory;
    }
}
