/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.util.List;
import retail.modelo.entidades.Compra;

/**
 *
 * @author William Vasquez
 */
public interface CompraDAO {

    public void insertarCompra(Compra compra)
            throws Exception;

    public void eliminarCompra(Compra compra)
            throws Exception;

    public void actualizarCompra(Compra compra)
            throws Exception;

    public List<Compra> obtenerCompra()
            throws Exception;

    public Compra obtenerCompraById(int id)
            throws Exception;

}
