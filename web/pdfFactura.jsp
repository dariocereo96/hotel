<%@page import="com.itextpdf.text.Font"%>
<%@page import="Modelos.ReservacionDAO"%>
<%@page import="Modelos.Reservacion"%>
<%@page import="Modelos.ClienteDAO"%>
<%@page import="Modelos.Cliente"%>
<%@page import="Modelos.Cliente"%>
<%@page import="Modelos.FacturaDAO"%>
<%@page import="Modelos.Factura"%>
<%@page import="Modelos.HabitacionDAO"%>
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
    Factura factura = new FacturaDAO().buscarFactura(Integer.parseInt(request.getParameter("idFactura")));
    Reservacion reservacion = new ReservacionDAO().buscarReservacionCliente(factura.getIdCliente());
    Cliente cliente = new ClienteDAO().buscarCliente(factura.getIdCliente());
    Habitacion habitacion = new HabitacionDAO().buscarHabitacion(reservacion.getIdHabitacion());

    // Crear el documento PDF
    Document document = new Document(PageSize.A4);
    PdfWriter.getInstance(document, response.getOutputStream());

    // Abrir el documento
    document.open();

    // Agregar el encabezado
    Paragraph encabezado = new Paragraph("Factura", new Font(Font.FontFamily.HELVETICA, 24, Font.BOLD));
    encabezado.setAlignment(Element.ALIGN_CENTER);
    document.add(encabezado);
    document.add(new Paragraph("\n"));

    // Crear una tabla para mostrar los datos del cliente
    PdfPTable tablaCli = new PdfPTable(2);
    tablaCli.setWidthPercentage(100);

    tablaCli.addCell("Nombre");
    tablaCli.addCell(cliente.getNombreCompleto());

    tablaCli.addCell("Tipo documeto");
    tablaCli.addCell(cliente.getTipoDocumento());

    tablaCli.addCell("Numero documento");
    tablaCli.addCell(cliente.getNumeroDocumento());

    tablaCli.addCell("Telefono");
    tablaCli.addCell(cliente.getTelefono());

    tablaCli.addCell("Correo");
    tablaCli.addCell(cliente.getCorreo());

    tablaCli.addCell("Fecha emision");
    tablaCli.addCell(factura.getFecha());
    
    tablaCli.addCell("Tipo de pago");
    tablaCli.addCell(factura.getTipoPago().toUpperCase());

    document.add(tablaCli);
    /*
    Paragraph datosCliente = new Paragraph();
    datosCliente.add("Nombre: " + cliente.getNombreCompleto() + "\n");
    datosCliente.add("Tipo documento: " + cliente.getTipoDocumento() + "\n");
    datosCliente.add("Numero: " + cliente.getTipoDocumento() + "\n");
    datosCliente.add("Correo: " + cliente.getCorreo() + "\n");
    datosCliente.add("Teléfono: " + cliente.getTelefono() + "\n");
    document.add(datosCliente);
     */

    //Detalle
    Paragraph detalle = new Paragraph("Detalle: ", new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD));
    document.add(detalle);
    document.add(new Paragraph("\n"));

    // Crear una tabla para mostrar los datos de las habitaciones
    PdfPTable table = new PdfPTable(4);
    table.setWidthPercentage(100);

    // Agregar las cabeceras de la tabla
    PdfPCell header1 = new PdfPCell(new Paragraph("CODIDO"));
    PdfPCell header2 = new PdfPCell(new Paragraph("DESCRIPCION"));
    PdfPCell header3 = new PdfPCell(new Paragraph("CANTIDAD"));
    PdfPCell header4 = new PdfPCell(new Paragraph("PRECIO"));

    table.addCell(header1);
    table.addCell(header2);
    table.addCell(header3);
    table.addCell(header4);

    table.addCell(String.valueOf(habitacion.getId()));
    table.addCell(String.valueOf(habitacion.getDatoHabitacion()));
    table.addCell(String.valueOf(reservacion.duracion()));
    table.addCell(String.valueOf("$ " + habitacion.getPrecioNoche()));

    // Agregar la tabla al documento
    document.add(table);

    //Detalle
    Paragraph pago = new Paragraph("Pago: ", new Font(Font.FontFamily.HELVETICA, 20, Font.BOLD));
    document.add(pago);
    document.add(new Paragraph("\n"));

    // Crear una tabla para mostrar los datos de las habitaciones 
    PdfPTable tablaPago = new PdfPTable(4);
    tablaPago.setWidthPercentage(100);

    //SUBTOTAL
    tablaPago.addCell("");
    tablaPago.addCell("");
    tablaPago.addCell("SUBTOTAL:");
    tablaPago.addCell("$ " + String.valueOf(factura.getSubtotal()));

    //IVA
    tablaPago.addCell("");
    tablaPago.addCell("");
    tablaPago.addCell("IVA:");
    tablaPago.addCell("$ " + String.valueOf(factura.getIva()));

    //TOTAL
    tablaPago.addCell("");
    tablaPago.addCell("");
    tablaPago.addCell("TOTAL:");
    tablaPago.addCell("$ " + String.valueOf(factura.getTotal()));

    //Agregar la la tabla
    document.add(tablaPago);
    document.add(new Paragraph("\n"));
    // Agregar un mensaje al final
    Paragraph mensajeFinal = new Paragraph("Gracias por su compra. Para cualquier consulta, por favor contáctenos.", new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD));
    document.add(mensajeFinal);
    

    // Cerrar el documento
    document.close();
%>