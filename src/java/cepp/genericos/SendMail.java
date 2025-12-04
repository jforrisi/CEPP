package cepp.genericos;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
import javax.mail.*;
import javax.mail.internet.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;

/**
 *
 * @author patricio
 */
public class SendMail {

    public static void EnviadorMail(String asunto, String cuerpo) throws Exception {

        try {
            System.out.println("Iniciando envío de email...");
            // Obtener las propiedades del correo
            System.out.println("Leyendo EmailFrom...");
            final String xEmailDesde = PropiedadesINI.getPropiedad("EmailFrom");
            System.out.println("EmailFrom leído: " + xEmailDesde);
            
            System.out.println("Leyendo EmailTo...");
            final String xEmailTo = PropiedadesINI.getPropiedad("EmailTo");
            System.out.println("EmailTo leído: " + xEmailTo);
            
            System.out.println("Leyendo Contrasenia...");
            final String xContrasena = PropiedadesINI.getPropiedad("Contrasenia");
            System.out.println("Contrasenia leída: ***");
            
            // Validar que las propiedades no estén vacías
            if (xEmailDesde == null || xEmailDesde.trim().isEmpty()) {
                throw new Exception("EmailFrom no configurado. Configura la variable de entorno EmailFrom o el archivo CEPP.ini");
            }
            if (xEmailTo == null || xEmailTo.trim().isEmpty()) {
                throw new Exception("EmailTo no configurado. Configura la variable de entorno EmailTo o el archivo CEPP.ini");
            }
            if (xContrasena == null || xContrasena.trim().isEmpty()) {
                throw new Exception("Contrasenia no configurado. Configura la variable de entorno Contrasenia o el archivo CEPP.ini");
            }

            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true"); // Usar STARTTLS en lugar de SSL
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587"); // Usar puerto 587 para STARTTLS

            // Crear sesión con autenticación
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(xEmailDesde, xContrasena);
                }
            });

            // Crear el mensaje
            MimeMessage msg = new MimeMessage(session);

            // Configurar el remitente con nombre
            String nombreRemitente = "PAGINA DE CEPP";
            msg.setFrom(new InternetAddress(xEmailDesde, nombreRemitente));

            // Configurar destinatario y contenido
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(xEmailTo));
            msg.setSubject(asunto);
            msg.setText(cuerpo);

            // Enviar el mensaje
            Transport.send(msg);
            System.out.println("Email enviado con éxito");
        } catch (Exception mex) {
            System.out.println("Exception en EnviadorMail: " + mex.getMessage());
            mex.printStackTrace();
            Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, mex);
            // Relanzar la excepción para que se maneje en el JSP
            throw new Exception("Error al enviar email: " + mex.getMessage(), mex);
        }
    
    }
    
    public static void EnviadorMailAdjunto(String asunto, String cuerpo,String xNombreAdjunto) {

        try {
            
            String xEmailDesde=PropiedadesINI.getPropiedad("EmailFrom");
            String xContrasena=PropiedadesINI.getPropiedad("Contrasenia");
            String xEmailTo=PropiedadesINI.getPropiedad("EmailTo");
            
            Properties props = new Properties();
            props.put("mail.smtp.user", xEmailDesde);
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.socketFactory.fallback", "false");

            Session session = Session.getInstance(props,
                    new javax.mail.Authenticator() {
                        
                protected PasswordAuthentication getPasswordAuthentication() {
                        
                    try {
                        String xEmailDesde=PropiedadesINI.getPropiedad("EmailFrom");
                        String xContrasena=PropiedadesINI.getPropiedad("Contrasenia");
                        
                        return new PasswordAuthentication(xEmailDesde, xContrasena);
                    } catch (Exception ex) {
                        Logger.getLogger(SendMail.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    return null;
                }
            });                        

            System.out.println("arma el texto");
            // Se compone la parte del texto
            BodyPart texto = new MimeBodyPart();
            texto.setText(cuerpo);

            System.out.println("arma el adjunto");
            // Se compone el adjunto con la imagen
            BodyPart adjunto = new MimeBodyPart();
            adjunto.setDataHandler(new DataHandler(new FileDataSource(PropiedadesINI.getPropiedad("DIRREPSTEMP")+xNombreAdjunto)));
            
            adjunto.setFileName(PropiedadesINI.getPropiedad("DIRREPSTEMP")+xNombreAdjunto);

            System.out.println("arma uniendo todo");
            // Una MultiParte para agrupar texto e imagen.
            MimeMultipart multiParte = new MimeMultipart();
            multiParte.addBodyPart(texto);
            multiParte.addBodyPart(adjunto);

            System.out.println("envia todo");
            // Se compone el correo, dando to, from, subject y el
            // contenido.
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(xEmailDesde));
            message.addRecipient(Message.RecipientType.TO,new InternetAddress(xEmailTo));
            message.setSubject(asunto);
            message.setContent(multiParte);

            System.out.println("antes de que envie");
            // Se envia el correo.
            Transport t = session.getTransport("smtp");
            t.connect(xEmailDesde, xContrasena);
            t.sendMessage(message, message.getAllRecipients());
            t.close();                              
            System.out.println("Mensaje con adjunto enviado satisfactoriamente");
        } catch (Exception mex) {
            System.out.println("Exception" + mex);
//            mex.printStackTrace();
        }
    }

    public static void sendMail(String xEmail, String xText, String xSubject) throws Exception {

        try {

            System.out.println("xEmail = " + xEmail);

//        String serverMail=FuncionesIni.getPropiedad("SERVER_MAIL");
            String serverMail = "smtp.gmail.com";
//        String fromMail=FuncionesIni.getPropiedad("FROM_MAIL");
            String fromMail = "patoppatoppatop@gmail.com";
            System.out.println("viene 1");

//        String fromMail=FuncionesIni.getPropiedad("patricio.paulino@gsoft.com.uy");
//        String userNameMail=FuncionesIni.getPropiedad("USERNAME_MAIL");
            String userNameMail = "patoppatoppatop@gmail.com";
//        String userNameMail=FuncionesIni.getPropiedad("patricio.paulino@gsoft.com.uy");

            System.out.println("viene 2");
//        String passwordMail=FuncionesIni.getPropiedad("PASSWORD_MAIL");
            String passwordMail = "reoreoreo";
//        String tlsMail=FuncionesIni.getPropiedad("TLS_MAIL");
            String tlsMail = "S";
//        String connectMail=FuncionesIni.getPropiedad("CONNECT_MAIL");
            String connectMail = "S";

            System.out.println("viene 3");
//        xEmail="patoppatoppatop@gmail.com";

//public Send(String from, String to, String subject, String text, String fileAttachement, String server, String username, String password, String tls, String xConnect, String xHtml) {
//        public Send(String from, String to, String subject, String text, String fileAttachement, String server, String username, String password, String tls, String xConnect, String xHtml) {
//        Send smtp = new Send(xEmail, fromMail, xSubject, xText, "", serverMail, userNameMail, passwordMail, tlsMail, connectMail, "");
//        Send smtp = new Send(xEmail, fromMail, xSubject, xText, "", serverMail, userNameMail, passwordMail, tlsMail, connectMail, "");
            Send smtp = new Send("patoppatoppatop@gmail.com", "patoppatoppatop@gmail.com", xSubject, xText, "", serverMail, userNameMail, passwordMail, tlsMail, connectMail, "");
            smtp.send();

            System.out.println("envio correctamente");
        } catch (Exception ex) {
            System.out.println("Exception--" + ex);
//            %><script>
//                javascript: showMensaje('Mensaje no enviado, verifique sus datos', 'error');
//            </script><%
            //        System.out.println("Exce");
            //        System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
        }

    }

//    public static void sendMailHTML(String xEmail, String xHtml, String xSubject) throws Exception {
//        System.out.println("xEmail = " + xEmail);
//
//        String serverMail = FuncionesIni.getPropiedad("SERVER_MAIL");
//        String fromMail = FuncionesIni.getPropiedad("FROM_MAIL");
//        String userNameMail = FuncionesIni.getPropiedad("USERNAME_MAIL");
//        String passwordMail = FuncionesIni.getPropiedad("PASSWORD_MAIL");
//        String tlsMail = FuncionesIni.getPropiedad("TLS_MAIL");
//        String connectMail = FuncionesIni.getPropiedad("CONNECT_MAIL");
//
//        Send smtp = new Send(fromMail, xEmail, xSubject, "", "", serverMail, userNameMail, passwordMail, tlsMail, connectMail, xHtml);
//        smtp.sendHTML();
//    }
}
