package icube.manage.consult.biz;

import java.text.SimpleDateFormat;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import icube.common.framework.abst.CommonAbstractServiceImpl;
import icube.common.mail.MailService;
import icube.common.util.FileUtil;
import icube.common.vo.CommonListVO;

@Service("mbrInqryService")
public class MbrInqryService extends CommonAbstractServiceImpl {

	@Resource(name = "mailService")
	private MailService mailService;

	@Resource(name="mbrInqryDAO")
	private MbrInqryDAO mbrInqryDAO;

	@Value("#{props['Mail.Username']}")
	private String sendMail;
	
	@Value("#{props['Mail.Form.FilePath']}")
	private String mailFormFilePath;
	
	@Value("#{props['Profiles.Active']}")
	private String activeMode;
	
	@Value("#{props['Mail.Testuser']}")
	private String mailTestuser;

	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");

	public CommonListVO mbrInqryListVO(CommonListVO listVO) throws Exception {
		return mbrInqryDAO.mbrInqryListVO(listVO);
	}

	public MbrInqryVO selectMbrInqry(int mbrInqryNo) throws Exception {
		return mbrInqryDAO.selectMbrInqry(mbrInqryNo);
	}

	public void insertMbrInqry(MbrInqryVO mbrInqryVO) throws Exception {
		mbrInqryDAO.insertMbrInqry(mbrInqryVO);
	}

		/**
	 * 회원 상담취소 이메일 발송
	 */
	public void sendMbrInqryEmail(MbrInqryVO mbrInqryVO) throws Exception {
		String MAIL_FORM_PATH = mailFormFilePath;
		String mailForm = FileUtil.readFile(MAIL_FORM_PATH + "mail_inqry.html");
		String mailSj = "[이로움 ON] 1:1문의가 접수 되었습니다.";
		String putEml = "thkc_cx@thkc.co.kr";
		
		mailForm = mailForm.replace("((mbr_nm))", mbrInqryVO.getMdfr());
		mailForm = mailForm.replace("((mbr_id))", mbrInqryVO.getMdfcnId());
		mailForm = mailForm.replace("((mbr_telno))", mbrInqryVO.getMblTelno());

		if ("real".equals(activeMode)) {
			mailService.sendMail(sendMail, putEml, mailSj, mailForm);
		} else {
			mailService.sendMail(sendMail, this.mailTestuser, mailSj, mailForm);
		}
	}

	public void updateMbrInqry(MbrInqryVO mbrInqryVO) throws Exception {
		mbrInqryDAO.updateMbrInqry(mbrInqryVO);
	}

	public void updateAnsInqry(MbrInqryVO mbrInqryVO) throws Exception {
		mbrInqryDAO.updateAnsInqry(mbrInqryVO);
	}

	public void deleteInqry(int inqryNo) throws Exception {
		mbrInqryDAO.deleteInqry(inqryNo);
	}

}