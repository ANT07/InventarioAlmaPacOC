/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.entidades.Clientes;
import retail.modelo.servicios.ServiciosCliente;

/**
 *
 * @author William Vasquez
 */
public class ClientesControlador extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String menu = request.getParameter("Tipo");
            String Mensaje = "";
            ServiciosCliente cliente = new ServiciosCliente();

            Clientes client = new Clientes();
            switch (menu) {
                case "insertar": {
                    try {
                        String nombre = request.getParameter("txtNombre");
                        String apellido = request.getParameter("txtApellido");
                        String direccion = request.getParameter("txtDireccion");
                        String telefono = request.getParameter("txtTelefono");
                        String sexo = request.getParameter("sexoCliente");

                        client.setNombreCliente(nombre);
                        client.setApellidoCliente(apellido);
                        client.setDireccionCliente(direccion);
                        client.setTelefonoCliente(telefono);
                        client.setSexoCliente(sexo.charAt(0));

                        cliente.insertarClientes(client);
                        Mensaje = "Cliente ingresado satisfactoriamente";

                        request.setAttribute("Mensaje", Mensaje);

                        request.getRequestDispatcher("ListaClientes.jsp").forward(request, response);
                    } catch (Exception e) {
                        Mensaje = "Error " + e;
                        request.setAttribute("Mensaje", Mensaje);

                        request.getRequestDispatcher("InsertarClientes.jsp").forward(request, response);
                    }

                    break;
                }
                case "actualizar": {
                    int idCliente = Integer.parseInt(request.getParameter("txtId"));
                    String nombre = request.getParameter("txtNombre");
                    String apellido = request.getParameter("txtApellido");
                    String direccion = request.getParameter("txtDireccion");
                    String telefono = request.getParameter("txtTelefono");
                    String sexo = request.getParameter("sexoCliente");
                  try {  
                    client.setNombreCliente(nombre);
                    client.setApellidoCliente(apellido);
                    client.setDireccionCliente(direccion);
                    client.setTelefonoCliente(telefono);
                    client.setSexoCliente(sexo.charAt(0));
                    client.setIdCliente(idCliente);
                
                    cliente.actualizarClientes(client);
                    Mensaje="Cliente actualizado correctamente";
                    request.setAttribute("Mensaje", Mensaje);
                    request.getRequestDispatcher("ListaClientes.jsp").forward(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(ClientesControlador.class.getName()).log(Level.SEVERE, null, ex);
                    Mensaje="Error al actualizar "+ex;
                    request.setAttribute("Mensaje", Mensaje);
                    request.getRequestDispatcher("ActualizarCliente.jsp").forward(request, response);
                }                   
                    break;
                }
                case "buscar": {

                    int id = Integer.parseInt(request.getParameter("idCliente"));

                    try {
                        client = cliente.obtenerClientesById(id);
                        
                        request.setAttribute("client", client);
                        request.getRequestDispatcher("ActualizarCliente.jsp").forward(request, response);

                    } catch (Exception e) {
                        out.print("error " + e);
                    }

                    break;
                }
                case "eliminar": {
                    try {
                        int id = Integer.parseInt(request.getParameter("cod"));
                        client.setIdCliente(id);
                        cliente.eliminarClientes(client);
                        Mensaje = "Cliente eliminado correctamente";
                        request.setAttribute("Mensaje", Mensaje);
                        request.getRequestDispatcher("ListaClientes.jsp").forward(request, response);
                    } catch (Exception e) {
                        Mensaje = "No se pudo eliminar el cliente " + e;
                        request.getRequestDispatcher("ListaClientes.jsp").forward(request, response);
                    }

                    break;
                }
            }
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
