package org.team;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {
	public static void sendEmail(int num, String idE) {

		  String host     = "smtp.gmail.com";
		  final String user   = "cchmtest90@gmail.com";
		  final String password  = "jmcpower1!";

		  String to = idE;
		  System.out.println(to);
		  
		  Properties props = new Properties();
		  
		  props.put("mail.smtp.host", "smtp.gmail.com"); 
		  props.put("mail.smtp.port", 465); 
		  props.put("mail.smtp.auth", "true"); 
		  props.put("mail.smtp.ssl.enable", "true"); 
		  props.put("mail.smtp.ssl.trust", "smtp.gmail.com");

		  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
		   protected PasswordAuthentication getPasswordAuthentication() {
		    return new PasswordAuthentication(user, password);
		   }
		  });

		  try {
		   MimeMessage message = new MimeMessage(session);
		   message.setFrom(new InternetAddress(user));
		   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		   message.setSubject("[leebook]메일 인증 번호");
		   message.setText(" 입력하실 코드는 " + num + " 입니다.");

		   Transport.send(message);
		   System.out.println("***gg***");

		  } catch (MessagingException e) {
		   e.printStackTrace();
		  }
		 }
		}
