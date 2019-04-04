/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import retail.modelo.entidades.Producto;
import retail.modelo.entidades.Usuario;
import retail.modelo.servicios.ServiciosProducto;
import retail.modelo.servicios.UsuarioDAO;

/**
 *
 * @author ANTHONY MARTINEZ
 */
public class ImagenControlador extends HttpServlet {

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

        try {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
             UsuarioDAO usuarioDAO= new  UsuarioDAO();
            List items = upload.parseRequest(request);
            HashMap<String, String> parametros = new HashMap<>();
            FileItem archivoImagen = null;
            String carpetaDestino = "C:/Users/ANTHONY MARTINEZ/Documents/NetBeansProjects/InventarioAlmaPacOC/web/userImages/";

            for (Object item : items) {
                FileItem uploaded = (FileItem) item;

                // Hay que comprobar si es un campo de formulario. Si no lo es, se guarda el fichero
                // subido donde nos interese
                if (!uploaded.isFormField()) {
                    // No es campo de formulario, guardamos el fichero en algún sitio
                    archivoImagen = uploaded;
                } else {
                    parametros.put(uploaded.getFieldName(),
                            uploaded.getString());
                }
            }
            

            String codigoUsuario = parametros.get("usuarioIdImg");
            Usuario usuario = usuarioDAO.obtenerUsuario(codigoUsuario);
            
            
            String extencion = usuario.getUsuario() + archivoImagen.getName().substring(archivoImagen.getName().lastIndexOf("."));
            carpetaDestino +=  extencion;
            File archivoGuardar = new File(carpetaDestino);
            if(archivoGuardar.exists()){
                archivoGuardar.delete();
            }
            archivoImagen.write(archivoGuardar);
            
            String rutaServidor = "/userImages/" + extencion;
            usuario.setRutaImagen(rutaServidor);
            
            usuarioDAO.actualizarUsuario(usuario);
            
            request.getRequestDispatcher("/UserView.jsp").forward(request, response);
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
