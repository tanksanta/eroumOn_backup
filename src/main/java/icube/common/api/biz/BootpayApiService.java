package icube.common.api.biz;

import java.util.HashMap;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import icube.manage.ordr.rebill.biz.OrdrRebillVO;
import kr.co.bootpay.Bootpay;
import kr.co.bootpay.model.request.Cancel;
import kr.co.bootpay.model.request.SubscribePayload;
import kr.co.bootpay.model.request.User;

@Service("bootpayApiService")
public class BootpayApiService {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "logsDAO")
	private LogsDAO logsDAO;

	@Value("#{props['Bootpay.Private.Key']}")
	private String bootpayPrivateKey;

	@Value("#{props['Bootpay.Rest.Key']}")
	private String bootpayRestKey;

	// 토큰발급
	public Boolean goGetToken() throws Exception {

		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);

		Boolean result = false;

        HashMap<String, Object> res = bootpay.getAccessToken();
        if(res.get("error_code") == null) { //success
            System.out.println("goGetToken success: " + res);
            result = true;
        } else {
        	System.out.println("goGetToken false: " + res);
        }

        return result;
    }

	// 결제검증
	public HashMap<String, Object> confirm(String receiptId) throws Exception {

		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);

		HashMap<String, Object> res = bootpay.getAccessToken();
        if(res.get("error_code") == null) { //success
            System.out.println("goGetToken success: " + res);
        } else {
        	System.out.println("goGetToken false: " + res);
        }

        HashMap<String, Object> returnMap = new HashMap<String, Object>();
        returnMap = bootpay.confirm(receiptId);
		/*
		 * if(goGetToken()) { }
		 */

        return returnMap;
    }

	// 결제취소 (전액/부분)
	// 전체취소시 price = 0
	public HashMap<String, Object> receiptCancel(String receiptId, String username, double price) throws Exception {

		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);

        Cancel cancel = new Cancel();
        cancel.receiptId = receiptId;
        cancel.cancelUsername = username;
        cancel.cancelMessage = "주문결제취소";
        if(price > 0) { //부분취소 요청시
        	cancel.cancelPrice = price;
        }

//        cancel.cancelId = "12342134"; //부분취소 요청시, 중복 부분취소 요청하는 실수를 방지하고자 할때 지정

//        RefundData refund = new RefundData(); // 가상계좌 환불 요청시, 단 CMS 특약이 되어있어야만 환불요청이 가능하다.
//        refund.account = "675601012341234"; //환불계좌
//        refund.accountholder = "홍길동"; //환불계좌주
//        refund.bankcode = BankCode.getCode("국민은행");//은행코드
//        cancel.refund = refund;


		HashMap<String, Object> res = bootpay.getAccessToken();
        if(res.get("error_code") == null) { //success
            System.out.println("goGetToken success: " + res);
        } else {
        	System.out.println("goGetToken false: " + res);
        }

		HashMap<String, Object> returnMap = new HashMap<String, Object>();
        returnMap = bootpay.receiptCancel(cancel);

        return returnMap;
    }



	// 빌링키 발급
	public HashMap<String, Object> lookupBillingKey(String receiptId) throws Exception {

		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);

		HashMap<String, Object> res = bootpay.getAccessToken();
        if(res.get("error_code") == null) { //success
            System.out.println("goGetToken success: " + res);
        } else {
        	System.out.println("goGetToken false: " + res);
        }

        HashMap<String, Object> returnMap = new HashMap<String, Object>();
        returnMap = bootpay.lookupBillingKey(receiptId);

        return returnMap;
    }


	// 빌링키 결제 승인 요청
	// 빌링키, 주문코드, 주문명, 결제금액, 연락처
	public HashMap<String, Object> requestSubscribe(OrdrRebillVO ordrRebillVO) throws Exception {

		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);
		HashMap<String, Object> res = bootpay.getAccessToken();
		if(res.get("error_code") == null) { //success
            System.out.println("goGetToken success: " + res);
        } else {
        	System.out.println("goGetToken false: " + res);
        }

		SubscribePayload payload = new SubscribePayload();
		payload.billingKey = ordrRebillVO.getBillingKey();
		payload.orderName = ordrRebillVO.getGdsNm();
		payload.price = ordrRebillVO.getStlmAmt();
		payload.user = new User();
		payload.user.username = ordrRebillVO.getOrdrrNm();
		payload.user.email = ordrRebillVO.getOrdrrEml();
		payload.user.phone = ordrRebillVO.getOrdrrMblTelno().replace("-", "");
		payload.orderId = ordrRebillVO.getOrdrCd();

		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap = bootpay.requestSubscribe(payload);

        return returnMap;
	}


	// 빌링키 삭제
	public HashMap<String, Object> destroyBillingKey(String billingKey) throws Exception {

		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);
		HashMap<String, Object> res = bootpay.getAccessToken();
		if(res.get("error_code") == null) { //success
            System.out.println("goGetToken success: " + res);
        } else {
        	System.out.println("goGetToken false: " + res);
        }

        HashMap<String, Object> returnMap = new HashMap<String, Object>();
        returnMap = bootpay.destroyBillingKey(billingKey);

        return returnMap;
	}


	// 본인인증(다날)
	public HashMap<String, Object> certificate(String receiptId) throws Exception {

		Bootpay bootpay = new Bootpay(bootpayRestKey, bootpayPrivateKey);

		HashMap<String, Object> res = bootpay.getAccessToken();
        if(res.get("error_code") == null) { //success
            System.out.println("goGetToken success: " + res);
        } else {
        	System.out.println("goGetToken false: " + res);
        }

		HashMap<String, Object> returnMap = new HashMap<String, Object>();
	    returnMap = bootpay.certificate(receiptId);

	    return returnMap;
	}

	public int insertLog(BootpayVO vo) throws Exception {
		return this.logsDAO.insertLogOne(vo);
	}

}
