/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import com.barcodelib.barcode.QRCode;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.entidades.Clientes;
import retail.modelo.entidades.Ventas;
import retail.modelo.servicios.ServiciosVenta;

/**
 *
 * @author William Vasquez
 */
public class QRControlador extends HttpServlet {

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
        String menu = request.getParameter("accion");
        String Mensaje = "";
        ServiciosVenta serVentas = new ServiciosVenta();
        
        
        try {
            response.setContentType("text/html;charset=UTF-8");
            response.setContentType("image/gif");

            String value = request.getParameter("value");
            QRCode codigoQR = new QRCode();
            codigoQR.setData(value);
            codigoQR.setModuleSize(5f);
            codigoQR.setResolution(72);
            ByteArrayOutputStream salida = new ByteArrayOutputStream();
            codigoQR.renderBarcode(salida);

            ServletOutputStream salidaJsp = response.getOutputStream();
            salidaJsp.write(salida.toByteArray());
            salidaJsp.flush();
            salidaJsp.close();
            request.getRequestDispatcher("ListaVentas.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(QRControlador.class.getName()).log(Level.SEVERE, null, ex);
            Mensaje = "error qr " + ex;
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
