/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.util.List;
import retail.modelo.entidades.Detallecompra;

/**
 *
 * @author William Vasquez
 */
public interface DetalleCompraDAO {

    public void insertarDetallecompra(Detallecompra detalleCompra)
            throws Exception;

    public void eliminarDetallecompra(Detallecompra detalleCompra)
            throws Exception;

    public void actualizarDetallecompra(Detallecompra detalleCompra)
            throws Exception;

    public List<Detallecompra> obtenerDetallecompra()
            throws Exception;

    public Detallecompra obtenerDetallecompraById(int id)
            throws Exception;

}
