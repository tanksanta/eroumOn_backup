<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<ul class="nav tab-list">
		<li><a href="#event-pane1" class="active" data-bs-toggle="pill" data-bs-target="#event-pane1" role="tab" aria-selected="true" id="firstTg">이벤트 정보</a></li>
		<li><a href="#event-pane2" data-bs-toggle="pill" data-bs-target="#event-pane2" role="tab" aria-selected="false" id="secondTg">응모자 확인</a></li>
		<li><a href="#event-pane3" data-bs-toggle="pill" data-bs-target="#event-pane3" role="tab" aria-selected="false" id="thirdTg">당첨자 발표</a></li>
	</ul>
	<div class="tab-content mt-10">
		<div class="tab-pane fade show active" id="event-pane1" role="tabpanel">
			<form:form name="frmEvent" id="frmEvent" action="./action" method="post" modelAttribute="eventVO" enctype="multipart/form-data">
				<form:hidden path="eventNo" />
				<form:hidden path="crud" />
				<input type="hidden" id="przwinNo" name="przwinNo" value="${eventPrzwinVO.przwinNo}" />
				<input type="hidden" id="textTotalRow" name="textTotalRow" value="${empty eventVO.iemList?0:eventVO.iemList.size() }" />
				<input type="hidden" id="delTextNo" name="delTextNo" value="" />
				<input type="hidden" id="delThumbFileNo" name="delThumbFileNo" value="" />
				<input type="hidden" id="updtThumbFileDc" name="updtThumbFileDc" value="" />
				<input type="hidden" id="delImgFileNo" name="delImgFileNo" value="" />

				<input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" />
				<input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" />
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
				<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
				<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
				<input type="hidden" name="srchEventTy" id="srchEventTy" value="${param.srchEventTy}" />
				<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn}" />
				<input type="hidden" name="cntPerPageEvent" id="cntPerPageEvent" value="${param.cntPerPageEvent}" />

				<fieldset>
					<legend class="text-title2 relative">
						${eventVO.crud eq 'CREATE'?'등록':'수정' } <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
						</span>
					</legend>
					<table class="table-detail">
						<colgroup>
							<col class="w-43">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="eventTrgt" class="require">이벤트 대상</label></th>
								<td><form:select path="eventTrgt" class="form-control w-64">
										<form:option value="">선택</form:option>
										<c:forEach var="trgt" items="${eventTrgtCode}">
											<form:option value="${trgt.key}">${trgt.value}</form:option>
										</c:forEach>
									</form:select></td>
							</tr>
							<tr>
								<th scope="row"><label for="eventNm" class="require">이벤트 명</label></th>
								<td><form:input type="text" class="form-control w-full" path="eventNm" /></td>
							</tr>
							<tr>
								<th scope="row"><label for="form-item3" class="require">기간</label></th>
								<td>
									<div class="form-group">
										<input type="date" class="form-control w-40 calendar" id="bgngDt" name="bgngDt" value="<fmt:formatDate value="${eventVO.bgngDt}" pattern="yyyy-MM-dd" />" /> <input type="time" class="form-control w-35" name="bgngTime" value="<fmt:formatDate value="${eventVO.bgngDt}" pattern="HH:mm" />" /> <i>~</i> <input type="date" class="form-control w-35 calendar" id="endDt" name="endDt" value="<fmt:formatDate value="${eventVO.endDt}" pattern="yyyy-MM-dd" />" /> <input type="time" class="form-control w-35" name="endTime" value="<fmt:formatDate value="${eventVO.endDt}" pattern="HH:mm" />" />
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="form-item4">당첨자 발표일</label></th>
								<td>
									<div class="form-group">
										<form:input type="date" class="form-control w-35 calendar" path="prsntnYmd" />
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label class="require">이벤트 형태</label></th>
								<td>
									<div class="form-check-group">
										<c:forEach var="eventTy" items="${eventTyCode}">
											<div class="form-check">
												<form:radiobutton class="form-check-input" path="eventTy" id="${eventTy.key}" value="${eventTy.key}" />
												<label class="form-check-label" for="${eventTy.key}">${eventTy.value}</label>
											</div>
										</c:forEach>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label class="require">상태</label></th>
								<td>
									<div class="form-check-group">
										<c:forEach var="yn" items="${dspyYnCode}">
											<div class="form-check">
												<form:radiobutton class="form-check-input" id="${yn.key}" path="dspyYn" value="${yn.key}" />
												<label class="form-check-label" for="${yn.key}">${yn.value}</label>
											</div>
										</c:forEach>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="form-item7" class="require">목록 이미지</label></th>
								<td><c:forEach var="fileList" items="${eventVO.fileList }" varStatus="status">
										<div id="thumbFileViewDiv${fileList.fileNo}" class="">
											<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
											<a href="#delFile" class="btn-secondary" onclick="delFileThumb('${fileList.fileNo}', 'THUMB', '${status.index}'); return false;"> 삭제</a>
											<div class="form-group mt-1 w-full">
												<label for="updtThumbFileDc${fileList.fileNo}"">대체텍스트</label> <input type="text" class="form-control flex-1 ml-2" id="updtThumbFileDc${fileList.fileNo}" name="updtThumbFileDc${fileList.fileNo}" value="${fileList.fileDc}" maxlength="200" data-update-dc>
											</div>
										</div>
									</c:forEach>

									<div id="thumbFileDiv">
										<c:forEach begin="0" end="0" varStatus="status">
											<!-- 첨부파일 갯수 -->
											<div class="row" id="thumbFileInputDiv${status.index}" <c:if test="${status.index < fn:length(eventVO.fileList) }">style="display:none;"</c:if>>
												<div class="col-12">
													<div class="custom-file">
														<input type="file" class="form-control w-2/3" id="thumbFile${status.index}" name="thumbFile${status.index}" onchange="fileCheck(this);" />
													</div>
												</div>
												<div class="col-12">
													<div class="form-group mt-1 w-full">
														<label for="updtthumbFileDc${fileList.fileNo}"">대체텍스트</label> <input type="text" class="form-control flex-1 ml-2" id="thumbFileDc${status.index}" name="thumbFileDc${status.index}" maxlength="200">
													</div>
												</div>
											</div>
										</c:forEach>
									</div></td>
							</tr>
							<tr>
								<th scope="row"><label for="eventCn" class="require">이벤트 본문 영역</label></th>
								<td><form:textarea path="eventCn" cols="30" rows="10" class="form-control w-full" /></td>
							</tr>
							<tr class="survForm">
								<th scope="row"><label for="form-item9" class="require">설문</label></th>
								<td>
									<div class="form-check-group mb-1.5">
										<div class="form-check">
											<input class="form-check-input" type="radio" name="textBtn" id="textBtn" value="text" <c:if test="${fn:length(eventIemList) != 0}" >checked="checked"</c:if>> <label class="form-check-label" for="textBtn">텍스트</label>
										</div>
										<div class="form-check">
											<input class="form-check-input" type="radio" name="textBtn" id="imgBtn" value="img" <c:if test="${fn:length(eventVO.iemList) != 0}">checked="checked"</c:if>> <label class="form-check-label" for="imgBtn">이미지</label>
										</div>
									</div>
									<span class="left-full top-1 ml-2 whitespace-nowrap text-sm">
										이미지 권장 사이즈 : 312px * 312px
									</span>

									<div class="formText" style="display: none;">
										<div class="form-group mt-1 w-full ">
											<label for="ttems1" class="w-15">항목1</label> <input type="text" class="form-control flex-1" id="ttems1" name="ttems1" value="${eventIemList[0].iemCn}">
											<button type="button" class="btn-primary w-30" id="addText">추가</button>
										</div>

										<c:forEach var="itemList" items="${eventIemList}" varStatus="status" begin="1">
											<div class="form-group mt-1 w-full textlen ${status.index + 1 }">
												<label for="ttems${status.index + 1 }" class="w-15">항목${status.index +1}</label> <input type="text" class="form-control flex-1" id="ttems${status.index + 1}" name="ttems${status.index + 1 }" value="${itemList.iemCn}">
												<button type="button" class="btn-secondary w-30 del2" data-idx-id="${status.index + 1 }">삭제</button>
											</div>
										</c:forEach>
									</div>

									<div class="formImg" style="display: none;">
										<c:forEach var="iemList" items="${eventVO.iemList }" varStatus="status">
											<div id="imgFileViewDiv${iemList.fileNo}" class="">
												<a href="/comm/getFile?srvcId=${iemList.srvcId }&amp;upNo=${iemList.upNo }&amp;fileTy=${iemList.fileTy }&amp;fileNo=${iemList.fileNo }" class="imgIem">${iemList.orgnlFileNm} (다운로드 : ${iemList.dwnldCnt}회)</a>&nbsp;&nbsp; <a href="#delFile" class="btn-secondary" onclick="delFile('${iemList.fileNo}', 'IMG', '${status.index}'); return false;"> 삭제</a>
											</div>
										</c:forEach>

										<div class="imgFileDiv">
											<div class="form-group mt-1 w-full" id="imgFileInputDiv${eventVO.iemList[0].fileNo}" <c:if test="${ fn:length(eventVO.iemList) != 0 }">style="display:none;"</c:if>>
												<div class="form-group mt-1 w-full">
													<label for="imgFile1" class="w-15">항목1</label> <input type="file" class="form-control flex-1" id="items1" name="imgFile${eventVO.iemList[0].fileNo}" onchange="fileCheck(this);" />
													<button type="button" class="btn-primary w-30" id="addImg">추가</button>
												</div>
											</div>
										</div>
									</div>

								</td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<div class="btn-group mt-8 right">
					<button type="submit" class="btn-primary large shadow" id="eveSub">저장</button>
					<a href="/_mng/promotion/event/list" class="btn-secondary large shadow">목록</a>
				</div>
			</form:form>
		</div>

		<!--  응모자 확인 -->
		<div class="tab-pane fade" id="event-pane2" role="tabpanel">
			<c:set var="pageParam" value="cntPerPageEvent=${param.cntPerPageEvent}" />
			<form action="./form?${pageParam}" id="srchFrm" name="srchFrm" method="get">
				<input type="hidden" id="eventNo" name="eventNo" value="${eventVO.eventNo}" /> <input type="hidden" id="przwinNo" name="przwinNo" value="${param.przwinNo}" /> <input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" /> <input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" /> <input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" /> <input type="hidden" name="cntPerPageEvent" id="cntPerPageEvent" value="${listVO.cntPerPage}" /> <input type="hidden" name="curPage" id="curPage" value="${param.curPage}" /> <input type="hidden" name="srchText" id="srchText" value="${param.srchText}" /> <input type="hidden" name="srchEventTy" id="srchEventTy" value="${param.srchEventTy}" /> <input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn}" /> <input type="hidden" name="modalTy" id="modalTy" value="" />
			</form>
			<div class="flex wrapEl">
				<p class="text-title2">이벤트명 : ${eventVO.eventNm}</p>
				<p class="mt-0.5 ml-auto">
					총 응모자 수 : <strong>
						<button type="button" class="sortAllByIem" data-iem-no="0">${eventVO.applcnCount}명</button>
				</p>
				</strong>
				</p>
			</div>
			<table class="table-detail wrapEl">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col class="w-57">
				</colgroup>
				<tbody>
					<c:forEach var="applcnCountList" items="${eventIemList}" varStatus="status">
						<tr>
							<th scope="row">항목${status.index + 1}</th>
							<td>${applcnCountList.iemCn}</td>
							<th scope="row"><p class="text-center">응모자수</p></th>
							<td><p class="text-center">
									<button type="button" class="sortByIem" data-iem-no="${applcnCountList.iemNo}">${applcnCountList.applcnIemCount}</button>
								</p></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<p class="text-title2 mt-13">응모자 목록</p>
			<table class="table-list">
				<colgroup>
					<col class="w-25">
					<col class="w-[15%]">
					<col>
					<col class="w-35">
					<col class="w-30">
					<col class="w-35">
					<col class="w-45">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">아이디</th>
						<th scope="col">회원이름</th>
						<th scope="col">휴대폰번호</th>
						<th scope="col">답변</th>
						<th scope="col">IP</th>
						<th scope="col">응모일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="applcnList" items="${listVO.listObject}" varStatus="status">
						<tr>
							<td>${status.index+1}</td>
							<td>${applcnList.applctId}</td>
							<td>${applcnList.applctNm}</td>
							<td>${applcnList.applctTelno}</td>
							<td>${applcnList.chcIemCn}</td>
							<td>${applcnList.ip}</td>
							<td><fmt:formatDate value="${applcnList.applctDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						</tr>
					</c:forEach>
					<c:if test="${empty listVO.listObject}">
						<tr>
							<td class="noresult" colspan="6">응모 내역이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>

			<div class="pagination mt-7">
				<mngr:mngrPaging listVO="${listVO}" />

				<div class="sorting2">
					<label for="countPerPage">출력</label> <select name="countPerPage" id="countPerPage" class="form-control">
						<option value="10" ${listVO.cntPerPage eq '10' ? 'selected' : '' }>10개</option>
						<option value="20" ${listVO.cntPerPage eq '20' ? 'selected' : '' }>20개</option>
						<option value="30" ${listVO.cntPerPage eq '30' ? 'selected' : '' }>30개</option>
					</select>
				</div>

				<div class="counter">
					<%--총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지 --%>
				</div>
			</div>

			<div class="btn-group right mt-8">
				<button type="button" class="btn-primary" id="btn-excel">엑셀다운로드</button>
			</div>
		</div>
		<!--  응모자 확인 -->


		<!-- 당첨자 발표 -->
		<div class="tab-pane fade" id="event-pane3" role="tabpanel">
			<form:form action="./appAction" id="appFrm" name="appFrm" method="post" modelAttribute="eventPrzwinVO" enctype="multipart/form-data">
				<form:hidden path="crud" />
				<form:hidden path="przwinNo" />
				<input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />
				<input type="hidden" id="eventNo" name="eventNo" value="${eventVO.eventNo}" />

				<input type="hidden" id="cntPerPage" name="cntPerPage" value="${param.cntPerPage}" />
				<input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" />
				<input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" />
				<input type="hidden" name="cntPerPageEvent" id="cntPerPageEvent" value="${param.cntPerPageEvent}" />
				<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
				<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
				<input type="hidden" name="srchEventTy" id="srchEventTy" value="${param.srchEventTy}" />
				<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn}" />
				<fieldset>
					<legend class="text-title2 relative">
						당첨자 발표 ${eventPrzwinVO.crud eq 'CREATE'?'등록':'수정' } <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
						</span>
					</legend>
					<table class="table-detail">
						<colgroup>
							<col class="w-43">
							<col>
							<col class="w-43">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">이벤트명</th>
								<td colspan="3">${eventVO.eventNm}</td>
							</tr>
							<tr>
								<th scope="row"><label for="form-item3-1" class="require">본문내용</label></th>
								<td colspan="3"><form:textarea path="cn" class="form-control w-full" cols="30" rows="10" /></td>
							</tr>
							<tr>
								<th scope="row"><label for="form-item3-2">첨부파일</label></th>
								<td colspan="3"><c:forEach var="fileList" items="${eventPrzwinVO.fileList }" varStatus="status">
										<div id="attachFileViewDiv${fileList.fileNo}" class="">
											<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp; <a href="#delFile" class="btn-secondary" onclick="delFilePrz('${fileList.fileNo}', 'ATTACH', '${status.index}'); return false;"> 삭제</a>
										</div>
									</c:forEach>

									<div id="attachFileDiv">
										<c:forEach begin="0" end="0" varStatus="status">
											<!-- 첨부파일 갯수 -->
											<div class="row" id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(eventPrzwinVO.fileList) }">style="display:none;"</c:if>>
												<div class="col-12">
													<div class="custom-file" id="uptAttach">
														<input type="file" class="form-control w-2/3" id="attachFile${status.index}" name="attachFile${status.index}" onchange="fileCheck(this);" />
													</div>
												</div>
												<div class="col-12"></div>
											</div>
										</c:forEach>
									</div></td>
							</tr>
							<tr>
								<th scope="row"><label for="form-item3-3" class="require">상태</label></th>
								<td>
									<div class="form-check-group">
										<c:forEach var="dspyYn" items="${dspyYnCode}" varStatus="status">
											<div class="form-check">
												<form:radiobutton class="form-check-input" path="dspyYn" id="dspyYn${status.index}" value="${dspyYn.key}" />
												<label class="form-check-label" for="dspyYn${status.index}">${dspyYn.value}</label>
											</div>
										</c:forEach>
									</div>
								</td>
							</tr>
							<c:if test="${eventPrzwinVO.przwinNo != 0}">
								<tr>
									<th scope="row">등록일</th>
									<td><fmt:formatDate value="${eventPrzwinVO.regDt}" pattern="yyyy-MM-dd HH:mm" /></td>
									<th scope="row">최종수정일</th>
									<td><fmt:formatDate value="${eventPrzwinVO.mdfcnDt}" pattern="yyyy-MM-dd HH:mm" /></td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</fieldset>

				<div class="btn-group mt-8 right">
					<button type="submit" class="btn-primary large shadow">저장</button>
					<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
				</div>
			</form:form>
		</div>
	</div>
</div>

<script>


//당첨자 첨부파일 삭제
function delFilePrz(fileNo, type, spanNo){
	if(confirm("삭제하시겠습니까?")){
		if(type == "IMG"){
			if($("#delAttachFileNo").val()==""){
				$("#delAttachFileNo").val(fileNo);
			}else{
				$("#delAttachFileNo").val($("#delAttachFileNo").val()+","+fileNo);
			}
			$("#attachFileViewDiv"+fileNo).remove();
			$("#attachFileInputDiv"+spanNo).show();
		}
	}
}

        	//첨부파일 이미지 제한
        	function fileCheck(obj) {

        		if(obj.value != ""){

        			/* 첨부파일 확장자 체크*/
        			var atchLmttArr = new Array();
        			atchLmttArr.push("jpg");
        			atchLmttArr.push("png");
        			atchLmttArr.push("gif");
        			atchLmttArr.push("xlsx");
        			atchLmttArr.push("xls");

        			var file = obj.value;
        			var fileExt = file.substring(file.lastIndexOf('.') + 1, file.length).toLowerCase();
        			var isFileExt = false;

        			for (var i = 0; i < atchLmttArr.length; i++) {
        				if (atchLmttArr[i] == fileExt) {
        					isFileExt = true;
        					break;
        				}
        			}

        			if (!isFileExt) {
        				alert("<spring:message code='errors.ext.limit' arguments='" + atchLmttArr + "' />");
        				obj.value = "";
        				return false;
        			}
        		}
        	};

        	//목록 이미지 삭제
        	function delFileThumb(fileNo, type, spanNo){

        		if(confirm("삭제하시겠습니까?")){
        			if(type == "THUMB"){
        				if($("#delThumbFileNo").val()==""){
        					$("#delThumbFileNo").val(fileNo);
        				}else{
        					$("#delThumbFileNo").val($("#delThumbFileNo").val()+","+fileNo);
        				}
        				$("#thumbFileViewDiv"+fileNo).remove();
        				$("#thumbFileInputDiv"+spanNo).show();
        			}
        		}
        	}

           	//설문 항목 이미지 삭제
        	function delFile(fileNo, type, spanNo){
        		if(confirm("삭제하시겠습니까?")){
        			if(type == "IMG"){
        				if($("#delImgFileNo").val()==""){
        					$("#delImgFileNo").val(fileNo);
        				}else{
        					$("#delImgFileNo").val($("#delImgFileNo").val()+","+fileNo);
        				}
        				$("#imgFileViewDiv"+fileNo).remove();
        				$("#imgFileInputDiv"+fileNo).show();
        			}
        		}
        	}


        	$(function(){

				if("${param.iemNo}" != '' || "${param.modalTy}" == "second"){
        			$("#event-pane1").removeClass("active show");
        			$("#event-pane2").addClass("active show");
        			$("#firstTg").removeClass("active");
        			$("#secondTg").addClass("active");
        			$("#modalTy").val("second");
				}

				//tinymce editor
				tinymce.overrideDefaults(baseConfig);
				tinymce.init({selector:"#cn"});

				//저장버튼
				/*if("${eventVO.crud}"=="UPDATE" &&  f_getToday() >= '<fmt:formatDate value="${eventVO.bgngDt}" pattern="yyyy-MM-dd" />'){
					$("#eveSub").hide();
				}else{
					$("#eveSub").show();
				}*/

				if("${eventVO.eventTy}" == "A"){
					$(".wrapEl").hide();
				}

				//엑셀 다운로드
				$("#btn-excel").on("click",function(){
					$("#srchFrm").attr("action","/_mng/promotion/event/excel")
					$("#srchFrm").submit();
					$("#srchFrm").attr("action","list");
				});

				//응모자 파라미터
				$("#secondTg").on("click",function(){
					$("#modalTy").val("second");
				});

        		//항목당 응모자
        		$(".sortByIem").on("click",function(){
        			var html="";
        			html += '<input type="hidden" name="iemNo" id="iemNo" value="'+$(this).data("iemNo")+'" />'
        			$("#srchFrm").append(html);
        			$("#srchFrm").submit();
        		});

        		//전체 응모자
        		$(".sortAllByIem").on("click",function(){
        			$("#iemNo").remove();
        			$("#srchFrm").submit();
        		});

        		// 페이지 > 출력 갯수
        	    $("#countPerPage").on("change", function(){
        	    	var cntperpage = $("#countPerPage option:selected").val();
        			$("#cntPerPageEvent").val(cntperpage);
        			$("#srchFrm").submit();
        		});

        		var iem = "${eventVO.iemList}"

        		if(iem.length != 0){
            		if("${eventIemList[0].iemTy}"=='img'){
            			$("#imgFileInputDiv1").css("display","");
            			$(".formImg").css("display","");
	        		}else{
	        			$(".formText").css("display","");
	        		}
        		}

        	   	<c:if test="${eventVO.useYn eq 'Y'}">
            	//tinymce editor
           		tinymce.overrideDefaults(baseConfig);
           		tinymce.init({selector:"#eventCn"});
           		</c:if>

				$(".del2").on("click",function(){
					$("."+$(this).data("idxId")).remove();
				});

				//이벤트 형태
				if($("#S").is(":checked")){
					$(".survForm").css({"display":""});
				}else{
					$(".survForm").css({"display":"none"});
				}
				$("input[name='eventTy']").on("click",function(){
					if($(this).val() == "S"){
						$(".survForm").css({"display":""});
					}else{
						$(".survForm").css({"display":"none"});
						$("#imgBtn").prop("checked",false);
						$("#textBtn").prop("checked",false);
					}
				});

        		//날짜 시작일 < 마감일 체크
        		$.validator.addMethod("SizeValidate", function(value,element){
        			var bgng = $("#bgngDt").val();
        			var end = $("#endDt").val();
        			if(end < bgng){
        				return false;
        			}else {
        				return true;
        			}
        		});

        		//날짜, 시간 체크 추가 유효성 검사 메소드
        		$.validator.addMethod("dtValidate", function(value,element){
        			var arrDate = [];
        			arrDate.push($("#bgngDt").val() == "");
        			arrDate.push($("#bgngTime").val() == "");
        			arrDate.push($("#endDt").val() == "");
        			arrDate.push($("#endTime").val() == "");
        			for (var i=0; i < 4; i ++){
        				if(arrDate.includes(true)){
        					return false;
        				}else{
        					return true;
        				}
        			}
        		}, "항목을 입력해주세요.");

        		// 첨부파일 검사 메소드
        		$.validator.addMethod("filechk", function(value,element){
        			if($("#crud").val() == "UPDATE"){
        				if($("#thumbFileInputDiv0").attr("style") != ''){
        					return true;
        				}else{
        					if($("#thumbFile0").val() == ''){
        						return false;
        					}else{
        						return true;
        					}
        				}
        			}else{
        				if($("#thumbFile0").val() == ''){
        					return false;
        				}else{
        					return true;
        				}
        			}
        		}, "파일은 필수 입력 항목입니다.");

        		//텍스트 항목 유효성 검사
        		$.validator.addMethod("survText", function(value,element){
       			if($("#S").is(":checked")){
        			if($("#textBtn").is(":checked")){
        				if($("#ttems1").val() == '' ){
        					return false;
        				}else{
        					return true;
        				}
        			}
       			}else{
       				return true;
       			}
        		}, "텍스트 항목은 필수 입력 사항입니다.");


        		//이벤트 항목 유효성 검사
        		$.validator.addMethod("survImg", function(value,element){
        			if($("#S").is(":checked")){
	        			if($("#imgBtn").is(":checked")){
   							if($(".imgIem").length > 0){
        						return true;
        					}else{
        						if($("#items1").val() == ''){
    	        					return false;
    	        				}else{
    	        					return true;
    	        				}
        					}
	        			}else{
	        				return true;
	        			}
        			}else{
        				return true;
        			}
        		}, "항목은 필수 입력 사항입니다.");

        		//유효성 검사
        			$("form#frmEvent").validate({
				    ignore: "input[type='text']:hidden",
				    rules : {
				    	bgngDt : { dtValidate : true, SizeValidate : true},
				    	eventTrgt : {required : true},
				    	eventNm : {required : true},
				    	eventCn : {required : true},
				    	thumbFileDc0 : {required : true},
				    	thumbFile0 : {filechk : true},
				    	ttems1 : {survText : true},
				    	items1 : {survImg : true},
				    	imgFile${eventVO.iemList[0].fileNo} : {survImg : true}
				    },
				    messages : {
				    	bgngDt : { dtValidate : "항목을 입력해주세요.", SizeValidate : "날짜를 점검해주세요."},
				    	eventTrgt : {required : "이벤트 대상을 선택해주세요."},
				    	eventNm : {required : "이벤트 명을 입력해주세요."},
				    	eventCn : {required : "이벤트 본문을 입력해주세요."},
				    	thumbFileDc0 : {required : "대체 텍스트를 입력해주세요."}
				    },

				    submitHandler: function (frm) {
				 		var arrUpdateDc = [];
			    		$("input[data-update-dc]").each(function(){
				    		arrUpdateDc.push($(this).attr("name"));
				    		console.log(arrUpdateDc);
				    	});
				    	if(arrUpdateDc.length>0){
				    		console.log(arrUpdateDc.join(","));
					    	$("input#updtThumbFileDc").val(arrUpdateDc.join(","));
					    	console.log($("input#updtThumbFileDc").val());
				    	}
				    	if(confirm("저장 하시겠습니까?")){
					    	frm.submit();
				    	} else{
				    		return false;
				    	}
				    }
				});

        		//1. 이미지 버튼을 눌렀을 때, 항목 전환
        		$("#imgBtn").on("click",function(){
        			$("#imgBtn").prop("checked",true);
        			$("#textBtn").prop("checked",false);
					$(".addTfrm").remove();
					$("#ttems1").val('');
        			$(".formImg").css("display","");
        			$(".formText").css("display","none");

        		});

        		//2. 텍스트 버튼을 눌렀을 때, 항목 전환
        		$("#textBtn").on("click",function(){
          			$("#imgBtn").prop("checked",false);
        			$("#textBtn").prop("checked",true);
        			$(".addIfrm").remove();
        			$(".textlen").remove();
        			$("#items1").val('');
        			$(".formImg").css("display","none");
        			$(".formText").css("display","");
        		});

        		//3. 이미지 형식 추가 버튼을 눌렀을 때, 항목 추가
       			var imgCnt = $(".addIfrm").length + 2;
        		$("#addImg").on("click",function(){
        			var html ="";
					html += '<div class="imgFileDiv'+imgCnt+' addIfrm">'
					html += '	<div class="form-group mt-1 w-full imglen" id="imgFileInputDiv'+ imgCnt +'" >'
					html += '		<div class="form-group mt-1 w-full">'
					html += '			<label for="imgFile'+imgCnt+'" class="w-15">항목'+ imgCnt +' </label>'
					html += '			<input type="file" class="form-control flex-1" id="items'+ imgCnt +'" name="imgFile'+ imgCnt +'" onchange="fileCheck(this);" />'
					html += '			<button type="button" class="btn-secondary w-30 del" data-index-id="imgFileDiv'+ imgCnt +'" >삭제</button>'
					html += '		</div>'
					html += '	</div>'
					html += '</div>'

					$(".formImg").append(html);
					imgCnt = imgCnt + 1;

        	  		//4. 이미지 형식 삭제 버튼 눌렀을 때, 항목 삭제
    				$(".del").on("click",function(){
    					$("."+$(this).data("indexId")).remove();
    				});
        		});

        		//5. 텍스트 형식 추가 버튼을 눌렀을 때, 항목 추가
        			var textCnt = $(".textlen").length + 2;

					$("#addText").on("click",function(){
					var html2 = "";
					html2 += '<div class="form-group mt-1 w-full addTfrm textlen '+textCnt+'">'
                    html2 += '	<label for="'+textCnt+'" class="w-15">항목'+textCnt+'</label>'
                    html2 += '		<input type="text" class="form-control flex-1" id="'+textCnt+'" name="ttems'+textCnt+'">'
                    html2 += '		<button type="button" class="btn-secondary w-30 del2" data-idx-id="'+textCnt+'">삭제</button>'
                	html2 += '</div>'

                	$(".formText").append(html2);

                	textCnt = textCnt +1;

                	//6. 텍스트 형식 삭제 버튼 눌렀을 때, 항목 삭제
					$(".del2").on("click",function(){
						$("."+$(this).data("idxId")).remove();
					});
				});


		        //유효성 검사
		        $("form#appFrm").validate({
			    ignore: "input[type='text']:hidden",
			    rules : {
			    	cn : { required : true}
			    },
			    messages : {
			    	cn : { required : "내용은 필수 입력 항목입니다."}
			    },
			    submitHandler: function (frm) {
			    	const ymd = '<fmt:formatDate value="${eventVO.prsntnYmd}" pattern="yyyy-MM-dd" />';
			    	if(ymd <= f_getToday() ){
			    		if(confirm("저장 하시겠습니까?")){
					    	frm.submit();
				    	} else{
				    		return false;
				    	}
			    	}else{
						alert("당첨자 발표일이 아닙니다.");
						return false;
			    	}
			    }
			});

        	});
            </script>


