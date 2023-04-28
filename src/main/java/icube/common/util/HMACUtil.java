package icube.common.util;

import java.nio.charset.StandardCharsets;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.codec.binary.Hex;

// HMAC
// https://ko.wikipedia.org/wiki/HMAC
public class HMACUtil {

	public static String encode(String memberId, String secretKey, String algorithm) {
		String expected_hash = "";
		try {
			byte[] data = memberId.getBytes();
			SecretKey macKey = new SecretKeySpec(hexify(secretKey), algorithm);
			Mac mac = Mac.getInstance(algorithm);
			mac.init(macKey);
			byte[] digest = mac.doFinal(data);
			byte[] hexBytes = new Hex().encode(digest);
			expected_hash = new String(hexBytes, StandardCharsets.UTF_8);
		} catch (InvalidKeyException | NoSuchAlgorithmException e) {
			expected_hash = "";
		}
		return expected_hash;
	}

	private static byte[] hexify(String secretKey) {
		return DatatypeConverter.parseHexBinary(secretKey);
	}

}
