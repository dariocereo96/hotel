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
public class Factura {

    private int id;
    private String fecha;
    private double subtotal;
    private double iva;
    private double total;
    private int idReservacion;
    private int idCliente;
    private String tipoPago;

    public Factura(String fecha, double subtotal, double iva, double total, int idReservacion, int idCliente, String tipoPago) {
        this.fecha = fecha;
        this.subtotal = subtotal;
        this.iva = iva;
        this.total = total;
        this.idReservacion = idReservacion;
        this.idCliente = idCliente;
        this.tipoPago = tipoPago;
    }

    public Factura(int id, String fecha, double subtotal, double iva, double total, int idReservacion, int idCliente, String tipoPago) {
        this.id = id;
        this.fecha = fecha;
        this.subtotal = subtotal;
        this.iva = iva;
        this.total = total;
        this.idReservacion = idReservacion;
        this.idCliente = idCliente;
        this.tipoPago = tipoPago;
    }

    // Getters y setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getIva() {
        return iva;
    }

    public void setIva(double iva) {
        this.iva = iva;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public int getIdReservacion() {
        return idReservacion;
    }

    public void setIdReservacion(int idReservacion) {
        this.idReservacion = idReservacion;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getTipoPago() {
        return tipoPago;
    }

    public void setTipoPago(String tipoPago) {
        this.tipoPago = tipoPago;
    }

    @Override
    public String toString() {
        return "Factura{" + "id=" + id + ", fecha=" + fecha + ", subtotal=" + subtotal + ", iva=" + iva + ", total=" + total + ", idReservacion=" + idReservacion + ", idCliente=" + idCliente + ", tipoPago=" + tipoPago + '}';
    }

}
