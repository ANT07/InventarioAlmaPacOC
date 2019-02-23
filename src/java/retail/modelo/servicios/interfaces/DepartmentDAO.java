/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.util.List;
import retail.modelo.entidades.Department;

/**
 *
 * @author anthony
 */
public interface DepartmentDAO {
    public void insertDepartment(Department department) throws Exception;
    public void deleteDepartment(Department department) throws Exception;
    public void updateDepartment(Department department) throws Exception;
    public Department getDepartmentById(int departmentId) throws Exception;
    public List<Department> getDepartments() throws Exception;
}
