package icube.market.srch;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import icube.common.framework.abst.CommonAbstractController;
import icube.market.srch.biz.SrchKwdCookieHandler;

/**
 * 마켓 > 상품 검색
 * @author kkm
 *
 */
@Controller
@RequestMapping(value = "#{props['Globals.Market.path']}/search")
public class SrchController extends CommonAbstractController {


	// 검색 컨테이너 호출
	@RequestMapping(value = {"index", "total"})
	public String search(
			@RequestParam(required=false, value="srchKwd") String srchKwd
			, HttpServletRequest request
			, HttpServletResponse response
			, Model model) throws Exception {









		return "/market/srch/total";
	}



	// 상품 검색






}
