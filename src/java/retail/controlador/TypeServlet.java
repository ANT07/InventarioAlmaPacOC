/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.entidades.OrderType;
import retail.modelo.servicios.OrderTypeImpl;

/**
 *
 * @author anthony
 */
public class TypeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,
            IOException {

        String tipo = request.getParameter("tipo");
        String typename = request.getParameter("typename");
        int typestate = request.getParameter("typestate") != null ? 1 : 0;

        RequestDispatcher requestDispatcher = request.getRequestDispatcher(
                "/ListaTipos.jsp");

        OrderType type = new OrderType();
        OrderTypeImpl typeImpl = new OrderTypeImpl();

        type.setTypename(typename);
        type.setTypestate(typestate);
        String mensaje = "";

        try {
            switch (tipo) {
                case "buscar": {
                    try {
                        int typeid = Integer.parseInt(request.getParameter(
                                "typeid"));
                        OrderType orderType = typeImpl.getOrderTypeById(typeid);
                        if (orderType != null) {
                            request.setAttribute("orderType",
                                    orderType);
                            request.getRequestDispatcher(
                                    "ActualizarTipoOrden.jsp").forward(request,
                                            response);
                        } else {
                            String Mensaje = "error no se encontraron datos ";
                            request.setAttribute("Mensaje",
                                    Mensaje);
                            request.getRequestDispatcher(
                                    "ActualizarTipoOrden.jsp").forward(request,
                                            response);
                        }
                    } catch (Exception ex) {
                        request.getRequestDispatcher("ActualizarTipoOrden.jsp").forward(
                                request,
                                response);
                    }
                    break;
                }
                case "insertar":
                    typeImpl.insertOrderType(type);
                    mensaje = "Tipo de orden insertado correctamente";
                    request.setAttribute("Mensaje", mensaje);
                    requestDispatcher.forward(request,
                            response);
                    break;
                case "actualizar":
                    int typeid = Integer.parseInt(request.getParameter("typeid"));
                    type.setTypeid(typeid);
                    typeImpl.updateOrderType(type);
                    mensaje = "Tipo de orden actualizado correctamente";
                    request.setAttribute("Mensaje", mensaje);
                    requestDispatcher.forward(request,
                            response);
                    break;
                case "eliminar":
                    try {
                        typeid = Integer.parseInt(request.getParameter("typeid"));
                        type.setTypeid(typeid);
                        mensaje = "Tipo de orden eliminado correctamente";
                        request.setAttribute("Mensaje", mensaje);
                        typeImpl.deleteOrderType(type);
                    } catch (Exception e) {
                            mensaje = "Error, no es posible eliminar a un tipo de orden que ha sido asociado a otros registros";
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
