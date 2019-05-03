/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author anthony
 */
@WebServlet(urlPatterns = "/reporteVenta.do")
public class ReporteVenta extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     *
     */
//    @Resource(name = "jdbc/reporte")
//    DataSource dataSource;

    protected void processRequest(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException,
            IOException {
        try {
//            Connection conexion = (Connection)dataSource.getConnection();

            InitialContext initCtx = new InitialContext();
            DataSource pool = (DataSource) initCtx.lookup("jdbc/reporte");
            Connection conexion = pool.getConnection();
            ServletContext application = this.getServletContext();
            File reportFile;
            Map parameters = new HashMap<String, Object>();

            String idCompra = request.getParameter("idVenta");
            parameters.put("idVenta",
                    idCompra);

//            reportFile = new File(application.getRealPath(
//                    "Informes/InventarioOrder_2.jasper"));
            JasperReport jasperReport =    JasperCompileManager.compileReport(application.getRealPath(
                    "Informes/factura.jrxml"));
            // ruta del reporte, parametros y conexion

            byte[] bytes = JasperRunManager.runReportToPdf(jasperReport,
                    parameters,
                    conexion);

            // generar pdf
            response.setContentType("application/pdf ; charset=UTF-8");
            response.setHeader("Content-Disposition",
                    "inline; filename= Registro_Compra.pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream ouputStream = response.getOutputStream();
            ouputStream.write(bytes,
                    0,
                    bytes.length);

            // limpiar y cerrar flujos de salida
            try {
                ouputStream.flush();
            } catch (Exception e) {
                e.printStackTrace();
            }

            ouputStream.close();

            // cerrar conexion
            conexion.close();
        } catch (Exception e) {
            e.printStackTrace();
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
