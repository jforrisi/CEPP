<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : envioEmail
    Created on : 09-may-2019, 21:50:53
    Author     : Patricio Paulino
--%>

<%@page import="cepp.genericos.SendMail"%>

<%
    String nombre = "";
    String email = "";
    String asunto = "Mensaje de la pagina de Agroayui";
    String mensaje = "";    
    String asuntoEnvio = "";    
    String telefono = "";   
    String xTipoEmail="N";
    String xMensaje="";
    
    System.out.println("=== INICIO envioEmail.jsp ===");
    System.out.println("Request method: " + request.getMethod());
    System.out.println("Content type: " + request.getContentType());

    try
    {        
        System.out.println("Entrando al try block...");
        //Obtengo parametros
        System.out.println("Leyendo parámetros...");
        if(request.getParameter("xNombre")!=null) nombre = request.getParameter("xNombre");
        if(request.getParameter("xEmail")!=null)email = request.getParameter("xEmail");
        if(request.getParameter("xMensaje")!=null) mensaje = request.getParameter("xMensaje");
        if(request.getParameter("xTelefono")!=null) telefono = request.getParameter("xTelefono");
        if(request.getParameter("xAsunto")!=null) asuntoEnvio = request.getParameter("xAsunto");
        if(request.getParameter("xTipoEmail")!=null) xTipoEmail = request.getParameter("xTipoEmail");
                
        System.out.println("Parámetros leídos:");
        System.out.println("  - nombre: " + nombre);
        System.out.println("  - email: " + email);
        System.out.println("  - telefono: " + telefono);
        System.out.println("  - asunto: " + asuntoEnvio);
        System.out.println("  - xTipoEmail: " + xTipoEmail);
        
        if(xTipoEmail.equals("N")){
            
            xMensaje = "Mensaje perteneciente a la pagina de agroayui.com, en la seccion de compras y ventas.\n"
                    + " El email ingresado fue el siguiente: " + email;
            
            SendMail.EnviadorMail(asunto, xMensaje);
            
%>
            <script>
                document.getElementById("mensaje").style.display = "block";
                var element = document.getElementById("mensaje");
                element.classList.remove("error_message");
                element.classList.add("succes_message");
                document.getElementById("mensaje").innerHTML = "Email enviado satisfactoriamente!";            

                $('#emailNewsletter').val('');
            </script>
<%
        }else if(xTipoEmail.equals("M")){
            
            System.out.println("Procesando email tipo M (contacto)...");
            xMensaje = "Mensaje perteneciente a la pagina de cepp.com, en la seccion de contacto.\n "
                    + "\n Asunto: "+asuntoEnvio
                    + "\n Envia: "+nombre
                    + "\n Email: "+email 
                    + "\n Telefono: "+telefono 
                    + "\n Mensaje: "+mensaje;                  

            System.out.println("Mensaje construido, llamando a SendMail.EnviadorMail()...");
            try {
                SendMail.EnviadorMail(asunto, xMensaje);
                System.out.println("Email enviado exitosamente!");
%>
            <script>

                document.getElementById("message").style.display = "block";
                var element = document.getElementById("message");
                element.classList.remove("error_message");
                element.classList.add("succes_message");
                document.getElementById("message").innerHTML = "Mensaje enviado con exito!";                                   

                $('#name').val('');
                $('#email').val('');
                $('#subject').val('');
                $('#phone').val('');
                $('#comments').val('');
            </script>
<%
            } catch (Exception emailEx) {
                System.out.println("ERROR en try interno de SendMail: " + emailEx.getMessage());
                System.out.println("Stack trace:");
                emailEx.printStackTrace();
                throw emailEx; // Relanzar para que se capture en el catch general
            }
<%
        }                        
    }
    catch(Exception ex)
    {
        // Log del error para debugging
        System.out.println("=== ERROR CAPTURADO en envioEmail.jsp ===");
        System.out.println("Mensaje: " + ex.getMessage());
        System.out.println("Tipo de excepción: " + ex.getClass().getName());
        System.out.println("Stack trace completo:");
        ex.printStackTrace();
        System.out.println("=== FIN ERROR ===");
        
        %><script>
            var errorMsg = 'Mensaje no enviado. ';
            <% if (ex.getMessage() != null && ex.getMessage().contains("no configurado")) { %>
                errorMsg += 'Error de configuración: <%= ex.getMessage() %>';
            <% } else { %>
                errorMsg += 'Verifique sus datos o contacte al administrador.';
            <% } %>
            document.getElementById("message").style.display = "block";
            var element = document.getElementById("message");
            element.classList.remove("succes_message");
            element.classList.add("error_message");
            element.innerHTML = errorMsg;
        </script><%
    }
%>

