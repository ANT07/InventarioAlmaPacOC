/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.sql.ResultSet;
import java.util.List;
import retail.modelo.entidades.Vendedor;

/**
 *
 * @author William Vasquez
 */
public interface VendedorDAO {

    public void insertarVendedor(Vendedor vendedor)
            throws Exception;

    public void eliminarVendedor(Vendedor vendedor)
            throws Exception;

    public void actualizarVendedor(Vendedor vendedor)
            throws Exception;

    public List<Vendedor> obtenerVendedores()
            throws Exception;

    public Vendedor obtenerVendedorById(int id)
            throws Exception;

}
