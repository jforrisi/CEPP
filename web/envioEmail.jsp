<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cepp.genericos.SendMail"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%
    // Logging inicial
    System.out.println("=== INICIO envioEmailSimple.jsp ===");
    
    String nombre = "";
    String email = "";
    String asunto = "Mensaje desde CEPP";
    String mensaje = "";
    String asuntoEnvio = "";
    String telefono = "";
    String xTipoEmail = "M";
    
    try {
        // Leer parámetros del formulario
        if (request.getParameter("xNombre") != null) {
            nombre = request.getParameter("xNombre").trim();
        }
        if (request.getParameter("xEmail") != null) {
            email = request.getParameter("xEmail").trim();
        }
        if (request.getParameter("xMensaje") != null) {
            mensaje = request.getParameter("xMensaje").trim();
        }
        if (request.getParameter("xTelefono") != null) {
            telefono = request.getParameter("xTelefono").trim();
        }
        if (request.getParameter("xAsunto") != null) {
            asuntoEnvio = request.getParameter("xAsunto").trim();
        }
        if (request.getParameter("xTipoEmail") != null) {
            xTipoEmail = request.getParameter("xTipoEmail").trim();
        }
        
        // Validar campos requeridos
        if (nombre.isEmpty()) {
            throw new Exception("El nombre es requerido");
        }
        if (email.isEmpty()) {
            throw new Exception("El email es requerido");
        }
        if (mensaje.isEmpty()) {
            throw new Exception("El mensaje es requerido");
        }
        
        // Construir mensaje del email
        StringBuilder cuerpoEmail = new StringBuilder();
        cuerpoEmail.append("Nuevo mensaje desde el formulario de contacto de CEPP\n\n");
        cuerpoEmail.append("Asunto: ").append(asuntoEnvio.isEmpty() ? "(Sin asunto)" : asuntoEnvio).append("\n");
        cuerpoEmail.append("Nombre: ").append(nombre).append("\n");
        cuerpoEmail.append("Email: ").append(email).append("\n");
        cuerpoEmail.append("Teléfono: ").append(telefono.isEmpty() ? "(No proporcionado)" : telefono).append("\n");
        cuerpoEmail.append("Mensaje:\n").append(mensaje);
        
        // Enviar email
        System.out.println("Enviando email...");
        SendMail.enviarEmail(asunto, cuerpoEmail.toString());
        System.out.println("Email enviado exitosamente");
        
        // Mostrar mensaje de éxito
%>
<script>
    document.getElementById("message").style.display = "block";
    var element = document.getElementById("message");
    element.classList.remove("error_message");
    element.classList.add("succes_message");
    element.innerHTML = "Mensaje enviado con éxito!";
    
    // Limpiar formulario
    $('#name').val('');
    $('#email').val('');
    $('#subject').val('');
    $('#phone').val('');
    $('#comments').val('');
</script>
<%
    } catch (Exception ex) {
        // Log del error
        System.err.println("ERROR en envioEmailSimple.jsp: " + ex.getMessage());
        ex.printStackTrace();
        
        // Mostrar mensaje de error
        String errorMsg = ex.getMessage();
        if (errorMsg == null || errorMsg.isEmpty()) {
            errorMsg = "Error desconocido al enviar el mensaje";
        }
        // Escapar comillas para JavaScript
        errorMsg = errorMsg.replace("'", "\\'").replace("\n", " ");
%>
<script>
    document.getElementById("message").style.display = "block";
    var element = document.getElementById("message");
    element.classList.remove("succes_message");
    element.classList.add("error_message");
    element.innerHTML = 'Error: <%= errorMsg %>';
    console.error("Error al enviar email:", '<%= errorMsg %>');
</script>
<%
    }
%>

