<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="cepp.genericos.SendMail"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.StringWriter"%>
<%
    // Logging inicial
    System.out.println("=== INICIO envioEmail.jsp ===");
    
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
        SendMail.EnviadorMail(asunto, cuerpoEmail.toString());
        System.out.println("Email enviado exitosamente");
        
        // Mostrar mensaje de éxito
%>
<script>
    var messageElement = document.getElementById("message");
    messageElement.style.display = "block";
    messageElement.classList.remove("error_message");
    messageElement.classList.add("succes_message");
    
    // Mensaje elegante y destacado
    messageElement.innerHTML = '<div style="background: linear-gradient(135deg, #28a745 0%, #20c997 100%); color: white; padding: 20px 25px; border-radius: 8px; box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3); margin: 15px 0; text-align: center; animation: slideIn 0.3s ease-out;">' +
        '<div style="font-size: 48px; margin-bottom: 10px;">✓</div>' +
        '<div style="font-size: 20px; font-weight: 600; margin-bottom: 8px; letter-spacing: 0.5px;">¡Mensaje enviado exitosamente!</div>' +
        '<div style="font-size: 15px; opacity: 0.95; line-height: 1.5;">Tu mensaje ha sido recibido y nos contactaremos contigo a la brevedad.</div>' +
        '</div>' +
        '<style>@keyframes slideIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }</style>';
    
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
        System.err.println("ERROR en envioEmail.jsp: " + ex.getMessage());
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

