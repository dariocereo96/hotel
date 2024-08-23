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

/**
 *
 * @author HP
 */
public class HabitacionDAO {

    ArrayList<Habitacion> habitaciones = null;
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    public ArrayList<Habitacion> getHabitaciones() {

        try {
            String query = "SELECT * FROM habitaciones";
            connection = new Conexion().getConexion();

            if (connection != null) {
                habitaciones = new ArrayList<>();
                statement = connection.prepareStatement(query);
                resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    int capacidad = resultSet.getInt("capacidad");
                    String tipo = resultSet.getString("tipo");
                    double precioNoche = resultSet.getDouble("precioNoche");
                    boolean disponible = resultSet.getBoolean("disponible");
                    String imagen = resultSet.getString("imagen");

                    Habitacion habitacion = new Habitacion(id, capacidad, tipo, precioNoche, disponible, imagen);
                    habitaciones.add(habitacion);
                }

                return habitaciones;

            } else {
                System.out.println("La conexion es nula");
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return habitaciones;
    }

    public void registrar(Habitacion habitacion) {
        try {
            String query = "INSERT INTO habitaciones (capacidad, tipo, precioNoche, disponible,imagen) VALUES (?, ?, ?, ?,?)";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, habitacion.getCapacidad());
            statement.setString(2, habitacion.getTipo());
            statement.setDouble(3, habitacion.getPrecioNoche());
            statement.setInt(4, habitacion.isDisponible() ? 1 : 0);
            statement.setString(5, habitacion.getImagen());
            statement.executeUpdate();

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

    }

    public Habitacion buscarHabitacion(int id) {
        Habitacion habitacion = null;
        try {
            String query = "SELECT * FROM habitaciones where id=?";
            connection = new Conexion().getConexion();

            if (connection != null) {
                statement = connection.prepareStatement(query);
                statement.setInt(1, id);

                // Ejecutar la consulta
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    int capacidad = resultSet.getInt("capacidad");
                    String tipo = resultSet.getString("tipo");
                    double precioNoche = resultSet.getDouble("precioNoche");
                    boolean disponible = resultSet.getBoolean("disponible");
                    String imagen = resultSet.getString("imagen");

                    habitacion = new Habitacion(id, capacidad, tipo, precioNoche, disponible, imagen);
                }

                return habitacion;

            } else {
                System.out.println("La conexion es nula");
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return habitacion;

    }

    public void editarHabitacion(Habitacion habitacion) {

        try {

            String query = "UPDATE habitaciones SET capacidad=?, tipo=?, disponible=? ,precioNoche=? WHERE id=?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);

            statement.setInt(1, habitacion.getCapacidad());
            statement.setString(2, habitacion.getTipo());
            statement.setBoolean(3, habitacion.isDisponible());
            statement.setDouble(4, habitacion.getPrecioNoche());
            statement.setInt(5, habitacion.getId());
            statement.executeUpdate();

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

    }

    public void editarHabitacionImage(Habitacion habitacion) {

        try {

            String query = "UPDATE habitaciones SET capacidad=?, tipo=?, disponible=? ,precioNoche=?,imagen=? WHERE id=?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);

            statement.setInt(1, habitacion.getCapacidad());
            statement.setString(2, habitacion.getTipo());
            statement.setBoolean(3, habitacion.isDisponible());
            statement.setDouble(4, habitacion.getPrecioNoche());
            statement.setString(5, habitacion.getImagen());
            statement.setInt(6, habitacion.getId());
            statement.executeUpdate();

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

    }

    public void eliminarHabitacion(int idHabitacion) {
        try {
            String query = "DELETE FROM habitaciones WHERE id=?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, idHabitacion);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        new HabitacionDAO().eliminarHabitacion(12);
    }

}
