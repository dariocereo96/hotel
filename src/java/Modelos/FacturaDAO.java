/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

import Conexiones.Conexion;
import com.mysql.jdbc.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HP
 */
public class FacturaDAO {

    ArrayList<Factura> facturas;
    public int idGenerado;
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    public void registrar(Factura factura) {
        try {
            // Establecer la conexión con la base de datos
            connection = new Conexion().getConexion();

            // Preparar la sentencia SQL de inserción
            String query = "INSERT INTO facturas (fecha, subtotal, iva, total, idReservacion, idCliente,tipoPago) "
                    + "VALUES (?, ?, ?, ?, ?, ?,?)";
            statement = connection.prepareStatement(query);

            // Establecer los valores de los parámetros
            statement.setString(1, factura.getFecha());
            statement.setDouble(2, factura.getSubtotal());
            statement.setDouble(3, factura.getIva());
            statement.setDouble(4, factura.getTotal());
            statement.setInt(5, factura.getIdReservacion());
            statement.setInt(6, factura.getIdCliente());
            statement.setString(7, factura.getTipoPago());

            // Ejecutar la sentencia de inserción
            statement.executeUpdate();

            // Obtener el último ID generado
            resultSet = statement.executeQuery("SELECT LAST_INSERT_ID() AS last_id");

            // Verificar si se obtuvo un resultado
            if (resultSet.next()) {
                idGenerado = resultSet.getInt("last_id");
                System.out.println("Último ID generado: " + idGenerado);
            } else {
                System.out.println("No se pudo obtener el último ID generado.");
            }

        } catch (SQLException e) {
            System.out.println("");
        }

    }

    public Factura buscarFactura(int idFactura) {
        Factura factura = null;
        try {
            String query = "SELECT * FROM facturas WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, idFactura);

            // Ejecutar la consulta
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String fecha = resultSet.getString("fecha");
                double subtotal = resultSet.getDouble("subtotal");
                double iva = resultSet.getDouble("iva");
                double total = resultSet.getDouble("total");
                int idReservacion = resultSet.getInt("idReservacion");
                int idCliente = resultSet.getInt("idCliente");
                String tipoPago = resultSet.getString("tipoPago");

                factura = new Factura(id, fecha, subtotal, iva, total, idReservacion, idCliente, tipoPago);
            }

            return factura;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return factura;

    }

    public Factura buscarFacturaIdReservacion(int idReserva) {
        Factura factura = null;
        try {
            String query = "SELECT * FROM facturas WHERE idReservacion = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, idReserva);

            // Ejecutar la consulta
            resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String fecha = resultSet.getString("fecha");
                double subtotal = resultSet.getDouble("subtotal");
                double iva = resultSet.getDouble("iva");
                double total = resultSet.getDouble("total");
                String tipoPago = resultSet.getString("tipoPago");
                int idReservacion = resultSet.getInt("idReservacion");
                int idCliente = resultSet.getInt("idCliente");

                factura = new Factura(id, fecha, subtotal, iva, total, idReservacion, idCliente, tipoPago);
            }

            return factura;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return factura;

    }

    public ArrayList<Factura> getFacturas() {

        try {
            String query = "SELECT * FROM facturas order by fecha desc";
            connection = new Conexion().getConexion();

            if (connection != null) {
                facturas = new ArrayList<>();
                statement = connection.prepareStatement(query);
                resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String fecha = resultSet.getString("fecha");
                    double subtotal = resultSet.getDouble("subtotal");
                    double iva = resultSet.getDouble("iva");
                    double total = resultSet.getDouble("total");
                    String tipoPago = resultSet.getString("tipoPago");
                    int idReservacion = resultSet.getInt("idReservacion");
                    int idCliente = resultSet.getInt("idCliente");

                    Factura factura = new Factura(id, fecha, subtotal, iva, total, idReservacion, idCliente, tipoPago);
                    facturas.add(factura);
                }

                return facturas;

            } else {
                System.out.println("La conexion es nula");
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return facturas;

    }

    public void eliminarFactura(int idFactura) {
        try {
            // Preparar la consulta SQL
            String query = "DELETE FROM facturas WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, idFactura);

            statement.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
                statement.close();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        }

    }

    public static void main(String[] args) {
        // Obtener la lista de habitaciones desde el atributo de la solicitud

    }
}
