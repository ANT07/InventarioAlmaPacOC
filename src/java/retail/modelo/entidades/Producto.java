package retail.modelo.entidades;
// Generated 02-18-2019 03:12:08 PM by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Producto generated by hbm2java
 */
public class Producto  implements java.io.Serializable {


     private int codigoProducto;
     private String nombreProducto;
     private String descripcionProducto;
     private double precioProducto;
     private int existenciaProducto;
     private Set detalleventas = new HashSet(0);
     private Set detallecompras = new HashSet(0);

    public Producto() {
    }

	
    public Producto(int codigoProducto, String nombreProducto, String descripcionProducto, double precioProducto, int existenciaProducto) {
        this.codigoProducto = codigoProducto;
        this.nombreProducto = nombreProducto;
        this.descripcionProducto = descripcionProducto;
        this.precioProducto = precioProducto;
        this.existenciaProducto = existenciaProducto;
    }
    public Producto(int codigoProducto, String nombreProducto, String descripcionProducto, double precioProducto, int existenciaProducto, Set detalleventas, Set detallecompras) {
       this.codigoProducto = codigoProducto;
       this.nombreProducto = nombreProducto;
       this.descripcionProducto = descripcionProducto;
       this.precioProducto = precioProducto;
       this.existenciaProducto = existenciaProducto;
       this.detalleventas = detalleventas;
       this.detallecompras = detallecompras;
    }
   
    public int getCodigoProducto() {
        return this.codigoProducto;
    }
    
    public void setCodigoProducto(int codigoProducto) {
        this.codigoProducto = codigoProducto;
    }
    public String getNombreProducto() {
        return this.nombreProducto;
    }
    
    public void setNombreProducto(String nombreProducto) {
        this.nombreProducto = nombreProducto;
    }
    public String getDescripcionProducto() {
        return this.descripcionProducto;
    }
    
    public void setDescripcionProducto(String descripcionProducto) {
        this.descripcionProducto = descripcionProducto;
    }
    public double getPrecioProducto() {
        return this.precioProducto;
    }
    
    public void setPrecioProducto(double precioProducto) {
        this.precioProducto = precioProducto;
    }
    public int getExistenciaProducto() {
        return this.existenciaProducto;
    }
    
    public void setExistenciaProducto(int existenciaProducto) {
        this.existenciaProducto = existenciaProducto;
    }
    public Set getDetalleventas() {
        return this.detalleventas;
    }
    
    public void setDetalleventas(Set detalleventas) {
        this.detalleventas = detalleventas;
    }
    public Set getDetallecompras() {
        return this.detallecompras;
    }
    
    public void setDetallecompras(Set detallecompras) {
        this.detallecompras = detallecompras;
    }




}


