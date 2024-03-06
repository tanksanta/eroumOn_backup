<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">

	    <header>
	      <nav class="top">
	        <div class="btn_back">
	          <div class="txt">
	            <span class="txtEvt">어르신</span>
	          </div>
	        </div>
	
	      </nav>
	    </header>
	
	
	    <main>
	      <section class="default">
	
			<%-- 선택된 수급자 index + 1 --%>
			<c:set var="selectedIndex" value="" />
		
	        <div class="om_reg_area">
	          <ul>
				<c:forEach var="recipientInfo" items="${mbrRecipientsList}" varStatus="status">
					<li class="fl_0${status.index + 1} waves-effect<c:if test="${recipientInfo.recipientsNo == curRecipientInfo.recipientsNo}"> active<c:set var="selectedIndex" value="${status.index + 1}" /></c:if>" 
						recipientsNo="${recipientInfo.recipientsNo}"
						onclick="location.href='/matching/membership/recipients/subMain?recipientsNo=${recipientInfo.recipientsNo}';">
						${recipientInfo.recipientsNm}
					</li>
				</c:forEach>
				<c:if test="${fn:length(mbrRecipientsList) < 4}">
					<li class="reg_btn waves-effect">어르신 등록</li>
				</c:if>
	          </ul>
	        </div>
	
	        <div class="h20"></div>
	
	        <div class="card active waves-effect w100p">
	
	          <div class="card-content box_om_profile pad20">
	
	            <div class="img_area fl_0${selectedIndex}">
	            	<c:if test="${curRecipientInfo.mainYn eq 'Y'}">
	            		<span class="txt">대표</span>
	            	</c:if>
	            </div>
	
	            <div>
	              <div class="font_sbmr"><span class="font_sbmb">${curRecipientInfo.recipientsNm}</span>님</div>
	              <div class="marT5">
	                <span class="badge_reco_num">요양인정번호</span>
	                <span class="font_sbsb">${curRecipientInfo.recipientsYn == 'Y' ? curRecipientInfo.rcperRcognNo : '등록해주세요'}</span>
	              </div>
	            </div>
	
	          </div>
	        </div>
	        <!-- card -->
	
	        <div class="align_center">
	          <img src="/html/page/app/matching/assets/src/images/08etc/link_40.svg" alt="obj" class="disBlock">
	        </div>
	
	        <div class="card">
			<c:choose>
			  <%-- 상담정보가 있을 때 --%>
			  <c:when test="${!empty consltInfo}">
			      <%-- 사업소 상담정보 가져오기 --%>
			      <c:set var="consltResultInfo" value="${fn:length(consltInfo.consltResultList) > 0 ? consltInfo.consltResultList[0] : null}" />
			  	
		          <div class="card-content">
		          
		            <div class="box_sub02">
		              <div class="img_area">
		                <img src="/html/page/app/matching/assets/src/images/08etc/bp_40.svg" alt="혜택">
		              </div>
		              <div class="ctn_area">
		              <c:choose>
		              	<c:when test="${!empty consltResultInfo}">
		                	<div class="font_sbls">${consltResultInfo.bplcNm}</div>
		                </c:when>
		                <c:otherwise>
		                	<div class="color_t_t font_sbls">어르신 장기요양기관</div>
		                </c:otherwise>
		              </c:choose>
		              </div>
		            </div>
		
		            <div class="h16"></div>
		
					<%-- 상담 취소 여부 --%>
					<c:set var="isCancelConslt" value="${consltInfo.consltSttus eq 'CS03' || consltInfo.consltSttus eq 'CS04' || consltInfo.consltSttus eq 'CS09' ? true : false}" />
					
		            <div class="step_area">
		              <%-- 텍스트영역에 active시 그래프영역에도 active 처리 - guide.js 참조--%>
		              <ul class="step_txt_area">
		                <li class="<c:if test="${consltInfo.consltSttus eq 'CS01' || consltInfo.consltSttus eq 'CS07'}">active</c:if><c:if test="${isCancelConslt}"> font_scxst</c:if>">신청완료</li>
		                <li class="<c:if test="${consltInfo.consltSttus eq 'CS02' || consltInfo.consltSttus eq 'CS08'}">active</c:if><c:if test="${isCancelConslt}"> font_scxst</c:if>">상담연결중</li>
		                <li class="<c:if test="${consltInfo.consltSttus eq 'CS05'}">active</c:if><c:if test="${isCancelConslt}"> font_scxst</c:if>">상담진행중</li>
		                <li class="<c:if test="${consltInfo.consltSttus eq 'CS06'}">active</c:if><c:if test="${isCancelConslt}"> font_scxst</c:if>">상담완료</li>
		              </ul>
		              <ul class="step_graph_area">
		                <li class="item"></li>
		                <li class="item"></li>
		                <li class="item"></li>
		                <li class="item"></li>
		              </ul>
		            </div>
		
		            <div class="h16"></div>
		
		            <div class="align_center gap04">
		              <c:choose>
		              	<%-- 취소 이미지 --%>
		              	<c:when test="${isCancelConslt}">
		              		<svg xmlns="http://www.w3.org/2000/svg" width="17" height="18" viewBox="0 0 17 18" fill="none">
				              <path fill-rule="evenodd" clip-rule="evenodd" d="M15.1668 8.99999C15.1668 12.7878 12.1821 15.8585 8.50016 15.8585C4.81826 15.8585 1.8335 12.7878 1.8335 8.99999C1.8335 5.21214 4.81826 2.14148 8.50016 2.14148C12.1821 2.14148 15.1668 5.21214 15.1668 8.99999ZM10.8485 6.58389C11.0465 6.77636 11.051 7.09292 10.8585 7.29093L9.19729 8.99998L10.8585 10.709C11.051 10.907 11.0465 11.2236 10.8485 11.4161C10.6505 11.6085 10.3339 11.604 10.1415 11.406L8.5 9.71733L6.85853 11.406C6.66606 11.604 6.34951 11.6085 6.1515 11.4161C5.95349 11.2236 5.949 10.907 6.14147 10.709L7.80271 8.99998L6.14147 7.29093C5.949 7.09292 5.95349 6.77636 6.1515 6.58389C6.34951 6.39142 6.66606 6.39591 6.85853 6.59392L8.5 8.28263L10.1415 6.59392C10.3339 6.39591 10.6505 6.39142 10.8485 6.58389Z" fill="#E53935"/>
				            </svg>
		              	</c:when>
		              	<%-- 상담완료 체크 이미지 --%>
		              	<c:when test="${consltInfo.consltSttus eq 'CS06'}">
		              		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="18" viewBox="0 0 16 18" fill="none">
				              <path d="M8.00016 2.14148C4.32016 2.14148 1.3335 5.21409 1.3335 8.99999C1.3335 12.7859 4.32016 15.8585 8.00016 15.8585C11.6802 15.8585 14.6668 12.7859 14.6668 8.99999C14.6668 5.21409 11.6802 2.14148 8.00016 2.14148ZM7.12352 11.9594C6.87342 12.2167 6.46024 12.2167 6.21014 11.9594L3.79049 9.47014C3.53603 9.20836 3.53603 8.79163 3.79049 8.52984C4.05511 8.25761 4.49219 8.2573 4.75719 8.52917L6.35466 10.168C6.52569 10.3435 6.80777 10.3433 6.97856 10.1676L11.2401 5.78345C11.5064 5.5095 11.9465 5.51028 12.2118 5.78516C12.4654 6.04792 12.4647 6.46454 12.2102 6.7264L7.12352 11.9594Z" fill="#FF8120"/>
				            </svg>
		              	</c:when>
		              	<%-- 상담 진행중 애니메이션 --%>
		              	<c:otherwise>
		              		<dotlottie-player src="https://lottie.host/1708b753-45e2-467d-b994-741cd16f91cb/hlyaHKO1FL.json"
		                	background="transparent" speed="1" style="width: 20px; height: 20px;" loop autoplay></dotlottie-player>
		              	</c:otherwise>
		              </c:choose>
		              
		              <c:choose>
		              	<c:when test="${consltInfo.consltSttus eq 'CS01' || consltInfo.consltSttus eq 'CS07'}">
		              		<div class="color_tp_p font_sbss">어르신에게 적합한 곳을 연결 중이에요</div>		
		              	</c:when>
		              	<c:when test="${consltInfo.consltSttus eq 'CS02' || consltInfo.consltSttus eq 'CS08'}">
		              		<div class="color_tp_p font_sbss">적합한 곳을 찾았어요! 기다려주세요</div>		
		              	</c:when>
		              	<c:when test="${consltInfo.consltSttus eq 'CS05'}">
		              		<div class="color_tp_p font_sbss">곧 연락드릴게요</div>		
		              	</c:when>
		              	<c:when test="${consltInfo.consltSttus eq 'CS06'}">
		              		<div class="color_tp_p font_sbss">상담완료</div>
		              	</c:when>
		              	<c:otherwise>
		              		<div class="color_tp_p font_sbss">취소되었어요</div>
		              	</c:otherwise>
		              </c:choose>
		              
		            </div>
		
		            <div class="h24"></div>
		
		
		            <a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/membership/conslt/list';">상담내역 보기</a>
		
		          </div>
	          </c:when>
	          <c:otherwise>
		          <div class="card-content">
	
		            <div class="box_sub02">
		              <div class="img_area">
		                <img src="/html/page/app/matching/assets/src/images/08etc/bp_40.svg" alt="혜택">
		              </div>
		              <div class="ctn_area">
		                <div class="color_t_t font_sbls">어르신 장기요양기관</div>
		              </div>
		            </div>
		
		            <div class="h24"></div>
		
		            <a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/main/service';">상담 신청하고 추천받기</a>
		
		          </div>
	          </c:otherwise>
	        </c:choose>
	        </div>
	
	        <div class="h32"></div>
	
	
	
	        <div class="card">
			<c:choose>
			  <c:when test="${fn:length(recipientsGdsCheckMap) > 0}">
	          <div class="card-content">
	
	            <div class="d-flex justify-content-between align-items-center">
	              <div class="color_t_p font_sbms">관심 복지용구</div>
	              
	              <%-- 상담진행중이면 노출하지 않음 --%>
	              <c:if test="${empty progressEquipCtgry}">
	              	<div class="waves-effect link_text small_thin" onclick="location.href='/matching/welfareinfo/interest/intro?recipientsNo=${curRecipientInfo.recipientsNo}';">설정하기</div>
	              </c:if>
	            </div>
	
	            <div class="h24"></div>
	
	            <div class="wel_select_slide marW-20">
				  
				  <c:if test="${ recipientsGdsCheckMap['10a0'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_01.svg" alt="성인용 보행기">
	                </div>
	                <span class="txt">성인용 보행기</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	              
	              <c:if test="${ recipientsGdsCheckMap['2080'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_02.svg" alt="수동휠체어">
	                </div>
	                <span class="txt">수동휠체어</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	              
	              <c:if test="${ recipientsGdsCheckMap['1050'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_03.svg" alt="지팡이">
	                </div>
	                <span class="txt">지팡이</span>
	              </div>
	              <!-- ctn -->
	              </c:if>

				  <c:if test="${ recipientsGdsCheckMap['1090'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_04.svg" alt="안전손잡이">
	                </div>
	                <span class="txt">안전손잡이</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	
				  <c:if test="${ recipientsGdsCheckMap['1080'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_05.svg" alt="미끄럼방지 매트">
	                </div>
	                <span class="txt">미끄럼방지<br>매트</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	              
	              <c:if test="${ recipientsGdsCheckMap['1070'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_06.svg" alt="미끄럼방지 양말">
	                </div>
	                <span class="txt">미끄럼방지<br>양말</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	
				  <c:if test="${ recipientsGdsCheckMap['1010'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_07.svg" alt="욕창예방 매트리스">
	                </div>
	                <span class="txt">욕창예방<br>매트리스</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	
				  <c:if test="${ recipientsGdsCheckMap['1040'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_08.svg" alt="욕창예방 방석">
	                </div>
	                <span class="txt">욕창예방 방석</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	
				  <c:if test="${ recipientsGdsCheckMap['1030'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_09.svg" alt="자세변환용구">
	                </div>
	                <span class="txt">자세변환용구</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	
				  <c:if test="${ recipientsGdsCheckMap['1020'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_10.svg" alt="요실금 팬티">
	                </div>
	                <span class="txt">요실금 팬티</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	
				  <c:if test="${ recipientsGdsCheckMap['10b0'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_11.svg" alt="목욕의자">
	                </div>
	                <span class="txt">목욕의자</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	
				  <c:if test="${ recipientsGdsCheckMap['10c0'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_12.svg" alt="이동변기">
	                </div>
	                <span class="txt">이동변기</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	
				  <c:if test="${ recipientsGdsCheckMap['1060'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_13.svg" alt="간이변기">
	                </div>
	                <span class="txt">간이변기</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	
				  <c:if test="${ recipientsGdsCheckMap['10d0'] }">
	              <div class="ctn waves-effect">
	                <div class="img_area">
	                  <img src="/html/page/app/matching/assets/src/images/02tool/tool02_14.svg" alt="경사로">
	                </div>
	                <span class="txt">경사로</span>
	              </div>
	              <!-- ctn -->
	              </c:if>
	
	            </div>
	
	
	            <div class="h24"></div>
	
				<%-- 상담중인 경우는 상담내역 보기로 노출 --%>
				<c:choose>
					<c:when test="${empty progressEquipCtgry}">
						<a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/membership/conslt/infoConfirm?prevPath=equip_ctgry&recipientsNo=${curRecipientInfo.recipientsNo}'">상담하기</a>
					</c:when>
					<c:otherwise>
						<a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/membership/conslt/list';">상담내역 보기</a>
					</c:otherwise>
				</c:choose>
	
	          </div>
	          </c:when>
	          <c:otherwise>
	          <div class="card-content">

	            <div class="color_t_p font_sbms">관심 복지용구</div>
	            <div class="marT4 color_t_s font_sbsr">장기요양금액으로 복지용구 지원받기</div>
	
	            <div class="h20"></div>
	
	            <div class="align_center">
	              <dotlottie-player src="https://lottie.host/26738494-b2f9-4f58-9ac3-7f08ab97128c/SVbf5oVEgn.json" background="transparent" speed="1" style="width: 280px; height: 130px;" loop autoplay></dotlottie-player>
	            </div>
	
	            <div class="h20"></div>
	
	            <a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/welfareinfo/interest/intro?recipientsNo=${curRecipientInfo.recipientsNo}';">설정하기</a>
	
	          </div>
	          </c:otherwise>
	        </c:choose>
	        </div>
	        <!-- card -->
	
	        <div class="h32"></div>
	
	
	        <div class="card">
	
			  <c:choose>
			  	  <c:when test="${!empty simpleTestInfo}">
		          <div class="card-content">
		
		            <div class="d-flex justify-content-between align-items-center">
		              <div class="color_t_p font_sbms">인정등급 간편 테스트</div>
		              
		              <%-- 상담진행중이면 노출하지 않음 --%>
	              	  <c:if test="${empty progressSimpleTest}">
		              	<div class="waves-effect link_text small_thin" onclick="location.href='/matching/simpletest/simple/intro?recipientsNo=${curRecipientInfo.recipientsNo}';">다시하기</div>
		              </c:if>
		            </div>
		
		            <div class="h24"></div>
		
		            <div class="align_center">
		              
		              <%-- 대상자 이미지 --%>
		              <c:choose>
		              	<c:when test="${simpleTestInfo.grade eq 1}">
		              		<img src="/html/page/app/matching/assets/src/images/11easy/easy_09.svg" alt="간편 테스트">
		              	</c:when>
		              	<c:otherwise>
		              		<img src="/html/page/app/matching/assets/src/images/11easy/easy_11.svg" alt="간편 테스트">
		              	</c:otherwise>
		              </c:choose>
		              
		            </div>
		
		            <div class="h24"></div>
		
					<%-- 상담중인 경우는 상담내역 보기로 노출 --%>
					<c:choose>
						<c:when test="${empty progressSimpleTest}">
							<a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/membership/conslt/infoConfirm?prevPath=simple_test&recipientsNo=${curRecipientInfo.recipientsNo}'">상담하기</a>
						</c:when>
						<c:otherwise>
							<a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/membership/conslt/list';">상담내역 보기</a>
						</c:otherwise>
					</c:choose>
		            
		          </div>
		          </c:when>
		          <c:otherwise>
		          <div class="card-content">

		              <div class="color_t_p font_sbms">인정등급 간편 테스트</div>
		              <div class="marT4 color_t_s font_sbsr">혜택 받을 수 있는 지 빠르게 확인하기</div>
		
		            <div class="h20"></div>
		
		            <div class="align_center">
		              <dotlottie-player src="https://lottie.host/be472d60-5369-4388-a90b-a0e465a565a4/FerkdXUTyC.json" background="transparent" speed="1" style="width: 200px; height: 132px;" loop autoplay></dotlottie-player>
		            </div>
		
		            <div class="h20"></div>
		
		            <a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/simpletest/simple/intro?recipientsNo=${curRecipientInfo.recipientsNo}';">확인하기</a>
		
		          </div>
		          </c:otherwise>
	          </c:choose>
	          
	        </div>
	        <!-- card -->
	
	        <div class="h32"></div>
	
	        <div class="card">
	
			  <c:choose>
			  	<c:when test="${!empty careTestInfo}">
		          <div class="card-content">
		
		            <div class="d-flex justify-content-between align-items-center">
		              <div class="color_t_p font_sbms">어르신 돌봄</div>
		              
		              <%-- 상담진행중이면 노출하지 않음 --%>
	              	  <c:if test="${empty progressCare}">
		              	<div class="waves-effect link_text small_thin" onclick="location.href='/matching/simpletest/care/intro?recipientsNo=${curRecipientInfo.recipientsNo}';">설정하기</div>
		              </c:if>
		              
		            </div>
		
		            <div class="h24"></div>
		
					<!-- 시간 선택 이미지 -->
					<c:choose>
						<c:when test="${careTestInfo.careTime eq 10}">
							<div class="align_center">
				              <img src="/html/page/app/matching/assets/src/images/08etc/time03_80.svg" style="height:132px;" alt="어르신 돌봄">		
				            </div>
				            <div class="h12"></div>
				            <div class="center font_sbms">8~10시간</div>
						</c:when>
						<c:when test="${careTestInfo.careTime eq 8}">
							<div class="align_center">
				              <img src="/html/page/app/matching/assets/src/images/08etc/time02_80.svg" style="height:132px;" alt="어르신 돌봄">		
				            </div>
				            <div class="h12"></div>
				            <div class="center font_sbms">3~8시간</div>
						</c:when>
						<c:otherwise>
				            <div class="align_center">
				              <img src="/html/page/app/matching/assets/src/images/08etc/time01_80.svg" style="height:132px;" alt="어르신 돌봄">		
				            </div>
				            <div class="h12"></div>
				            <div class="center font_sbms">3시간 이내</div>
						</c:otherwise>
					</c:choose>
		
		            <div class="h24"></div>
		            
		            <%-- 상담중인 경우는 상담내역 보기로 노출 --%>
					<c:choose>
						<c:when test="${empty progressCare}">
							<a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/membership/conslt/infoConfirm?prevPath=care&recipientsNo=${curRecipientInfo.recipientsNo}'">상담하기</a>
						</c:when>
						<c:otherwise>
							<a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/membership/conslt/list';">상담내역 보기</a>
						</c:otherwise>
					</c:choose>
		
		          </div>
	          	</c:when>
	          	<c:otherwise>
	          	  <div class="card-content">

		              <div class="color_t_p font_sbms">어르신 돌봄</div>
		              <div class="marT4 color_t_s font_sbsr">필요한 시간에 돌봄 서비스 지원받기</div>
		
		            <div class="h20"></div>
		
		            <div class="align_center">
		               <dotlottie-player src="https://lottie.host/6cc52783-7906-4744-8b24-7f7edb478789/ZxIn89efOe.json" background="transparent" speed="1" style="width: 160px; height: 160px;" loop autoplay></dotlottie-player>
		            </div>
		
		            <div class="h20"></div>
		
		            <a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/simpletest/care/intro?recipientsNo=${curRecipientInfo.recipientsNo}';">설정하기</a>
		
		          </div>
	          	</c:otherwise>
	          </c:choose>
	        </div>
	        <!-- card -->
	
	      </section>
	    </main>
	
	    <!-- 하단 네이비게이션 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/bottomNavigation.jsp">
			<jsp:param value="recipients" name="menuName" />
		</jsp:include>

	</div>
	<!-- wrapper -->
	
	
	<script>
		$(function() {
			//현재 페이지 history 저장 
			saveCurrentPageHistory();
			
			//body에 css class 추가
			$('body').addClass('back_gray');
		});
	</script>