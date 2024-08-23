package Modelos;

/**
 *
 * @author HP
 */
public class Usuario {

    private int id;
    private String username;
    private String password;
    private String perfil;
    private boolean activo;
    private int idCliente;

    public Usuario(String username, String password, String perfil) {
        this.username = username;
        this.password = password;
        this.perfil = perfil;
    }

    public Usuario(String username, String password, String perfil, boolean activo) {
        this.username = username;
        this.password = password;
        this.perfil = perfil;
        this.activo = activo;
    }

    public Usuario(int id, String username, String password, String perfil, boolean activo) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.perfil = perfil;
        this.activo = activo;
    }

    public Usuario(String username, String password, String perfil, int idCliente) {
        this.username = username;
        this.password = password;
        this.perfil = perfil;
        this.idCliente = idCliente;
    }

    public Usuario(int id, String username, String password, String perfil) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.perfil = perfil;
    }

    public Usuario(int id, String username, String password, String perfil, int idCliente) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.perfil = perfil;
        this.idCliente = idCliente;
    }

    public Usuario(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPerfil() {
        return perfil;
    }

    public void setPerfil(String perfil) {
        this.perfil = perfil;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }

    @Override
    public String toString() {
        return "Usuario{" + "id=" + id + ", username=" + username + ", password=" + password + ", perfil=" + perfil + ", idCliente=" + idCliente + '}';
    }

}
