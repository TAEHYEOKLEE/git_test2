package email;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendEmail {

 public boolean SendEmail(String id, String pass, String email) 
 {
	 
  boolean isOk = false;
  String host     = "smtp.naver.com";
  final String user   = "yoz09@naver.com";
  final String password  = "ghkdtp3773";
  
  String to = email; //email

  
  // Get the session object
  Properties props = new Properties();
  props.put("mail.smtp.host", host);
  props.put("mail.smtp.auth", "true");

  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
   protected PasswordAuthentication getPasswordAuthentication() {
    return new PasswordAuthentication(user, password);
   }
  });

  // Compose the message
  try {
   MimeMessage message = new MimeMessage(session);
   message.setFrom(new InternetAddress(user));
   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

   // Subject
   message.setSubject("[Subject] "+id+"님의 비밀번호 검색 결과");
   
   // Text
   message.setText("비밀번호는 "+pass+"입니다.");

   // send the message
   Transport.send(message);
   System.out.println("message sent successfully...");
   isOk = true;
  } catch (MessagingException e) {
   e.printStackTrace();
   isOk = false;
  }
  
  return isOk;
 }
 
	public boolean SendEmail2(String id, String pass, String email) {
		boolean isOk = false;
		String host = "smtp.naver.com";
		final String user = "yoz09@naver.com";
		final String password = "ghkdtp3773";

		String to = "" + "npnorladb@gmail.com"; // email

		// Get the session object
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.auth", "true");

		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		// Compose the message
		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(user));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

			// Subject
			message.setSubject("[Subject] " + id + "님의 비밀번호 검색 결과");

			// Text
			message.setText("비밀번호는 " + pass + "입니다.");

			// send the message
			Transport.send(message);
			System.out.println("message sent successfully...");
			isOk = true;
		} catch (MessagingException e) {
			e.printStackTrace();
			isOk = false;
		}

		return isOk;
	}
}