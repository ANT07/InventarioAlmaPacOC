/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.sql.ResultSet;
import java.util.List;
import retail.modelo.entidades.Producto;

/**
 *
 * @author William Vasquez
 */
public interface ProductoDAO {

    public void insertarProducto(Producto producto)
            throws Exception;

    public void eliminarProducto(Producto producto)
            throws Exception;

    public void actualizarProducto(Producto producto)
            throws Exception;

    public List<Producto> obtenerProducto()
            throws Exception;

    public Producto obtenerProductoById(int id)
            throws Exception;

}
