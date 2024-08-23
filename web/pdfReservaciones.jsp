<%@page import="Modelos.HabitacionDAO"%>
<%@page import="Modelos.ReservacionDAO"%>
<%@page import="Modelos.Reservacion"%>
<%@page import="com.itextpdf.text.Font"%>
<%@page import="Modelos.ClienteDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Cliente"%>
<%@page import="Modelos.Cliente"%>
<%@ page import="com.itextpdf.text.Document" %>
<%@ page import="com.itextpdf.text.Element" %>
<%@ page import="com.itextpdf.text.PageSize" %>
<%@ page import="com.itextpdf.text.Paragraph" %>
<%@ page import="com.itextpdf.text.pdf.PdfPCell" %>
<%@ page import="com.itextpdf.text.pdf.PdfPTable" %>
<%@ page import="com.itextpdf.text.pdf.PdfWriter" %>
<%@ page contentType="application/pdf" %>
<%@ page language="java" %>
<%
    // Obtener la lista de habitaciones desde el objeto request
    ArrayList<Reservacion> reservaciones = new ReservacionDAO().getReservaciones();

    // Crear el documento PDF
    Document document = new Document(PageSize.A4.rotate());
    PdfWriter.getInstance(document, response.getOutputStream());

    // Abrir el documento
    document.open();

    // Agregar el encabezado
    Paragraph encabezado = new Paragraph("Reservaciones", new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD));
    encabezado.setAlignment(Element.ALIGN_CENTER);
    document.add(encabezado);
    document.add(new Paragraph("\n"));

    // Crear una tabla para mostrar los datos de las habitaciones
    PdfPTable table = new PdfPTable(6);
    table.setWidthPercentage(100);

    // Agregar las cabeceras de la tabla
    PdfPCell header1 = new PdfPCell(new Paragraph("Cod."));
    PdfPCell header2 = new PdfPCell(new Paragraph("Nombre cliente"));
    PdfPCell header3 = new PdfPCell(new Paragraph("Cedula"));
    PdfPCell header4 = new PdfPCell(new Paragraph("Habitacion"));
    PdfPCell header5 = new PdfPCell(new Paragraph("Precio"));
    PdfPCell header6 = new PdfPCell(new Paragraph("Tiempo de estadia"));
    
    table.addCell(header1);
    table.addCell(header2);
    table.addCell(header3);
    table.addCell(header4);
    table.addCell(header5);
    table.addCell(header6);
    

    // Agregar los datos de las clientes a la tabla
    for (Reservacion reservacion : reservaciones) {
        table.addCell(String.valueOf(reservacion.getId()));
        table.addCell(new ClienteDAO().buscarCliente(reservacion.getIdCliente()).getNombreCompleto());
        table.addCell(new ClienteDAO().buscarCliente(reservacion.getIdCliente()).getNumeroDocumento());
        table.addCell(String.valueOf(new HabitacionDAO().buscarHabitacion(reservacion.getIdHabitacion()).getId()));
        table.addCell(String.valueOf(new HabitacionDAO().buscarHabitacion(reservacion.getIdHabitacion()).getPrecioNoche()));
        table.addCell(String.valueOf(reservacion.duracion()));
    }

    // Agregar la tabla al documento
    document.add(table);

    // Cerrar el documento
    document.close();
%>
