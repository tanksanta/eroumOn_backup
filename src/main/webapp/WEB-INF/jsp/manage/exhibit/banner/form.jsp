<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form action="./action" id="bannerFrm" name="bannerFrm" method="post" modelAttribute="bnnrMngVO" enctype="multipart/form-data">
<form:hidden path="crud" />
<form:hidden path="bannerNo" />

	<input type="hidden" name="srchBannerNm" id="srchBannerNm" value="${param.srchBannerNm}" />
	<input type="hidden" name="srchUseYn" id="srchUseYn" value="${param.srchUseYn}" />
	<input type="hidden" name="srchBannerTy" id="srchBannerTy" value="${param.srchBannerTy}" />
	<input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" />
	<input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" />
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
	<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />

	<input type="hidden" id="delMobileFileNo" name="delMobileFileNo" value="" />
	<input type="hidden" id="delPcFileNo" name="delPcFileNo" value="" />

	<fieldset>
		<legend class="text-title2 relative">
			${bnnrMngVO.crud eq 'CREATE'?'등록':'수정' }
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
					<th scope="row"><label for="bannerNm" class="require">배너명</label></th>
					<td><form:input class="form-control w-full" path="bannerNm" maxlength="50"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item2" class="require">노출기간</label></th>
					<td>
						<div class="form-group">
							<input type="date" class="form-control w-40 calendar" id="bgngDt" name="bgngDt" value="<fmt:formatDate value="${bnnrMngVO.bgngDt}" pattern="yyyy-MM-dd" />" />
							<input type="time" class="form-control w-35" name="bgngTime" value="<fmt:formatDate value="${bnnrMngVO.bgngDt}" pattern="HH:mm" />" />
							<i>~</i>
							<input type="date" class="form-control w-35 calendar" id="endDt" name="endDt" value="<fmt:formatDate value="${bnnrMngVO.endDt}" pattern="yyyy-MM-dd" />" />
							<input type="time" class="form-control w-35" name="endTime" value="<fmt:formatDate value="${bnnrMngVO.endDt}" pattern="HH:mm" />" />
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item3" class="require">노출여부</label></th>
					<td>
						<div class="form-check-group">
							<c:forEach var="useYn" items="${useYnCode}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="useYn" id="useYn${status.index}" value="${useYn.key}" />
									<label class="form-check-label" for="useYn${status.index}">${useYn.value }</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="adverArea" class="require">배너구분</label></th>
					<td>
						<form:select path="bannerTy" id="bannerTy" name="bannerTy" class="form-control w-30">
							<c:forEach var="bannerTy" items="${bannerTyCode}" varStatus="status">
								<option value="${bannerTy.key}" <c:if test="${bannerTy.key eq bnnrMngVO.bannerTy}">selected="selected"</c:if>>${bannerTy.value}</option>
							</c:forEach>
						</form:select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item7" class="require">배너 이미지(PC)</label></th>
					<td><c:forEach var="fileList" items="${bnnrMngVO.pcFileList }" varStatus="status">
							<div id="pcFileViewDiv${fileList.fileNo}" class="">
								<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
								 <a href="#delFile" class="btn-secondary pc-delete-flag" onclick="delFile('${fileList.fileNo}', 'PC', '${status.index}'); return false;"> 삭제</a>
									<div class="form-group mt-1 w-full">
										<label for="updtPcFileDc${fileList.fileNo}"">대체텍스트</label>
										<input type="text" class="form-control flex-1 ml-2" id="updtPcFileDc${fileList.fileNo}" name="updtPcFileDc" value="${fileList.fileDc}" maxlength="200" data-update-dc>
									</div>
							</div>
						</c:forEach>

						<div id="pcFileDiv">
							<c:forEach begin="0" end="0" varStatus="status">
								<!-- 첨부파일 갯수 -->
								<div class="row" id="pcFileInputDiv${status.index}" <c:if test="${status.index < fn:length(bnnrMngVO.pcFileList) }">style="display:none;"</c:if>>
									<div class="col-12">
										<div class="custom-file" id="uptPc">
											<input type="file" class="form-control w-2/3" id="pcFile${status.index}" name="pcFile${status.index}" onchange="fileCheck(this);" />
										</div>
									</div>
									<div class="col-12">
										<div class="form-group mt-1 w-full">
											<label for="updtPcFileDc${fileList.fileNo}"">대체텍스트</label>
											<input type="text" class="form-control flex-1 ml-2" id="pcFileDc${status.index}" name="pcFileDc${status.index}"  maxlength="200">
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<p>※ 이미지 권장 사이즈 (띠 배너 1200px * 55px, 메인 배너 1920px * 500px)</p>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item7" class="require" id="mobile" >배너 이미지(모바일)</label></th>
					<td><c:forEach var="fileList" items="${bnnrMngVO.mobileFileList }" varStatus="status">
							<div id="mobileFileViewDiv${fileList.fileNo}" class="">
								<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
								 <a href="#delFile" class="btn-secondary mobile-delete-flag" onclick="delFile('${fileList.fileNo}', 'MOBILE', '${status.index}'); return false;"> 삭제</a>
									<div class="form-group mt-1 w-full">
										<label for="updtMobileFileDc${fileList.fileNo}"">대체텍스트</label>
										<input type="text" class="form-control flex-1 ml-2" id="updtMobileFileDc${fileList.fileNo}" name="updtMobileFileDc" value="${fileList.fileDc}" maxlength="200" data-update-dc>
									</div>
							</div>
						</c:forEach>

						<div id="mobileFileDiv">
							<c:forEach begin="0" end="0" varStatus="status">
								<!-- 첨부파일 갯수 -->
								<div class="row" id="mobileFileInputDiv${status.index}" <c:if test="${status.index < fn:length(bnnrMngVO.mobileFileList) }">style="display:none;"</c:if>>
									<div class="col-12">
										<div class="custom-file" id="uptMobile">
											<input type="file" class="form-control w-2/3" id="mobileFile${status.index}" name="mobileFile${status.index}" onchange="fileCheck(this);" />
										</div>
									</div>
									<div class="col-12">
										<div class="form-group mt-1 w-full">
											<label for="updtMobileFileDc${fileList.fileNo}"">대체텍스트</label>
											<input type="text" class="form-control flex-1 ml-2" id="mobileFileDc${status.index}" name="mobileFileDc${status.index}"  maxlength="200">
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
						<p class="mobileText">※ 이미지 권장 사이즈 (띠 배너 800px * 100px, 메인 배너 800px * 800px)</p>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="linkTy" class="require">링크</label></th>
					<td>
						<div class="form-check-group">
							<c:forEach var="link" items="${linkTyCode}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="linkTy" id="linkTy${status.index}" value="${link.key}" />
									<label class="form-check-label" for="linkTy${status.index}">${link.value}</label>
								</div>
							</c:forEach>
						</div>
						<form:input class="form-control w-full mt-1" path="linkUrl" maxlength="250" />
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<p>※ 대체텍스트는 시각장애인의 웹 접근성을 위한 설명입니다.</p>

	<c:set var="pageParam" value="curPage=${param.curPage}&srchBgngDt=${param.srchBgngDt}&srchEndDt=${param.srchEndDt}&srchBannerNm=${param.srchBannerNm}&srchUseYn=${param.srchUseYn}" />
	<div class="btn-group right mt-8">
		<button type="submit" class="btn-primary large shadow">저장</button>
		<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	</div>
</form:form>

<script>
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

function delFile(fileNo, type, spanNo){
	if(confirm("삭제하시겠습니까?")){

		if(type == "PC"){
			if($("#delPcFileNo").val() == ""){
				$("#delPcFileNo").val(fileNo);
			}else{
				$("#delPcFileNo").val($("#delPcFileNo").val()+","+fileNo);
			}
			$("#pcFileViewDiv"+fileNo).remove();
			$("#pcFileInputDiv"+spanNo).show();
		}else if(type=="MOBILE"){
			if($("#delMobileFileNo").val() == ""){
				$("#delMobileFileNo").val(fileNo);
			}else{
				$("#delMobileFileNo").val($("#delMobileFileNo").val()+","+fileNo);
			}
			$("#mobileFileViewDiv"+fileNo).remove();
			$("#mobileFileInputDiv"+spanNo).show();
		}
	}
}

$(function(){

	$("#bannerTy").on("change",function(){
		let mobileTextMsg = "※ 모바일 띠배너 비 권장";
		let pcTextMsg = "※ 이미지 권장 사이즈 (띠 배너 1920px * 500px, 메인 배너 800px * 800px)";

		if($("#bannerTy").val() == "S"){
			$(".mobileText").text(mobileTextMsg);
			$("#mobile").removeClass("require");
		}else{
			$(".mobileText").text(pcTextMsg);
			$("#mobile").addClass("require");
		}
	});

	$("#pcFile0, #mobileFile0").on("change",function(){
		if($(this).val() != '' ){
			$(this).removeClass("is-invalid");
			$(this).siblings(".invalid-feedback").remove();
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
			if($("#pcFileInputDiv0").attr("style") != ''){
				return true;
			}else{
				if($("#pcFile0").val() == ''){
					return false;
				}else{
					return true;
				}
			}
		}else{
			if($("#pcFile0").val() == ''){
				return false;
			}else{
				return true;
			}
		}
	}, "파일은 필수 입력 항목입니다.");

	// 첨부파일 검사 메소드
	$.validator.addMethod("mobileFilechk", function(value,element){
		let bannerTy = $("#bannerTy").val();

		// 메인 배너는 모바일 필수
		// 띠 배너는 모바일 필수 x
		// 업데이트 때에 삭제 버튼이 있으면 통과 없으면 실패

		if("${bnnrMngVO.crud}" == "UPDATE"){
			if(bannerTy == "M"){
				if($(".mobile-delete-flag").length > 0 || $("#mobileFile0").val() != ''){
					return true;
				}else{
					return false;
				}
			}else{
				return true;
			}
		}else{
			if(bannerTy == "M"){
				if($("#mobileFile0").val() != ''){
					return true;
				}else{
					return false;
				}
			}else{
				return true;
			}
		}
	}, "파일은 필수 입력 항목입니다.");

	$("form#bannerFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	bannerNm : { required : true},
	    	bgngDt : { dtValidate : true, SizeValidate : true},
	    	linkUrl : {required : true},
	    	pcFile0 : {filechk : true},
	    	mobileFile0 : {mobileFilechk : true}
	    },
	    messages : {
	    	bannerNm : { required : "제목은 필수 입력 항목 입니다."},
	    	linkUrl : {required : "링크는 필수 입력 항목입니다."},
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