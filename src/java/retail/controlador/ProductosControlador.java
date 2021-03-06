/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.entidades.Department;
import retail.modelo.entidades.Existencia;
import retail.modelo.entidades.Producto;
import retail.modelo.servicios.DepartmentImpl;
import retail.modelo.servicios.ServiciosExistencia;
import retail.modelo.servicios.ServiciosProducto;

/**
 *
 * @author William Vasquez
 */
public class ProductosControlador extends HttpServlet {

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
            ServiciosProducto serviciosProducto = new ServiciosProducto();
            ServiciosExistencia serviciosExistencia = new ServiciosExistencia();
            DepartmentImpl serviciosDepartamento = new DepartmentImpl();

            Producto Produc = new Producto();
            switch (menu) {
                case "insertar": {
                    try {
                        String nombre = request.getParameter("txtNombre");
                        String descripcion = request.getParameter("txtDescripcion");
                        double precio = Double.parseDouble(request.getParameter("txtPrecio"));
                        List<Department> departamentos = serviciosDepartamento.getDepartmentsByInventario(1);
                        for (Department departamento : departamentos) {
                            Existencia existencia = new Existencia();
                            existencia.setDepartamento(departamento);
                            existencia.setProducto(Produc);
                            existencia.setDisponible(0);
                            Produc.getExistencias().add(existencia);
                        }
                        Produc.setNombreProducto(nombre);
                        Produc.setDescripcionProducto(descripcion);
                        Produc.setPrecioProducto(precio);

                        serviciosProducto.insertarProducto(Produc);
                        Mensaje = "Producto ingresado satisfactoriamente";

                        request.setAttribute("Mensaje", Mensaje);

                        request.getRequestDispatcher("ListaProductos.jsp").forward(request, response);
                    } catch (Exception e) {
                        Mensaje = "Error " + e;
                        request.setAttribute("Mensaje", Mensaje);

                        request.getRequestDispatcher("InsertarProductos.jsp").forward(request, response);
                    }

                    break;
                }
                case "actualizar": {
                    int codigoProducto = Integer.parseInt(request.getParameter("txtCodigo"));
                    String nombre = request.getParameter("txtNombre");
                    String descripcion = request.getParameter("txtDescripcion");
                    double precio = Double.parseDouble(request.getParameter("txtPrecio"));

                    try {
                        Produc.setNombreProducto(nombre);
                        Produc.setDescripcionProducto(descripcion);
                        Produc.setPrecioProducto(precio);

                        Produc.setCodigoProducto(codigoProducto);
                        serviciosProducto.actualizarProducto(Produc);
                        Mensaje = "Producto actualizado correctamente";
                        request.setAttribute("Mensaje", Mensaje);
                        request.getRequestDispatcher("ListaProductos.jsp").forward(request, response);
                    } catch (Exception ex) {
                        Logger.getLogger(ProductosControlador.class.getName()).log(Level.SEVERE, null, ex);
                        Mensaje = "Error al actualizar " + ex;
                        request.setAttribute("Mensaje", Mensaje);
                        request.getRequestDispatcher("ActualizarProducto.jsp").forward(request, response);
                    }
                    break;
                }
                case "buscar": {

                    int cod = Integer.parseInt(request.getParameter("codigoProducto"));

                    try {
                        Produc = serviciosProducto.obtenerProductoById(cod);

                        request.setAttribute("Produc", Produc);
                        request.getRequestDispatcher("ActualizarProducto.jsp").forward(request, response);

                    } catch (Exception e) {
                        out.print("error " + e);
                    }

                    break;
                }
                case "eliminar": {
                    try {
                        int cod = Integer.parseInt(request.getParameter("cod"));
                        Produc.setCodigoProducto(cod);
                        serviciosProducto.eliminarProducto(Produc);
                        Mensaje = "Producto eliminado correctamente";
                        request.setAttribute("Mensaje", Mensaje);
                        request.getRequestDispatcher("ListaProductos.jsp").forward(request, response);
                    } catch (Exception e) {
                        Mensaje = "Error, no es posible eliminar a un producto que ha sido asociado a otros registros";
                        request.setAttribute("Mensaje", Mensaje);
                        request.getRequestDispatcher("ListaProductos.jsp").forward(request, response);
                    }

                    break;
                }
                case "existenciaBodega": {
                    int idBodega = Integer.parseInt(request.getParameter("idDestino"));
                    int codigoProducto = Integer.parseInt(request.getParameter("codigoProducto"));
                    Existencia existenciaReal = serviciosProducto.getExistenciaByCodigo(codigoProducto, idBodega);
                    response.getWriter().print(existenciaReal.getDisponible());
                    break;
                }
                case "nombreProducto": {
                    try {
                        int codigoProducto = Integer.parseInt(request.getParameter("codigoProducto"));
                        Producto producto = serviciosProducto.obtenerProductoById(codigoProducto);
                        String nombreProducto = "Error de codigo";
                        if (producto != null) {
                            nombreProducto = producto.getNombreProducto();
                        }
                        response.getWriter().print(nombreProducto);
                    } catch (Exception e) {
                        e.printStackTrace();
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
