<%@page import="com.itextpdf.text.Font"%>
<%@page import="Modelos.HabitacionDAO"%>
<%@page import="Modelos.ClienteDAO"%>
<%@page import="Modelos.Cliente"%>
<%@page import="Modelos.Habitacion"%>
<%@page import="java.util.ArrayList"%>
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

    // Obtener la lista de habitaciones desde el atributo de la solicitud
    ArrayList<Habitacion> habitaciones = (ArrayList<Habitacion>) new HabitacionDAO().getHabitaciones();

    // Crear el documento PDF
    Document document = new Document(PageSize.A4);
    PdfWriter.getInstance(document, response.getOutputStream());

    // Abrir el documento
    document.open();

    // Agregar el encabezado
    Paragraph encabezado = new Paragraph("Habitaciones", new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD));
    encabezado.setAlignment(Element.ALIGN_CENTER);
    document.add(encabezado);
    document.add(new Paragraph("\n"));

    // Crear una tabla para mostrar los datos de las habitaciones
    PdfPTable table = new PdfPTable(5);
    table.setWidthPercentage(100);

    // Agregar las cabeceras de la tabla
    PdfPCell header1 = new PdfPCell(new Paragraph("Numero"));
    PdfPCell header2 = new PdfPCell(new Paragraph("Capacidad"));
    PdfPCell header3 = new PdfPCell(new Paragraph("Tipo"));
    PdfPCell header4 = new PdfPCell(new Paragraph("Disponibilidad"));
    PdfPCell header5 = new PdfPCell(new Paragraph("Precio"));

    table.addCell(header1);
    table.addCell(header2);
    table.addCell(header3);
    table.addCell(header4);
    table.addCell(header5);

    // Agregar los datos de las habitaciones a la tabla
    for (Habitacion habitacion : habitaciones) {
        table.addCell(String.valueOf(habitacion.getId()));
        table.addCell(String.valueOf(habitacion.getCapacidad()));
        table.addCell(habitacion.getTipo());
        table.addCell(habitacion.isDisponible() ? "Sí" : "No");
        table.addCell("$ "+String.valueOf(habitacion.getPrecioNoche()));
    }

    // Agregar la tabla al documento
    document.add(table);

    // Cerrar el documento
    document.close();
%>
