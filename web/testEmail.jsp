<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    System.out.println("=== TEST EMAIL JSP EJECUTADO ===");
    System.out.println("Request method: " + request.getMethod());
    
    try {
        System.out.println("Intentando importar SendMail...");
        %><%@page import="cepp.genericos.SendMail"%><%
        System.out.println("SendMail importado correctamente");
        
        System.out.println("Intentando leer variables de entorno...");
        String emailFrom = System.getenv("EmailFrom");
        String emailTo = System.getenv("EmailTo");
        String contrasenia = System.getenv("Contrasenia");
        
        System.out.println("EmailFrom: " + (emailFrom != null ? emailFrom : "NO ENCONTRADO"));
        System.out.println("EmailTo: " + (emailTo != null ? emailTo : "NO ENCONTRADO"));
        System.out.println("Contrasenia: " + (contrasenia != null ? "***" : "NO ENCONTRADO"));
        
        System.out.println("Intentando leer PropiedadesINI...");
        %><%@page import="cepp.genericos.PropiedadesINI"%><%
        System.out.println("PropiedadesINI importado correctamente");
        
        System.out.println("Intentando leer propiedad EmailFrom...");
        String propEmailFrom = PropiedadesINI.getPropiedad("EmailFrom");
        System.out.println("EmailFrom leído: " + propEmailFrom);
        
    } catch (Exception e) {
        System.out.println("ERROR EN TEST: " + e.getMessage());
        e.printStackTrace();
        %><h1>Error: <%= e.getMessage() %></h1><%
    }
%>
<h1>Test Email JSP</h1>
<p>Revisa los logs del servidor</p>

