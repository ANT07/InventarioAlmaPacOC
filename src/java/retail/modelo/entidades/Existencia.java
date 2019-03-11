/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.entidades;

/**
 *
 * @author ANTHONY MARTINEZ
 */
public class Existencia {
    
    
    private int idExistencia;
    private Producto producto;
    private Department departamento;
    private double disponible;

    public Existencia() {
    }

    public Existencia(int idExistencia, Producto producto, Department departamento, double disponible) {
        this.idExistencia = idExistencia;
        this.producto = producto;
        this.departamento = departamento;
        this.disponible = disponible;
    }
    
    public int getIdExistencia() {
        return idExistencia;
    }

    public void setIdExistencia(int idExistencia) {
        this.idExistencia = idExistencia;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public Department getDepartamento() {
        return departamento;
    }

    public void setDepartamento(Department departamento) {
        this.departamento = departamento;
    }

    public double getDisponible() {
        return disponible;
    }

    public void setDisponible(double disponible) {
        this.disponible = disponible;
    }
    
    
}
