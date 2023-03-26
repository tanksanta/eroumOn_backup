package icube;

import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.Scanner;

public class Base64Test {

	public static void main(String[] args) throws Exception {


		//java8 encodeing

		//String strSample = "T09061089109"; //VDA5MDYxMDg5MTA5
		String strSample = "F30090204002";

		byte[] byteMsg1 = strSample.getBytes(StandardCharsets.UTF_8);
		String encoded = Base64.getEncoder().encodeToString(byteMsg1);

		System.out.println("encoded: " + encoded);

		System.out.println("=====================================");


		byte[] byteMsg2 = Base64.getDecoder().decode(encoded);
		String decoded = new String(byteMsg2, StandardCharsets.UTF_8);

		System.out.println("decoded: " + decoded);
/*
		System.out.println("decoded: " + new String(Base64.getDecoder().decode("RjMwMDkwMjA0MDAy"), StandardCharsets.UTF_8));
		System.out.println("decoded: " + new String(Base64.getDecoder().decode("MA=="), StandardCharsets.UTF_8));
		System.out.println("decoded: " + new String(Base64.getDecoder().decode("MQ=="), StandardCharsets.UTF_8));
		System.out.println("decoded: " + new String(Base64.getDecoder().decode("OTk5OTk="), StandardCharsets.UTF_8));
*/

		System.out.println("decoded: " + new String(Base64.getDecoder().decode("66CI65OcH1M="), StandardCharsets.UTF_8));
		System.out.println("decoded: " + new String(Base64.getDecoder().decode("66CI65OcHk0="), StandardCharsets.UTF_8));
		System.out.println("decoded: " + new String(Base64.getDecoder().decode("67iU66OoH1M="), StandardCharsets.UTF_8));

		//char a = 0x1E;
		String t = "레드 * M * S";
		System.out.println("t: " + t.replace(" * ", Character.toString( (char) 0x1E) ));


	}

}
