/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Modelos;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

/**
 *
 * @author HP
 */
public class Reservacion {

    private int id;
    private int idCliente;
    private int idHabitacion;
    private String fechaInicio;
    private String fechaFin;
    private int idHabitacionAnterior;
    private int ocupantes;

    public Reservacion(int id, int idCliente, int idHabitacion, String fechaInicio, String fechaFin, int ocupantes) {
        this.id = id;
        this.idCliente = idCliente;
        this.idHabitacion = idHabitacion;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.ocupantes = ocupantes;
    }

    public int getIdHabitacionAnterior() {
        return idHabitacionAnterior;
    }

    public void setIdHabitacionAnterior(int idHabitacionAnterior) {
        this.idHabitacionAnterior = idHabitacionAnterior;
    }

    public Reservacion(int idCliente, int idHabitacion, String fechaInicio, String fechaFin, int ocupantes) {
        this.idCliente = idCliente;
        this.idHabitacion = idHabitacion;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.ocupantes = ocupantes;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public int getIdHabitacion() {
        return idHabitacion;
    }

    public void setIdHabitacion(int idHabitacion) {
        this.idHabitacion = idHabitacion;
    }

    public String getFechaInicio() {
        return fechaInicio;
    }

    public void setFechaInicio(String fechaInicio) {
        this.fechaInicio = fechaInicio;
    }

    public String getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(String fechaFin) {
        this.fechaFin = fechaFin;
    }

    public int getOcupantes() {
        return ocupantes;
    }

    public void setOcupantes(int ocupantes) {
        this.ocupantes = ocupantes;
    }

    @Override
    public String toString() {
        return "Reservacion{" + "idCliente=" + idCliente + ", idHabitacion=" + idHabitacion + ", fechaInicio=" + fechaInicio + ", fechaFin=" + fechaFin + '}';
    }

    public long duracion() {
        // Convertir las cadenas en objetos LocalDate
        LocalDate inicio = LocalDate.parse(fechaInicio);
        LocalDate fin = LocalDate.parse(fechaFin);

        // Calcular la diferencia en días
        long dias = ChronoUnit.DAYS.between(inicio, fin);

        return dias;

    }

}
