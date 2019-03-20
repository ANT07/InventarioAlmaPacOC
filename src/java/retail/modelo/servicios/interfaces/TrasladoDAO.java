/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.util.List;
import retail.modelo.entidades.Traslado;


/**
 *
 * @author William Vasquez
 */
public interface TrasladoDAO {

    public void insertarTraslado(Traslado traslado)
            throws Exception;

    public void eliminarTraslado(Traslado traslado)
            throws Exception;

    public void actualizarTraslado(Traslado traslado)
            throws Exception;

    public List<Traslado> obtenerTraslado()
            throws Exception;

    public Traslado obtenerTrasladoById(int id)
            throws Exception;

}
