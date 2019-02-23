/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.util.List;
import retail.modelo.entidades.Contact;

/**
 *
 * @author anthony
 */
public interface ContactDAO {
        public void insertContact(Contact contact) throws Exception;
        public void deleteContact(Contact contact) throws Exception;
        public void updateContact(Contact contact) throws Exception;
        public Contact getContactById(int contactId) throws Exception;
        public List<Contact> getContacts(String hql) throws Exception;
}
