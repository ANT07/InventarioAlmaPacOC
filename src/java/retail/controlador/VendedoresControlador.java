/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import java.io.IOException;

import java.sql.ResultSet;

import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.servicios.ServiciosVendedor;
import retail.modelo.entidades.Vendedor;

/**
 *
 * @author David
 */
public class VendedoresControlador extends HttpServlet {

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
        String Seleccion = request.getParameter("Tipo");
        ServiciosVendedor sv = new ServiciosVendedor();
        Vendedor v = new Vendedor();
        String Mensaje;
        
        
        switch (Seleccion)
        {
            case "insertar":
                String nombre = request.getParameter("txtNombre");
                String apellido = request.getParameter("txtApellido");
                String direccion = request.getParameter("txtDireccion");
                char sexo = request.getParameter("sexoVendedor").charAt(0);
                String telefono = request.getParameter("txtTelefono");
                String dui = request.getParameter("txtDui");
                
                v.setNombreVendedor(nombre);
                v.setApellidoVendedor(apellido);
                v.setDireccionVendedor(direccion);
                v.setSexoVendedor(sexo);
                v.setTelefonoVendedor(telefono);
                v.setDuiVendedor(dui);
                
        {
                    try {
                        sv.insertarVendedor(v);
                        Mensaje ="Vendedor guardado correctamente";
                        request.setAttribute("Mensaje", Mensaje);
                        request.getRequestDispatcher("ListaVendedores.jsp").forward(request, response);
                        
                    } catch (Exception ex) {
                        Logger.getLogger(VendedoresControlador.class.getName()).log(Level.SEVERE, null, ex);
                        System.out.println("error" + ex);
                    }
                }
                
                break;
                
        case "eliminar":
        {
            int codigo = Integer.parseInt(request.getParameter("cod"));
            v.setIdVendedor(codigo);
            
            try {
                sv.eliminarVendedor(v);
                Mensaje ="Dato eliminado correctamente";
                        request.setAttribute("Mensaje", Mensaje);
                        request.getRequestDispatcher("ListaVendedores.jsp").forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(VendedoresControlador.class.getName()).log(Level.SEVERE, null, ex);
                Mensaje = "El vendedor no se puede eliminar porque ya ha sido asignado ";
                request.setAttribute("Mensaje", Mensaje);
                request.getRequestDispatcher("ListaVendedores.jsp").forward(request, response);
                
            }
             break;  
        }
        
        case "buscar":
        {
            try {
            int codigo = Integer.parseInt(request.getParameter("idVendedor"));

            
                
                v = sv.obtenerVendedorById(codigo);;
                if (v != null) {
                    request.setAttribute("v", v);
                    request.getRequestDispatcher("ActualizarVendedor.jsp").forward(request, response);
                }
                    else {
                        Mensaje = "error no se encontraron datos ";
                        request.setAttribute("Mensaje", Mensaje);
                        request.getRequestDispatcher("ActualizarVendedor.jsp").forward(request, response);
                    }

                } catch (Exception ex) {
                    Logger.getLogger(VendedoresControlador.class.getName()).log(Level.SEVERE, null, ex);
                    request.getRequestDispatcher("ActualizarVendedor.jsp").forward(request, response);
                }
            }
            case "actualizar": 
            {
                int id1 = Integer.parseInt(request.getParameter("txtId"));
                String nombre1 = request.getParameter("txtNombre");
                String apellido1 = request.getParameter("txtApellido");
                String telefono1 = request.getParameter("txtTelefono");
                String sexo1 = request.getParameter("sexoVendedor");
                String direccion1 = request.getParameter("txtDireccion");
                String dui1 = request.getParameter("txtDui");
                
                
                
            try {
                v.setIdVendedor(id1);
                v.setNombreVendedor(nombre1);
                v.setApellidoVendedor(apellido1);
                v.setTelefonoVendedor(telefono1);
                v.setSexoVendedor(sexo1.charAt(0));
                v.setDireccionVendedor(direccion1);
                v.setDuiVendedor(dui1);

                sv.actualizarVendedor(v);
                Mensaje = "Dato editado correctamente";
                request.setAttribute("Mensaje", Mensaje);
                request.getRequestDispatcher("ListaVendedores.jsp").forward(request, response);

            } catch (Exception ex) {
                Logger.getLogger(VendedoresControlador.class.getName()).log(Level.SEVERE, null, ex);
                            
                Mensaje = "Error al editar ";
                request.setAttribute("Mensaje", Mensaje);
                request.getRequestDispatcher("ListaVendedores.jsp").forward(request, response);
                
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
