<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form:form name="mainFrm" id="mainFrm" modelAttribute="mainMngVO" method="post" action="./action" enctype="multipart/form-data">
		<form:hidden path="crud" />
		<form:hidden path="mainNo" />
		<form:hidden path="sortNo" />
		<form:hidden path="rdcnt" />

		<input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />
		<input type="hidden" id="delAttachPcFileNo" name="delAttachPcFileNo" value="" />
		<input type="hidden" id="delAttachMobileFileNo" name="delAttachMobileFileNo" value="" />
		<input type="hidden" id="delAttachHalfFileNo" name="delAttachHalfFileNo" value="" />

		<fieldset>
			<legend class="text-title2 relative">
				${mainMngVO.crud eq 'CREATE'?'등록':'수정' } <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
				</span>
			</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="themaTy" class="require">테마구분</label></th>
						<td>
							<form:select path="themaTy" class="form-control w-39">
								<c:forEach var="thema" items="${mainTyCode}">
									<option value="${thema.key}" <c:if test="${thema.key eq mainMngVO.themaTy}">selected="selected"</c:if>>${thema.value}</option>
								</c:forEach>
							</form:select>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="sj" class="require">주제명</label></th>
						<td>
							<form:input class="form-control w-full" path="sj" value="${mainMngVO.sj}"/>
						</td>
					</tr>
					<tr class="gds_view" <c:if test="${mainMngVO.themaTy ne 'G' }">style="display:none;"</c:if>>
						<th scope="row">
							<label for="" class="require">주제명 아이콘</label>
						</th>
						<td>
							<c:forEach var="fileList" items="${mainMngVO.fileList}" varStatus="status">
								<div id="attachFileViewDiv${fileList.fileNo}">
									<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
									<a href="#delFile" class="btn-secondary icon-delete-flag" onclick="delFile('${fileList.fileNo}', 'ICON', '${status.index}'); return false;"> 삭제</a>
								</div>
							</c:forEach>

							<div id="attachFileDiv">
								<c:forEach begin="0" end="0" varStatus="status">
									<!-- 첨부파일 갯수 -->
									<div class="row" id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(mainMngVO.fileList) }">style="display:none;"</c:if>>
										<div class="col-12">
											<div class="custom-file" id="uptAttach">
												<input type="file" class="form-control w-2/3" id="attachFile${status.index}" name="attachFile${status.index}" onchange="fileChk(this);" />
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
							<p>※ 1MB 이하의 jpg.gif.png 확장자 등록 가능</p>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item2">노출 여부</label></th>
						<td>
							<div class="form-group">
								<div class="form-check-group">
									<c:forEach var="sttus" items="${useYnCode}">
										<div class="form-check">
											<form:radiobutton path="useYn" class="form-check-input" id="${sttus.value}" value="${sttus.key}" />
											<label class="form-check-label" for="${sttus.value}">${sttus.value}</label>
										</div>
									</c:forEach>
								</div>
							</div>
						</td>
					</tr>
					<tr  class="gds_view" <c:if test="${mainMngVO.themaTy ne 'G' }">style="display:none;"</c:if>>
						<th><label for="telno">상품 선택</label></th>
						<td>
							<button type="button" class="btn btn-primary f_srchGds" data-bs-toggle="modal" data-bs-target="#gdsModal">상품 선택</button>
							<input type="hidden" name="choose_item" value="" />
						</td>
					</tr>
					<tr class="view_banner" <c:if test="${mainMngVO.themaTy ne 'B' }">style="display:none;"</c:if>>
						<th class="text-center">
							<label for="" class="require">배너 이미지(PC)</label><br />
							※ 이미지 권장 사이즈<br />
							(1200px * 150px)
						</th>
						<td>
							<c:forEach var="fileList" items="${mainMngVO.pcImgFileList}" varStatus="status">
								<div id="attachFilePcViewDiv${fileList.fileNo}" class="">
									<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
									<a href="#delFile" class="btn-secondary banner-delete-flag" onclick="delFile('${fileList.fileNo}', 'PC', '${status.index}'); return false;"> 삭제</a>
									<div class="form-group mt-1 w-full">
										<label for="updtAttachPcFileDc"">대체텍스트</label>
										<input type="text" class="form-control flex-1 ml-2" id="updtAttachPcFileDc${fileList.fileNo}" name="updtAttachPcFileDc" value="${fileList.fileDc}" maxlength="200" data-update-dc>
									</div>
								</div>
							</c:forEach>

							<div id="attachPcFileDiv">
								<c:forEach begin="0" end="0" varStatus="status">
									<!-- 첨부파일 갯수 -->
									<div class="row" id="attachFilePcInputDiv${status.index}" <c:if test="${status.index < fn:length(mainMngVO.pcImgFileList)}">style="display:none;"</c:if>>
										<div class="col-12">
											<div class="custom-file" id="uptPcAttach">
												<input type="file" class="form-control w-2/3" id="attachPcFile${status.index}" name="pcFile${status.index}" onchange="fileChk(this);" />
											</div>
										</div>
										<div class="col-12">
											<div class="form-group mt-1 w-full">
												<label for="pcFileDc${fileList.fileNo}"">대체텍스트</label>
												<input type="text" class="form-control flex-1 ml-2" id="pcFileDc${status.index}" name="pcFileDc${status.index}" maxlength="200">
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr class="view_banner" <c:if test="${mainMngVO.themaTy ne 'B' }">style="display:none;"</c:if>>
						<th class="text-center">
							<label for="" class="require">배너 이미지(모바일)</label><br />
							※ 이미지 권장 사이즈<br />
							(800px * 150px)
						</th>
						<td>
							<c:forEach var="fileList" items="${mainMngVO.mobileImgFileList }" varStatus="status">
								<div id="attachMobileFileViewDiv${fileList.fileNo}" class="">
									<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
									<a href="#delFile" class="btn-secondary banner-delete-flag" onclick="delFile('${fileList.fileNo}', 'MOBILE', '${status.index}'); return false;"> 삭제</a>
									<div class="form-group mt-1 w-full">
										<label for="updtMobileFileDc${fileList.fileNo}"">대체텍스트</label>
										<input type="text" class="form-control flex-1 ml-2" id="updtMobileFileDc${fileList.fileNo}" name="updtMobileFileDc" value="${fileList.fileDc}" maxlength="200" data-update-dc>
									</div>
								</div>
							</c:forEach>

							<div id="attachMobileFileDiv">
								<c:forEach begin="0" end="0" varStatus="status">
									<!-- 첨부파일 갯수 -->
									<div class="row" id="attachFileMobileInputDiv${status.index}" <c:if test="${status.index < fn:length(mainMngVO.mobileImgFileList)}">style="display:none;"</c:if>>
										<div class="col-12">
											<div class="custom-file" id="uptMobileAttach">
												<input type="file" class="form-control w-2/3" id="mobileFile${status.index}" name="mobileFile${status.index}" onchange="fileChk(this);" />
											</div>
										</div>
										<div class="col-12">
											<div class="form-group mt-1 w-full">
												<label for="mobileFileDc${fileList.fileNo}"">대체텍스트</label>
												<input type="text" class="form-control flex-1 ml-2" id="mobileFileDc${status.index}" name="mobileFileDc${status.index}" maxlength="200">
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr class="view_half" <c:if test="${mainMngVO.themaTy ne 'H' }">style="display:none;"</c:if>>
						<th class="text-center">
							<label for="" class="require">배너 이미지</label><br />
							※ 이미지 권장 사이즈<br />
							(590px * 100px)
						</th>
						<td>
							<c:forEach var="fileList" items="${mainMngVO.halfFileList}" varStatus="status">
								<div id="attachHalfFileViewDiv${fileList.fileNo}" class="">
									<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
									<a href="#delFile" class="btn-secondary half-delete-flag" onclick="delFile('${fileList.fileNo}', 'HALF', '${status.index}'); return false;"> 삭제</a>
									<div class="form-group mt-1 w-full">
										<label for="updtHalfFileDc${fileList.fileNo}"">대체텍스트</label>
										<input type="text" class="form-control flex-1 ml-2" id="updtHalfFileDc${fileList.fileNo}" name="updtHlafFileDc" value="${fileList.fileDc}" maxlength="200" data-update-dc>
									</div>
								</div>
							</c:forEach>

							<div id="attachHalfFileDiv">
								<c:forEach begin="0" end="0" varStatus="status">
									<!-- 첨부파일 갯수 -->
									<div class="row" id="attachFileHalfInputDiv${status.index}" <c:if test="${status.index < fn:length(mainMngVO.halfFileList)}">style="display:none;"</c:if>>
										<div class="col-12">
											<div class="custom-file" id="uptHalfAttach">
												<input type="file" class="form-control w-2/3" id="attachHalfFile${status.index}" name="halfFile${status.index}" onchange="fileChk(this);" />
											</div>
										</div>
										<div class="col-12">
											<div class="form-group mt-1 w-full">
												<label for="halfFileDc${fileList.fileNo}"">대체텍스트</label>
												<input type="text" class="form-control flex-1 ml-2" id="halfFileDc${status.index}" name="halfFileDc${status.index}" maxlength="200">
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr class="view_banner view_half" <c:if test="${mainMngVO.themaTy eq 'G' }">style="display:none;"</c:if> id="linkUrlView">
						<th><label for="" class="require">배너 링크 주소</label></th>
						<td>
							<form:input class="form-control w-full" path="linkUrl" />
						</td>
					</tr>
				</tbody>
			</table>
			<p>※ 대체텍스트는 시각장애인의 웹 접근성을 위한 설명입니다.</p>
		</fieldset>

		<fieldset class="mt-13 grpView1CL gds_view" <c:if test="${mainMngVO.themaTy ne 'G' }">style="display:none;"</c:if>>
			<legend class="text-title2 relative">상품구성	</legend>

			<table class="table-list" id="relGdsList">
				<colgroup>
					<col class="w-15">
					<col class="w-[15%]">
					<col>
					<col>
					<col class="w-30">
					<col class="w-20">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">
							<div class="form-check">
							</div>
						</th>
						<th scope="col">상품코드</th>
						<th scope="col">상품명</th>
						<th scope="col">상품 카테고리</th>
						<th scope="col">전시여부</th>
						<th scope="col">노출 순서</th>
					</tr>
				</thead>
				<tbody id="bodyView/{num}/ori" class="relGdsList/{num}/oriCL selectView">
					<c:forEach var="resultList" items="${itemList}" varStatus="status">
						<tr class="draggableTr">
							<td>
								<div class="form-check">
									<button type="button" class="btn-danger tiny btn-relGds-remove">
										<i class="fa fa-trash"></i>
									</button>
									<input type="hidden" name="gdsNo/{num}/ori" value="${resultList.gdsNo }">
								</div>
							</td>
							<td><a href="#">${resultList.gdsInfo.gdsCd}</a></td>
							<td class="text-left">${resultList.gdsInfo.gdsNm }</td>
							<td>
								${resultList.gdsCtgry.upCtgryNm}
								<c:if test="${!empty resultList.gdsCtgry.ctgryNm}">
								> ${resultList.gdsCtgry.ctgryNm}
								</c:if>
							</td>
							<td>${useYnCode[resultList.gdsInfo.useYn]}</td>
							<td class="draggable" style="cursor: pointer;">
								<button type="button" class="btn-warning tiny" data-click-val="${status.index +1}">
									<i class="fa fa-arrow-down-up-across-line"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty itemList}">
						<tr class="noresult blankVal/{num}/ori">
							<td colspan="6">등록된 상품이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</fieldset>


		<c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}&amp;srchYn=${param.srchYn}&amp;sortBy=${param.sortBy}" />
		<div class="btn-group mt-8 right">
			<button type="submit" class="btn-primary large shadow">저장</button>
			<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
		</div>
	</form:form>
</div>
<c:import url="/_mng/gds/gds/modalGdsSearch" />

<script>

//노출 상태
var dspyYnCode = {
<c:forEach items="${dspyYnCode}" var="iem" varStatus="status">
${iem.key} : "${iem.value}",
</c:forEach>
}

var Dragable = function(){
	return {
		init: function(){

			var containers = document.querySelectorAll('#relGdsList tbody');
			if (containers.length === 0) {
				return false;
			}
			var sortable = new Sortable.default(containers, {
				draggable: '.draggableTr',
				handle: '.draggable',
				delay:100,
				mirror: {
					appendTo: "#relGdsList tbody",
					constrainDimensions: true
				}
			});

		}
	};
}();

//삭제 스크립트
function delFile(fileNo, type, spanNo){
	if(confirm("삭제하시겠습니까?")){

		if(type == "ICON"){
			if($("#delAttachFileNo").val() == ""){
				$("#delAttachFileNo").val(fileNo);
			}else{
				$("#delAttachFileNo").val($("#delAttachFileNo").val()+","+fileNo);
			}
			$("#attachFileViewDiv"+fileNo).remove();
			$("#attachFileInputDiv"+spanNo).show();
		}else if(type == "PC"){
			if($("#delAttachPcFileNo").val() == ""){
				$("#delAttachPcFileNo").val(fileNo);
			}else{
				$("#delAttachPcFileNo").val($("#delAttachPcFileNo").val()+","+fileNo);
			}
			$("#attachFilePcViewDiv"+fileNo).remove();
			$("#attachFilePcInputDiv"+spanNo).show();
		}else if(type=="MOBILE"){
			if($("#delAttachMobileFileNo").val() == ""){
				$("#delAttachMobileFileNo").val(fileNo);
			}else{
				$("#delAttachMobileFileNo").val($("#delAttachMobileFileNo").val()+","+fileNo);
			}
			$("#attachMobileFileViewDiv"+fileNo).remove();
			$("#attachFileMobileInputDiv"+spanNo).show();
		}else {
			if($("#delAttachHalfFileNo").val() == ""){
				$("#delAttachHalfFileNo").val(fileNo);
			}else{
				$("#delAttachHalfFileNo").val($("#delAttachHalfFileNo").val()+","+fileNo);
			}
			$("#attachHalfFileViewDiv"+fileNo).remove();
			$("#attachFileHalfInputDiv"+spanNo).show();
		}
	}
}

//상품검색 콜백
function f_modalGdsSearch_callback(gdsNos){
	//console.log("callback: " + gdsNos);
	if($("#relGdsList tbody td").hasClass("no-data")){
		$("#relGdsList tbody tr").remove();
	}

	// 자신 번호도 추가x
	gdsNos = arrayRemove(gdsNos, ${gdsVO.gdsNo});
		// 중복된 상품이 있을 경우 추가x
		$("input[name='gdsNo']").each(function(){
   		gdsNos = arrayRemove(gdsNos, $(this).val());
		});

	gdsNos.forEach(function(gdsNo){
		console.log('gdsNo', gdsNo);
		//console.log(gdsMap.get(parseInt(gdsNo)));
		var gdsJson = gdsMap.get(parseInt(gdsNo));
		$(".noresult").remove();
		//relGdsList
		var html ="";
		html += '<tr class="draggableTr">';
		html += '<td>';
		html += '<div class="form-check">';
		html += '<button type="button" class="btn-danger tiny btn-relGds-remove"><i class="fa fa-trash"></i></button>';
		html += '<input type="hidden" name="gdsNo"  value="'+gdsJson.gdsNo+'">';
		html += '</div>';
		html += '</td>';
		html += '<td><a href="#">'+gdsJson.gdsCd+'</a></td>';
		html += '<td class="text-left">'+gdsJson.gdsNm+'</td>';
		html += '<td class="text-left">'+gdsJson.upCtgryNm+' &gt; '+gdsJson.ctgryNm+'</td>';
		html += '<td>'+dspyYnCode[gdsJson.useYn]+'</td>';
        html += '    <td class="draggable" style="cursor:pointer;">';
        html += '	 	<button type="button" class="btn-warning tiny"><i class="fa fa-arrow-down-up-across-line"></i></button>';
        html += '    </td>';
        html += '</td>';
		html += '</tr>';
		$("#relGdsList tbody").append(html);
	});

	$(".btn-close").click();
}

//첨부파일 이미지 제한
function fileChk(obj) {

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
	// 상품검색 모달
	$(".f_srchGds").on("click", function(){
		if($(".selectView .noresult").length < 1){
   			$("input[name='choose_item']").siblings(".invalid-feedback").remove();
   		}

		if ( !$.fn.dataTable.isDataTable('#gdsDataTable') ) { //데이터 테이블이 있으면x
 			GdsDataTable.init();
 		}
	});

   	//draggable js loading
	$.getScript("<c:url value='/html/core/vendor/draggable/draggable.bundle.js'/>", function(data,textStatus,jqxhr){
		if(jqxhr.status == 200) {
			Dragable.init();
		} else {
			console.log("draggable is load failed")
		}
	});

   	$("#themaTy").on("change", function(){
   		$("input[type='file']").val(null);
   		$("input[type='text']").val(null);
   		$("#linkUrl").val("#");
   		$(".selectView").empty();
   		$(".selectView").append('<tr><td colspan="6" class="noresult">등록된 관련상품이 없습니다.</td></tr>');

   		if($(this).val() == "G"){
   			$(".view_banner").hide();
   			$(".view_half").hide();
   			$(".gds_view").show();
   		}else if($(this).val() == "B"){
   			$(".view_banner").show();
   			$(".view_half").hide();
   			$(".gds_view").hide();
   			$("#linkUrlView").show();
   		}else{
   			$(".view_banner").hide();
   			$(".gds_view").hide();
			$(".view_half").show();
   		}
   	});

   	$("#attachFile0").on("change",function(){
   		if($(this).val() != ''){
   			$(this).removeClass("is-invalid");
   	   		$(this).siblings(".invalid-feedback").remove();
   		}
   	});

 	// 관련상품 목록 삭제
	$(document).on("click", ".btn-relGds-remove", function(e){
		e.preventDefault();
		$(this).parents("tr").remove();
		if($(".draggableTr").length == 0){
			$(".selectView").append('<tr><td colspan="6" class="noresult">등록된 관련상품이 없습니다.</td></tr>');
		}
	});

	$.validator.addMethod("iconCheck", function(value,element){
		if($("#themaTy").val() == "G"){
			if("${mainMngVO.crud}" != "UPDATE"){
				if($("#attachFile0").val() == ""){
					return false;
				}else{
					return true;
				}
			}else{
				if($(".icon-delete-flag").length < 1 && $("#attachFile0").val() == ""){
					return false;
				}else{
					return true;
				}
			}
		}else{
			return true;
		}
	}, "주제명 아이콘은 필수 입력 항목입니다.");

  //유효성 검사
    $("form#mainFrm").validate({
    ignore: "input[type='text']:hidden",
    rules : {
    	sj : { required : true}
    	, attachFile0 : {iconCheck : true}
    },
    messages : {
    	sj : { required : "주제명은 필수 입력 항목입니다."}
    },
    submitHandler: function (frm) {
   		if(confirm("저장하시겠습니까?")){
       		//frm.submit();
       	}else{
       		return false;
       	}
    }

    });
});

</script>

