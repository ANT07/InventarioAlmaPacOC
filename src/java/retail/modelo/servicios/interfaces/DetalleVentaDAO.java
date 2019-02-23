/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.util.List;
import retail.modelo.entidades.Detalleventa;

/**
 *
 * @author William Vasquez
 */
public interface DetalleVentaDAO {

    public void insertarDetalleventa(Detalleventa detalleVenta)
            throws Exception;

    public void eliminarDetalleventa(Detalleventa detalleVenta)
            throws Exception;

    public void actualizarDetalleventa(Detalleventa detalleVenta)
            throws Exception;

    public List<Detalleventa> obtenerDetalleventa()
            throws Exception;

    public Detalleventa obtenerDetalleventaById(int id)
            throws Exception;

}
