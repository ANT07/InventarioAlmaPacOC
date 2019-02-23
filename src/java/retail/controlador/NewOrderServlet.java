/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.controlador;


import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import retail.modelo.entidades.Contact;
import retail.modelo.entidades.Department;
import retail.modelo.entidades.OrderDetail;
import retail.modelo.entidades.OrderDetailId;
import retail.modelo.entidades.OrderMaster;
import retail.modelo.entidades.OrderType;
import retail.modelo.entidades.Producto;
import retail.modelo.entidades.Provider;
import retail.modelo.entidades.Vendedor;
import retail.modelo.servicios.OrdermasterImpl;

/**
 *
 * @author anthony
 */
public class NewOrderServlet extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewOrderServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewOrderServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        try {
            String orderDate = request.getParameter("fecha");
            String orderId = request.getParameter("orderid");
            int providerId = Integer.parseInt(request.getParameter("providerid"));
            int typeId = Integer.parseInt(request.getParameter("typeid"));
            int sellerId = Integer.parseInt(request.getParameter("sellerid"));
            int departmentId = Integer.parseInt(request.getParameter("departmentid"));
            
            String comentario = request.getParameter("comentario");
            
            
            OrderMaster orderMaster = new OrderMaster();
            OrdermasterImpl orderMasterImpl = new OrdermasterImpl();
            
            Provider provider = new Provider();
            provider.setProviderid(providerId);
            Vendedor vendedor = new Vendedor();
            vendedor.setIdVendedor(sellerId);
            OrderType orderType = new OrderType();
            orderType.setTypeid(typeId);
            Department department = new Department();
            department.setDepartmentid(departmentId);
            

            OrderDetail orderDetail;
            Set<OrderDetail> ordersDetails = new HashSet<OrderDetail>();
            String [] productsId = request.getParameterValues("productid");
            String [] cantidades = request.getParameterValues("cantidad");
            String [] preciosUnitatios = request.getParameterValues("precioUnitario");
            String [] productColors = request.getParameterValues("color");
            
            double total = 0;
            for(int i = 0; i< productsId.length; i++){
                orderDetail = new OrderDetail();
                orderDetail.setId(new OrderDetailId(i+1,orderId));
//                orderDetail.setOrderMaster(orderMaster);
                orderDetail.setOrderdetailquantity(Float.parseFloat(cantidades[i]));
                orderDetail.setOrderdetailunitprice(Float.parseFloat(preciosUnitatios[i]));
                Producto producto = new Producto();
                producto.setCodigoProducto(Integer.parseInt(productsId[i]));
                orderDetail.setProduct(producto);
                orderDetail.setOrderdetailtotal(orderDetail.getOrderdetailquantity() * orderDetail.getOrderdetailunitprice());
                orderDetail.setProductcolor(productColors[i]);
                orderMaster.getOrderDetails().add(orderDetail);
                total += orderDetail.getOrderdetailtotal();
            }
            
            orderMaster.setOrderid(orderId);
            orderMaster.setDepartment(department);
            orderMaster.setOrderType(orderType);
            orderMaster.setOrdercoment(comentario);
            orderMaster.setVendedor(vendedor);
            orderMaster.setProvider(provider);
            
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            java.util.Date fecha = (java.util.Date)dateFormat.parse(orderDate);
            orderMaster.setOrderdate(dateFormat.parse(orderDate));
            
            orderMaster.setOrdertotal((float)total);
            
            orderMasterImpl.insertOrderMaster(orderMaster);
//            
//            for(OrderDetail detail : ordersDetails){
//                orderDetailImpl.insertOrderDetail(detail);
//            }
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("/OrdersView.jsp");
            requestDispatcher.forward(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(NewOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(NewOrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }  
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
