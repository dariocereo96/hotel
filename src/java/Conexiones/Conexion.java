/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Conexiones;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author HP
 */
public class Conexion {

    private Connection connection = null;
    private final String url = "jdbc:mysql://localhost:3306/hoteldb4?useSSL=false";
//    private final String url = "jdbc:mysql://localhost:3306/hotelDB";
    private final String usuario = "root";
    private final String contraseña = "";

    public Connection getConexion() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = (Connection) DriverManager.getConnection(url, usuario, contraseña);
            System.out.println("Conexion exitosa");
            return connection;
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println("Error al conectar con la base de datos MySQL: " + e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        Conexion con = new Conexion();
        con.getConexion();
    }
}
