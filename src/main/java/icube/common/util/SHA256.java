package icube.common.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

public class SHA256 {

	public String encrypt(String text) throws NoSuchAlgorithmException {
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(text.getBytes());

        return bytesToHex(md.digest());
    }

	public static String HmacEncrypt(String text, String secretKey) throws Exception {
		return HmacEncode(text, secretKey, "HmacSHA256");
	}
	
	
    private String bytesToHex(byte[] bytes) {
        StringBuilder builder = new StringBuilder();
        for (byte b : bytes) {
            builder.append(String.format("%02x", b));
        }
        return builder.toString();
    }

    private static String HmacEncode(String text, String secretKey, String algorithms) {
	  try {
	    Mac mac = Mac.getInstance(algorithms);
	    mac.init(new SecretKeySpec(hexify(secretKey), algorithms));
	
	    byte[] hash = mac.doFinal(text.getBytes());
	
	    StringBuilder sb = new StringBuilder(hash.length * 2);
	    for (byte b: hash) {
	      sb.append(String.format("%02x", b));
	    }
	
	    return sb.toString();
	  }catch (Exception e) {
	    throw new RuntimeException(e);
	  }
	}

	private static byte[] hexify(String string) {
		return DatatypeConverter.parseHexBinary(string);
	}
}
