/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.entidades.Department;
import retail.modelo.servicios.DepartmentImpl;
import retail.modelo.servicios.interfaces.DepartmentDAO;

/**
 *
 * @author anthony
 */
public class DepartmentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Inject
    DepartmentDAO departmentImpl;

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,
            IOException {

        String tipo = request.getParameter("tipo");
        String departmentname = request.getParameter("departmentname");
        int departmentstate = request.getParameter("departmentstate") != null ? 1 : 0;

        RequestDispatcher requestDispatcher = request.getRequestDispatcher(
                "/ListaDepartamentos.jsp");

        Department department = new Department();

        department.setDepartmentname(departmentname);
        department.setDepartemetstate(departmentstate);

        String mensaje = "";
        try {
            switch (tipo) {
                case "buscar": {
                    try {
                        int departmentid = Integer.parseInt(
                                request.getParameter("departmentid"));
                        department = departmentImpl.getDepartmentById(
                                departmentid);
                        if (department != null) {
                            request.setAttribute("department",
                                    department);
                            request.getRequestDispatcher(
                                    "ActualizarDepartamento.jsp").forward(
                                            request,
                                            response);
                        } else {
                            String Mensaje = "error no se encontraron datos ";
                            request.setAttribute("Mensaje",
                                    Mensaje);
                            request.getRequestDispatcher(
                                    "ActualizarDepartamento.jsp").forward(
                                            request,
                                            response);
                        }
                    } catch (Exception ex) {
                        request.getRequestDispatcher(
                                "ActualizarDepartamento.jsp").forward(
                                        request,
                                        response);
                    }
                    break;
                }
                case "insertar":
                    int isInventario = Integer.parseInt(request.getParameter("inventario"));
                    department.setInventario(isInventario);
                    departmentImpl.insertDepartment(department);
                    mensaje = "Departamento insertado correctamente";
                    request.setAttribute("Mensaje", mensaje);
                    requestDispatcher.forward(request,
                            response);
                    break;
                case "actualizar":
                    int departmentid = Integer.parseInt(request.getParameter(
                            "departmentid"));
                    department.setDepartmentid(departmentid);
                    departmentImpl.updateDepartment(department);
                    mensaje = "Departamento actualizado correctamente";
                    request.setAttribute("Mensaje", mensaje);
                    requestDispatcher.forward(request,
                            response);
                    break;
                case "eliminar":
                    try {
                        departmentid = Integer.parseInt(request.getParameter(
                                "departmentid"));
                        department = departmentImpl.getDepartmentById(
                                departmentid);
                        departmentImpl.deleteDepartment(department);
                        mensaje = "Departamento eliminado correctamente";
                        request.setAttribute("Mensaje", mensaje);
                    } catch (Exception e) {
                        mensaje = "Error, no es posible eliminar a un departamento que ha sido asociado a otros registros";
                        request.setAttribute("Mensaje", mensaje);
                    }

                    requestDispatcher.forward(request,
                            response);
                    break;
                default:
                    throw new Exception("Error de operacion" + this.getClass());
            }

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,
            IOException {
        processRequest(request,
                response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,
            IOException {
        processRequest(request,
                response);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
