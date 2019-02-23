/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios;


import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.entidades.Contact;
import retail.modelo.servicios.interfaces.ContactDAO;

/**
 *
 * @author anthony
 */
public class ContactImpl implements ContactDAO{

    @Override
    public void insertContact(Contact contact) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(contact);
        tx.commit();
        session.close();
    }

    @Override
    public void deleteContact(Contact contact) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(contact);
        tx.commit();
        session.close();
    }

    @Override
    public void updateContact(Contact contact) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(contact);
        tx.commit();
        session.close();
    }
    
    @Override
    public Contact getContactById(int contactId) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Contact contact = (Contact)session.get(Contact.class, contactId);
        session.close();
        return contact;
    }
    
    @Override
    public List<Contact> getContacts(String hql) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery(hql);
        List<Contact> contacts = query.list();
        return contacts;
    }
    
}
