<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">

		<!-- 상단 뒤로가기 버튼 추가 -->
	    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
	        <jsp:param value="어르신 정보" name="addTitle" />
	    </jsp:include>
	    
	    
	    <main>
            <section class="default">

                <div class="box_om_profile info_mdfy">

                    <div class="img_area fl_0${indexNumber}"></div>

                    <div class="font_sbmr"><span class="font_sbmb">${curRecipientInfo.recipientsNm}</span>님</div>

					<a id="aTagMainYn" class="waves-effect btn btn_cancel align_center gap02 rounded" onclick="clickUpdateMainYn();">
						<%-- 대표가 설정된 별 이미지 --%>
                        <svg id="whiteStarSvg" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
                            fill="none">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                d="M6.88614 1.54777C7.3914 0.708199 8.60858 0.7082 9.11384 1.54777L10.6675 4.12937C10.7094 4.19897 10.7777 4.24861 10.8568 4.26694L13.7922 4.94677C14.7468 5.16786 15.1229 6.32547 14.4806 7.06544L12.5054 9.34079C12.4522 9.40214 12.4261 9.48246 12.4331 9.56339L12.6936 12.5652C12.7783 13.5414 11.7936 14.2568 10.8914 13.8746L8.11702 12.6992C8.04222 12.6675 7.95776 12.6675 7.88296 12.6992L5.10862 13.8746C4.20637 14.2568 3.22165 13.5414 3.30637 12.5652L3.56689 9.56339C3.57391 9.48246 3.54781 9.40214 3.49456 9.34079L1.51941 7.06544C0.877068 6.32547 1.2532 5.16786 2.20781 4.94677L5.14316 4.26694C5.2223 4.24861 5.29062 4.19897 5.33251 4.12937L6.88614 1.54777Z"
                                fill="white" />
                        </svg>
                        <%-- 대표가 미설정된 별 이미지 --%>
                        <svg id="blackStarSvg" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
                            fill="none">
                            <path fill-rule="evenodd" clip-rule="evenodd"
                                d="M6.88614 1.54783C7.3914 0.70826 8.60858 0.708261 9.11384 1.54783L10.6675 4.12943C10.7094 4.19903 10.7777 4.24867 10.8568 4.267L13.7922 4.94683C14.7468 5.16792 15.1229 6.32553 14.4806 7.0655L12.5054 9.34085C12.4522 9.4022 12.4261 9.48252 12.4331 9.56345L12.6936 12.5652C12.7783 13.5414 11.7936 14.2569 10.8914 13.8746L8.11702 12.6993C8.04222 12.6676 7.95776 12.6676 7.88296 12.6993L5.10862 13.8746C4.20637 14.2569 3.22165 13.5414 3.30637 12.5652L3.56689 9.56345C3.57391 9.48252 3.54781 9.4022 3.49456 9.34085L1.51941 7.0655C0.877068 6.32553 1.2532 5.16792 2.20781 4.94683L5.14316 4.267C5.2223 4.24867 5.29062 4.19903 5.33251 4.12943L6.88614 1.54783Z"
                                fill="#555555" />
                        </svg>
                        대표 설정
                    </a>
					
                </div>

                <!-- 대표설정된 사람 -->

                <div class="h40"></div>

                <div class="d-flex justify-content-between align-items-center">
                    <span class="font_sbms">기본정보</span>
                    <a class="modal-close waves-effect btn-middle02 btn_white_bder" onclick="clickUpdateRecipientInfo('base');">수정</a>
                </div>

                <div class="h20"></div>

                <table class="table_basic small">
                    <colgroup>
                        <col style="width:50%;">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th class="color_secondary font_sbmr">본인과의 가족관계</th>
                            <td class="font_sbmr">${relationCdMap[curRecipientInfo.relationCd]}</td>
                        </tr>
                        <tr>
                            <th class="color_secondary font_sbmr">어르신 이름</th>
                            <td class="font_sbmr">${curRecipientInfo.recipientsNm}</td>
                        </tr>
                        <tr>
                            <th class="color_secondary font_sbmr">어르신 생년월일</th>
                            <td class="font_sbmr">
                            	<c:if test="${!empty curRecipientInfo.brdt && fn:length(curRecipientInfo.brdt) >= 8}">
                            		${fn:substring(curRecipientInfo.brdt,0,4)}/${fn:substring(curRecipientInfo.brdt,4,6)}/${fn:substring(curRecipientInfo.brdt,6,8)}
                            	</c:if>
                            </td>
                        </tr>
                        <tr>
                            <th class="color_secondary font_sbmr">요양인정번호</th>
                            <td class="font_sbmr">
                            	<c:choose>
                            		<c:when test="${curRecipientInfo.recipientsYn eq 'Y'}">
                            			L${curRecipientInfo.rcperRcognNo}
                            		</c:when>
                            		<c:otherwise>
                            			없음
                            		</c:otherwise>
                            	</c:choose>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="h40"></div>


                <div class="d-flex justify-content-between align-items-center">
                    <span class="font_sbms">상담정보</span>
                    <a class="modal-close waves-effect btn-middle02 btn_white_bder" onclick="clickUpdateRecipientInfo('conslt');">수정</a>
                </div>

                <div class="h20"></div>

                <table class="table_basic small">
                    <colgroup>
                        <col style="width:50%;">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th class="color_secondary font_sbmr">상담받을 연락처</th>
                            <td class="font_sbmr">${curRecipientInfo.tel}</td>
                        </tr>
                        <tr>
                            <th class="color_secondary font_sbmr">서비스받을 지역</th>
                            <td class="font_sbmr">${curRecipientInfo.sido}&nbsp;${curRecipientInfo.sigugun}</td>
                        </tr>

                    </tbody>
                </table>

                <div class="h40"></div>

                <div class="waves-effect padH16 w100p color_t_s font_sbmr" onclick="clickRemoveRecipient();">어르신 삭제</div>

            </section>
        </main>

	</div>
	<!-- wrapper -->
	
	
	<script>
		var recipientsNo = ${curRecipientInfo.recipientsNo};
		var mainYn = '${curRecipientInfo.mainYn}';
	
		//대표 설정 버튼 그리기
		function showATagMainYn() {
			var aTagMainYn = $('#aTagMainYn');
			
			if(mainYn == 'Y') {
				aTagMainYn.removeClass('btn_cancel');
				aTagMainYn.addClass('btn_primary');
				$('#whiteStarSvg').removeClass('disNone');
				$('#blackStarSvg').addClass('disNone');
			} else {
				aTagMainYn.addClass('btn_cancel');
				aTagMainYn.removeClass('btn_primary');
				$('#whiteStarSvg').addClass('disNone');
				$('#blackStarSvg').removeClass('disNone');
			}
		}
		
		//대표 설정 클릭 이벤트
		async function clickUpdateMainYn() {
			//대표수급자 변경
	        if (mainYn === 'Y') {
	        	await showAlertPopup('이미 대표 어르신으로 설정되었어요');
	        } else {
	        	callPostAjaxIfFailOnlyMsg(
	        		'/matching/membership/recipients/update/main.json',
	        		{ recipientsNo:Number(recipientsNo), isMatching: 'Y' },
	        		function(result) {
	        			mainYn = 'Y';
	        			showATagMainYn();
	        			
	        			showToastMsg('대표 어르신으로 설정되었어요');
	        		}
       			);
	        }
		}
		
		//어르신 수정
		async function clickUpdateRecipientInfo(type) {
			//기본정보 수정페이지로 이동
			if (type === 'base') {
				removeInLocalStorage('updateRelationCd');
				location.href = '/matching/membership/recipients/update/baseInfo?recipientsNo=' + recipientsNo;
			}
			//상담정보 수정페이지로 이동
			else if (type === 'conslt') {
				location.href = '/matching/membership/recipients/update/consltInfo?recipientsNo=' + recipientsNo;
			}
		}
		
		//어르신 삭제
		async function clickRemoveRecipient() {
			var answer = await showConfirmPopup('정말 어르신을 삭제하시겠어요?', '삭제 후에는 복구가 불가해요');
			if (answer === 'confirm') {
				callPostAjaxIfFailOnlyMsg(
	        		'/matching/membership/recipients/removeMbrRecipient.json',
	        		{ recipientsNo:Number(recipientsNo) },
	        		function(result) {
	        			popHistoryStack();
	        			location.href = '/matching/membership/recipients/subMain';
	        		}
	     		);
			}
		}
		
		
		$(function() {
			//대표 설정 버튼 그리기
			showATagMainYn();
		});
	</script>