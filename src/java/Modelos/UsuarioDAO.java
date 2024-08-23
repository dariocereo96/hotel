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

public class UsuarioDAO {

    Connection connection = null;
    PreparedStatement statement = null;
    ResultSet resultSet = null;

    public UsuarioDAO() {

    }

    public Usuario login(String username, String password) {
        try {
            String query = "SELECT * FROM usuarios WHERE username = ?";
            connection = new Conexion().getConexion();

            if (connection != null) {
                statement = connection.prepareStatement(query);
                statement.setString(1, username);
                resultSet = statement.executeQuery();

                if (resultSet.next()) {
                    // Inicio de sesión exitoso
                    System.out.println("Usuario correctos");
                    return new Usuario(resultSet.getInt("id"), resultSet.getString("username"), resultSet.getString("password"), resultSet.getString("perfil"), resultSet.getBoolean("estado"));
                } else {
                    // Credenciales inválidas
                    System.out.println("Usuario Incorrectos");
                }

            } else {
                System.out.println("La conexion es nula");
            }

        } catch (SQLException ex) {
            System.out.println("Error: " + ex.getMessage());
        }
        return null;
    }

    public void registrarUsuario(Usuario usuario) {
        try {
            String query = "INSERT INTO usuarios (username, password, perfil,estado) VALUES (?, ?, ? ,?)";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setString(1, usuario.getUsername());
            statement.setString(2, usuario.getPassword());
            statement.setString(3, usuario.getPerfil());
            statement.setBoolean(4, usuario.isActivo());
            statement.executeUpdate();
            statement.close();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void registrarUsuarioCliente(Usuario usuario) {
        try {
            String query = "INSERT INTO usuarios (username, password, perfil,idCliente) VALUES (?, ?, ? ,?)";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setString(1, usuario.getUsername());
            statement.setString(2, usuario.getPassword());
            statement.setString(3, usuario.getPerfil());
            statement.setInt(4, usuario.getIdCliente());
            statement.executeUpdate();
            statement.close();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public ArrayList<Usuario> obtenerUsuarios() {

        ArrayList<Usuario> usuarios = null;
        try {
            String query = "SELECT * FROM usuarios";
            connection = new Conexion().getConexion();

            statement = connection.prepareStatement(query);
            resultSet = statement.executeQuery();
            usuarios = new ArrayList<>();

            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String username = resultSet.getString("username");
                String password = resultSet.getString("password");
                String perfil = resultSet.getString("perfil");
                boolean estado = resultSet.getBoolean("estado");
                Usuario usuario = new Usuario(id, username, password, perfil, estado);
                usuarios.add(usuario);
            }

            return usuarios;

        } catch (SQLException ex) {
            System.out.println(ex.getMessage());
        }

        return usuarios;

    }

    public Usuario buscarUsuario(int idUsuario) {
        Usuario usuario = null;

        try {
            // Preparar la consulta SQL
            String query = "SELECT * FROM usuarios WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, idUsuario);

            // Ejecutar la consulta
            resultSet = statement.executeQuery();

            // Verificar si se encontró un usuario
            if (resultSet.next()) {
                int id = resultSet.getInt("id");
                String username = resultSet.getString("username");
                String password = resultSet.getString("password");
                String perfil = resultSet.getString("perfil");
                boolean estado = resultSet.getBoolean("estado");

                usuario = new Usuario(id, username, password, perfil, estado);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            // Cerrar las conexiones y liberar los recursos
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    e.getMessage();
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.getMessage();
                }
            }
        }

        return usuario;
    }

    public void modificarUsuario(Usuario usuario) {
        try {
            // Preparar la consulta SQL
            String query = "UPDATE usuarios SET username = ?, password = ? , perfil = ? , estado = ? WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setString(1, usuario.getUsername());
            statement.setString(2, usuario.getPassword());
            statement.setString(3, usuario.getPerfil());
            statement.setBoolean(4, usuario.isActivo());
            statement.setInt(5, usuario.getId());

            // Ejecutar la consulta
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            // Cerrar las conexiones y liberar los recursos
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.getMessage();
                }
            }
        }
    }

    public void eliminarUsuario(int usuarioId) {
        try {
            // Preparar la consulta SQL
            String query = "DELETE FROM usuarios WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, usuarioId);

            // Ejecutar la consulta
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            // Cerrar las conexiones y liberar los recursos
            if (statement != null) {
                try {
                    statement.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    System.out.println(e.getMessage());
                }
            }
        }
    }

    public void desabilitarUsuario(int idUsuario) {
        try {
            // Preparar la consulta SQL para actualizar el estado del usuario
            String query = "UPDATE usuarios SET estado = 0 WHERE id = ?";
            connection = new Conexion().getConexion();
            statement = connection.prepareStatement(query);
            statement.setInt(1, idUsuario);

            // Ejecutar la consulta
            statement.executeUpdate();

            // Cerrar la conexión y liberar recursos
            statement.close();
            connection.close();
        } catch (SQLException e) {
            System.out.println("Error al actualizar el estado del usuario: " + e.getMessage());
        }
    }

}
