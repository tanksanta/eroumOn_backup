package icube.common.mail;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;


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
		helper.setFrom(from);
		helper.setTo(to);
		helper.setSubject(sj);
		mimeMessage.setContent(content, "text/html;charset=utf-8");
		mailSender.send(mimeMessage);
	}

}
