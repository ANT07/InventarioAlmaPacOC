/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.sql.ResultSet;
import java.util.List;
import retail.modelo.entidades.Ventas;

/**
 *
 * @author William Vasquez
 */
public interface VentaDAO {

    public void insertarVentas(Ventas venta)
            throws Exception;

    public void eliminarVentas(Ventas venta)
            throws Exception;

    public void actualizarVentas(Ventas venta)
            throws Exception;

    public List<Ventas> obtenerVentas()
            throws Exception;

    public Ventas obtenerVentasById(int id)
            throws Exception;

}
