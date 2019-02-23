/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;


import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.entidades.Menu;
import retail.modelo.servicios.MenuDAO;

/**
 *
 * @author anthony
 */
public class MenuServlet extends HttpServlet {

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
            out.println("<title>Servlet MenuServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println(
                    "<h1>Servlet MenuServlet at " + request.getContextPath() + "</h1>");
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
        try {
            String tipo = request.getParameter("tipo");
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            switch (tipo) {
                case "eliminar": {

                    MenuDAO menuDAO = new MenuDAO();
                    Menu menu = menuDAO.obtenerMenu(menuId);
                    menuDAO.eliminarMenu(menu);
                    break;
                }
            }
            request.getRequestDispatcher("/MenuView.jsp").forward(
                    request,
                    response);
        } catch (Exception e) {
            String mensaje = e.getMessage();
            e.printStackTrace();
            request.setAttribute("mensaje",
                    mensaje);
            request.getRequestDispatcher("/Errores.jsp").forward(request,
                    response);
        }

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

        try {
            String tipo = request.getParameter("tipo");
            String nombreMenu = request.getParameter("nombreMenu");
            int menuId = Integer.parseInt(request.getParameter("menuId"));
            switch (tipo) {
                case "guardar": {
                    Menu menu = new Menu();
                    MenuDAO menuDAO = new MenuDAO();
                    menu.setMenuName(nombreMenu);

                    menuDAO.insertarMenu(menu);
                    break;
                }

                case "editar": {

                    MenuDAO menuDAO = new MenuDAO();
                    Menu menu = menuDAO.obtenerMenu(menuId);
                    menu.setMenuName(nombreMenu);

                    menuDAO.actualizarMenu(menu);
                    break;
                }

            }

            request.getRequestDispatcher("/MenuView.jsp").forward(
                    request,
                    response);
        } catch (Exception e) {
            String mensaje = e.getMessage();
            e.printStackTrace();
            request.setAttribute("mensaje",
                    mensaje);
            request.getRequestDispatcher("/Errores.jsp").forward(request,
                    response);
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
