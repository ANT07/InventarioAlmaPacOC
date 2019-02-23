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
import retail.modelo.entidades.Menu;
import retail.modelo.entidades.Roll;
import retail.modelo.entidades.RollSubmenu;
import retail.modelo.entidades.SubMenu;
import retail.modelo.servicios.MenuDAO;
import retail.modelo.servicios.RollDAO;
import retail.modelo.servicios.RollSubmenuDAO;
import retail.modelo.servicios.SubmenuDAO;

/**
 *
 * @author anthony
 */
public class SubmenuServlet extends HttpServlet {

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
            out.println("<title>Servlet SubmenuServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println(
                    "<h1>Servlet SubmenuServlet at " + request.getContextPath() + "</h1>");
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
            int submenuId = Integer.parseInt(request.getParameter("submenuId"));
            switch (tipo) {
                case "eliminar": {

                    SubmenuDAO submenuDAO = new SubmenuDAO();
                    SubMenu subMenu = submenuDAO.obtenerSubMenu(submenuId);
                    submenuDAO.eliminarSubMenu(subMenu);
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
            RequestDispatcher salida = request.getRequestDispatcher("/MenuView.jsp");
            String tipo = request.getParameter("tipo");

            switch (tipo) {
                case "guardar": {
                    int menuId = Integer.parseInt(request.getParameter("menuId"));
                    String nombreSumenu = request.getParameter("nombreSumenu");
                    String url = request.getParameter("url");
                    
                    RollDAO rollDAO = new RollDAO();
                    MenuDAO menuDAO = new MenuDAO();
                    SubmenuDAO submenuDAO = new SubmenuDAO();
                    RollSubmenuDAO rollSubmenuDAO = new RollSubmenuDAO();
                    
                    List<Roll> rolles = rollDAO.obtenerRolls();
                    Menu menu = menuDAO.obtenerMenu(menuId);
                    SubMenu subMenu = new SubMenu();
                    
                    subMenu.setMenu(menu);
                    subMenu.setSubmenuName(nombreSumenu);
                    subMenu.setUrl(url);
                    
                    submenuDAO.insertarSubMenu(subMenu);
                    
                    for(Roll roll : rolles){
                        RollSubmenu rollSubmenu = new RollSubmenu();
                        rollSubmenu.setEstado(0);
                        rollSubmenu.setRoll(roll);
                        rollSubmenu.setSubMenu(subMenu);
                        rollSubmenuDAO.insertarRollSubmenu(rollSubmenu);
                    }
                    
                    break;
                }
                case "editar": {
                    int menuId = Integer.parseInt(request.getParameter("menuId"));
                    String nombreSumenu = request.getParameter("nombreSumenu");
                    int submenuId = Integer.parseInt(request.getParameter("SubMenuId"));
                    String url = request.getParameter("url");
                    
                    MenuDAO menuDAO = new MenuDAO();
                    SubmenuDAO submenuDAO = new SubmenuDAO();
                    
                    Menu menu = menuDAO.obtenerMenu(menuId);
                    SubMenu subMenu = new SubMenu();
                    
                    subMenu.setMenu(menu);
                    subMenu.setSubmenuName(nombreSumenu);
                    subMenu.setSummenuId(submenuId );
                    subMenu.setUrl(url);
                    
                    submenuDAO.actualizarSubMenu(subMenu);
                    break;
                }
            }
            
            salida.forward(request,
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
