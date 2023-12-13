<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <!-- plugin -->
    <link rel="stylesheet" href="../../../core/vendor/swiperjs/swiper-bundle.css">
    <script src="../../../core/vendor/swiperjs/swiper-bundle.min.js"></script>
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
                                    	<button type="button" class="btn-primary" onclick="viewConsltDetailModal('${mbrConsltVO.prevPath}');">상세보기</button>
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
                                        <input type="hidden" id="regMbrNm" name="regMbrNm" value="${mbrVO.mbrNm}">
                                    	<input type="hidden" id="consltMbrTelno" name="consltMbrTelno" value="${mbrConsltVO.mbrTelno}">
                                    	<input type="hidden" id="regUniqueId" name="regUniqueId" value="${mbrConsltVO.getRegUniqueId()}">
                                        <input type="hidden" id="originConsltBplcUniqueId" name="originConsltBplcUniqueId" value="${consltBplcUniqueId}">
                                    	<input type="hidden" id="chgHistListSize" name="chgHistListSize" value="${chgHistList.size()}">
                                    	<input type="hidden" id="originConsltSttus" name="originConsltSttus" value="${mbrConsltVO.consltSttus}">
                                        <input type="hidden" id="recipientsNo" name="recipientsNo" value="${mbrConsltVO.recipientsNo}">
                                        
										<!-- 진행(CS05)전 상태이면 사업소 수정가능하게 해야함 -->

										<c:if test="${(mbrConsltVO.consltSttus eq 'CS01' || mbrConsltVO.consltSttus eq 'CS07') || mbrConsltVO.consltSttus eq 'CS02' || mbrConsltVO.consltSttus eq 'CS04' }">
                                        <button type="button" class="btn-primary shadow f_srchBplc" data-bs-toggle="modal" data-bs-target="#bplcModal">선택</button>
                                        </c:if>

                                        <ul class="mt-2 space-y-1 bplcLi">
                                        	<c:forEach items="${consltAssignmentList}" var="resultList" varStatus="status">
	                                            <li <c:if test="${resultList.reject}">style="opacity: 0.5;"</c:if>>
	                                            	${resultList.consltCnt}차 상담 사업소<c:if test="${resultList.reject}">(상담 거부)</c:if> : ${resultList.bplcNm} (${resultList.bplcTelno}
	                                            	/ <img src="/html/page/members/assets/images/ico-mypage-recommend.svg" style="display: inline; margin-top: -2px; margin-right: 3px; height: 13px;">${resultList.rcmdCnt})
	                                            	, <fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss" />
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
                                    	<div class="flex items-center gap-4">
	                                        <ul>
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
	                                        <c:if test="${!empty bplcRejectChgList && bplcRejectChgList.size() > 0}">
	                                        	<button type="button" class="btn-primary shadow" data-bs-toggle="modal" data-bs-target="#modal5">상담 거부 사유 확인</button>
	                                        </c:if>
                                        </div>
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
                        </c:if>
                        <c:if test="${mbrConsltVO.consltSttus ne 'CS06'}">
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
                
                <!-- 상담 거부 사유 확인 -->
                <div class="modal fade" id="modal5" tabindex="-1">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <p>상담 거부 사유 확인</p>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                            </div>
                            <div class="modal-body">
                                <p>상담 거부 사유를 확인하세요</p>
                                <table class="table-detail mt-5">
                                    <colgroup>
                                        <col class="w-43">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                    	<c:forEach items="${bplcRejectChgList}" var="resultList" varStatus="status">
	                                        <tr>
	                                            <th scope="row">
	                                                ${status.index+1}차 거부 사업소
	                                                <p class="mt-2 font-bold">(${resultList. bplcNm})</p>
	                                            </th>
	                                            <td>
	                                            	${resultList.resn}
	                                            </td>
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //상담 거부 사유 확인  -->
                
                
                <!-- 등급테스트결과 모달 -->
               	<%@include file="./testResultModal.jsp"%>
               	
               	<!-- 요양정보 간편조회 모달 -->
               	<%@include file="./simpleSearchModal.jsp"%>
               	
               	<!-- 상담 정보 수정 모달 -->
               	<%@include file="./updateConsltModal.jsp"%>
                

               <a href="#modal-example1" class="btn-primary" data-bs-toggle="modal" data-bs-target="#popup-detail">수급자 상담정보 상세</a>
                <!--수급자 상담정보 상세-->
                <div class="modal modal-show" id="popup-detail" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h2 class="text-title">수급자 상담정보 상세</h2>
                                <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                            </div>
                            <div class="modal-body">
                                <h3 class="text-xl">복지용구상담</h3>
                                <p class="flex items-center gap-2">
                                    <span>상담받을 연락처</span>
                                    <strong class="text-2xl">010-1234-5678</strong>
                                </p>
                                <hr class="divide-x-1"/>
                                <p class="mt-5 font-medium"><span>어르신 관심 품목(</span><strong class="font-normal">n</strong>개)</p>
                                <p class="mt-2 text-gray1 text-xs">※ 요양정보(계약완료/구매예상)는 데이터 조회 시점에 따라 실제와 다를 수 있으니 참고용으로만 사용바랍니다</p>
                            
                                <div class="careinfo-status !my-2">
                                    <div class="status-swiper">
                                        <div class="swiper">
                                            <div class="swiper-wrapper">
                                                <div class="swiper-slide swiper-item1">
                                                    <strong>성인용 보행기</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item2">
                                                    <strong>수동휠체어</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item3">
                                                    <strong>지팡이</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item4">
                                                    <strong>안전손잡이</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item5">
                                                    <strong>미끄럼방지 매트</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item6">
                                                    <strong>미끄럼방지 양말</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item7">
                                                    <strong>욕창예방 매트리스</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item8">
                                                    <strong>욕창예방 방석</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item9">
                                                    <strong>자세변환용구</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item10">
                                                    <strong>요실금 팬티</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item11">
                                                    <strong>목욕의자</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item12">
                                                    <strong>이동변기</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item13">
                                                    <strong>간이변기</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item14">
                                                    <strong>경사로(실내)</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item15">
                                                    <strong>경사로(실외)</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item16">
                                                    <strong>전동침대</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item17">
                                                    <strong>수동침대</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item18">
                                                    <strong>이동욕조</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item19">
                                                    <strong>목욕리프트</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                                <div class="swiper-slide swiper-item20">
                                                    <strong>배회감지기</strong>
                                                    <i></i>
                                                    <dl>
                                                        <dt>계약완료</dt>
                                                        <dd><span class="blurring">1</span></dd>
                                                    </dl>
                                                    <dl>
                                                        <dt>구매예상</dt>
                                                        <dd><span class="blurring">0</span></dd>
                                                    </dl>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="swiper-button-prev"></div>
                                        <div class="swiper-button-next"></div>
                                    </div>
                
                                    <div class="collapse" id="collapse-agree1">
                                        <h4 class="status-title">복지용구 상세 현황</h4>
                                        <table class="status-table">
                                            <caption class="hidden">복지용구 품목명, 계약완료상태, 구매예상 표입니다</caption>
                                            <colgroup>
                                                <col class="min-w-10 w-[15%]">
                                                <col>
                                                <col class="min-w-16 w-1/5">
                                                <col class="min-w-16 w-1/5">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">No</th>
                                                    <th scope="col">품목명</th>
                                                    <th scope="col">계약완료</th>
                                                    <th scope="col">구매예상</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td class="subject">수동휠체어</td>
                                                    <td>1개</td>
                                                    <td>1개</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td class="subject">수동휠체어</td>
                                                    <td>1개</td>
                                                    <td>1개</td>
                                                </tr>
                                            </tbody>
                                        </table>
                        
                                        <h4 class="status-title">대여 복지용구 상세 현황</h4>
                                        <table class="status-table">
                                            <caption class="hidden">대여 복지용구 품목명, 계약완료상태, 구매예상 표입니다</caption>
                                            <colgroup>
                                                <col class="min-w-10 w-[15%]">
                                                <col>
                                                <col class="min-w-16 w-1/5">
                                                <col class="min-w-16 w-1/5">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">No</th>
                                                    <th scope="col">품목명</th>
                                                    <th scope="col">계약완료</th>
                                                    <th scope="col">구매예상</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><span class="blurring">1</span></td>
                                                    <td class="subject">수동휠체어</td>
                                                    <td><span class="blurring">1개</span></td>
                                                    <td><span class="blurring">1개</span></td>
                                                </tr>
                                                <tr>
                                                    <td><span class="blurring">1</span></td>
                                                    <td class="subject">수동휠체어</td>
                                                    <td><span class="blurring">1개</span></td>
                                                    <td><span class="blurring">1개</span></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <p class="text-center mt-3 text-sm">※ 위 내용은 데이터 조회 시점에 따라 <span class="underline font-bold">실제와 다를 수 있으니 참고용</span>으로만 사용해주세요. </p>
                                    </div>
                
                                    <button type="button" class="btn status-toggle" data-bs-target="#collapse-agree1" data-bs-toggle="collapse" aria-expanded="false">상세열기</button>
                                </div>
                                
                                <fieldset class="mt-10">
                                    <legend class="text-title2">요양정보</legend>
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
                                                <td><input type="text" class="form-control large" placeholder="강봉성" disabled></td>
                                                <th scope="row">요양인정번호</th>
                                                <td><input type="text" class="form-control large" placeholder="1234567890" disabled></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </fieldset>
                                <div class="flex justify-center my-4">
                                    <button class="btn-primary large w-52">조회하기</button>
                                </div>

                                <div class="careinfo-myinfo !mt-8">
                                    <div class="myinfo-wrapper">
                                        <div class="myinfo-box1">
                                            <p class="name"><span class="blurring">이로미님</span> <a href="#">정보수정</a></p>
                                            <dl class="numb">
                                                <dt class="desc">요양인정번호</dt>
                                                <dd><span class="blurring">L123456789</span></dd>
                                            </dl>
                                            <dl class="date">
                                                <dt class="desc">인정 유효기간</dt>
                                                <dd><span class="blurring">2023년 1월 1일<br> ~ 2023년 12월 31일</span></dd>
                                            </dl>
                                        </div>
                                        <div class="myinfo-box2">
                                            <p class="desc">잔여급여</p>
                                            <p class="cost"><span class="blurring"><strong>1,250,000</strong>원</span></p>
                                            <dl class="used1">
                                                <dt class="desc">사용</dt>
                                                <dd class="percent">
                                                    <div class="track">
                                                        <div class="bar" style="width: 25%;"></div>
                                                    </div>
                                                    <div class="won"><span class="blurring">350,000원</span></div>
                                                </dd>
                                            </dl>
                                            <dl class="used2">
                                                <dt class="desc">총 급여</dt>
                                                <dd class="percent">
                                                    <div class="track">
                                                        <div class="bar" style="width: 75%;"></div>
                                                    </div>
                                                    <div class="won"><span class="blurring">1,600,000원</span></div>
                                                </dd>
                                            </dl>
                                        </div>
                                        <div class="myinfo-box3">
                                            <p class="desc">인정등급</p>
                                            <p class="cost"><span class="blurring"><strong>15</strong>등급</span></p>
                                            <p class="desc">제품가 최소 85% 지원</p>
                                        </div>
                                        <div class="myinfo-box4">
                                            <p class="name">본인부담율</p>
                                            <p class="cost"><span class="blurring"><strong>15</strong>%</span></p>
                                            <p class="desc">월 141만원내에서<br> 요양보호사 신청 가능</p>
                                        </div>
                                    </div>
                                </div>

                                <div class="careinfo-status !my-8">
                                    <div class="collapse" id="collapse-agree1">
                                        <h4 class="status-title">복지용구 상세 현황</h4>
                                        <table class="status-table">
                                            <caption class="hidden">복지용구 품목명, 계약완료상태, 구매예상 표입니다</caption>
                                            <colgroup>
                                                <col class="min-w-10 w-[15%]">
                                                <col>
                                                <col class="min-w-16 w-1/5">
                                                <col class="min-w-16 w-1/5">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">No</th>
                                                    <th scope="col">품목명</th>
                                                    <th scope="col">계약완료</th>
                                                    <th scope="col">구매예상</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr class="bg-[#ffe1cc]">
                                                    <td>1</td>
                                                    <td class="subject">수동휠체어</td>
                                                    <td>1개</td>
                                                    <td>1개</td>
                                                </tr>
                                                <tr>
                                                    <td>1</td>
                                                    <td class="subject">수동휠체어</td>
                                                    <td>1개</td>
                                                    <td>1개</td>
                                                </tr>
                                            </tbody>
                                        </table>
                        
                                        <h4 class="status-title">대여 복지용구 상세 현황</h4>
                                        <table class="status-table">
                                            <caption class="hidden">대여 복지용구 품목명, 계약완료상태, 구매예상 표입니다</caption>
                                            <colgroup>
                                                <col class="min-w-10 w-[15%]">
                                                <col>
                                                <col class="min-w-16 w-1/5">
                                                <col class="min-w-16 w-1/5">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">No</th>
                                                    <th scope="col">품목명</th>
                                                    <th scope="col">계약완료</th>
                                                    <th scope="col">구매예상</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><span class="blurring">1</span></td>
                                                    <td class="subject">수동휠체어</td>
                                                    <td><span class="blurring">1개</span></td>
                                                    <td><span class="blurring">1개</span></td>
                                                </tr>
                                                <tr>
                                                    <td><span class="blurring">1</span></td>
                                                    <td class="subject">수동휠체어</td>
                                                    <td><span class="blurring">1개</span></td>
                                                    <td><span class="blurring">1개</span></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                        <p class="text-center mt-3 text-sm">※ 위 내용은 데이터 조회 시점에 따라 <span class="underline font-bold">실제와 다를 수 있으니 참고용</span>으로만 사용해주세요. </p>
                                    </div>
                                    <div class="flex justify-center my-4">
                                        <button type="button" class="btn status-toggle" data-bs-target="#collapse-agree1" data-bs-toggle="collapse" aria-expanded="false">상세열기</button>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary btn-large">확인</button>
                            </div>
                        </div>
                    </div>
                </div>


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
		$(".bplcLi li:first").remove();
	}

	$("#bplcUniqueId").val(bplcUniqueId);
	$("#bplcId").val(bplcId);
	$("#bplcNm").val(bplcNm);
	

	<c:if test="${fn:length(mbrConsltVO.consltResultList) > 0}"><%--등록된 데이터o--%>
		<c:if test="${mbrConsltVO.consltSttus eq 'CS02' || mbrConsltVO.consltSttus eq 'CS08'}"> <%--CS02 or CS08 배정진행중 --%>
			$("#consltSttus").val("${mbrConsltVO.consltSttus}");
			$(".bplcLi li:first").remove();
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
	<c:if test="${!empty mbrConsltVO.consltResultList && mbrConsltVO.consltSttus eq 'CS01'}"><%-- 상담거부 후 배정인 경우 --%>
		$("#consltSttus").val("CS02");
	</c:if>


	let liCnt = $(".bplcLi li").length;
	$(".bplcLi").prepend("<li>(배정중) 상담 사업소 : "+ bplcNm +" ("+ telno +" / <img src='/html/page/members/assets/images/ico-mypage-recommend.svg' style='display: inline; margin-top: -2px; margin-right: 3px; height: 13px;'>"+ rcmdCnt +")</li>");
}

//수급자 요양정보 조회
function getRecipientInfo(recipientsNo) {
	// 요양정보 조회 API 호출
	jsCallApi.call_api_post_json(window, "/_mng/mbr/recipients/getInfo.json", "getRecipientInfoCallback", {recipientsNo});
}
//수급자 요양정보 조회 콜백
function getRecipientInfoCallback(result, errorResult, data, param) {
	if (errorResult == null) {
		var data = result;
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
	} else {
		alert('서버와 연결이 좋지 않습니다.');
	}
}


//상담유형상세 상세보기 버튼 클릭 이벤트
function viewConsltDetailModal(prevPath) {
	if (prevPath === 'test') {
		$('#grade-test-result').modal('show');
	} else {
		getRecipientInfo(Number('${mbrConsltVO.recipientsNo}'));
	}
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

    var swiper = new Swiper(".swiper", {
        slidesPerView : 'auto',
        spaceBetween : 10,
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        breakpoints: {
            spaceBetween : 12,
        },
    });
    
    $('.status-toggle').on('click', function() {
        $(this).toggleClass('is-active').prev('.status-list').toggleClass('hidden');
    })
});


</script>