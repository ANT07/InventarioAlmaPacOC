/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;


import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.krysalis.barcode4j.impl.upcean.EAN13;
import org.krysalis.barcode4j.impl.upcean.EAN13Bean;

import org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider;


/**
 *
 * @author ANTHONY MARTINEZ
 */
public class BarraControlador extends HttpServlet {

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
        response.setContentType("image/jpg");
        DecimalFormat formatoNumero = new DecimalFormat("000000000000");
        String value = request.getParameter("value");
        value = formatoNumero.format(Double.valueOf(value));
        EAN13Bean codigoBarra = new EAN13Bean();
        codigoBarra.setHeight(15);
        codigoBarra.setModuleWidth(0.5);
        codigoBarra.setQuietZone(15);
        codigoBarra.doQuietZone(true);
        ByteArrayOutputStream salida = new ByteArrayOutputStream();
        BitmapCanvasProvider canvas = new BitmapCanvasProvider(salida, "image/x-png", 100, BufferedImage.TYPE_BYTE_BINARY, false);
        codigoBarra.generateBarcode(canvas, value );
        canvas.finish();
        
        ServletOutputStream salidaJsp = response.getOutputStream();
        salidaJsp.write(salida.toByteArray());
        salidaJsp.flush();
        salidaJsp.close();
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
