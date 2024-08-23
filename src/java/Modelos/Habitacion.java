/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

/**
 *
 * @author HP
 */
public class Habitacion {

    private int id;
    private int capacidad;
    private String tipo;
    private double precioNoche;
    private boolean disponible;
    private String imagen;

    public Habitacion(int id, int capacidad, String tipo, double precioNoche, boolean disponible, String imagen) {
        this.id = id;
        this.capacidad = capacidad;
        this.tipo = tipo;
        this.precioNoche = precioNoche;
        this.disponible = disponible;
        this.imagen = imagen;
    }

    public Habitacion(int capacidad, String tipo, double precioNoche, boolean disponible, String imagen) {
        this.capacidad = capacidad;
        this.tipo = tipo;
        this.precioNoche = precioNoche;
        this.disponible = disponible;
        this.imagen = imagen;
    }

    public Habitacion(int id, int capacidad, String tipo, double precioNoche, boolean disponible) {
        this.id = id;
        this.capacidad = capacidad;
        this.tipo = tipo;
        this.precioNoche = precioNoche;
        this.disponible = disponible;
    }
    
     public Habitacion(int capacidad, String tipo, double precioNoche, boolean disponible) {
        this.capacidad = capacidad;
        this.tipo = tipo;
        this.precioNoche = precioNoche;
        this.disponible = disponible;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCapacidad() {
        return capacidad;
    }

    public void setCapacidad(int capacidad) {
        this.capacidad = capacidad;
    }

    public double getPrecioNoche() {
        return precioNoche;
    }

    public void setPrecioNoche(double precioNoche) {
        this.precioNoche = precioNoche;
    }

    public boolean isDisponible() {
        return disponible;
    }

    public void setDisponible(boolean disponible) {
        this.disponible = disponible;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    @Override
    public String toString() {
        return "Habitacion{" + "id=" + id + ", capacidad=" + capacidad + ", tipo=" + tipo + ", precioNoche=" + precioNoche + ", disponible=" + disponible + '}';
    }

    public String getDatoHabitacion() {
        return "N°: " + this.getId() + " " + this.tipo + " Valor " + this.precioNoche + " el dia" + " Capacidad " + capacidad;
    }

}
