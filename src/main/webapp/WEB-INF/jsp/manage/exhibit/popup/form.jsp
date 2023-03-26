<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
     <form:form name="frmPopup" id="frmPopup" modelAttribute="popupVO" method="post" action="./action" enctype="multipart/form-data">
         <form:hidden path="crud" />
         <form:hidden path="popNo" />

         <input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />
         <input type="hidden" id="updtImgFileDc" name="updtImgFileDc" value="" />

		<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
		<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn }" />
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
		<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />

		<input type="hidden" name="popTy" id="popTy" value="L">

		<fieldset>
             <legend class="text-title2 relative">
                 ${popupVO.crud eq 'CREATE'?'등록':'수정' }
                 <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                     (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                 </span>
             </legend>
             <table class="table-detail">
                 <colgroup>
                     <col class="w-43">
                     <col>
                 </colgroup>
                 <tbody>
                     <tr>
                         <th scope="row"><label for="popSj" class="require">제목</label></th>
                         <td><form:input type="text" class="form-control w-full" path="popSj" maxlength="50"/></td>
                     </tr>
                     <tr>
                         <th scope="row"><label for="form-item2" class="require">노출기간</label></th>
                         <td>
							<div class="form-group">
								<input type="date" class="form-control w-40 calendar" id="bgngDt" name="bgngDt" value="<fmt:formatDate value="${popupVO.bgngDt}" pattern="yyyy-MM-dd" />"/>
								<input type="time" class="form-control w-35" name="bgngTime"  value="<fmt:formatDate value="${popupVO.bgngDt}" pattern="HH:mm" />"/>
								<i>~</i>
								<input type="date" class="form-control w-35 calendar"  id="endDt" name="endDt" value="<fmt:formatDate value="${popupVO.endDt}" pattern="yyyy-MM-dd" />"/>
								<input type="time" class="form-control w-35" name="endTime" value="<fmt:formatDate value="${popupVO.endDt}" pattern="HH:mm" />"/>
							</div>
                         </td>
                     </tr>
                     <tr>
                         <th scope="row"><label for="form-item3" class="require">상태</label></th>
							<td>
								<div class="form-group">
									<div class="form-check-group">
										<c:forEach var="sttus" items="${dspyYn}">
											<div class="form-check">
												<form:radiobutton path="useYn" class="form-check-input" id="${sttus.value}" value="${sttus.key}" />
												<label class="form-check-label" for="${sttus.value}">${sttus.value}</label>
											</div>
										</c:forEach>
									</div>
								</div>
							</td>
                     </tr>
                     <tr>
                         <th scope="row"><label class="require">하루열기옵션</label></th>
                         <td>
							<div class="form-group">
								<div class="form-check-group">
									<c:forEach var="use" items="${useYn}">
										<div class="form-check">
											<form:radiobutton path="oneViewTy" class="form-check-input" id="${use.key}" value="${use.key}" />
											<label class="form-check-label" for="${use.key}">${use.value}</label>
										</div>
									</c:forEach>
								</div>
							</div>
                         </td>
                     </tr>
                     <tr>
                         <th scope="row"><label for="" class="require">팝업크기</label></th>
                         <td>
                             <div class="form-group">
                                 <label for="popWidth" class="w-29">넓이(width)</label>
                                 <form:input type="text" path="popWidth" class="form-control w-30" value="${popupVO.popWidth}" maxlength="10"/>
                                 <span>px</span>
                             </div>
                             <div class="form-group ml-12">
                                 <label for="popHeight" class="w-29">높이(height)</label>
                                 <form:input type="text" path="popHeight" class="form-control w-30" value="${popupVO.popHeight }" maxlength="10"/>
                                 <span>px</span>
                             </div>
                         </td>
                     </tr>
                     <tr>
                         <th scope="row"><label for="" class="require">팝업위치</label></th>
                         <td>
                             <div class="form-group">
                                 <label for="popLeft" class="w-29">좌측(left)으로부터</label>
                                 <form:input type="text" path="popLeft" class="form-control w-30" value="${popupVO.popLeft}" maxlength="10"/>
                                 <span>px</span>
                             </div>
                             <div class="form-group ml-12">
                                 <label for="popTop" class="w-29">상단(top)으로부터</label>
                                 <form:input type="text" path="popTop" class="form-control w-30" value="${popupVO.popTop}" maxlength="10"/>
                                 <span>px</span>
                             </div>
                         </td>
                     </tr>
					<tr>
						<th scope="row"><label for="form-item7" class="require">팝업 이미지</label></th>
						<td><c:forEach var="fileList" items="${popupVO.fileList }" varStatus="status">
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
									<div class="row" id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(popupVO.fileList) }">style="display:none;"</c:if>>
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
                         <th scope="row"><label for="form-item8" class="require">링크</label></th>
                         <td>
							<div class="form-group">
								<div class="form-check-group">
									<c:forEach var="link" items="${linkTy}" varStatus="status">
										<div class="form-check">
											<form:radiobutton path="linkTy" class="form-check-input" id="linkTy${status.index}" value="${link.key}" maxlength="50"/>
											<label class="form-check-label" for="linkTy${status.index}">${link.value}</label>
										</div>
									</c:forEach>
								</div>
							</div>
                             <form:input type="text" class="form-control w-full mt-1" path="linkUrl" value="${popVO.linkUrl}"/>
                         </td>
                     </tr>
                 </tbody>
             </table>
         </fieldset>

		<c:set var="pageParam" value="curPage=${param.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}&srchBgngDt=${param.srchBgngDt}&srchEndDt=${param.srchEndDt}&srchText=${param.srchText}&srchYn=${param.srchYn}" />
         <div class="btn-group right mt-8">
             <button type="submit" class="btn-primary large shadow">저장</button>
             <a href="/_mng/exhibit/popup/list?${pageParam}" class="btn-secondary large shadow">목록</a>
         </div>
     </form:form>
 </div>

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

$(function(){

	//링크 없음 #
	if($("#link").prop("checked")){
		$("#linkUrl").val("#");
	}

	$("input[name='linkTy']").on("click",function(){
		if($("#linkTy1, #linkTy2").is(":checked")){
			$("#linkUrl").val("http://");
		}else{
			$("#linkUrl").val("#");
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

	$("form#frmPopup").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	bgngDt : { dtValidate : true, SizeValidate : true},
	   		popSj : {required : true},
	    	useYn : {required : true},
	    	oneViewTy : {required : true},
	    	popWidth : {required : true , min : 1 , digits : true},
	    	popHeight : {required : true , min : 1 , digits : true},
	    	popTop : {required : true , min : 0 , digits : true},
	    	popLeft : {required : true , min : 0 , digits : true},
	    	linkUrl : {required : true},
	    	attachFile0 : {filechk : true},
	    	attachFileDc0 : {required : true}
	    },
	    messages : {
	    	bgngDt : { dtValidate : "항목을 입력해주세요.", SizeValidate : "날짜를 점검해주세요."},
	    	popSj : {required : "제목은 필수 입력 항목입니다."},
	    	useYn : {required : "상태는 필수 입력 항목입니다."},
	    	oneViewTy : {required : "옵션은 필수 입력 항목입니다."},
	     	popWidth : {required : "넓이를 입력해주세요" , min : "최솟값은 1입니다." , digits : "숫자 형식만 가능합니다."},
	    	popHeight : {required : "높이를 입력해주세요" , min : "최솟값은 1입니다." , digits : "숫자 형식만 가능합니다."},
	    	popTop : {required : "상단 위치를 입력해주세요." , min : "최솟값은 0입니다." , digits : "숫자 형식만 가능합니다."},
	    	popLeft : {required : "좌측 위치를 입력해주세요." , min : "최솟값은 0입니다." , digits : "숫자 형식만 가능합니다."},
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
