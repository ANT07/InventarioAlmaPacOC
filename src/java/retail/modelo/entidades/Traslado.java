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
public class Traslado {
    private int idTraslado;
    private Department departmentoOrigen;
    private Department departmentDestino;
    private Producto producto;
    private double cantidadTralado;

    public Traslado() {
    }

    public Traslado(int idTraslado, Department departmentoOrigen, Department departmentDestino, Producto producto, double cantidadTralado) {
        this.idTraslado = idTraslado;
        this.departmentoOrigen = departmentoOrigen;
        this.departmentDestino = departmentDestino;
        this.producto = producto;
        this.cantidadTralado = cantidadTralado;
    }

    
    
    public int getIdTraslado() {
        return idTraslado;
    }

    public void setIdTraslado(int idTraslado) {
        this.idTraslado = idTraslado;
    }

    public Department getDepartmentoOrigen() {
        return departmentoOrigen;
    }

    public void setDepartmentoOrigen(Department departmentoOrigen) {
        this.departmentoOrigen = departmentoOrigen;
    }

    public Department getDepartmentDestino() {
        return departmentDestino;
    }

    public void setDepartmentDestino(Department departmentDestino) {
        this.departmentDestino = departmentDestino;
    }

    public Producto getProducto() {
        return producto;
    }

    public void setProducto(Producto producto) {
        this.producto = producto;
    }

    public double getCantidadTralado() {
        return cantidadTralado;
    }

    public void setCantidadTralado(double cantidadTralado) {
        this.cantidadTralado = cantidadTralado;
    }
    
    
}
