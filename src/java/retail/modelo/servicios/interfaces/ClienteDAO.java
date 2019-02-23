/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.sql.ResultSet;
import java.util.List;
import retail.modelo.entidades.Clientes;

/**
 *
 * @author William Vasquez
 */
public interface ClienteDAO {

    public void insertarClientes(Clientes cliente)
            throws Exception;

    public void eliminarClientes(Clientes cliente)
            throws Exception;

    public void actualizarClientes(Clientes cliente)
            throws Exception;

    public List<Clientes> obtenerClientes()
            throws Exception;

    public Clientes obtenerClientesById(int id)
            throws Exception;

}
