package icube.common.util;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

public class Base64Util {

	// base64 encode
	public static String encoder(String str) throws Exception {

		byte[] byteMsg1 = str.getBytes(StandardCharsets.UTF_8);
		String encoded = Base64.getEncoder().encodeToString(byteMsg1);

		return encoded;
	}

	// base64 decode
	public static String decoder(String str) throws Exception {

		byte[] byteMsg2 = Base64.getDecoder().decode(str);
		String decoded = new String(byteMsg2, StandardCharsets.UTF_8);

		return decoded;
	}
}
