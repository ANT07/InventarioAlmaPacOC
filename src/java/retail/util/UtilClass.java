/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.util;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import retail.modelo.entidades.OrderMaster;
import retail.modelo.servicios.OrdermasterImpl;

/**
 *
 * @author anthony
 */
public class UtilClass {
    public static String parseFecha(Date date){
        SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
        return formatoFecha.format(date);
    }
    
    public static Date formatFecha(String date) throws Exception{
        SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
        return formatoFecha.parse(date);
    }
    
    public static Date formatFecha2(String date) throws Exception{
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        return formatoFecha.parse(date);
    }
    
    public static String getFechaServidor(){
        GregorianCalendar calendario = (GregorianCalendar) GregorianCalendar.getInstance();
        Date fechaServidor = calendario.getTime();
        return parseFecha(fechaServidor);
    }
    
    public String formatoDecimales(double decimal){
        DecimalFormat formatoDecimales = new DecimalFormat("#######0.00");
        return formatoDecimales.format(decimal);
    }
    
    public  String formatoFecha(Date date){
        SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");
        return formatoFecha.format(date);
    }
    
    public static String getOrderId(){
        
        int orderCount ;
        String orderId = "";
        String anio = (""+(new GregorianCalendar().get(Calendar.YEAR))).substring(2,4);
        OrdermasterImpl orderMasterImpl = new OrdermasterImpl();
        try {
            List<OrderMaster> orderMasters = orderMasterImpl.getOrderMasters();
            orderCount = orderMasters.size()+1;
            
            DecimalFormat formato = new DecimalFormat("000000");
            orderId = formato.format(orderCount);
        } catch (Exception ex) {
            Logger.getLogger(UtilClass.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return orderId+"-"+anio;
    }
}
