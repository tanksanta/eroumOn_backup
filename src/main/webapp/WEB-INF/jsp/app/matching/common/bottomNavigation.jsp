<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <footer class="page-footer bottomNav">

      <ul class="bottomNav_menu">

        <li class="btn_om<c:if test="${ param != null && param.menuName == 'recipients' }"> active</c:if>" onclick="clickRecipientsBtn();">
          <a class="waves-effect">
            <span class="txt">어르신</span>
          </a>
        </li>
        <li class="btn_wel<c:if test="${ param != null && param.menuName == 'welfare' }"> active</c:if>" onclick="location.href='/matching/welfareinfo/list'">
          <a class="waves-effect">
            <span class="txt">복지용구</span>
          </a>
        </li>
        <li class="btn_service<c:if test="${ param != null && param.menuName == 'service' }"> active</c:if>" onclick="location.href='/matching/main/service';">
          <a class="waves-effect">
            <span class="txt">서비스</span>
          </a>
        </li>
        <li class="btn_guide<c:if test="${ param != null && param.menuName == 'guide' }"> active</c:if>">
          <a class="waves-effect" href="/matching/bbs/guide/list">
            <span class="txt">길잡이</span>
          </a>
        </li>
        <li class="btn_entier<c:if test="${ param != null && param.menuName == 'entire' }"> active</c:if>">
          <a class="waves-effect">
            <span class="txt">전체</span>
          </a>
        </li>

      </ul>

    </footer>
    
    
    <script>
    	function clickRecipientsBtn() {
    		var isLogin = '${_matMbrSession.loginCheck}';
    		//로그인이 안되어 있는 경우
    		if (!isLogin || isLogin === 'false') {
    			location.href = '/matching/kakao/login';
    			return;
    		}
    		
    		//로그인이 되어 있는 경우
    		if (isLogin === 'true') {
    			callPostAjaxIfFailOnlyMsg(
   					'/matching/membership/info/getMbrInfo.json', 
   					{},
   					async function(result) {
   						//등록된 수급자가 없을 때
   						if (!result.mbrRecipients || result.mbrRecipients.length < 1) {
   							var answer = await showConfirmPopup('어르신을 등록해주세요', '혜택을 받으려면 정확한 어르신 정보가 필요해요', '등록하기');
   							if (answer === 'confirm') {
   								location.href = '/matching/membership/recipients/regist/intro?redirecturl=/matching/membership/recipients/subMain';
   							}
   						}
   						else {
   							location.href = '/matching/membership/recipients/subMain';
   						}
   					}
   				);
    		}
    	}
    
    	$(function() {
    		
    	});
    </script>