<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<jsp:include page="../layout/page_header.jsp">
				<jsp:param value="1:1상담(인정등급테스트)" name="pageTitle"/>
			</jsp:include>

			<!-- page content -->
            <div id="page-content">
                <p class="mb-7">인정등급테스트 후 1:1상담 신청한 내역을 확인하는 페이지입니다.</p>
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
                                    <td colspan="3">(${mbrConsltVO.zip}) ${mbrConsltVO.addr} ${mbrConsltVO.daddr}</td>
                                </tr>
                                <tr>
                                    <th scope="row">상담 신청일</th>
                                    <td><fmt:formatDate value="${mbrConsltVO.regDt}" pattern="yyyy-MM-dd" /></td>
                                    <th scope="row">상담진행상태</th>
                                    <td>
                                        <ul class="space-y-1">
                                            <li>
                                            	<c:choose>
													<c:when test="${mbrConsltResultVO.consltSttus eq 'CS01'}">상담 신청 접수</c:when>
													<c:when test="${mbrConsltResultVO.consltSttus eq 'CS02'}">상담 신청 접수</c:when>
													<c:when test="${mbrConsltResultVO.consltSttus eq 'CS03'}">상담 취소</c:when>
													<c:when test="${mbrConsltResultVO.consltSttus eq 'CS04'}">상담 취소</c:when>
													<c:when test="${mbrConsltResultVO.consltSttus eq 'CS09'}">상담 취소</c:when>
													<c:when test="${mbrConsltResultVO.consltSttus eq 'CS05'}">상담 진행 중</c:when>
													<c:when test="${mbrConsltResultVO.consltSttus eq 'CS06'}">상담 완료</c:when>
													<c:when test="${mbrConsltResultVO.consltSttus eq 'CS07'}">상담 신청 접수</c:when>
													<c:when test="${mbrConsltResultVO.consltSttus eq 'CS08'}">상담 신청 접수</c:when>
												</c:choose>
                                            </li>
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

 				<form:form action="./action" method="post" id="frmView" name="frmView" modelAttribute="mbrConsltResultVO" >
				<form:hidden path="consltNo" />
				<form:hidden path="bplcConsltNo" />
				<form:hidden path="consltSttus" />

					<c:if test="${mbrConsltResultVO.consltSttus eq 'CS05' || mbrConsltResultVO.consltSttus eq 'CS06'}">

                    <fieldset class="mt-13">
                        <legend class="text-title2">상담내용(멤버스 관리자 메모)</legend>
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
											<c:when test="${mbrConsltResultVO.consltSttus eq 'CS01'}">상담 신청 접수</c:when>
											<c:when test="${mbrConsltResultVO.consltSttus eq 'CS02'}">상담 신청 접수</c:when>
											<c:when test="${mbrConsltResultVO.consltSttus eq 'CS03'}">상담 취소</c:when>
											<c:when test="${mbrConsltResultVO.consltSttus eq 'CS04'}">상담 취소</c:when>
											<c:when test="${mbrConsltResultVO.consltSttus eq 'CS09'}">상담 취소</c:when>
											<c:when test="${mbrConsltResultVO.consltSttus eq 'CS05'}">상담 진행 중</c:when>
											<c:when test="${mbrConsltResultVO.consltSttus eq 'CS06'}">상담 완료</c:when>
											<c:when test="${mbrConsltResultVO.consltSttus eq 'CS07'}">상담 신청 접수</c:when>
											<c:when test="${mbrConsltResultVO.consltSttus eq 'CS08'}">상담 신청 접수</c:when>
										</c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="consltDtls" class="require">상담내용</label></th>
                                    <td>
                                    	<form:textarea path="consltDtls" class="form-control w-full" title="메모" cols="30" rows="5" />
                                    </td>
                                </tr>
                                <c:if test="${!empty mbrConsltResultVO.regUniqueId}">
                                <tr>
                                    <th scope="row">등록일</th>
                                    <td>${mbrConsltResultVO.rgtr}(${mbrConsltResultVO.regId}) / <fmt:formatDate value="${mbrConsltResultVO.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </fieldset>
					</c:if>

					<c:set var="pageParam" value="curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;srchRegBgng=${param.srchRegBgng}&amp;srchRegEnd=${param.srchRegEnd}&amp;srchMbrNm=${param.srchMbrNm}&amp;srchMbrTelno=${param.srchMbrTelno}&amp;srchConsltSttus=${param.srchConsltSttus}" />
                    <div class="btn-group right mt-8">
						<%-- 배정(CS02)->상담진행중(CS05) or 거부(CS04)로 변경 --%>
						<c:if test="${mbrConsltResultVO.consltSttus eq 'CS02' || mbrConsltResultVO.consltSttus eq 'CS08'}">
                        <button type="button" class="btn-success large shadow f_consltSttus" data-sttus="CS05">상담수락</button>
                        <button type="button" class="btn-danger large shadow f_consltSttus" data-sttus="CS04">상담거부</button>
                        </c:if>

                        <c:if test="${mbrConsltResultVO.consltSttus ne 'CS02' && mbrConsltResultVO.consltSttus ne 'CS03'
                        	&& mbrConsltResultVO.consltSttus ne 'CS04'  && mbrConsltResultVO.consltSttus ne 'CS06' && mbrConsltResultVO.consltSttus ne 'CS08' && mbrConsltResultVO.consltSttus ne 'CS09'}">
                        <button type="button" class="btn-danger large shadow" data-bs-toggle="modal" data-bs-target="#modal1">상담취소</button>
                        </c:if>

						<c:if test="${mbrConsltResultVO.consltSttus eq 'CS05'}">
						<button type="submit" class="btn-success large shadow">상담완료</button>
						</c:if>
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
            </div>
            <!-- //page content -->

            <script>
            $(function(){

            	$(".f_consltSttus").on("click", function(e){
            		e.preventDefault();
            		let sttus = $(this).data("sttus");
            		let params = {consltNo:$("#consltNo").val()
            				, bplcConsltNo:$("#bplcConsltNo").val()
            				, consltSttus:sttus};

            		let confirmMsg = "수락";
            		if(sttus == "CS04"){
            			confirmMsg = "거부";
            		}
            		if(confirm("상담 신청을"+ confirmMsg + " 하시겠습니까?")){
	            		console.log(params);
	            		$.ajax({
            				type : "post",
            				url  : "./changeSttus.json",
            				data : params,
            				dataType : 'json'
            			})
            			.done(function(data) {
            				if(data.result){
            					alert("정상적으로 "+ confirmMsg +" 되었습니다.");
            				}else{
            					alert("상담 상태 변경 처리중 에러가 발생하였습니다.");
            				}
            				location.reload();
            			})
            			.fail(function(data, status, err) {
            				console.log("ERROR : " + err);
            			});
            		}


            	});

            	$(".f_saveCanclResn").on("click", function(e){
            		e.preventDefault();
            		let params = {
            				consltNo:$("#consltNo").val()
            				, bplcConsltNo:$("#bplcConsltNo").val()
            				, canclResn:$("#canclResn").val()};
            		if($("#canclResn").val() === ""){
            			alert("취소 사유를 입력해 주세요");
            			$("#canclResn").focus();
            		}else{
            			$.ajax({
            				type : "post",
            				url  : "./canclConslt.json",
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