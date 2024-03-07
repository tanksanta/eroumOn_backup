<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">

		<!-- 상단 뒤로가기 버튼 추가 -->
	    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
	        <jsp:param value="어르신 기본 정보 수정" name="addTitle" />
	    </jsp:include>
	    
	    
	    <main>
            <section class="default">

                <form action="">

                    <label class="input_label">본인과의 가족관계</label>
                    <div id="divRelation" class="waves-effect input_basic list_link font_sbmr" onclick="location.href='/matching/membership/recipients/update/relation';"></div>
                    <div class="h32"></div>

                    <label class="input_label">어르신 이름</label>
                    <input id="inputName" type="text" class="input_basic bder_danger" value="${curRecipientInfo.recipientsNm}">
          			<div id="nameErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
          
                    <div class="h32"></div>

                    <label class="input_label">어르신 생년월일</label>
                    <input id="inputBrdt" type="text" class="input_basic keycontrol birthdt10 bder_danger" value="<c:if test="${!empty curRecipientInfo.brdt && fn:length(curRecipientInfo.brdt) >= 8}">
                         	${fn:substring(curRecipientInfo.brdt,0,4)}/${fn:substring(curRecipientInfo.brdt,4,6)}/${fn:substring(curRecipientInfo.brdt,6,8)}
                        </c:if>"
                     >
                     <div id="brdtErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
          
                    <div class="h32"></div>

                    <label class="input_label">요양인정번호</label>
                    <input id="inputLno" type="text" class="input_basic keycontrol numberonly bder_danger" maxlength="10" placeholder="1234567890" value="${curRecipientInfo.rcperRcognNo}">
                    <div id="lnoErrorMsg" class="vaild_txt error">유효성 체크 텍스트입니다. Help message</div>
                    <div id="lnoHelpMsg" class="vaild_txt">입력하시면 더 빠르게 혜택을 받을 수 있어요</div>
          
                    <div class="h40"></div>

                </form>

            </section>
        </main>


        <footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p" onclick="clickUpdateRecipient();">수정하기</a>
            </div>

        </footer>

	</div>
	<!-- wrapper -->
	
	
	<script>
		var _jsCommon;
		var recipientsNo = '${curRecipientInfo.recipientsNo}';
		var relationCd = '${curRecipientInfo.relationCd}';
		var relationCdMap = {
			<c:forEach var="rMap" items="${relationCdMap}" varStatus="status">
				'${rMap.key}': '${rMap.value}',
			</c:forEach>
		}
		
		var namechk = /^[ㄱ-ㅎ|가-힣]+$/;
		var datechk = /^([1-2][0-9]{3})\/([0-1][0-9])\/([0-3][0-9])$/;  //날짜 정규식
		
		
		//UI 초기화
		function initialize() {
			var inputName = $('#inputName');
			var inputBrdt = $('#inputBrdt');
			var inputLno = $('#inputLno');
			inputName.removeClass('bder_danger');
			inputBrdt.removeClass('bder_danger');
			inputLno.removeClass('bder_danger');
			
			var nameErrorMsg = $('#nameErrorMsg');
			var brdtErrorMsg = $('#brdtErrorMsg');
			var lnoErrorMsg = $('#lnoErrorMsg');
			var lnoHelpMsg = $('#lnoHelpMsg');
			nameErrorMsg.addClass('disNone');
			brdtErrorMsg.addClass('disNone');
			lnoErrorMsg.addClass('disNone');
			lnoHelpMsg.removeClass('disNone');
		}
		
		//유효성 검사
		function validation() {
			var isValid = true;
			var inputName = $('#inputName');
			var inputBrdt = $('#inputBrdt');
			var inputLno = $('#inputLno');
			
			var nameErrorMsg = $('#nameErrorMsg');
			var brdtErrorMsg = $('#brdtErrorMsg');
			var lnoErrorMsg = $('#lnoErrorMsg');
			var lnoHelpMsg = $('#lnoHelpMsg');
			
			//이름
			var name = inputName.val();
			if (!name) {
				inputName.addClass('bder_danger');
				nameErrorMsg.text('이름을 입력해주세요');
				nameErrorMsg.removeClass('disNone');
				isValid = false;
			}
			else if (!namechk.test(name)) {
				inputName.addClass('bder_danger');
				nameErrorMsg.text('한글만 입력해주세요');
				nameErrorMsg.removeClass('disNone');
				isValid = false;
			} else {
				inputName.removeClass('bder_danger');
				nameErrorMsg.addClass('disNone');
			}
			
			//생년월일
			var brdt = inputBrdt.val();
			if (!brdt || !datechk.test(brdt)) {
				inputBrdt.addClass('bder_danger');
				brdtErrorMsg.text('다시 확인해주세요');
				brdtErrorMsg.removeClass('disNone');
				isValid = false;
			} else {
				inputBrdt.removeClass('bder_danger');
				brdtErrorMsg.addClass('disNone');
			}
			
			//요양인정번호
			var lno = inputLno.val();
			if (lno && lno.length !== 10) {
				inputLno.addClass('bder_danger');
				lnoErrorMsg.text('번호를 확인해주세요');
				lnoErrorMsg.removeClass('disNone');
				lnoHelpMsg.addClass('disNone');
				isValid = false;
			} else {
				inputLno.removeClass('bder_danger');
				lnoErrorMsg.addClass('disNone');
				lnoHelpMsg.removeClass('disNone');
			}
			return isValid;
		}
		
		//수정하기 버튼 클릭 이벤트
		async function clickUpdateRecipient() {
			var valid = validation();
			if (!valid) {
				return;
			}
			
			var answer = await showConfirmPopup('정말 수정하시겠어요?', '정확한 정보를 입력하셔야 필요한 정보를 받을 수 있어요');
			if (answer === 'confirm') {
				var inputName = $('#inputName');
				var inputBrdt = $('#inputBrdt');
				var inputLno = $('#inputLno');
				
				var relationCd = getInLocalStorage('updateRelationCd');
				var recipientsNm = inputName.val();
				var brdt = inputBrdt.val();
				var rcperRcognNo = inputLno.val();
				
				callPostAjaxIfFailOnlyMsg(
	        		'/matching/membership/recipients/updateMbrRecipient.json',
	        		{
	        			recipientsNo : Number(recipientsNo),
	        			updateType : 'base',
	        			relationCd,
	        			recipientsNm,
	        			brdt,
	        			rcperRcognNo,
	        		},
	        		function(result) {
	        			backBtnEvent();
	        		}
	     		);
			}
		}
		
		
		$(function() {
			_jsCommon = new JsCommon();
            _jsCommon.fn_keycontrol();
            
            //UI 초기화
            initialize();
            
            //관계 변경이 없으면 어르신 관계로 표출
            var updateRelationCd = getInLocalStorage('updateRelationCd');
            if (!updateRelationCd) {
            	saveInLocalStorage('updateRelationCd', relationCd);
            	updateRelationCd = relationCd;
            } else {
            	relationCd = updateRelationCd;
            }
            $('#divRelation').text(relationCdMap[updateRelationCd]);
		});
	</script>