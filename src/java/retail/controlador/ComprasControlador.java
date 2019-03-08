/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.entidades.Clientes;
import retail.modelo.entidades.Compra;
import retail.modelo.entidades.Detalleventa;
import retail.modelo.entidades.Detallecompra;
import retail.modelo.entidades.Producto;
import retail.modelo.entidades.Provider;
import retail.modelo.entidades.Ventas;
import retail.modelo.servicios.ServiciosCompra;
import retail.modelo.servicios.ServiciosDetalleCompra;
import retail.modelo.servicios.ServiciosDetalleVenta;
import retail.modelo.servicios.ServiciosProducto;
import retail.modelo.servicios.ServiciosVenta;
import retail.util.UtilClass;

/**
 *
 * @author Andres
 */
public class ComprasControlador extends HttpServlet {

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
        ServiciosCompra serviciosCompra = new ServiciosCompra();

        ServiciosDetalleVenta serviciosVentaDetalle = new ServiciosDetalleVenta();
        ServiciosDetalleCompra serviciosCompraDetalle = new ServiciosDetalleCompra();

        ServiciosProducto serviciosProductos = new ServiciosProducto();

        String accion = request.getParameter("accion");

        RequestDispatcher salidaListaCompra = request.getRequestDispatcher(
                "ListaCompras.jsp");

        String Mensaje = "";

        Ventas venta = new Ventas();
        Compra compra = new Compra();

        switch (accion) {
            case "insertar": {

                try {

                    String fecha = request.getParameter("fechaCompra");
                    String fechaDocumento = request.getParameter("fechaDocumento");
                    String noDocumento = request.getParameter("noDocumento");
                    int proveedorId = Integer.parseInt(request.getParameter("providerid"));

                    String[] codigosProductos = request.getParameterValues(
                            "codigoProducto");

                    String[] cantidadesDetalles = request.getParameterValues(
                            "cantidadDetalle");

                    String[] preciosDetalles = request.getParameterValues(
                            "precioDetalle");

                    String[] totalesDetalles = request.getParameterValues(
                            "totalDetalle");

                    double totalCompra = Double.parseDouble(
                            request.getParameter("totalCompra"));

                    //Intertando Compra
                    compra.setFechaCompra(retail.util.UtilClass.formatFecha(
                            fecha));
                    compra.setFechaDocumento(retail.util.UtilClass.formatFecha2(
                            fechaDocumento));
                    compra.setNoDocumento(noDocumento);
                    Provider proveedor = new Provider();
                    proveedor.setProviderid(proveedorId);
                    compra.setProveedor(proveedor);
                    compra.setTotalCompra(totalCompra);

                    //insertando detalle de la venta
                    for (int i = 0; i < codigosProductos.length; i++) {

                        Detallecompra detalleCompra = new Detallecompra();

                        detalleCompra.setCantidadDetalle(Integer.parseInt(
                                cantidadesDetalles[i]));
                        detalleCompra.setPrecioDetalle(Double.parseDouble(
                                preciosDetalles[i]));
                        detalleCompra.setTotalDetalle(Double.parseDouble(
                                totalesDetalles[i]));
                        Producto producto = new Producto();
                        producto.setCodigoProducto(Integer.parseInt(
                                codigosProductos[i]));
                        detalleCompra.setProducto(producto);
                        detalleCompra.setCompra(compra);
                        compra.getDetallecompras().add(detalleCompra);

                    }

                    serviciosCompra.insertarCompra(compra);
                    Mensaje = "Compra realizada correctamente";
                    request.setAttribute("Mensaje",
                            Mensaje);
                    //Redirigiendo a la lista
                    salidaListaCompra.forward(request,
                            response);

                } catch (Exception e) {

                    Mensaje = "Error al realizar la compra " + e;
                    request.setAttribute("Mensaje",
                            Mensaje);
                    e.printStackTrace();
                }

                break;
            }
            case "efectuar": {
                try {

                    int idCompra = Integer.parseInt(request.getParameter(
                            "idCompra"));
                    List<Detallecompra> compradetalles = serviciosCompraDetalle.obtenerDetallecomprasByCompra(
                            idCompra);
                    Compra compraEfectuar = serviciosCompra.obtenerCompraById(
                            idCompra);
                    compraEfectuar.setEstado(1);
                    compraEfectuar.setFechaInventario(UtilClass.formatFecha(UtilClass.getFechaServidor()));

                    for (Detallecompra compradetalle : compradetalles) {
                        Producto producto = compradetalle.getProducto();
                        producto.setExistenciaProducto(
                                producto.getExistenciaProducto() + compradetalle.getCantidadDetalle());
                        serviciosProductos.actualizarProducto(producto);
                    }

                    serviciosCompra.actualizarCompra(compraEfectuar);

                    Mensaje = "La compra se efectuó de manera correcta";
                    request.setAttribute("Mensaje",
                            Mensaje);

                    salidaListaCompra.forward(request,
                            response);

                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;

            }
            case "actualizar": {
                try {
                    int idCompra = Integer.parseInt(request.getParameter(
                            "idCompra"));
                    compra = serviciosCompra.obtenerCompraById(idCompra);
                    String fechaDocumento = request.getParameter("fechaDocumento");
                    String noDocumento = request.getParameter("noDocumento");
                    int proveedorId = Integer.parseInt(request.getParameter("providerid"));

                    String[] codigosProductos = request.getParameterValues(
                            "codigoProducto");
                    String[] cantidadesDetalles = request.getParameterValues(
                            "cantidadDetalle");
                    String[] preciosDetalles = request.getParameterValues(
                            "precioDetalle");
                    String[] totalesDetalles = request.getParameterValues(
                            "totalDetalle");
                    double totalCompra = Double.parseDouble(
                            request.getParameter("totalCompra"));

                    //Intertando Venta
                    compra.setFechaDocumento(retail.util.UtilClass.formatFecha(
                            fechaDocumento));
                    Provider proveedor = new Provider();
                    proveedor.setProviderid(proveedorId);
                    compra.setProveedor(proveedor);
                    compra.setTotalCompra(totalCompra);
                    compra.setNoDocumento(noDocumento);
                    //obteniendo viejos detalles de la venta
                    List<Detallecompra> detalleCompraViejos = serviciosCompraDetalle.obtenerDetallecomprasByCompra(
                            idCompra);

                    //eliminando Viejos detalles
                    for (Detallecompra detalleCompraViejo : detalleCompraViejos) {

                        serviciosCompraDetalle.eliminarDetallecompra(
                                detalleCompraViejo);
                    }
                    //insertando nuevos detalles de la venta
                     HashSet<Detallecompra> detalleCompraNuevos = new HashSet<>();
                    for (int i = 0; i < codigosProductos.length; i++) {

                        Detallecompra detalleCompra = new Detallecompra();

                        detalleCompra.setCantidadDetalle(Integer.parseInt(
                                cantidadesDetalles[i]));
                        detalleCompra.setPrecioDetalle(Double.parseDouble(
                                preciosDetalles[i]));
                        detalleCompra.setTotalDetalle(Double.parseDouble(
                                totalesDetalles[i]));
                        Producto producto = new Producto();
                        producto.setCodigoProducto(Integer.parseInt(
                                codigosProductos[i]));
                        detalleCompra.setProducto(producto);
                        detalleCompra.setCompra(compra);
                        detalleCompraNuevos.add(detalleCompra);
                    }
                    compra.setDetallecompras(detalleCompraNuevos);
                    serviciosCompra.actualizarCompra(compra);
                    //Redirigiendo a la lista
                    Mensaje = "La Compra fue actualizada de manera correcta";
                    request.setAttribute("Mensaje",
                            Mensaje);
                    salidaListaCompra.forward(request,
                            response);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                break;
            }
            case "anular": {
                try {

                    int idCompra = Integer.parseInt(request.getParameter(
                            "idCompra"));

                    List<Detallecompra> compradetalles = serviciosCompraDetalle.obtenerDetallecomprasByCompra(
                            idCompra);
                    Compra compraEfectuar = serviciosCompra.obtenerCompraById(
                            idCompra);
                    compraEfectuar.setEstado(0);

                    for (Detallecompra compradetalle : compradetalles) {
                        Producto producto = compradetalle.getProducto();
                        producto.setExistenciaProducto(
                                producto.getExistenciaProducto() - compradetalle.getCantidadDetalle());
                        serviciosProductos.actualizarProducto(producto);
                    }

                    serviciosCompra.actualizarCompra(compraEfectuar);
                    Mensaje = "La Compra se anuló de manera correcta";
                    request.setAttribute("Mensaje",
                            Mensaje);
                    salidaListaCompra.forward(request,
                            response);
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            }
            case "nombreProducto": {
                try {
                    response.setContentType("text/html");
                    int codigoProducto = Integer.parseInt(request.getParameter(
                            "idProducto"));
                    Producto producto = serviciosProductos.obtenerProductoById(
                            codigoProducto);
                    if (producto.getNombreProducto() == null) {
                        response.getWriter().write("Error de Producto");
                    } else {
                        response.getWriter().write(
                                producto.getNombreProducto() + "," + producto.getExistenciaProducto() + "," + producto.getPrecioProducto());
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    response.getWriter().write("Error de Producto");
                }
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
