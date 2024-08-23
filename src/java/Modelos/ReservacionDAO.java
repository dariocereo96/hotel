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
public class ReservacionDAO {

    ArrayList<Reservacion> reservaciones = null;
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    public int idGenerado;

    public void registrarReservacion(Reservacion reservacion) {
        try {
            String query = "INSERT INTO reservaciones (idCliente, idHabitacion, fechaInicio, fechaFinalizacion,ocupantes) VALUES (?, ?, ?, ?,?)";

            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, reservacion.getIdCliente());
            statement.setInt(2, reservacion.getIdHabitacion());
            statement.setString(3, reservacion.getFechaInicio());
            statement.setString(4, reservacion.getFechaFin());
            statement.setInt(5, reservacion.getOcupantes());
            statement.executeUpdate();

            //
            // Obtener el último ID generado
            resultSet = statement.executeQuery("SELECT LAST_INSERT_ID() AS last_id");

            // Verificar si se obtuvo un resultado
            if (resultSet.next()) {
                idGenerado = resultSet.getInt("last_id");
                System.out.println("Último ID generado: " + idGenerado);
            } else {
                System.out.println("No se pudo obtener el último ID generado.");
            }

            //Cambiar el estado de la habitacion
            query = "UPDATE habitaciones SET disponible = ? WHERE id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, 0);
            statement.setInt(2, reservacion.getIdHabitacion());

            statement.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public Reservacion buscarReservacionCliente(int clienteId) {
        Reservacion reservacion = null;

        try {
            // Preparar la consulta SQL
            String query = "SELECT * FROM reservaciones WHERE idCliente = ? order by fechaInicio desc";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, clienteId);

            // Ejecutar la consulta
            resultSet = statement.executeQuery();

            // Verificar si se encontró un reservacion
            if (resultSet.next()) {
                // Obtener los valores de los campos
                int id = resultSet.getInt("id");
                String fechaInicio = resultSet.getString("fechaInicio");
                String fechaFinalizacion = resultSet.getString("fechaFinalizacion");
                int ocupantes = resultSet.getInt("ocupantes");
                int idHabitacion = resultSet.getInt("idHabitacion");
                int idCliente = resultSet.getInt("idCliente");

                reservacion = new Reservacion(id, idCliente, idHabitacion, fechaInicio, fechaFinalizacion, ocupantes);
            }
            return reservacion;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public Reservacion buscarReservacion(int idReservacion) {
        Reservacion reservacion = null;

        try {
            // Preparar la consulta SQL
            String query = "SELECT * FROM reservaciones WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, idReservacion);

            // Ejecutar la consulta
            resultSet = statement.executeQuery();

            // Verificar si se encontró un reservacion
            if (resultSet.next()) {
                // Obtener los valores de los campos
                int id = resultSet.getInt("id");
                String fechaInicio = resultSet.getString("fechaInicio");
                String fechaFinalizacion = resultSet.getString("fechaFinalizacion");
                int ocupantes = resultSet.getInt("ocupantes");
                int idHabitacion = resultSet.getInt("idHabitacion");
                int idCliente = resultSet.getInt("idCliente");

                reservacion = new Reservacion(id, idCliente, idHabitacion, fechaInicio, fechaFinalizacion, ocupantes);
            }
            return reservacion;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public ArrayList<Reservacion> getReservaciones() {
        try {
            String query = "SELECT * FROM reservaciones";
            connection = new Conexion().getConexion();

            if (connection != null) {
                reservaciones = new ArrayList<>();
                statement = connection.prepareStatement(query);
                resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String fechaInicio = resultSet.getString("fechaInicio");
                    String fechaFin = resultSet.getString("fechaFinalizacion");
                    int ocupantes = resultSet.getInt("ocupantes");
                    int idHabitacion = resultSet.getInt("idHabitacion");
                    int idCliente = resultSet.getInt("idCliente");

                    // Crear un objeto Reservacion con los datos obtenidos
                    Reservacion reservacion = new Reservacion(id, idCliente, idHabitacion, fechaInicio, fechaFin, ocupantes);
                    reservaciones.add(reservacion);
                }

                return reservaciones;

            } else {
                System.out.println("La conexion es nula");
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return reservaciones;
    }

    public void modificarReservacion(Reservacion reservacion) {
        try {
            String query = "UPDATE reservaciones SET fechaInicio=?, fechaFinalizacion=?, idHabitacion=?,ocupantes=? WHERE id=?";

            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setString(1, reservacion.getFechaInicio());
            statement.setString(2, reservacion.getFechaFin());
            statement.setInt(3, reservacion.getIdHabitacion());
            statement.setInt(4, reservacion.getOcupantes());
            statement.setInt(5, reservacion.getId());

            statement.executeUpdate();

            query = "UPDATE habitaciones SET disponible = ? WHERE id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, 0);
            statement.setInt(2, reservacion.getIdHabitacion());

            statement.executeUpdate();

            query = "UPDATE habitaciones SET disponible = ? WHERE id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, 1);
            statement.setInt(2, reservacion.getIdHabitacionAnterior());

            statement.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void eliminarReservacion(int idReservacion) {
        try {
            connection = new Conexion().getConexion();

            // Obtener el id de la habitación asociada a la reserva que se va a eliminar
            String queryHabitacion = "SELECT idHabitacion FROM reservaciones WHERE id = ?";
            statement = connection.prepareStatement(queryHabitacion);
            statement.setInt(1, idReservacion);
            int idHabitacion = 0;
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                idHabitacion = resultSet.getInt("idHabitacion");
            }

            // Eliminar la reserva
            String queryEliminar = "DELETE FROM reservaciones WHERE id = ?";
            statement = connection.prepareStatement(queryEliminar);
            statement.setInt(1, idReservacion);
            statement.executeUpdate();

            // Actualizar el estado de la habitación a "desocupado"
            String queryActualizarHabitacion = "UPDATE habitaciones SET disponible = 1 WHERE id = ?";
            statement = connection.prepareStatement(queryActualizarHabitacion);
            statement.setInt(1, idHabitacion);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }

    public ArrayList<Reservacion> getReservacionesCliente(String cedula) {
        try {
            String query = "select * from reservaciones r join clientes c on r.idCliente = c.id where c.numeroDocumento = ? order by r.fechaInicio desc";
            connection = new Conexion().getConexion();
            System.out.println(cedula);

            if (connection != null) {
                reservaciones = new ArrayList<>();
                statement = connection.prepareStatement(query);
                statement.setString(1, cedula);
                resultSet = statement.executeQuery();

                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String fechaInicio = resultSet.getString("fechaInicio");
                    String fechaFin = resultSet.getString("fechaFinalizacion");
                    int idHabitacion = resultSet.getInt("idHabitacion");
                    int idCliente = resultSet.getInt("idCliente");
                    int ocupantes = resultSet.getInt("ocupantes");

                    // Crear un objeto Reservacion con los datos obtenidos
                    Reservacion reservacion = new Reservacion(id, idCliente, idHabitacion, fechaInicio, fechaFin, ocupantes);
                    reservaciones.add(reservacion);
                }

                return reservaciones;

            } else {
                System.out.println("La conexion es nula");
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return reservaciones;
    }

    public static void main(String[] args) {
        System.out.println(new ReservacionDAO().getReservacionesCliente("1207340264"));
    }

}
