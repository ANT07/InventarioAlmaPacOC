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
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.criterion.Restrictions;
import retail.modelo.conexion.NewHibernateUtil;
import retail.modelo.entidades.Department;
import retail.modelo.servicios.interfaces.DepartmentDAO;

/**
 *
 * @author anthony
 */
public class DepartmentImpl implements DepartmentDAO {

    @Override
    public void insertDepartment(Department department) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.save(department);
        tx.commit();
        session.close();
    }

    @Override
    public void deleteDepartment(Department department) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.delete(department);
        tx.commit();
        session.close();
    }

    @Override
    public void updateDepartment(Department department) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Transaction tx = session.beginTransaction();
        session.update(department);
        tx.commit();
        session.close();
    }

    @Override
    public Department getDepartmentById(int departmentId) throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Department department = (Department) session.get(Department.class, departmentId);
        session.close();
        return department;
    }

    @Override
    public List<Department> getDepartments() throws Exception {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Query query = session.createQuery("from Department");
        List<Department> departments = query.list();
        return departments;
    }

    public List<Department> getDepartmentsByInventario(int inventario) {
        SessionFactory sessionFactory = NewHibernateUtil.getSessionFactory();
        Session session = sessionFactory.openSession();
        Criteria criteriaDepartamento = session.createCriteria(Department.class);
        criteriaDepartamento.add(Restrictions.eq("inventario", inventario));
        List<Department> departments = criteriaDepartamento.list();
        return departments;
    }
}
