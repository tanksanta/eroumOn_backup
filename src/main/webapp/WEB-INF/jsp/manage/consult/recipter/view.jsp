<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- page content -->
            <div id="page-content">
                <p class="mb-7">인정등급테스트 후 1:1상담 신청한 내역을 확인하는 페이지입니다.</p>
                <form:form action="./action" method="post" id="frmView" name="frmView" modelAttribute="mbrConsltVO" onsubmit="return submitEvent();">
				<form:hidden path="consltNo" />
				<form:hidden path="consltSttus" />
                    <fieldset>
                        <legend class="text-title2">상담내역</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">수급자 성명</th>
                                    <td>${mbrConsltVO.mbrNm}</td>
                                    <th scope="row">수급자와의 관계</th>
                                    <td>${MBR_RELATION_CD[mbrConsltVO.relationCd]}</td>
                                </tr>
                                <tr>
                                    <th scope="row">회원아이디</th>
                                    <td>${mbrConsltVO.regId}</td>
                                    <th scope="row">상담유형</th>
                                    <td>${PREV_PATH[mbrConsltVO.prevPath]}</td>
                                </tr>
                                <tr>
                                    <th scope="row">성별</th>
                                    <td>${genderCode[mbrConsltVO.gender]}</td>
                                    <th scope="row">상담유형 상세</th>
                                    <td>
                                    	<c:if test="${mbrConsltVO.prevPath == 'test'}">
                                    		<button type="button" class="btn-primary" data-bs-toggle="modal" data-bs-target="#grade-test-result">등급테스트결과</button>
                                    	</c:if>
                                    	<c:if test="${not empty mbrConsltVO.rcperRcognNo}">
                                    		<button type="button" class="btn-primary" onclick="getRecipientInfo('${mbrConsltVO.recipientsNo}');">요양정보</button>
                                    	</c:if>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">생년월일</th>
                                    <td><fmt:formatDate value="${mbrVO.brdt}" pattern="yyyy-MM-dd" /></td>
                                    <th scope="row">장기요양인정번호</th>
                                    <td>
                                        <c:choose>  
                                            <c:when test="${not empty mbrConsltVO.rcperRcognNo}">L${mbrConsltVO.rcperRcognNo}</c:when> 
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">상담받을 연락처</th>
                                    <td>${mbrConsltVO.mbrTelno}</td>
                                    <th scope="row">상담신청일시</th>
                                    <td><fmt:formatDate value="${mbrConsltVO.regDt}" pattern="yyyy-MM-dd HH:mm" /></td>
                                </tr>
                                <tr>
                                    <th scope="row">실거주지 주소</th>
                                    <td colspan="3">${mbrConsltVO.zip}&nbsp;${mbrConsltVO.addr}&nbsp;${mbrConsltVO.daddr}</td>
                                </tr>
                                <tr>
                                    <th scope="row">장기요양기관 지정</th>
                                    <td colspan="3">
                                    	<input type="hidden" id="bplcUniqueId" name="bplcUniqueId" value="">
                                    	<input type="hidden" id="bplcId" name="bplcId" value="">
                                    	<input type="hidden" id="bplcNm" name="bplcNm" value="">
                                    	<input type="hidden" id="consltmbrNm" name="consltmbrNm" value="${mbrConsltVO.mbrNm}">
                                    	<input type="hidden" id="consltMbrTelno" name="consltMbrTelno" value="${mbrConsltVO.mbrTelno}">
                                    	<input type="hidden" id="regUniqueId" name="regUniqueId" value="${mbrConsltVO.getRegUniqueId()}">
                                        <input type="hidden" id="originConsltBplcUniqueId" name="originConsltBplcUniqueId" value="${consltBplcUniqueId}">
                                    	<input type="hidden" id="chgHistListSize" name="chgHistListSize" value="${chgHistList.size()}">
                                    	<input type="hidden" id="originConsltSttus" name="originConsltSttus" value="${mbrConsltVO.consltSttus}">
                                        
										<!-- 진행(CS05)전 상태이면 사업소 수정가능하게 해야함 -->

										<c:if test="${(mbrConsltVO.consltSttus eq 'CS01' || mbrConsltVO.consltSttus eq 'CS07') || mbrConsltVO.consltSttus eq 'CS02' || mbrConsltVO.consltSttus eq 'CS04' }">
                                        <button type="button" class="btn-primary shadow f_srchBplc" data-bs-toggle="modal" data-bs-target="#bplcModal">선택</button>
                                        </c:if>

                                        <ul class="mt-2 space-y-1 bplcLi">
                                        	<c:forEach items="${mbrConsltVO.consltResultList}" var="resultList" varStatus="status">
                                            <li>${status.index+1}차 상담 사업소 : ${resultList.bplcNm} (${resultList.bplcInfo.telno}
                                            	/ <img src="/html/page/members/assets/images/ico-mypage-recommend.svg" style="display: inline; margin-top: -2px; margin-right: 3px; height: 13px;">${resultList.bplcInfo.rcmdCnt})
                                            	, 상담 배정 일시 : <fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss" />
                                            </li>
                                        	</c:forEach>
                                        </ul>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">탈퇴여부</th>
                                    <td>
                                        <c:choose>  
                                            <c:when test="${mbrVO.mberSttus eq 'EXIT'}">${MBER_STTUS[mbrVO.mberSttus]}</c:when> 
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <th scope="row">상담진행상태</th>
                                    <td>
                                        <ul class="space-y-1">
                                            <li>
                                            	<c:choose>
													<c:when test="${mbrConsltVO.consltSttus eq 'CS01'}"><span class="text-red1">상담 신청 접수</span></c:when>
													<c:when test="${mbrConsltVO.consltSttus eq 'CS02'}">상담 기관 배정 완료</c:when>
													<c:when test="${mbrConsltVO.consltSttus eq 'CS03'}">상담 취소<br>(상담자)</c:when>
													<c:when test="${mbrConsltVO.consltSttus eq 'CS04'}">상담 취소<br>(상담기관)</c:when>
													<c:when test="${mbrConsltVO.consltSttus eq 'CS09'}">상담 취소<br>(THKC)</c:when>
													<c:when test="${mbrConsltVO.consltSttus eq 'CS05'}">상담 진행 중</c:when>
													<c:when test="${mbrConsltVO.consltSttus eq 'CS06'}">상담 완료</c:when>
													<c:when test="${mbrConsltVO.consltSttus eq 'CS07'}">
													<span class="text-red1">재상담 신청 접수</span>
                                                	<a href="#modal3" class="btn-primary tiny shadow relative -top-px" data-bs-toggle="modal" data-bs-target="#modal3">재상담 신청 사유 확인</a>
													</c:when>
													<c:when test="${mbrConsltVO.consltSttus eq 'CS08'}">상담 기관 재배정 완료</c:when>
												</c:choose>
                                            </li>
                                        </ul>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>
                    
                    <%--
					<c:if test="${mbrConsltVO.consltSttus eq 'CS03'}">
                    <fieldset class="mt-13">
                        <legend class="text-title2">상담 취소 사유</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="form-item1">상담 취소 사유</label></th>
                                    <td><textarea name="vwCanclResn" id="vwCanclResn" cols="30" rows="5" class="form-control w-full" readonly="readonly">${mbrConsltVO.canclResn }</textarea></td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>
                    </c:if>
                    --%>
                    
                    <c:set var="pageParam" value="curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;srchRegBgng=${param.srchRegBgng}&amp;srchRegEnd=${param.srchRegEnd}&amp;srchMbrNm=${param.srchMbrNm}&amp;srchMbrTelno=${param.srchMbrTelno}&amp;srchConsltSttus=${param.srchConsltSttus}" />
                    <div class="btn-group right mt-5">
                    	<c:if test="${mbrConsltVO.consltSttus ne 'CS01' && fn:length(mbrConsltVO.consltResultList) > 0}">
                        	<button type="button" class="btn-primary large shadow float-left" data-bs-toggle="modal" data-bs-target="#modal4">멤버스 상담 내역 확인</button>
                        </c:if>
                        
                        <c:if test="${mbrConsltVO.consltSttus ne 'CS03' && mbrConsltVO.consltSttus ne 'CS04' && mbrConsltVO.consltSttus ne 'CS06' && mbrConsltVO.consltSttus ne 'CS09' }">
                        	<button type="button" class="btn-danger large shadow" data-bs-toggle="modal" data-bs-target="#modal1">상담취소</button>
                        </c:if>
                        <c:if test="${mbrConsltVO.consltSttus eq 'CS01' || mbrConsltVO.consltSttus eq 'CS02' || mbrConsltVO.consltSttus eq 'CS07' }">
	                        <button type="submit" class="btn-success large shadow">저장</button>
	                        <button type="button" class="btn-warning large shadow" data-bs-toggle="modal" data-bs-target="#modal-consulting-info">정보수정</button>
                        </c:if>
                        <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
                    </div>

					<%--
                    <fieldset class="mt-13">
                        <legend class="text-title2">상담내용(관리자 메모)</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
  	                          </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">상담진행상태</th>
                                    <td>
                                    	<c:choose>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS01'}"><span class="text-red1">상담 신청 접수</span></c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS02'}">상담 기관 배정 완료</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS03'}">상담 취소<br>(상담자)</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS09'}">상담 취소<br>(THKC)</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS04'}">상담 취소<br>(상담기관)</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS05'}">상담 진행 중</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS06'}">상담 완료</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS07'}"><span class="text-red1">재상담 신청 접수</span></c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS08'}">상담 기관 재배정 완료</c:when>
										</c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="mngMemo" class="require">상담내용</label></th>
                                    <td>
                                    	<textarea id="mngMemo" name="mngMemo" class="form-control w-full" title="메모" cols="30" rows="5">${mbrConsltVO.mngMemo }</textarea>
                                    </td>
                                </tr>
                                <c:if test="${!empty mbrConsltVO.mngrUniqueId}">
                                <tr>
                                    <th scope="row">등록일</th>
                                    <td>${mbrConsltVO.mngrNm}(${mbrConsltVO.mngrId}) / <fmt:formatDate value="${mbrConsltVO.memoMdfcnDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </fieldset>
                    --%>
                </form:form>
                

				<fieldset class="mt-15">                                                                                                
				    <legend class="text-title2">상담기록 및 진행상태 변경 내역</legend>                                                                 
				    <table class="table-detail">
				        <colgroup>
				            <col class="w-full">
				            <col>
				        </colgroup>
				        <tbody>                               
				            <tr>  
				                <!-- <th scope="row"><label for="form-item1">내역</label></th> -->
				                <td>
				                    <textarea name="" id="form-item1" cols="30" rows="5" class="w-full p-3" readonly>${historyText}</textarea>
				                </td>                      
				            </tr>                                
				        </tbody>
				    </table>
				</fieldset>

				<fieldset class="mt-5">                                                                        
				    <legend class="text-title2">상담기록</legend>
				    <div class="btn-group right mx-2">
				        <button class="small shadow btn-primary f_saveMngMemo">저장</button>
				    </div>                        
				    <table class="table-detail">
				        <colgroup>
				            <col class="w-43">
				            <col>
				        </colgroup>
				        <tbody>                               
				            <tr>
				                <th scope="row"><label for="form-item1">상담기록 작성</label></th>
				                <td>
				                	<textarea name="" id="mngMemo" cols="30" rows="5" class="form-control w-full"></textarea>
				                </td>
				            </tr>                                
				        </tbody>
				    </table>
				</fieldset>
				
				<fieldset class="mt-5">                        
                    <legend class="text-title2">상담진행상태 변경</legend>
                    <div class="btn-group right mx-2">
                        <button class="small shadow btn-primary f_changeConsltSttus">저장</button>
                    </div>
                    <table class="table-detail">
                        <colgroup>
                            <col class="w-43">
                            <col>
                        </colgroup>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">현재</th>
                                    <td class="currentSttus">
                                    	<c:choose>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS01'}"><span class="text-red1">상담 신청 접수</span></c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS02'}">상담 기관 배정 완료</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS03'}">상담 취소<br>(상담자)</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS09'}">상담 취소<br>(THKC)</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS04'}">상담 취소<br>(상담기관)</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS05'}">상담 진행 중</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS06'}">상담 완료</c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS07'}"><span class="text-red1">재상담 신청 접수</span></c:when>
											<c:when test="${mbrConsltVO.consltSttus eq 'CS08'}">상담 기관 재배정 완료</c:when>
										</c:choose>
                                    </td>
                                    <th scope="row">변경</th>
                                    <td>
                                        <select name="chgSttusSelect" id="chgSttusSelect" class="form-control w-50">
                                            <option value="">선택</option>
                                            <option value="CS01">상담 신청 접수</option>
                                            <option value="CS02">상담 기관 배정 완료</option>
                                            <option value="CS03">상담 취소 (상담자)</option>
                                            <option value="CS09">상담 취소 (THKC)</option>
                                            <option value="CS04">상담 취소 (상담기관)</option>
                                            <option value="CS05">상담 진행 중</option>
                                            <option value="CS06">상담 완료</option>
                                            <option value="CS07">재상담 신청 접수</option>
                                            <option value="CS08">상담 기관 재배정 완료</option>             
                                        </select>
                                    </td>
                                </tr>                                   
                            </tbody>
                        </table>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>                               
                                                            
                            </tbody>
                        </table>                         
                    </table>
                </fieldset>  


                <!-- 상담 취소 사유 -->
                <div class="modal fade" id="modal1" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <form class="modal-content" id="modalCancl" name="modalCancl" method="post">
                            <div class="modal-header">
                                <p>상담 취소 사유 입력</p>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                            </div>
                            <fieldset class="modal-body">
                                <label>상담 취소 사유를 입력해 주세요</label>
                                <p class="text-red1">※ 상담 취소 시 재상담 신청 접수가 불가합니다.</p>
                                <textarea name="canclResn" id="canclResn" cols="30" rows="5" class="form-control w-full mt-4"></textarea>
                            </fieldset>
                            <div class="modal-footer">
                                <button tyep="button" class="btn large btn-primary w-36 f_saveCanclResn">저장하기</button>
                                <button type="button" class="btn large btn-secondary w-36" data-bs-dismiss="modal" aria-label="close">취소</button>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- //상담 취소 사유 -->

                <!-- 사업소 선택 -->
                <c:import url="/_mng/members/bplc/modalBplcSearch" />

                <!-- 재상담 신청 사유 확인  -->
                <div class="modal fade" id="modal3" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <p>재상담 신청 사유 확인
                                </p>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                            </div>
                            <div class="modal-body">
                                <p>재상담 신청 사유를 확인 하세요</p>
                                <table class="table-detail mt-5">
                                    <colgroup>
                                        <col class="w-43">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                    	<c:forEach items="${mbrConsltVO.consltResultList}" var="resultList" varStatus="status">
                                        <tr>
                                            <th scope="row">
                                                ${status.index+1}차 상담 사업소
                                                <p class="mt-2 font-bold">(${resultList.bplcNm})</p>
                                            </th>
                                            <td>${resultList.reconsltResn}</td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //재상담 신청 사유 확인  -->

                <!-- 멤버스 상담 내역 확인 -->
                <div class="modal fade" id="modal4" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <p>멤버스 상담 내역 확인</p>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                            </div>
                            <div class="modal-body">
                                <p>멤버스에서 상담한 상담 내역을 확인 하세요</p>
                                <table class="table-detail mt-5">
                                    <colgroup>
                                        <col class="w-43">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                    	<c:forEach items="${mbrConsltVO.consltResultList}" var="resultList" varStatus="status">
                                        <tr>
                                            <th scope="row">
                                                ${status.index+1}차 상담 사업소
                                                <p class="mt-2 font-bold">(${resultList.bplcNm})</p>
                                            </th>
                                            <td>
                                            	<c:if test="${resultList.consltSttus eq 'CS06'}">
                                            	(상담입력 : <fmt:formatDate value="${resultList.regDt }" pattern="yyyy-MM-dd HH:mm" />)<br>
                                                ${resultList.consltDtls}
                                                </c:if>

                                                <c:if test="${resultList.consltSttus ne 'CS06'}">
                                                상담 대기 중
                                                </c:if>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn large btn-primary w-36" data-bs-dismiss="modal" aria-label="close">확인</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //멤버스 상담 내역 확인 -->
                
                
                <!-- 등급테스트결과 모달 -->
               	<%@include file="./testResultModal.jsp"%>
               	
               	<!-- 요양정보 간편조회 모달 -->
               	<%@include file="./simpleSearchModal.jsp"%>
               	
               	<!-- 상담 정보 수정 모달 -->
               	<%@include file="./updateConsltModal.jsp"%>
            </div>
            <!-- //page content -->


<script>

function submitEvent() {
	var currentSttus = document.getElementsByClassName('currentSttus')[0].innerText;
	
	if (currentSttus === '상담 기관 배정 완료') {
		return confirm('사업소를 변경할 경우 기존사업소 상담 정보는 삭제됩니다. 진행하시겠습니까?');	
	} 
	
	return true;
}

function f_modalBplcSearch_callback(bplcUniqueId, bplcId, bplcNm, telno, rcmdCnt){

	if($("#bplcUniqueId").val() != ""){ //선택된게 있으면 지움
		$(".bplcLi li:last").remove();
	}

	$("#bplcUniqueId").val(bplcUniqueId);
	$("#bplcId").val(bplcId);
	$("#bplcNm").val(bplcNm);
	

	<c:if test="${fn:length(mbrConsltVO.consltResultList) > 0}"><%--등록된 데이터o--%>
		<c:if test="${mbrConsltVO.consltSttus eq 'CS02' || mbrConsltVO.consltSttus eq 'CS08'}"> <%--CS02 or CS08 배정진행중 --%>
	$("#consltSttus").val("${mbrConsltVO.consltSttus}");
	$(".bplcLi li:last").remove();
		</c:if>
		<c:if test="${mbrConsltVO.consltSttus eq 'CS07'}"><%--CS07 재접수--%>
	$("#consltSttus").val("CS08");
		</c:if>
		<c:if test="${mbrConsltVO.consltSttus eq 'CS04'}"><%-- 사업소에서 거부해서 재배정하는경우--%>
	$("#consltSttus").val("CS08");
		</c:if>
	</c:if>
	<c:if test="${empty mbrConsltVO.consltResultList}"><%--등록된 데이터x--%>
	$("#consltSttus").val("CS02"); //최초면 CS02 추가면 CS08
	</c:if>


	let liCnt = $(".bplcLi li").length;
	$(".bplcLi").append("<li>"+ (liCnt+1) +"차 상담 사업소 : "+ bplcNm +" ("+ telno +" / <img src='/html/page/members/assets/images/ico-mypage-recommend.svg' style='display: inline; margin-top: -2px; margin-right: 3px; height: 13px;'>"+ rcmdCnt +")</li>");
}


//수급자 요양정보 조회
function getRecipientInfo(recipientsNo) {
	$.ajax({
		type : "post",
		url  : "/_mng/mbr/recipients/getInfo.json",
		data : {
			recipientsNo
		},
		dataType : 'json'
	})
	.done(function(data) {
		if(data.success) {
			var recipientInfo = data.recipientInfo;
			
			//수급자 요양정보
			$('#mss-rcperRcognNo').text(recipientInfo.rcperRcognNo);
			if (recipientInfo.ltcRcgtGradeCd) {
				$('#mss-ltcRcgtGradeCd').text(recipientInfo.ltcRcgtGradeCd + '등급');	
			} else {
				$('#mss-ltcRcgtGradeCd').text('');	
			}
			$('#mss-rcgtEdaDt').text(recipientInfo.rcgtEdaDt);
			$('#mss-penPayRate').text(recipientInfo.penPayRate);
			$('#mss-bgngApdt').text(recipientInfo.bgngApdt);
			$('#mss-remindAmt').text(comma(Number(recipientInfo.remindAmt)) + '원');
			$('#mss-useAmt').text(comma(Number(recipientInfo.useAmt)) + '원');
			$('#mss-searchDt').text(recipientInfo.searchDt);
			
			$('#modal-simple-search').modal('show');
		}else{
			alert(data.msg);
		}
	})
	.fail(function(data, status, err) {
		alert('서버와 연결이 좋지 않습니다');
	});
}



$(function(){

	$(".f_srchBplc").on("click", function(){
		if ( !$.fn.dataTable.isDataTable('#bplcDataTable') ) { //데이터 테이블이 있으면x
			BplcDataTable.init();
		}
	});

	$(".f_saveCanclResn").on("click", function(e){
		e.preventDefault();
		let params = {
				consltNo:$("#consltNo").val()
				, canclResn:$("#canclResn").val()
				, consltmbrNm:"${mbrConsltVO.mbrNm}"
				, consltMbrTelno:"${mbrConsltVO.mbrTelno}"
				};
		
		if($("#canclResn").val() === ""){
			alert("취소 사유를 입력해 주세요");
			$("#canclResn").focus();
		}else{
			$.ajax({
				type : "post",
				url  : "/_mng/consult/recipter/canclConslt.json",
				data : params,
				dataType : 'json'
			})
			.done(function(data) {
				if(data.result){
					alert("정상적으로 저장되었습니다.");
				}else{
					alert("상담 취소 처리중 에러가 발생하였습니다.");
				}
				location.reload();
			})
			.fail(function(data, status, err) {
				console.log("ERROR : " + err);
			});
		}
	});
	
	$('.f_saveMngMemo').on('click', function(e) {
		e.preventDefault();
		
		let params = {
			consltNo:$("#consltNo").val()
			, mngMemo:$("#mngMemo").val()
		};
		
		if (confirm('상담기록을 저장하시겠습니까?')) {
			$.ajax({
				type : "post",
				url  : "/_mng/consult/recipter/saveMemo.json",
				data : params,
				dataType : 'json'
			})
			.done(function(data) {
				if(data.result){
					alert("정상적으로 저장되었습니다.");
				}else{
					alert("상담 메모 저장중 에러가 발생하였습니다.");
				}
				location.reload();
			})
			.fail(function(data, status, err) {
				console.log("ERROR : " + err);
			});
		}
	});
	
	$('.f_changeConsltSttus').on('click', function(e) {
		e.preventDefault();
		
		var currentSttus = document.getElementsByClassName('currentSttus')[0].innerText;
		var selectedChgSttus = $('#chgSttusSelect option:selected').val();
		var selectedChgSttusText = $('#chgSttusSelect option:selected').text().trim();
		if (selectedChgSttusText === '선택') {
			alert('변경 상태를 선택하세요.');
			return;
		}
		if (currentSttus === selectedChgSttusText) {
			alert('현재상태로 변경할 수 없습니다.');
			return;
		}
		if (selectedChgSttusText === '상담 신청 접수') {
			alert('상담 신청 접수 상태로 변경할 수 없습니다. 사업소 변경을 원하시는 경우 상담 기관 배정 완료상태에서 진행하세요.');
			return;
		}
		if (selectedChgSttusText === '재상담 신청 접수') {
			alert('재상담 신청 접수 상태로 변경할 수 없습니다. 사업소 변경을 원하시는 경우 완료처리 후 재상담을 진행하세요.');
			return;
		}
		
		if (confirm('상담진행상태를 변경하시겠습니까?')) {
			let params = {
				consltNo:$("#consltNo").val(),
				changedSttus:selectedChgSttus,
			};
			
			$.ajax({
				type : "post",
				url  : "/_mng/consult/recipter/changeConsltSttus.json",
				data : params,
				dataType : 'json'
			})
			.done(function(data) {
				if(data.result){
					alert("정상적으로 변경되었습니다.");
				}else{
					alert("상담진행상태 변경중 에러가 발생하였습니다.");
				}
				location.reload();
			})
			.fail(function(data, status, err) {
				console.log("ERROR : " + err);
			});
		}
	});
});


</script>