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
public class ClienteDAO {

    ArrayList<Cliente> clientes = null;
    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;
    public int idGenerado;

    public ArrayList<Cliente> getClientes() {
        try {
            String query = "SELECT * FROM clientes";
            connection = new Conexion().getConexion();

            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            clientes = new ArrayList<>();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String nombre = resultSet.getString("nombre");
                String apellido = resultSet.getString("apellido");
                String tipoDocumento = resultSet.getString("tipoDocumento");
                String numeroDocumento = resultSet.getString("numeroDocumento");
                String correo = resultSet.getString("correo");
                String telefono = resultSet.getString("telefono");

                Cliente cliente = new Cliente(id, nombre, apellido, tipoDocumento, numeroDocumento, correo, telefono);
                clientes.add(cliente);

            }

            return clientes;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

        return clientes;
    }

    public void registrar(Cliente cliente) {
        try {
            String query = "INSERT INTO clientes (nombre, apellido, tipoDocumento, numeroDocumento, correo, telefono) VALUES (?, ?, ?, ?, ?, ?)";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);

            statement.setString(1, cliente.getNombre());
            statement.setString(2, cliente.getApellido());
            statement.setString(3, cliente.getTipoDocumento());
            statement.setString(4, cliente.getNumeroDocumento());
            statement.setString(5, cliente.getCorreo());
            statement.setString(6, cliente.getTelefono());

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

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public Cliente buscarCliente(int clienteId) {
        Cliente cliente = null;

        try {
            // Preparar la consulta SQL
            String query = "SELECT * FROM clientes WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, clienteId);

            // Ejecutar la consulta
            resultSet = statement.executeQuery();

            // Verificar si se encontró un cliente
            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String nombre = resultSet.getString("nombre");
                String apellido = resultSet.getString("apellido");
                String tipoDocumento = resultSet.getString("tipoDocumento");
                String numeroDocumento = resultSet.getString("numeroDocumento");
                String correo = resultSet.getString("correo");
                String telefono = resultSet.getString("telefono");

                cliente = new Cliente(id, nombre, apellido, tipoDocumento, numeroDocumento, correo, telefono);
            }
            return cliente;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public void editarCliente(Cliente cliente) {
        try {
            String query = "UPDATE clientes SET nombre=?, apellido=?, tipoDocumento=?, numeroDocumento=?, correo=?, telefono=? WHERE id=?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);

            statement.setString(1, cliente.getNombre());
            statement.setString(2, cliente.getApellido());
            statement.setString(3, cliente.getTipoDocumento());
            statement.setString(4, cliente.getNumeroDocumento());
            statement.setString(5, cliente.getCorreo());
            statement.setString(6, cliente.getTelefono());
            statement.setInt(7, cliente.getId());

            statement.executeUpdate();

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }
    }

    public void eliminarCliente(int clienteId) {
        try {
            String query = "DELETE FROM clientes WHERE id=?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, clienteId);
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

}
