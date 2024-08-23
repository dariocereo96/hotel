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
    ArrayList<Cliente> clientes = new ClienteDAO().getClientes();

    // Crear el documento PDF
    Document document = new Document(PageSize.A4.rotate());
    PdfWriter.getInstance(document, response.getOutputStream());

    // Abrir el documento
    document.open();

    // Agregar el encabezado
    Paragraph encabezado = new Paragraph("Clientes", new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD));
    encabezado.setAlignment(Element.ALIGN_CENTER);
    document.add(encabezado);
    document.add(new Paragraph("\n"));

    // Crear una tabla para mostrar los datos de las habitaciones
    PdfPTable table = new PdfPTable(6);
    table.setWidthPercentage(100);

    // Agregar las cabeceras de la tabla
    PdfPCell header1 = new PdfPCell(new Paragraph("Codigo Cliente"));
    PdfPCell header2 = new PdfPCell(new Paragraph("Nombres"));
    PdfPCell header3 = new PdfPCell(new Paragraph("Tipo documento"));
    PdfPCell header4 = new PdfPCell(new Paragraph("Numero documento"));
    PdfPCell header5 = new PdfPCell(new Paragraph("Correo"));
    PdfPCell header6 = new PdfPCell(new Paragraph("Telefono"));

    table.addCell(header1);
    table.addCell(header2);
    table.addCell(header3);
    table.addCell(header4);
    table.addCell(header5);
    table.addCell(header6);

    // Agregar los datos de las clientes a la tabla
    for (Cliente cliente : clientes) {
        table.addCell(String.valueOf(cliente.getId()));
        table.addCell(cliente.getNombreCompleto());
        table.addCell(cliente.getTipoDocumento());
        table.addCell(cliente.getNumeroDocumento());
        table.addCell(cliente.getCorreo());
        table.addCell(cliente.getTelefono());
    }

    // Agregar la tabla al documento
    document.add(table);

    // Cerrar el documento
    document.close();
%>
