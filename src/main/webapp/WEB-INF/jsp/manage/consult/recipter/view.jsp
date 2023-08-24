<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- page content -->
            <div id="page-content">
                <p class="mb-7">인정등급테스트 후 1:1상담 신청한 내역을 확인하는 페이지입니다.</p>
                <form:form action="./action" method="post" id="frmView" name="frmView" modelAttribute="mbrConsltVO" >
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
                                    <th scope="row">성명</th>
                                    <td>${mbrConsltVO.mbrNm}</td>
                                    <th scope="row">성별</th>
                                    <td>${genderCode[mbrConsltVO.gender]}</td>
                                </tr>
                                <tr>
                                    <th scope="row">연락처</th>
                                    <td>${mbrConsltVO.mbrTelno}</td>
                                    <th scope="row">생년월일</th>
                                    <td>${mbrConsltVO.brdt}</td>
                                </tr>
                                <tr>
                                    <th scope="row">거주지 주소</th>
                                    <td colspan="3">(${mbrConsltVO.zip}) ${mbrConsltVO.addr}&nbsp;${mbrConsltVO.daddr}</td>
                                </tr>
                                <tr>
                                    <th scope="row">상담 신청일</th>
                                    <td><fmt:formatDate value="${mbrConsltVO.regDt}" pattern="yyyy-MM-dd" /></td>
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
                                <tr>
                                    <th scope="row">사업소 지정</th>
                                    <td colspan="3">
                                    	<input type="hidden" id="bplcUniqueId" name="bplcUniqueId" value="">
                                    	<input type="hidden" id="bplcId" name="bplcId" value="">
                                    	<input type="hidden" id="bplcNm" name="bplcNm" value="">

										<!-- 진행(CS05)전 상태이면 사업소 수정가능하게 해야함 -->

										<c:if test="${(mbrConsltVO.consltSttus eq 'CS01' || mbrConsltVO.consltSttus eq 'CS07') || mbrConsltVO.consltSttus eq 'CS02' || mbrConsltVO.consltSttus eq 'CS04' }">
                                        <button type="button" class="btn-primary shadow f_srchBplc" data-bs-toggle="modal" data-bs-target="#bplcModal">사업소 선택</button>
                                        </c:if>

                                        <ul class="mt-2 space-y-1 bplcLi">
                                        	<c:forEach items="${mbrConsltVO.consltResultList}" var="resultList" varStatus="status">
                                            <li>${status.index+1}차 상담 사업소 : ${resultList.bplcNm} (${resultList.bplcInfo.telno} / <img src="/html/page/members/assets/images/ico-mypage-recommend.svg" style="display: inline; margin-top: -2px; margin-right: 3px; height: 13px;">${resultList.bplcInfo.rcmdCnt})</li>
                                        	</c:forEach>
                                        </ul>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>
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
                                    	<form:textarea path="mngMemo" class="form-control w-full" title="메모" cols="30" rows="5" />
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

					<c:set var="pageParam" value="curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;srchRegBgng=${param.srchRegBgng}&amp;srchRegEnd=${param.srchRegEnd}&amp;srchMbrNm=${param.srchMbrNm}&amp;srchMbrTelno=${param.srchMbrTelno}&amp;srchConsltSttus=${param.srchConsltSttus}" />
                    <div class="btn-group right mt-8">
                    	<c:if test="${mbrConsltVO.consltSttus ne 'CS01' && fn:length(mbrConsltVO.consltResultList) > 0}">
                        <button type="button" class="btn-primary large shadow float-left" data-bs-toggle="modal" data-bs-target="#modal4">멤버스 상담 내역 확인</button>
                        </c:if>
                        <c:if test="${mbrConsltVO.consltSttus ne 'CS03' && mbrConsltVO.consltSttus ne 'CS04' && mbrConsltVO.consltSttus ne 'CS06' && mbrConsltVO.consltSttus ne 'CS09' }">
                        <button type="button" class="btn-danger large shadow" data-bs-toggle="modal" data-bs-target="#modal1">상담취소</button>
                        </c:if>
                        <button type="submit" class="btn-success large shadow">저장</button>
                        <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
                    </div>
                </form:form>

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
                                                ${resultList.consltDtls}
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
            </div>
            <!-- //page content -->


<script>

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
				, canclResn:$("#canclResn").val()};

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

});


</script>