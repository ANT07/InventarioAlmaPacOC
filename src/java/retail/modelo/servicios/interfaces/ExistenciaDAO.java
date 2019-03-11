/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;
import java.util.List;
import retail.modelo.entidades.Existencia;

/**
 *
 * @author William Vasquez
 */
public interface ExistenciaDAO {

    public void insertarExistencia(Existencia existencia)
            throws Exception;

    public void eliminarExistencia(Existencia existencia)
            throws Exception;

    public void actualizarExistencia(Existencia existencia)
            throws Exception;

    public List<Existencia> obtenerExistencias()
            throws Exception;

    public Existencia obtenerExistenciaById(int id)
            throws Exception;

}
