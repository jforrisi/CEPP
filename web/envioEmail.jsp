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
    
    System.out.println("viene aca");

    try
    {        
    System.out.println("pasa");
        //Obtengo parametros
        if(request.getParameter("xNombre")!=null) nombre = request.getParameter("xNombre");
        if(request.getParameter("xEmail")!=null)email = request.getParameter("xEmail");
        if(request.getParameter("xMensaje")!=null) mensaje = request.getParameter("xMensaje");
        if(request.getParameter("xTelefono")!=null) telefono = request.getParameter("xTelefono");
        if(request.getParameter("xAsunto")!=null) asuntoEnvio = request.getParameter("xAsunto");
        if(request.getParameter("xTipoEmail")!=null) xTipoEmail = request.getParameter("xTipoEmail");
                
        
        System.out.println("el email que viene es"+email);
        
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
            
            xMensaje = "Mensaje perteneciente a la pagina de cepp.com, en la seccion de contacto.\n "
                    + "\n Asunto: "+asuntoEnvio
                    + "\n Envia: "+nombre
                    + "\n Email: "+email 
                    + "\n Telefono: "+telefono 
                    + "\n Mensaje: "+mensaje;                  

            SendMail.EnviadorMail(asunto, xMensaje);
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
        }                        
    }
    catch(Exception ex)
    {
        %><script>
            javascript: showMensaje('Mensaje no enviado, verifique sus datos', 'error');
        </script><%
    }
%>

