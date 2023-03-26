<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form action="./action" id="adverFrm" name="adverFrm" method="post" modelAttribute="adverMngVO" enctype="multipart/form-data">
<form:hidden path="crud" />
<form:hidden path="adverNo" />

	<input type="hidden" name="srchCn" id="srchText" value="${param.srchText}" />
	<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn}" />
	<input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" />
	<input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" />
	<input type="hidden" name="srchArea" id="srchArea" value="${param.srchArea}" />
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
	<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
	<input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />
	<input type="hidden" id="updtImgFileDc" name="updtImgFileDc" value="" />

	<fieldset>
		<legend class="text-title2 relative">
			${adverMngVO.crud eq 'CREATE'?'등록':'수정' }
			<span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
			(<span class="badge-require ml-1 mr-0.5 -translate-y-0.5">
			</span> 는 필수입력사항입니다.) </span>
		</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="adverNm" class="require">제목</label></th>
					<td><form:input class="form-control w-full" path="adverNm" maxlength="50"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item2" class="require">노출기간</label></th>
					<td>
						<div class="form-group">
							<input type="date" class="form-control w-40 calendar" id="bgngDt" name="bgngDt" value="<fmt:formatDate value="${adverMngVO.bgngDt}" pattern="yyyy-MM-dd" />" />
							<input type="time" class="form-control w-35" name="bgngTime" value="<fmt:formatDate value="${adverMngVO.bgngDt}" pattern="HH:mm" />" />
							<i>~</i>
							<input type="date" class="form-control w-35 calendar" id="endDt" name="endDt" value="<fmt:formatDate value="${adverMngVO.endDt}" pattern="yyyy-MM-dd" />" />
							<input type="time" class="form-control w-35" name="endTime" value="<fmt:formatDate value="${adverMngVO.endDt}" pattern="HH:mm" />" />
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item3" class="require">사용</label></th>
					<td>
						<div class="form-check-group">
							<c:forEach var="useYn" items="${useYn}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="useYn" id="useYn${status.index}" value="${useYn.key}" />
									<label class="form-check-label" for="useYn${status.index}">${useYn.value }</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="adverArea" class="require">광고영역(노출위치)</label></th>
					<td>
						<form:select path="adverArea" class="form-control w-50">
							<option value="">선택</option>
							<c:forEach var="area" items="${area}">
								<form:option value="${area.key}">${area.value}</form:option>
							</c:forEach>
						</form:select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item7" class="require">배너이미지</label></th>
					<td><c:forEach var="fileList" items="${adverMngVO.fileList }" varStatus="status">
							<div id="attachFileViewDiv${fileList.fileNo}" class="">
								<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
								 <a href="#delFile" class="btn-secondary" onclick="delFile('${fileList.fileNo}', 'ATTACH', '${status.index}'); return false;"> 삭제</a>
									<div class="form-group mt-1 w-full">
										<label for="updtAttachFileDc${fileList.fileNo}"">대체텍스트</label>
										<input type="text" class="form-control flex-1 ml-2" id="updtAttachFileDc${fileList.fileNo}" name="updtAttachFileDc${fileList.fileNo}" value="${fileList.fileDc}" maxlength="200" data-update-dc>
									</div>
							</div>
						</c:forEach>

						<div id="attachFileDiv">
							<c:forEach begin="0" end="0" varStatus="status">
								<!-- 첨부파일 갯수 -->
								<div class="row" id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(adverMngVO.fileList) }">style="display:none;"</c:if>>
									<div class="col-12">
										<div class="custom-file" id="uptAttach">
											<input type="file" class="form-control w-2/3" id="attachFile${status.index}" name="attachFile${status.index}" onchange="fileCheck(this);" />
										</div>
									</div>
									<div class="col-12">
										<div class="form-group mt-1 w-full">
											<label for="updtAttachFileDc${fileList.fileNo}"">대체텍스트</label>
											<input type="text" class="form-control flex-1 ml-2" id="attachFileDc${status.index}" name="attachFileDc${status.index}"  maxlength="200">
										</div>
									</div>
								</div>
							</c:forEach>
						</div></td>
				</tr>
				<tr>
					<th scope="row"><label for="linkTy" class="require">링크</label></th>
					<td>
						<div class="form-check-group">
							<div class="form-check">
								<input type="radio" class="form-check-input" id="linkTy" name="linkTy" value="" checked/>
								<label class="form-check-label" for="linkTy">없음</label>
							</div>
							<c:forEach var="link" items="${link}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="linkTy" id="linkTy${status.index}" value="${link.key}" />
									<label class="form-check-label" for="linkTy${status.index}">${link.value}</label>
								</div>
							</c:forEach>
						</div>
						<form:input class="form-control w-full mt-1" path="linkUrl" maxlength="50" />
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<c:set var="pageParam" value="curPage=${param.curPage}&srchBgngDt=${param.srchBgngDt}&srchEndDt=${param.srchEndDt}&srchCn=${param.srchCn}&srchYn=${param.srchYn}&srchArea=${param.srchArea}" />
	<div class="btn-group right mt-8">
		<button type="submit" class="btn-primary large shadow">저장</button>
		<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	</div>
</form:form>
<script>
//파일 삭제
function delFile(fileNo, type, spanNo){
	if(confirm("삭제하시겠습니까?")){
		if(type == "ATTACH"){
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

$(function(){

	//링크 없음 #
	if($("#linkTy").prop("checked")){
		$("#linkUrl").val("#");
	}

	//날짜 시작일 < 마감일 체크
	$.validator.addMethod("SizeValidate", function(value,element){
		var bgng = $("#bgngDt").val();
		var end = $("#endDt").val();
		if(end < bgng){
			return false;
		}else {
			return true;
		}
	}, "기간을 확인해주세요.");

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
			if($("#attachFileInputDiv0").attr("style") != ''){
				return true;
			}else{
				if($("#attachFile0").val() == ''){
					return false;
				}else{
					return true;
				}
			}
		}else{
			if($("#attachFile0").val() == ''){
				return false;
			}else{
				return true;
			}
		}
	}, "파일은 필수 입력 항목입니다.");

	$("form#adverFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	adverNm : { required : true},
	    	bgngDt : { dtValidate : true, SizeValidate : true},
	    	useYn : {required : true},
	    	adverArea : {required : true},
	    	linkUrl : {required : true},
	    	attachFile0 : {filechk : true},
	    	attachFileDc0 : {required : true}
	    },
	    messages : {
	    	adverNm : { required : "제목은 필수 입력 항목 입니다."},
	    	useYn : {required : "상태는 필수 입력 항목입니다."},
	    	adverArea : {required : "광고영역은 필수 선택 항목입니다."},
	    	linkUrl : {required : "링크는 필수 입력 항목입니다."},
	    	attachFileDc0 : {required : "대체 텍스트는 필수 입력 항목입니다."}
	    },
	    submitHandler: function (frm) {
	 		var arrUpdateDc = [];
    		$("input[data-update-dc]").each(function(){
	    		arrUpdateDc.push($(this).attr("name"));
	    		console.log(arrUpdateDc);
	    	});
	    	if(arrUpdateDc.length>0){
	    		console.log(arrUpdateDc.join(","));
		    	$("input#updtImgFileDc").val(arrUpdateDc.join(","));
		    	console.log($("input#updtImgFileDc").val());
	    	}
	    	if(confirm("저장 하시겠습니까?")){
		    	frm.submit();
	    	} else{
	    		return false;
	    	}
	    }
	});
});
</script>