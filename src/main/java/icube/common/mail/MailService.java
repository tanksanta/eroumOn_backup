package icube.common.mail;

import java.io.File;

import javax.mail.Multipart;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.values.CodeMap;


@Service("mailService")
public class MailService extends CommonAbstractServiceImpl {

	@Autowired
	private JavaMailSender mailSender;

	/**
	 * 메일발송
	 * @param from : 보내는사람
	 * @param to : 받는사람
	 * @param sj : 제목
	 * @param content : 내용
	 * @throws Exception
	 */
	@Async
	public void sendMail(String from, String to, String sj, String content) throws Exception {
		MimeMessage mimeMessage = mailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, false, "utf-8");

		if (CodeMap.MAIL_SENDER_NAME.get(from) == null){
			helper.setFrom(from);
		}else{
			helper.setFrom(new InternetAddress(from, CodeMap.MAIL_SENDER_NAME.get(from)));
		}
		
		helper.setTo(to);
		helper.setSubject(sj);
		mimeMessage.setContent(content, "text/html;charset=utf-8");
		mailSender.send(mimeMessage);
	}

	/**
	 * 메일발송 + 첨부파일
	 * @param from : 보내는사람
	 * @param to : 받는사람
	 * @param sj : 제목
	 * @param content : 내용
	 * @param filePath : 첨부파일 (경로+파일명)
	 * @throws Exception
	 */
	@Async
	public void sendMail(String from, String to, String sj, String content, String filePath) throws Exception {
		MimeMessage mimeMessage = mailSender.createMimeMessage();

		// 멀티파트 지원 false -> true
		MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "utf-8");
		
		if (CodeMap.MAIL_SENDER_NAME.get(from) == null){
			helper.setFrom(from);
		}else{
			helper.setFrom(new InternetAddress(from, CodeMap.MAIL_SENDER_NAME.get(from)));
		}
		helper.setTo(to);
		helper.setSubject(sj);

		Multipart multipart = new MimeMultipart();

		// 아래의 처리 방법 주의사항
		// MineBodyPart를 하나만 선언해서 사용하면 html을 attach가 덮어씌움
		// 따라서 별도로 선언하여 addBodyPart로 각각 추가

		// 본문 내용 처리
	    MimeBodyPart messageBodyPart = new MimeBodyPart();
	    messageBodyPart.setContent(content, "text/html;charset=utf-8");
	    multipart.addBodyPart(messageBodyPart);

	    // 첨부 파일 처리
	    MimeBodyPart attachmentBodyPart = new MimeBodyPart();
	    attachmentBodyPart.attachFile(new File(filePath));
	    multipart.addBodyPart(attachmentBodyPart);

		mimeMessage.setContent(multipart);

		mailSender.send(mimeMessage);
	}
}
