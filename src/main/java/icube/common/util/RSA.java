package icube.common.util;

import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RSA {

	private static final Logger LOGGER = LoggerFactory.getLogger(RSA.class);

	private String publicKeyModulus = "";
	private String publicKeyExponent = "";
	private PrivateKey privateKey = null;

	public static RSA getEncKey() {

		KeyPairGenerator generator;
		try {
			generator = KeyPairGenerator.getInstance("RSA");
		} catch (NoSuchAlgorithmException e) {
			LOGGER.debug(e.getMessage());
			return null;
		}
		generator.initialize(2048); // 키 사이즈

		KeyPair keyPair = generator.genKeyPair();

		KeyFactory keyFactory;
		try {
			keyFactory = KeyFactory.getInstance("RSA");
		} catch (NoSuchAlgorithmException e) {
			LOGGER.debug(e.getMessage());
			return null;
		}

		PublicKey publicKey = keyPair.getPublic(); // 공개키
		PrivateKey privateKey = keyPair.getPrivate(); // 개인키

		RSAPublicKeySpec publicSpec;
		try {
			publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
		} catch (InvalidKeySpecException e) {
			LOGGER.debug(e.getMessage());
			return null;
		}
		String publicKeyModulus = publicSpec.getModulus().toString(16);
		String publicKeyExponent = publicSpec.getPublicExponent().toString(16);

		RSA rsa = new RSA();
		rsa.setPrivateKey(privateKey);
		rsa.setPublicKeyExponent(publicKeyExponent);
		rsa.setPublicKeyModulus(publicKeyModulus);

		return rsa;
	}

	public static boolean dec(PrivateKey privateKey, String encString) throws Exception {
		boolean result = false;

		if (privateKey == null) {
			throw new RuntimeException("암호화 비밀키 정보를 찾을 수 없습니다.");
		}

		try {
			decryptRsa(privateKey, encString);
			result = true;
		} catch (Exception e) {
			LOGGER.debug(e.getMessage());
		}

		return result;
	}

	public static String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
		Cipher cipher = Cipher.getInstance("RSA");
		byte[] encryptedBytes = hexToByteArray(securedValue);
		cipher.init(Cipher.DECRYPT_MODE, privateKey);
		byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
		String decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
		return decryptedValue;
	}

	public static byte[] hexToByteArray(String hex) {
		if (hex == null || hex.length() % 2 != 0) {
			return new byte[] {};
		}

		byte[] bytes = new byte[hex.length() / 2];
		for (int i = 0; i < hex.length(); i += 2) {
			byte value = (byte) Integer.parseInt(hex.substring(i, i + 2), 16);
			bytes[(int) Math.floor(i / 2)] = value;
		}
		return bytes;
	}

}
