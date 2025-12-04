<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%
    System.out.println("=== TEST EMAIL JSP EJECUTADO ===");
    System.out.println("Request method: " + request.getMethod());
    
    String errorMsg = null;
    String successMsg = null;
    String stackTrace = null;
    
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
        
        // INTENTAR ENVIAR EMAIL DE PRUEBA
        System.out.println("=== INTENTANDO ENVIAR EMAIL DE PRUEBA ===");
        try {
            SendMail.EnviadorMail("Test desde CEPP", "Este es un email de prueba desde ceppuy.com");
            successMsg = "✅ Email enviado exitosamente!";
            System.out.println("✅ Email enviado exitosamente!");
        } catch (Exception emailEx) {
            errorMsg = "❌ Error al enviar email: " + emailEx.getMessage();
            System.out.println("ERROR al enviar email: " + emailEx.getMessage());
            emailEx.printStackTrace();
            
            // Capturar stack trace completo
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            emailEx.printStackTrace(pw);
            stackTrace = sw.toString();
        }
        
    } catch (Exception e) {
        errorMsg = "❌ Error en test: " + e.getMessage();
        System.out.println("ERROR EN TEST: " + e.getMessage());
        e.printStackTrace();
        
        // Capturar stack trace completo
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        stackTrace = sw.toString();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Email - CEPP</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .container { max-width: 800px; margin: 0 auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        h1 { color: #333; }
        .success { background: #d4edda; color: #155724; padding: 15px; border-radius: 4px; margin: 10px 0; }
        .error { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 4px; margin: 10px 0; }
        .info { background: #d1ecf1; color: #0c5460; padding: 15px; border-radius: 4px; margin: 10px 0; }
        pre { background: #f4f4f4; padding: 15px; border-radius: 4px; overflow-x: auto; font-size: 12px; }
        .var { margin: 5px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🧪 Test de Envío de Email</h1>
        
        <div class="info">
            <h3>Variables de Entorno:</h3>
            <div class="var"><strong>EmailFrom:</strong> <%= System.getenv("EmailFrom") != null ? System.getenv("EmailFrom") : "❌ NO CONFIGURADO" %></div>
            <div class="var"><strong>EmailTo:</strong> <%= System.getenv("EmailTo") != null ? System.getenv("EmailTo") : "❌ NO CONFIGURADO" %></div>
            <div class="var"><strong>Contrasenia:</strong> <%= System.getenv("Contrasenia") != null ? "✅ Configurada" : "❌ NO CONFIGURADO" %></div>
        </div>
        
        <% if (successMsg != null) { %>
            <div class="success">
                <h3>✅ Éxito</h3>
                <p><%= successMsg %></p>
            </div>
        <% } %>
        
        <% if (errorMsg != null) { %>
            <div class="error">
                <h3>❌ Error</h3>
                <p><%= errorMsg %></p>
                <% if (stackTrace != null) { %>
                    <details>
                        <summary style="cursor: pointer; margin-top: 10px;"><strong>Ver detalles técnicos (click para expandir)</strong></summary>
                        <pre><%= stackTrace %></pre>
                    </details>
                <% } %>
            </div>
        <% } %>
        
        <div class="info" style="margin-top: 20px;">
            <p><strong>Nota:</strong> Revisa también los logs del servidor para más detalles.</p>
        </div>
    </div>
</body>
</html>

