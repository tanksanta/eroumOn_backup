<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/page_header.jsp">
	<jsp:param value="공지사항" name="pageTitle" />
</jsp:include>
<div id="page-content">
	<form:form action="./ntceAction" method="post" modelAttribute="bplcBbsVO" enctype="multipart/form-data" id="ntceFrm" name="ntceFrm">
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
	<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
	<form:hidden path="crud" />
	<form:hidden path="nttNo" />
	<input type="hidden" id="useYn" name="useYn" value="${bplcVO.useYn}">
	<input type="hidden" id="bplcUniqueId" name="bplcUniqueId" value="${bplcVO.uniqueId}">
	<input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="">
		<fieldset>
			<legend class="text-title2 relative">
				공지사항 ${bplcBbsVO.crud eq 'CREATE'?'등록':'수정' } <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
				</span>
			</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="form-item1">공지여부</label></th>
						<td>
							<div class="form-check-group">
								<c:forEach var="ntcYn" items="${useYnCode}" varStatus="status">
									<div class="form-check">
										<form:radiobutton class="form-check-input" path="ntcYn" id="ntcYn${status.index}" value="${ntcYn.key}"/>
										<label class="form-check-label" for="ntcYn${status.index}">${ntcYn.value}</label>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="ttl" class="require">제목</label></th>
						<td><form:input path="ttl" class="form-control w-full" maxlength="100"/></td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item3" class="require">내용</label></th>
						<td><form:textarea path="cn" rows="7" class="form-control w-full" /></td>
					</tr>
					<tr>
					<th scope="row"><label for="form-item7">첨부파일</label></th>
					<td><c:forEach var="fileList" items="${bplcBbsVO.bplcFileList}" varStatus="status">
							<div id="attachFileViewDiv${fileList.fileNo}" class="">
								<a href="/comm/getFile?srvcId=BPLCBBS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
								 <a href="#delFile" class="btn-secondary" onclick="delFile('${fileList.fileNo}', 'ATTACH', '${status.index}'); return false;"> 삭제</a>
							</div>
						</c:forEach>

						<div id="attachFileDiv">
							<c:forEach begin="0" end="0" varStatus="status">
								<!-- 첨부파일 갯수 -->
								<div class="row" id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(bplcBbsVO.bplcFileList) }">style="display:none;"</c:if>>
									<div class="col-12">
										<div class="custom-file" id="uptAttach">
											<input type="file" class="form-control w-2/3" id="attachFile${status.index}" name="attachFile${status.index}" onchange="fileChk(this);" />
										</div>
									</div>
								</div>
							</c:forEach>
						</div></td>
				</tr>
				</tbody>
			</table>
		</fieldset>
		<div class="btn-group mt-8 right">
			<c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage}" />
			<button type="submit" class="btn-save large shadow">저장</button>
			<c:if test="${bplcBbsVO.crud eq 'UPDATE' }">
			<button type="button" id="delBbs" class="btn-cancel large shadow">삭제</button>
			</c:if>
			<a href="./ntceList?${pageParam}" class="btn-primary large shadow">목록</a>
		</div>
	</form:form>
</div>

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
function fileChk(obj) {

if(obj.value != ""){

	/* 첨부파일 확장자 체크*/
	var atchLmttArr = new Array();
	atchLmttArr.push("jpg");
	atchLmttArr.push("png");
	atchLmttArr.push("gif");
	atchLmttArr.push("jpeg");
	atchLmttArr.push("pdf");
	atchLmttArr.push("hwp");
	atchLmttArr.push("doc");
	atchLmttArr.push("docx");

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
}

$(function(){

	<c:if test="${bplcSetupVO.useYn eq 'Y'}">
	//tinymce editor
	tinymce.overrideDefaults(baseConfig);
	tinymce.init({selector:"#cn"});
	</c:if>


	//유효성
	$("form#ntceFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	ttl : {required : true},
	    	cn : {required : true}
	    },
	    messages : {
	    	ttl : {required : "제목은 필수 입력 항목입니다."},
	    	cn : {required : "내용은 필수 입력 항목입니다."}
	    },
	    submitHandler: function (frm) {
	   		if($("#crud").val() != "DELETE"){
	   		 	if(confirm("저장하시겠습니까?")){
		   			frm.submit();
		   		}else{
		   			return false;
		   		}
	   		}else{
	   		frm.submit();
	    }
	    }
	});

	//삭제 기능
	$("#delBbs").on("click",function(){
		if(confirm("삭제하시겠습니까?")){
			$("#crud").val("DELETE");
			$("#ntceFrm").submit();
		}else{
			return false;
		}

	})

});
</script>