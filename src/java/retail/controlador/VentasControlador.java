/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import java.io.IOException;
import java.util.List;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.entidades.Clientes;
import retail.modelo.entidades.Department;
import retail.modelo.entidades.Detalleventa;
import retail.modelo.entidades.Existencia;
import retail.modelo.entidades.Producto;
import retail.modelo.entidades.Vendedor;
import retail.modelo.entidades.Ventas;
import retail.modelo.servicios.ServiciosCliente;
import retail.modelo.servicios.ServiciosDetalleVenta;
import retail.modelo.servicios.ServiciosExistencia;
import retail.modelo.servicios.ServiciosProducto;
import retail.modelo.servicios.ServiciosVendedor;
import retail.modelo.servicios.ServiciosVenta;
import retail.util.UtilClass;

/**
 *
 * @author ANTHONY MARTINEZ
 */
public class VentasControlador extends HttpServlet {

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
        ServiciosVenta serviciosVenta = new ServiciosVenta();
        ServiciosDetalleVenta serviciosVentaDetalle = new ServiciosDetalleVenta();
        ServiciosProducto serviciosProductos = new ServiciosProducto();
        ServiciosExistencia serviciosExistencia = new ServiciosExistencia();
        String accion = request.getParameter("accion");
        RequestDispatcher salidaListaVentas = request.getRequestDispatcher(
                "ListaVentas.jsp");
        String Mensaje = "";
        Ventas venta = new Ventas();
        Vendedor vende = new Vendedor();
        Clientes client = new Clientes();

        ServiciosVendedor serviciosvendedor = new ServiciosVendedor();
        ServiciosCliente servicioscliente = new ServiciosCliente();

        switch (accion) {
            case "insertar": {

                try {

                    String fecha = request.getParameter("fechaVenta");
                    int idVendedor = Integer.parseInt(request.getParameter(
                            "idVendedor"));
                    int idCliente = Integer.parseInt(request.getParameter(
                            "idCliente"));
                    String[] codigosProductos = request.getParameterValues(
                            "codigoProducto");
                    String[] cantidadesDetalles = request.getParameterValues(
                            "cantidadDetalle");
                    String[] preciosDetalles = request.getParameterValues(
                            "precioDetalle");
                    String[] totalesDetalles = request.getParameterValues(
                            "totalDetalle");
                    double totalVenta = Double.parseDouble(request.getParameter(
                            "totalVenta"));

                    //Intertando Venta
                    Clientes cliente = new Clientes();
                    cliente.setIdCliente(idCliente);
                    venta.setClientes(cliente);
                    Vendedor vendedor = new Vendedor();
                    vendedor.setIdVendedor(idVendedor);
                    venta.setVendedor(vendedor);
                    venta.setFechaVenta(retail.util.UtilClass.formatFecha(fecha));
                    venta.setTotalVenta(totalVenta);
                    serviciosVenta.insertarVentas(venta);

                    //insertando detalle de la venta
                    for (int i = 0; i < codigosProductos.length; i++) {
                        Detalleventa detalleVenta = new Detalleventa();
                        detalleVenta.setCantidadDetalle(Integer.parseInt(
                                cantidadesDetalles[i]));
                        detalleVenta.setPrecioDetalle(Double.parseDouble(
                                preciosDetalles[i]));
                        detalleVenta.setTotalDetalle(Double.parseDouble(
                                totalesDetalles[i]));
                        Producto producto = new Producto();
                        producto.setCodigoProducto(Integer.parseInt(
                                codigosProductos[i]));
                        detalleVenta.setProducto(producto);
                        detalleVenta.setVentas(venta);
                        serviciosVentaDetalle.insertarDetalleventa(detalleVenta);
                    }
                    Mensaje = "Venta realizada correctamente";
                    request.setAttribute("Mensaje",
                            Mensaje);
                    //Redirigiendo a la lista
                    salidaListaVentas.forward(request,
                            response);

                } catch (Exception e) {

                    Mensaje = "Error al realizar la venta " + e;
                    request.setAttribute("Mensaje",
                            Mensaje);
                    e.printStackTrace();
                }

                break;
            }
            case "efectuar": {
                try {
                    int idVenta = Integer.parseInt(request.getParameter(
                            "idVenta"));
                    List<Detalleventa> ventadetalles = serviciosVentaDetalle.obtenerDetalleventasByIdVenta(
                            idVenta);
                    Ventas ventaEfectuar = serviciosVenta.obtenerVentasById(
                            idVenta);
                    ventaEfectuar.setEstado(1);
                    for (Detalleventa ventadetalle : ventadetalles) {
                        Producto producto = ventadetalle.getProducto();
                        Existencia existencia = serviciosExistencia.obtenerExistenciaByProductoByDepartamento(producto.getCodigoProducto(), 3);
                        existencia.setDisponible(existencia.getDisponible() + ventadetalle.getCantidadDetalle());
                        serviciosExistencia.actualizarExistencia(existencia);
                    }

                    serviciosVenta.actualizarVentas(ventaEfectuar);
                    Mensaje = "La venta se efectuó de manera correcta";
                    request.setAttribute("Mensaje",
                            Mensaje);
                    salidaListaVentas.forward(request,
                            response);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            }
            case "actualizar": {
                try {
                    int idVenta = Integer.parseInt(request.getParameter(
                            "idVenta"));
                    venta = serviciosVenta.obtenerVentasById(idVenta);
                    String fecha = request.getParameter("fechaVenta");
                    int idVendedor = Integer.parseInt(request.getParameter(
                            "idVendedor"));
                    int idCliente = Integer.parseInt(request.getParameter(
                            "idCliente"));
                    String[] codigosProductos = request.getParameterValues(
                            "codigoProducto");
                    String[] cantidadesDetalles = request.getParameterValues(
                            "cantidadDetalle");
                    String[] preciosDetalles = request.getParameterValues(
                            "precioDetalle");
                    String[] totalesDetalles = request.getParameterValues(
                            "totalDetalle");
                    double totalVenta = Double.parseDouble(request.getParameter(
                            "totalVenta"));

                    //Intertando Venta
                    Clientes cliente = new Clientes();
                    cliente.setIdCliente(idCliente);
                    venta.setClientes(cliente);
                    Vendedor vendedor = new Vendedor();
                    vendedor.setIdVendedor(idVendedor);
                    venta.setVendedor(vendedor);
                    venta.setFechaVenta(retail.util.UtilClass.formatFecha(fecha));
                    venta.setTotalVenta(totalVenta);
                    serviciosVenta.actualizarVentas(venta);

                    //obteniendo viejos detalles de la venta
                    List<Detalleventa> detalleVentasViejos = serviciosVentaDetalle.obtenerDetalleventasByIdVenta(
                            idVenta);

                    //eliminando Viejos detalles
                    for (Detalleventa detalleVentasViejo : detalleVentasViejos) {
                        serviciosVentaDetalle.eliminarDetalleventa(
                                detalleVentasViejo);
                    }
                    //insertando nuevos detalles de la venta
                    for (int i = 0; i < codigosProductos.length; i++) {
                        Detalleventa detalleVenta = new Detalleventa();
                        detalleVenta.setCantidadDetalle(Integer.parseInt(
                                cantidadesDetalles[i]));
                        detalleVenta.setPrecioDetalle(Double.parseDouble(
                                preciosDetalles[i]));
                        detalleVenta.setTotalDetalle(Double.parseDouble(
                                totalesDetalles[i]));
                        Producto producto = new Producto();
                        producto.setCodigoProducto(Integer.parseInt(
                                codigosProductos[i]));
                        detalleVenta.setProducto(producto);
                        detalleVenta.setVentas(venta);
                        serviciosVentaDetalle.insertarDetalleventa(detalleVenta);
                    }
                    //Redirigiendo a la lista
                    Mensaje = "La venta fue actualizada de manera correcta";
                    request.setAttribute("Mensaje",
                            Mensaje);
                    salidaListaVentas.forward(request,
                            response);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                break;
            }
            case "anular": {
//                try {
//                    int idVenta = Integer.parseInt(request.getParameter(
//                            "idVenta"));
//                    List<Detalleventa> ventadetalles = serviciosVentaDetalle.obtenerDetalleventasByIdVenta(
//                            idVenta);
//                    Ventas ventaEfectuar = serviciosVenta.obtenerVentasById(
//                            idVenta);
//                    ventaEfectuar.setEstado(0);
//                    for (Detalleventa ventadetalle : ventadetalles) {
//                        Producto producto = serviciosProductos.obtenerProductoById(
//                                ventadetalle.getProducto().getCodigoProducto());
//                        producto.setExistenciaProducto(
//                                producto.getExistenciaProducto() + ventadetalle.getCantidadDetalle());
//                        serviciosProductos.actualizarProducto(producto);
//                    }
//
//                    serviciosVenta.actualizarVentas(ventaEfectuar);
//                    Mensaje = "La venta se anuló de manera correcta";
//                    request.setAttribute("Mensaje",
//                            Mensaje);
//                    salidaListaVentas.forward(request,
//                            response);
//                } catch (Exception ex) {
//                    ex.printStackTrace();
//                }
                break;
            }
            case "nombreProducto": {
                try {
                    response.setContentType("text/html");
                    int codigoProducto = Integer.parseInt(request.getParameter(
                            "idProducto"));
                    Producto producto = serviciosProductos.obtenerProductoById(
                            codigoProducto);
                    Existencia existencia = serviciosExistencia.obtenerExistenciaByProductoByDepartamento(producto.getCodigoProducto(), 3);
                    if (producto.getNombreProducto() != null) {
                        response.getWriter().write(
                                producto.getNombreProducto() + "," + existencia.getDisponible()+ "," + producto.getPrecioProducto());
                    } else {
                        response.getWriter().write("Error de Producto");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write("Error de Producto");
                }
                break;
            }
            case "existencia": {
//                try {
//                    response.setContentType("text/html");
//                    int codigoProducto = Integer.parseInt(request.getParameter(
//                            "codigoProducto"));
//                    Producto producto = serviciosProductos.obtenerProductoById(
//                            codigoProducto);
//                    if (producto.getNombreProducto() != null) {
//                        response.getWriter().write(
//                                producto.getExistenciaProducto());
//                    } else {
//                        response.getWriter().write("0");
//                    }
//
//                } catch (Exception e) {
//                    e.printStackTrace();
//                    response.getWriter().write("0");
//                }
                break;
            }
            case "buscarVentasqr": {

                int id = Integer.parseInt(request.getParameter("idVenta"));

                try {
                    Ventas ventas = serviciosVenta.obtenerVentasById(id);
                    request.setAttribute("ventasQR",
                            ventas);
                    request.setAttribute("clientes",
                            ventas.getClientes());
                    request.getRequestDispatcher("ListaVentas.jsp").forward(
                            request,
                            response);

                } catch (Exception e) {
                    Mensaje = "error " + e;
                    request.setAttribute("Mensaje",
                            Mensaje);
                    request.getRequestDispatcher("ListaVentas.jsp").forward(
                            request,
                            response);
                }
                break;
            }
            case "ventasVendedor": {
                int id = Integer.parseInt(request.getParameter("vendedorVenta"));
                try {
                    List<Ventas> ventas = serviciosVenta.obtenerVentasByVendedor(
                            id);
                    request.setAttribute("serviciosventas",
                            serviciosVenta);
                    request.setAttribute("vendedores",
                            ventas);

                    vende = serviciosvendedor.obtenerVendedorById(id);

                    request.setAttribute("vende",
                            vende);

                    request.getRequestDispatcher("ListaVentasVendedor.jsp").forward(
                            request,
                            response);

                } catch (Exception ex) {
                    Logger.getLogger(VentasControlador.class.getName()).log(
                            Level.SEVERE,
                            null,
                            ex);
                }
                break;
            }
            case "ventasCliente": {
                int id = Integer.parseInt(request.getParameter("clienteVenta"));
                try {

                    List<Ventas> clientes = serviciosVenta.obtenerVentasByCliente(
                            id);
                    request.setAttribute("serviciosventas",
                            serviciosVenta);
                    request.setAttribute("clientes",
                            clientes);

                    client = servicioscliente.obtenerClientesById(id);
                    request.setAttribute("cliente",
                            client);

                    request.getRequestDispatcher("ListaVentasCliente.jsp").forward(
                            request,
                            response);

                } catch (Exception ex) {
                    Logger.getLogger(VentasControlador.class.getName()).log(
                            Level.SEVERE,
                            null,
                            ex);
                }
                break;

            }

            case "ventasPorDia": {

                String fechaString = request.getParameter("fechaVenta");
                try {
                    //serviciosVenta.obtenerVentasPorFecha(fecha);
                    Date fecha = UtilClass.formatFecha(fechaString);
                    List<Ventas> ventas = serviciosVenta.obtenerVentasByFecha(fecha);
                    //request.setAttribute("serviciosventas", serviciosVenta);
                    request.setAttribute("fecha",
                            fechaString);
                    request.setAttribute("fechas",
                            ventas);
                    request.getRequestDispatcher("ListaVentaPorDia.jsp").forward(
                            request,
                            response);
                } catch (Exception ex) {
                    Logger.getLogger(VentasControlador.class.getName()).log(
                            Level.SEVERE,
                            null,
                            ex);
                }
                break;
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
