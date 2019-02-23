/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.conexion;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *
 * @author Lab6
 */
public class Conexion {
    private Connection conexion;
    public Conexion () throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/retail","root","12345678");
    }
    
    public Conexion (String sql) throws Exception{
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/prueba","root","12345678");
        
        
    }

    public Connection getConexion() {
        if (conexion!=null)
        {
            System.out.println("Conexión realizada con éxito");
        }else{
            System.out.println("Error de conexion");
        }
        return conexion;
    }
            
    public void closeConexion() throws Exception{
        conexion.close();
    }
public static void main(String[] args) throws Exception {
        Conexion C = new Conexion();
        C.getConexion();
        
    }

}
