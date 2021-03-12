package handlers;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.Random;

/**
 * This class handles generating and hashing passwords.
 */
public class PasswordHandler {

	private static final Random rand = new SecureRandom();

	/**
	 * Hashes the provided password string with the provided salt string using
	 * SHA-256.
	 * @param password the users password.
	 * @param salt the users salt.
	 * @return hashed password as a String.
	 * @throws NoSuchAlgorithmException if the given cryptographic algorithm is not
	 *                                  available in the environment.
	 */
	public static String hashPassword(String password, String salt) {
		String hashedPassword = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			// Converts the String salt to byte[] and configures the hash function with the
			// salt string
			md.update(salt.getBytes(StandardCharsets.UTF_8));
			// Converts the password string to byte[] and then hashes it using SHA-256
			byte[] bytes = md.digest(password.getBytes(StandardCharsets.UTF_8));
			// Encodes the bytes array to String
			hashedPassword = Base64.getEncoder().encodeToString(bytes);
		} catch (NoSuchAlgorithmException exception) {
			exception.printStackTrace();
		}
		return hashedPassword;
	}
	
	/**
	 * Generates a new random password according to requirement 6.2.1 in PUSS214201.
	 * @return password as a String.
	 */
	public static String generatePassword() {
		ArrayList<Character> passwordChars = new ArrayList<>();
		StringBuilder sb = new StringBuilder();
		final char[] lowerCase = "abcdefghijklmnopqrstuvwxyz".toCharArray();
		final char[] upperCase = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".toCharArray();
		final char[] numbers = "1234567890".toCharArray();

		for (int i = 0; i < 3; i++)
			passwordChars.add(i, lowerCase[rand.nextInt(lowerCase.length)]);
		for (int i = 0; i < 3; i++)
			passwordChars.add(i, upperCase[rand.nextInt(upperCase.length)]);
		for (int i = 0; i < 2; i++)
			passwordChars.add(i, numbers[rand.nextInt(numbers.length)]);

		Collections.shuffle(passwordChars);
		for (Character c : passwordChars) {
			sb.append(c);
		}
		return sb.toString();
	}
	
	/**
	 * Generates a new random salt String.
	 * 
	 * @return salt as a String.
	 */
	public static String generateSalt() {
		byte[] salt = new byte[16];
		rand.nextBytes(salt);
		return Base64.getEncoder().encodeToString(salt);
	}
	
}