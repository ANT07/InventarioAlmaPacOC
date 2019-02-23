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
import retail.modelo.entidades.Roll;
import retail.modelo.entidades.Usuario;
import retail.modelo.servicios.UsuarioDAO;

/**
 *
 * @author anthony
 */
public class UsuarioServlet extends HttpServlet {

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
            out.println("<title>Servlet UsuarioServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println(
                    "<h1>Servlet UsuarioServlet at " + request.getContextPath() + "</h1>");
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
        try {
            String tipo = request.getParameter("tipo");
            String usuarioId = request.getParameter("usuario");
            String nombreUsuario = request.getParameter("nombreUsuario");
            String contrasena = request.getParameter("contrasena");
            int rollId = Integer.parseInt(request.getParameter("rollId"));

            switch (tipo) {
                case "guardar": {
                    Usuario usuario = new Usuario();
                    Roll roll = new Roll();
                    UsuarioDAO usuarioDAO = new UsuarioDAO();

                    roll.setRollId(rollId);
                    usuario.setUsuario(usuarioId);
                    usuario.setNombre(nombreUsuario);
                    usuario.setContrasena(contrasena);
                    usuario.setRoll(roll);

                    usuarioDAO.insertarUsuario(usuario);

                    request.getRequestDispatcher("/UserView.jsp").forward(
                            request,
                            response);
                    break;
                }
                case "editar": {

                    Roll roll = new Roll();
                    UsuarioDAO usuarioDAO = new UsuarioDAO();
                    Usuario usuario = usuarioDAO.obtenerUsuario(usuarioId);

                    usuario.getRoll().setRollId(rollId);
                    usuario.setUsuario(usuarioId);
                    usuario.setNombre(nombreUsuario);
                    usuario.setContrasena(contrasena);
                    //usuario.setRoll(roll);

                    usuarioDAO.actualizarUsuario(usuario);

                    request.getRequestDispatcher("/UserView.jsp").forward(
                            request,
                            response);
                    break;
                }
            }
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
