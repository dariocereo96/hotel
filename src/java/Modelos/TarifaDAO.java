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
public class TarifaDAO {

    ArrayList<Tarifa> tarifas = null;
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    public void registrarTarifa(Tarifa tarifa) {
        try {
            String query = "INSERT INTO tarifas (descripcion, precio,categoria,imagen) VALUES (?, ?,?,?)";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setString(1, tarifa.getDescripcion());
            statement.setDouble(2, tarifa.getPrecio());
            statement.setString(3, tarifa.getCategoria());
            statement.setString(4, tarifa.getImagen());
            statement.executeUpdate();
            statement.close();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

    }

    public ArrayList<Tarifa> obtenerTarifas() {

        try {
            String query = "SELECT * FROM tarifas";
            connection = new Conexion().getConexion();

            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            tarifas = new ArrayList<>();

            while (resultSet.next()) {
                int idTarifa = resultSet.getInt("id");
                String descripcion = resultSet.getString("descripcion");
                double precio = resultSet.getDouble("precio");
                String categoria = resultSet.getString("categoria");
                String imagen = resultSet.getString("imagen");

                Tarifa tarifa = new Tarifa(idTarifa, descripcion, precio, categoria, imagen);
                tarifas.add(tarifa);
            }

            return tarifas;

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return tarifas;

    }

    public void editarTarifa(Tarifa tarifa) {
        try {
            // Preparar la consulta SQL
            String query = "UPDATE tarifas SET descripcion = ?, precio = ?,categoria = ? WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setString(1, tarifa.getDescripcion());
            statement.setDouble(2, tarifa.getPrecio());
            statement.setString(3, tarifa.getCategoria());
            statement.setInt(4, tarifa.getIdTarifa());

            // Ejecutar la consulta
            int filasActualizadas = statement.executeUpdate();

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

    public Tarifa buscarTarifa(int idTarifa) {
        try {
            // Preparar la consulta SQL
            String query = "SELECT * FROM tarifas WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, idTarifa);

            // Ejecutar la consulta
            resultSet = statement.executeQuery();

            // Verificar si se encontró la tarifa
            if (resultSet.next()) {
                String descripcion = resultSet.getString("descripcion");
                double precio = resultSet.getDouble("precio");
                String categoria = resultSet.getString("categoria");
                String imagen = resultSet.getString("imagen");

                return new Tarifa(idTarifa, descripcion, precio, categoria, imagen);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
                statement.close();
                resultSet.close();
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
        }
        return null; // Si no se encontró la tarifa, devuelve null
    }

    public void eliminarTarifa(int idTarifa) {
        try {
            // Preparar la consulta SQL
            String query = "DELETE FROM tarifas WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, idTarifa);

            // Ejecutar la consulta
            int filasEliminadas = statement.executeUpdate();

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

    public ArrayList<Tarifa> obtenerTarifasCategoria(String cate) {

        try {
            String query = "SELECT * FROM tarifas where categoria=?";
            connection = new Conexion().getConexion();

            statement = connection.prepareStatement(query);
            statement.setString(1, cate);
            resultSet = statement.executeQuery();
            tarifas = new ArrayList<>();

            while (resultSet.next()) {
                int idTarifa = resultSet.getInt("id");
                String descripcion = resultSet.getString("descripcion");
                double precio = resultSet.getDouble("precio");
                String categoria = resultSet.getString("categoria");
                String imagen = resultSet.getString("imagen");

                Tarifa tarifa = new Tarifa(idTarifa, descripcion, precio, categoria, imagen);
                tarifas.add(tarifa);
            }

            return tarifas;

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return tarifas;

    }

    public void editarTarifaImage(Tarifa tarifa) {
        try {
            // Preparar la consulta SQL
            String query = "UPDATE tarifas SET descripcion = ?, precio = ?,categoria = ?, imagen = ? WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setString(1, tarifa.getDescripcion());
            statement.setDouble(2, tarifa.getPrecio());
            statement.setString(3, tarifa.getCategoria());
            statement.setString(4, tarifa.getImagen());
            statement.setInt(5, tarifa.getIdTarifa());

            // Ejecutar la consulta
            int filasActualizadas = statement.executeUpdate();

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

}
