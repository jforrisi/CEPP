package cepp.genericos;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.AddressException;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
/**
 *
 * @author Patricio
 */
public class Send
{
    private String from;
    private String to;
    private String subject;
    private String text;
    private String fileAttachment;
    private String username;
    private String password;
    private String server;
    private String tls;
    private String autenticator;
    private String connect;
    private String html;

//    Send smtp = new Send("patoppatoppatop@gmail.com", "patoppatoppatop@gmail.com", xSubject, xText, "", serverMail, userNameMail, passwordMail, tlsMail, connectMail, "");
    public Send(String from, String to, String subject, String text, String fileAttachement, String server, String username, String password, String tls, String xConnect, String xHtml) {
        this.from = from;
        this.to = to;
        this.subject = subject;
        this.text = text;
        this.fileAttachment = fileAttachement;
        this.username=username;
        this.password=password;
        this.server=server;
        this.tls=tls;
        this.connect=xConnect;
        this.html=xHtml;
    }

    public void send() throws AddressException, MessagingException {

//         Properties props = new Properties();
//        props.put("mail.smtp.user", "patoppatoppatop@gmail.com");
//        props.put("mail.smtp.host", "smtp.gmail.com");
//        props.put("mail.smtp.port", "465");
//        props.put("mail.smtp.starttls.enable", "true");
//        props.put("mail.smtp.auth", "true");
//        props.put("mail.smtp.socketFactory.port", "465");
//        props.put("mail.smtp.socketFactory.class",
//                "javax.net.ssl.SSLSocketFactory");
//        props.put("mail.smtp.socketFactory.fallback", "false");
        
        
        Properties props = new Properties(); //System.getProperties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.debug", "true");
        if (this.tls.equals("S"))
            props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host","smtp.gmail.com");
        props.put("mail.smtp.port","465");
                props.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");
        

        Session session = Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                }
            });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        
        System.out.println("from es"+from);
        
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);
        System.out.println("subject es"+subject);

        MimeBodyPart messageBodyPart = new MimeBodyPart();
        messageBodyPart.setText(text);
        System.out.println("text"+text);

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(messageBodyPart);

        // Put parts in message
        message.setContent(multipart);

        // Send the message
        Transport transport = session.getTransport("smtp");
        if(this.connect.equals("S"))
            transport.connect(this.server, 465, this.username, this.password);
        
        System.out.println("la contraseña es"+this.password);
        System.out.println("el nombre de usuarui  es"+this.username);
        System.out.println("la server es"+this.server);
        
        
        Transport.send(message);
    }

    public void sendHTML() throws AddressException, MessagingException {

        Properties props = new Properties(); //System.getProperties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.debug", "true");
        if (this.tls.equals("S"))
            props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host",this.server);
        props.put("mail.smtp.port",25);
	props.put("mail.mime.charset","UTF-8");

        Session session = Session.getInstance(props,
            new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                }
            });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(from));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
        message.setSubject(subject);

        message.setContent(this.html, "text/html");

        // Send the message
        Transport transport = session.getTransport("smtp");
        if(this.connect.equals("S"))
            transport.connect(this.server, 25, this.username, this.password);
        Transport.send(message);
    }
}
