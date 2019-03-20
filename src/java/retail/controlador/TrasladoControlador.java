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
import retail.modelo.entidades.Clientes;
import retail.modelo.entidades.Department;
import retail.modelo.entidades.Existencia;
import retail.modelo.entidades.Producto;
import retail.modelo.entidades.Traslado;
import retail.modelo.servicios.ServiciosExistencia;
import retail.modelo.servicios.ServiciosTraslado;

/**
 *
 * @author William Vasquez
 */
public class TrasladoControlador extends HttpServlet {

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

            String tipo = request.getParameter("tipo");
            String Mensaje = "";
            ServiciosTraslado serviciosTraslado = new ServiciosTraslado();
            ServiciosExistencia serviciosExistencia = new ServiciosExistencia();

            Clientes client = new Clientes();
            switch (tipo) {
                case "insertar": {
                    try {
                        int departamentoOrigen = Integer.parseInt(request.getParameter("departamentoOrigen"));
                        int departamentoDestino = Integer.parseInt(request.getParameter("departamentoDestino"));
                        double cantidadTralado = Double.parseDouble(request.getParameter("cantidadTralado"));
                        int codigoProducto = Integer.parseInt(request.getParameter("productid"));

                        Traslado traslado = new Traslado();

                        Producto producto = new Producto();
                        producto.setCodigoProducto(codigoProducto);
                        Department bodegaOrigen = new Department();
                        bodegaOrigen.setDepartmentid(departamentoOrigen);
                        Department bodegaDestino = new Department();
                        bodegaDestino.setDepartmentid(departamentoDestino);

                        traslado.setDepartmentDestino(bodegaDestino);
                        traslado.setDepartmentoOrigen(bodegaOrigen);
                        traslado.setProducto(producto);
                        traslado.setCantidadTralado(cantidadTralado);

                        Existencia existenciaOrigen = serviciosExistencia.obtenerExistenciaByProductoByDepartamento(codigoProducto, departamentoOrigen);
                        Existencia existenciaDestino = serviciosExistencia.obtenerExistenciaByProductoByDepartamento(codigoProducto, departamentoDestino);
                        existenciaOrigen.setDisponible( existenciaOrigen.getDisponible() - cantidadTralado);
                        existenciaDestino.setDisponible(existenciaDestino.getDisponible() + cantidadTralado);

                        serviciosExistencia.actualizarExistencia(existenciaOrigen);
                        serviciosExistencia.actualizarExistencia(existenciaDestino);

                        serviciosTraslado.insertarTraslado(traslado);

                        Mensaje = "Traslado realizado correctamente";

                        request.setAttribute("Mensaje", Mensaje);

                        request.getRequestDispatcher("ExistenciaProducto.jsp").forward(request, response);
                    } catch (Exception e) {
                        Mensaje = "Error " + e;
                        request.setAttribute("Mensaje", Mensaje);
                        request.getRequestDispatcher("ExistenciaProducto.jsp").forward(request, response);
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
