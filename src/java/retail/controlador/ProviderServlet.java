/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.entidades.Contact;
import retail.modelo.entidades.Provider;
import retail.modelo.servicios.ContactImpl;
import retail.modelo.servicios.ProviderImpl;

/**
 *
 * @author anthony
 */
public class ProviderServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Provider</title>");
            out.println("</head>");
            out.println("<body>");
            out.println(
                    "<h1>Servlet Provider at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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

        String tipo = request.getParameter("tipo");
        String providername = request.getParameter("providername");
        String contactname = request.getParameter("contactname");
        String contactPhone = request.getParameter("contactPhone");
        int providerstate = request.getParameter("providerstate") != null ? 1 : 0;

        RequestDispatcher requestDispatcher = request.getRequestDispatcher(
                "/ListaProveedores.jsp");

        Provider provider = new Provider();
        ProviderImpl providerImpl = new ProviderImpl();

        provider.setProvidername(providername);
        provider.setProviderstate(providerstate);

        try {
            switch (tipo) {
                case "buscar": {
                    try {
                        int typeid = Integer.parseInt(request.getParameter(
                                "providerid"));
                        provider = providerImpl.getProviderById(typeid);
                        if (provider != null) {
                            request.setAttribute("provider",
                                    provider);
                            request.getRequestDispatcher(
                                    "ActualizarProveedor.jsp").forward(request,
                                            response);
                        } else {
                            String Mensaje = "error no se encontraron datos ";
                            request.setAttribute("Mensaje",
                                    Mensaje);
                            request.getRequestDispatcher(
                                    "ActualizarProveedor.jsp").forward(request,
                                            response);
                        }
                    } catch (Exception ex) {
                        request.getRequestDispatcher("ActualizarProveedor.jsp").forward(
                                request,
                                response);
                    }
                    break;
                }
                case "insertar":

                    Contact contact = new Contact();
                    contact.setContactname(contactname);
                    contact.setPhone(contactPhone);
                    contact.setContactstate(1);
                    provider.setContact(contact);

                    providerImpl.insertProvider(provider);

                    requestDispatcher.forward(request,
                            response);
                    break;
                case "editar":
                    int providerid = Integer.parseInt(request.getParameter(
                            "providerid"));
                    provider = providerImpl.getProviderById(providerid);
                    provider.setProvidername(providername);
                    provider.getContact().setContactname(contactname);
                    provider.getContact().setPhone(contactPhone);
                    providerImpl.updateProvider(provider);

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
