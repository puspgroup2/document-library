package handlers;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;

/**
 * This class handles sending out mail to users requesting password change
 */
public class MailHandler {
	
	/*
	 * IN ORDER FOR THIS CLASS TO FUNCTION, TWO EXTERNAL JARS ARE REQUIRED. ADD ALL
	 * JARS IN THE "resources" FOLDER TO CLASSPATH .
	 */
	
	private final String senderEmail = "puspmailgroup2@gmail.com";
	private final String senderPassword = "_7xYxeY-9c$7by.r%/aL";
	private Properties prop_;

	public MailHandler() {
		this.prop_ = new Properties();
		prop_.put("mail.smtp.host", "smtp.gmail.com");
		prop_.put("mail.smtp.port", "587");
		prop_.put("mail.smtp.auth", "true");
		prop_.put("mail.smtp.starttls.enable", "true"); // TLS
	}

	/**
	 * Send password to the recipient's e-mail.
	 * 
	 * @param recipient The e-mail of recipient.
	 * @param userName  recipient's userName.
	 * @param password  recipient's password.
	 */
	public void sendPasswordMail(String recipient, String userName, String password) {
		// Recipient's email ID needs to be mentioned.
		String toRecipient = recipient;

		// Sender's email ID needs to be mentioned
		String fromSender = senderEmail;

		// Assuming you are sending email from through gmails smtp
		String host = "smtp.gmail.com";

		// Get system properties
		Properties properties = System.getProperties();

		// Setup mail server
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", "465");
		properties.put("mail.smtp.ssl.enable", "true");
		properties.put("mail.smtp.auth", "true");

		// Get the Session object.// and pass userName and password
		Session session = Session.getInstance(properties, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(senderEmail, senderPassword);
			}
		});

		try {
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(fromSender));
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(toRecipient));
			message.setSubject("Your TimeMate login credentials");
			message.setText(
					"Your login credentials are:" + "\n" + "Username: " + userName + "\n" + "Password: " + password);
			Transport.send(message);
		} catch (MessagingException exception) {
			exception.printStackTrace();
		}
	}
}
