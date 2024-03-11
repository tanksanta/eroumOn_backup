<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="icube.manage.consult.biz.MbrConsltVO"%>
<%@ page import="icube.manage.consult.biz.MbrConsltChgHistVO"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	MbrConsltVO mbrConsltVO = (MbrConsltVO) request.getAttribute("mbrConsltVO");
	MbrConsltChgHistVO reuqestChgHistVO = (MbrConsltChgHistVO) request.getAttribute("reuqestChgHistVO");
	MbrConsltChgHistVO connectChgHistVO = (MbrConsltChgHistVO) request.getAttribute("connectChgHistVO");
	MbrConsltChgHistVO progressChgHistVO = (MbrConsltChgHistVO) request.getAttribute("progressChgHistVO");
	MbrConsltChgHistVO completeChgHistVO = (MbrConsltChgHistVO) request.getAttribute("completeChgHistVO");
%>
<%!
	public String getDateFormat(MbrConsltChgHistVO chgHistVO) {
		if (chgHistVO == null) {
			return "-";
		}
		return getDateFormat(chgHistVO.getRegDt());
	}

	public String getDateFormat(Date date) {
		int hours = date.getHours();

		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String dateString = formatter.format(date);
		String[] strArray = dateString.split(" ");
		if (strArray.length > 1) {
			//오전, 오후 판별
			String addedText = "오전";
			if (hours >= 12) {
				addedText = "오후";
			}
			
			dateString = strArray[0] + " " + addedText + " " + strArray[1];
		}
		
		return dateString;
	}
%>

	<div class="wrapper">

		<!-- 상단 뒤로가기 버튼 추가 -->
	    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
	        <jsp:param value="상담내역" name="addTitle" />
	    </jsp:include>


        <main>
            <section class="default noPad">
				<%-- 상담 취소 여부 --%>
				<c:set var="isCancelConslt" value="${mbrConsltVO.consltSttus eq 'CS03' || mbrConsltVO.consltSttus eq 'CS04' || mbrConsltVO.consltSttus eq 'CS09' ? true : false}" />

                <div class="box_history_area <c:if test="${isCancelConslt}">gray</c:if>">
                    <c:choose>
                    	<c:when test="${mbrConsltVO.consltSttus eq 'CS01' || mbrConsltVO.consltSttus eq 'CS07'}">
                    		<h4 class="title color_tp_i">
		                        신청완료<br>
		                        어르신에게 적합한 곳을 연결 중이에요
		                    </h4>
		                    <div class="h32"></div>
                    	</c:when>
                    	<c:when test="${mbrConsltVO.consltSttus eq 'CS02' || mbrConsltVO.consltSttus eq 'CS08'}">
                    		<h4 class="title color_tp_i">
		                        상담 연결 중<br>
		                        적합한 곳을 찾았어요! 기다려주세요
		                    </h4>
		                    <div class="h32"></div>
                    	</c:when>
                    	<c:when test="${mbrConsltVO.consltSttus eq 'CS05'}">
                    		<h4 class="title color_tp_i">
		                        상담진행중<br>
		                        곧 연락드릴게요
		                    </h4>
		                    <div class="h32"></div>
                    	</c:when>
                    	<c:when test="${mbrConsltVO.consltSttus eq 'CS06'}">
                    		<h4 class="title color_tp_i">
		                        상담완료<br>
		                        혜택이 아직 더 남아있어요
		                    </h4>
		                    <div class="h16"></div>
		                    <span class="waves-effect link_text color_white font_sbmu">더 알아보기</span>
		                    <div class="h44"></div>
                    	</c:when>
                    	<c:otherwise>
                    		<h4 class="title color_tp_i">
		                        취소되었어요<br>
		                        혜택이 아직 더 남아있어요
		                    </h4>
		                    <div class="h16"></div>
		                    <span class="waves-effect link_text color_white font_sbmu">더 알아보기</span>
		                    <div class="h44"></div>
                    	</c:otherwise>
                    </c:choose>

                    <div class="card waves-effect w100p radius08">

                        <%-- 상담 상태 박스 --%>
						<c:set var="consltInfo" value="${mbrConsltVO}" scope="request"/>
						<jsp:include page="/WEB-INF/jsp/app/matching/membership/conslt/include/consltStatusBox.jsp" />

                    </div>
                    <!-- card -->


                </div>

                <div class="h12"></div>

                <div class="box_normal pad20">

                    <div class="font_sbls padH08">상담정보</div>

                    <div class="h12"></div>


                    <table class="table_basic small_2">
                        <colgroup>
                            <col style="width:50%;">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="color_t_s font_sbmr">신청자 이름</th>
                                <td class="font_sbmr">${mbrConsltVO.rgtr}</td>
                            </tr>
                        </tbody>
                    </table>

                    <div class="h16"></div>

                    <div class="color_t_s font_sbmr">어르신의 기본정보</div>

                    <div class="h12"></div>

                    <div class="box_normal gray">


                        <table class="table_basic small_2">
                            <colgroup>
                                <col style="width:50%;">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="color_t_s font_sbmr">본인과의 가족관계</th>
                                    <td class="font_sbmr">${relationCdMap[mbrConsltVO.relationCd]}</td>
                                </tr>
                                <tr>
                                    <th class="color_t_s font_sbmr">어르신 이름</th>
                                    <td class="font_sbmr">${mbrConsltVO.mbrNm}</td>
                                </tr>
                                <tr>
                                    <th class="color_t_s font_sbmr">어르신 생년월일</th>
                                    <td class="font_sbmr">
                                    	<c:if test="${!empty mbrConsltVO.brdt && fn:length(mbrConsltVO.brdt) >= 8}">
		                            		${fn:substring(mbrConsltVO.brdt,0,4)}/${fn:substring(mbrConsltVO.brdt,4,6)}/${fn:substring(mbrConsltVO.brdt,6,8)}
		                            	</c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <th class="color_t_s font_sbmr">요양인정번호</th>
                                    <td class="font_sbmr">
                                    	<c:choose>
		                            		<c:when test="${!empty mbrConsltVO.rcperRcognNo}">
		                            			L${mbrConsltVO.rcperRcognNo}
		                            		</c:when>
		                            		<c:otherwise>
		                            			없음
		                            		</c:otherwise>
		                            	</c:choose>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                    </div>

                    <div class="h16"></div>

                    <div class="color_t_s font_sbmr">어르신 상담정보</div>

                    <div class="h12"></div>

                    <div class="box_normal gray">

                        <table class="table_basic small_2">
                            <colgroup>
                                <col style="width:50%;">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th class="color_t_s font_sbmr">상담받을 연락처</th>
                                    <td class="font_sbmr">${mbrConsltVO.mbrTelno}</td>
                                </tr>
                                <tr>
                                    <th class="color_t_s font_sbmr">서비스받을 주소</th>
                                    <td class="font_sbmr">${mbrConsltVO.zip}&nbsp;${mbrConsltVO.addr}</td>
                                </tr>

                            </tbody>
                        </table>

                    </div>

                </div>
                <!-- box_normal -->

                <div class="h12"></div>

                <div class="box_normal pad20">
	
                    <div class="d-flex align_between_center">
                        <div class="font_sbls">
                        	<c:choose>
                        		<c:when test="${!empty mbrConsltResultVO}">
                        			${mbrConsltResultVO.bplcNm}
                        		</c:when>
                        		<c:otherwise>
                        			어르신 장기요양기관
                        		</c:otherwise>
                        	</c:choose>
                        </div>
                        <c:if test="${!empty mbrConsltResultVO}">
	                        <a class="waves-effect btn btn_cancel align_center inline_flex gap02 rounded modal-trigger"
	                            href="#modal_counPlace">
	
	                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16"
	                                fill="none">
	                                <path fill-rule="evenodd" clip-rule="evenodd"
	                                    d="M7.99989 3.06946C5.27682 3.06946 3.06934 5.27694 3.06934 8.00001C3.06934 10.7231 5.27682 12.9306 7.99989 12.9306C10.723 12.9306 12.9304 10.7231 12.9304 8.00001C12.9304 5.27694 10.723 3.06946 7.99989 3.06946ZM1.81934 8.00001C1.81934 4.58659 4.58646 1.81946 7.99989 1.81946C11.4133 1.81946 14.1804 4.58659 14.1804 8.00001C14.1804 11.4134 11.4133 14.1806 7.99989 14.1806C4.58646 14.1806 1.81934 11.4134 1.81934 8.00001ZM7.99989 7.37502C8.34507 7.37502 8.62489 7.65484 8.62489 8.00002V10.2222C8.62489 10.5674 8.34507 10.8472 7.99989 10.8472C7.65471 10.8472 7.37489 10.5674 7.37489 10.2222V8.00002C7.37489 7.65484 7.65471 7.37502 7.99989 7.37502ZM7.99989 5.15279C7.65471 5.15279 7.37489 5.43261 7.37489 5.77779C7.37489 6.12297 7.65471 6.40279 7.99989 6.40279H8.00545C8.35062 6.40279 8.63045 6.12297 8.63045 5.77779C8.63045 5.43261 8.35062 5.15279 8.00545 5.15279H7.99989Z"
	                                    fill="#333333" />
	                            </svg>
	                            정보
	                        </a>
                        </c:if>
                    </div>

                    <div class="h20"></div>

                    <hr>

                    <div class="h20"></div>

                    <div class="font_sbls padH08">상담 진행상황</div>

                    <div class="h12"></div>



                    <div class="step_area_vertical">

                        <div class="step_txt_area">
                            <div class="vertical_bar">
                                <span class="bar_active"></span>
                            </div>
                            <div class="item <c:if test="${phaseNum eq 1}">active</c:if> <c:if test="${phaseNum >= 1 && isCancelConslt}"> past cancel</c:if>">
                                <span class="title color_t_d">신청완료</span>
                                <span class="color_t_t font_sbsr">
                                	<%=getDateFormat(reuqestChgHistVO)%>
                                </span>
                            </div>

                            <div class="h12"></div>

                            <div class="item <c:if test="${phaseNum eq 2}">active</c:if> <c:if test="${phaseNum >= 2 && isCancelConslt}"> past cancel</c:if>">
                                <span class="title">상담연결중</span>
                                <span class="color_t_t font_sbsr">
                                	<%=getDateFormat(connectChgHistVO)%>
                                </span>
                            </div>

                            <div class="h12"></div>

                            <div class="item <c:if test="${phaseNum eq 3}">active</c:if> <c:if test="${phaseNum >= 3 && isCancelConslt}"> past cancel</c:if>">
                                <span class="title fs10">상담진행중</span>
                                <span class="color_t_t font_sbsr">
                                	<%=getDateFormat(progressChgHistVO)%>
                                </span>
                            </div>

                            <div class="h12"></div>

                            <div class="item <c:if test="${phaseNum eq 4}">active</c:if> <c:if test="${phaseNum >= 4 && isCancelConslt}"> past cancel</c:if>">
                                <span class="title">상담완료</span>
                                <span class="color_t_t font_sbsr">
                                	<%=getDateFormat(completeChgHistVO)%>
                                </span>
                            </div>
                        </div>

						<c:if test="${isCancelConslt}">
	                        <div class="h12"></div>
	                        <div class="coun_cancel">
	                            <span class="title color_t_danger font_sbms">상담취소</span>
	                            <span class="color_t_t font_sbsr"><%=getDateFormat(mbrConsltVO.getCanclDt())%></span>
	                        </div>
						</c:if>

                    </div>

                </div>
                <!-- box_normal -->

                <div class="h12"></div>

                <div class="box_normal pad20">

                    <div class="font_sbls">길잡이</div>

                    <div class="h12"></div>

                    <div class="waves-effect list_link font_sbmr">인정등급 발급 절차</div>
                    <div class="waves-effect list_link font_sbmr">어떤 혜택을 받을 수 있나요?</div>

                    <div class="h24"></div>

                    <a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/bbs/guide/list';">더 알아보기</a>

                </div>
                <!-- box_normal -->

                <div class="h12"></div>

                <div class="box_normal padH12W20">

                    <div class="waves-effect padH16 w100p color_t_s font_sbmr">상담취소</div>

                </div>
            </section>
        </main>	    
	    

	</div>
	<!-- wrapper -->
	
	
	<!-- 장기요양기관 정보 모달 -->
	<c:if test="${!empty mbrConsltResultVO}">
	    <div id="modal_counPlace" class="modal bottom-sheet modal_om_select">
	
	        <div class="modal_header">
	            <h4 class="modal_title">${mbrConsltResultVO.bplcNm}</h4>
	            <div class="close_x modal-close waves-effect"></div>
	        </div>
	
	        <div class="modal-content">
	
	            <div class="marT4 color_t_s font_sbmr">
	                ${mbrConsltResultVO.bplcInfo.addr}<br>
	                ${mbrConsltResultVO.bplcInfo.daddr}
	            </div>
	
	            <div class="h20"></div>
	
	        </div>
	
	        <div class="modal-footer">
	            <div class="btn_area d-flex">
	                <a class="waves-effect btn btn-middle btn_white_bder w100p align_center gap02" onclick="callWithMobile('${mbrConsltResultVO.bplcInfo.telno}');">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16" fill="none">
	                        <path fill-rule="evenodd" clip-rule="evenodd" d="M10.5813 9.7076C10.7268 9.76804 10.859 9.8566 10.9703 9.96823L12.0958 11.0977C12.2078 11.2074 12.2966 11.3385 12.3569 11.4831C12.4173 11.6278 12.4479 11.7831 12.447 11.9399C12.4474 12.0977 12.4166 12.2541 12.3563 12.4C12.296 12.5459 12.2075 12.6784 12.0958 12.79L11.557 13.3328C11.3219 13.5535 11.0452 13.7252 10.7429 13.8375C10.4407 13.9499 10.119 14.0009 9.79686 13.9873C9.68519 13.9933 9.57327 13.9933 9.4616 13.9873C7.96491 13.8437 6.14493 12.8658 4.63227 11.3492C3.11961 9.83253 2.13778 8.03251 2.01007 6.53581C1.95569 6.15984 1.98626 5.77645 2.09953 5.41384C2.21281 5.05123 2.4059 4.71862 2.66462 4.44044L3.20742 3.90163C3.31897 3.78994 3.45151 3.70141 3.59741 3.64113C3.74331 3.58086 3.89968 3.55002 4.05754 3.55041C4.21429 3.54953 4.36961 3.58016 4.51428 3.6405C4.65895 3.70083 4.79001 3.78964 4.89968 3.90163L6.02918 5.02715C6.14081 5.13839 6.22938 5.27057 6.28981 5.41611C6.35024 5.56165 6.38135 5.71769 6.38135 5.87527C6.38135 6.03286 6.35024 6.1889 6.28981 6.33444C6.22938 6.47998 6.14081 6.61216 6.02918 6.7234L5.45046 7.30212C5.86401 7.95372 6.34858 8.55742 6.89527 9.10214C7.43999 9.64884 8.0437 10.1334 8.69529 10.547L9.27402 9.96823C9.38525 9.8566 9.51743 9.76804 9.66297 9.7076C9.80851 9.64717 9.96455 9.61606 10.1221 9.61606C10.2797 9.61606 10.4358 9.64717 10.5813 9.7076ZM10.2873 2.46696C11.0134 2.76768 11.6728 3.20915 12.2275 3.76593C12.7909 4.3258 13.2366 4.99281 13.5382 5.72763C13.8398 6.46244 13.9913 7.25021 13.9836 8.04448C13.9836 8.15033 13.9416 8.25185 13.8667 8.3267C13.7919 8.40155 13.6903 8.4436 13.5845 8.4436C13.4786 8.4436 13.3771 8.40155 13.3023 8.3267C13.2274 8.25185 13.1854 8.15033 13.1854 8.04448C13.1912 7.35943 13.0612 6.68001 12.8031 6.04543C12.5449 5.41085 12.1637 4.83368 11.6813 4.34722C11.1989 3.86076 10.625 3.47464 9.9926 3.21115C9.36022 2.94766 8.68192 2.81202 7.99684 2.81204C7.89098 2.81204 7.78947 2.76999 7.71462 2.69514C7.63977 2.62029 7.59772 2.51878 7.59772 2.41292C7.59772 2.30707 7.63977 2.20555 7.71462 2.1307C7.78947 2.05586 7.89098 2.01381 7.99684 2.01381C8.78275 2.01223 9.56121 2.16624 10.2873 2.46696ZM10.4835 6.83759C10.3622 6.54217 10.183 6.274 9.95647 6.04887C9.73577 5.82474 9.47308 5.64629 9.1834 5.52371C8.89372 5.40113 8.58273 5.33682 8.2682 5.33445C8.16234 5.33445 8.06083 5.2924 7.98598 5.21755C7.91113 5.1427 7.86908 5.04118 7.86908 4.93533C7.86908 4.82947 7.91113 4.72796 7.98598 4.65311C8.06083 4.57826 8.16234 4.53621 8.2682 4.53621C8.69088 4.53618 9.10936 4.62007 9.49937 4.78302C9.88938 4.94597 10.2432 5.18474 10.5402 5.48547C10.8372 5.7862 11.0716 6.14291 11.2296 6.53492C11.3877 6.92692 11.4664 7.34642 11.4611 7.76907C11.4611 7.87492 11.4191 7.97644 11.3442 8.05129C11.2694 8.12614 11.1679 8.16818 11.062 8.16818C10.9562 8.16818 10.8547 8.12614 10.7798 8.05129C10.705 7.97644 10.6629 7.87492 10.6629 7.76907C10.6658 7.44972 10.6048 7.13301 10.4835 6.83759Z" fill="#333333"/>
	                    </svg>
	                    전화하기
	                </a>
	                <a class="waves-effect btn btn-middle btn_white_bder w100p align_center gap02" onclick="copyAddrIntoClipboard('${mbrConsltResultVO.bplcInfo.addr}' + ' ' + '${mbrConsltResultVO.bplcInfo.daddr}');">
	                    <svg xmlns="http://www.w3.org/2000/svg" width="17" height="16" viewBox="0 0 17 16" fill="none">
	                        <path fill-rule="evenodd" clip-rule="evenodd" d="M4.88103 2.66663C4.42638 2.66663 3.99034 2.84724 3.66885 3.16873C3.34736 3.49022 3.16675 3.92626 3.16675 4.38091V10.0952C3.16675 10.2468 3.22695 10.3921 3.33412 10.4993C3.44128 10.6064 3.58662 10.6666 3.73818 10.6666C3.88973 10.6666 4.03507 10.6064 4.14224 10.4993C4.2494 10.3921 4.30961 10.2468 4.30961 10.0952V4.38091C4.30961 4.22936 4.36981 4.08401 4.47697 3.97685C4.58414 3.86969 4.72948 3.80948 4.88103 3.80948H10.5953C10.7469 3.80948 10.8922 3.74928 10.9994 3.64212C11.1065 3.53495 11.1667 3.38961 11.1667 3.23805C11.1667 3.0865 11.1065 2.94116 10.9994 2.83399C10.8922 2.72683 10.7469 2.66663 10.5953 2.66663H4.88103ZM6.59532 4.95234C6.29221 4.95234 6.00152 5.07275 5.7872 5.28708C5.57287 5.5014 5.45246 5.79209 5.45246 6.0952V12.1904C5.45246 12.4935 5.57287 12.7842 5.7872 12.9986C6.00152 13.2129 6.29221 13.3333 6.59532 13.3333H12.6906C12.9937 13.3333 13.2844 13.2129 13.4987 12.9986C13.713 12.7842 13.8334 12.4935 13.8334 12.1904V6.0952C13.8334 5.79209 13.713 5.5014 13.4987 5.28708C13.2844 5.07275 12.9937 4.95234 12.6906 4.95234H6.59532Z" fill="#333333"/>
	                    </svg>
	                    주소복사하기
	                </a>
	            </div>
	        </div>
	    </div>
    </c:if>
	
	
	<script>
		//전화하기
		function callWithMobile (tel) {
			sendDataToMobileApp({ actionName: 'callOpenUrl', url: 'tel:' + tel });
		}
	
		//클립보드에 텍스트 복사
		function copyAddrIntoClipboard(text) {
			navigator.clipboard.writeText(text);
		}
	
	
	    $(function () {
	
	    	//body에 css class 추가
			$('body').addClass('back_gray');
	    	
	    	
	        //세로 스크롤
	        //전체 진행바 높이
	        var step_txt_areaHeight = $('.step_txt_area').height() - 30;
	        $('.vertical_bar').css('height', step_txt_areaHeight + 'px');
	
	        //진행바 높이
	        var bar_activeTop = $('.step_txt_area .active').position().top + 12;
	        $('.vertical_bar .bar_active').css('height', bar_activeTop + 'px');
	
	        //지난결과 class추가
	        $('.step_txt_area .item.active').prevAll('.item').addClass('past');
	
	        //지난결과 class추가 -취소시
	        $('.step_txt_area .item.active.cancel').prevAll('.item').addClass('past cancel');
	
	    });
	</script>