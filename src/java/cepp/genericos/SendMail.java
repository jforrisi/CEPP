package cepp.genericos;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

/**
 * Versión simplificada de envío de emails usando Gmail SMTP
 * Usa las mismas variables de entorno: EmailFrom, EmailTo, Contrasenia
 */
public class SendMail {
    
    /**
     * Envía un email usando Gmail SMTP
     * @param asunto Asunto del email
     * @param cuerpo Cuerpo del mensaje
     * @throws Exception Si hay algún error al enviar
     */
    public static void enviarEmail(String asunto, String cuerpo) throws Exception {
        try {
            // Leer configuración desde variables de entorno o CEPP.ini
            String emailFrom = PropiedadesINI.getPropiedad("EmailFrom");
            String emailTo = PropiedadesINI.getPropiedad("EmailTo");
            String contrasenia = PropiedadesINI.getPropiedad("Contrasenia");
            
            // Validar configuración
            if (emailFrom == null || emailFrom.trim().isEmpty()) {
                throw new Exception("EmailFrom no configurado");
            }
            if (emailTo == null || emailTo.trim().isEmpty()) {
                throw new Exception("EmailTo no configurado");
            }
            if (contrasenia == null || contrasenia.trim().isEmpty()) {
                throw new Exception("Contrasenia no configurada");
            }
            
            // Configurar propiedades SMTP de Gmail
            Properties props = new Properties();
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            
            // Crear sesión con autenticación
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(emailFrom, contrasenia);
                }
            });
            
            // Crear mensaje
            MimeMessage mensaje = new MimeMessage(session);
            mensaje.setFrom(new InternetAddress(emailFrom, "CEPP - Centro de Estudios de Políticas Públicas"));
            mensaje.addRecipient(Message.RecipientType.TO, new InternetAddress(emailTo));
            mensaje.setSubject(asunto);
            mensaje.setText(cuerpo);
            
            // Enviar
            Transport.send(mensaje);
            System.out.println("Email enviado exitosamente a: " + emailTo);
            
        } catch (Exception e) {
            System.err.println("Error al enviar email: " + e.getMessage());
            e.printStackTrace();
            throw new Exception("Error al enviar email: " + e.getMessage(), e);
        }
    }
}

