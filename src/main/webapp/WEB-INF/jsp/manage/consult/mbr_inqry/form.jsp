<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<fieldset>
	<p class="text-title2">상세정보</p>
	<table class="table-detail">
		<colgroup>
			<col class="w-43">
			<col>
			<col class="w-43">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">문의유형</th>
				<td>${inqryTyCode[mbrInqryVO.inqryTy]}</td>
			</tr>
			<tr>
				<th scope="row">작성자</th>
				<td>${mbrInqryVO.rgtr}</td>
			</tr>
			<tr>
				<th scope="row">휴대폰 번호</th>
				<td>${mbrInqryVO.mblTelno }</td>
				<th scope="row">SMS 알림</th>
				<td>${useYn[mbrInqryVO.smsAnsYn]}</td>
			</tr>
			<tr>
				<th scope="row">이메일</th>
				<td>${mbrInqryVO.eml}</td>
				<th scope="row">이메일 알림</th>
				<td>${useYn[mbrInqryVO.emlAnsYn]}</td>
			</tr>
			<tr>
				<th scope="row">주문번호</th>
				<td>${mbrInqryVO.ordrCd}</td>
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td>${mbrInqryVO.ttl}</td>
			</tr>
			<tr>
				<th scope="row">내용</th>
				<td>${mbrInqryVO.cn}</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td>
					<c:forEach var="fileList" items="${mbrInqryVO.fileList}">
						<a href="/comm/getFile?srvcId=INQRY&amp;upNo=${fileList.upNo}&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm}</a>
						<a class="form-control" href="/comm/getFile?srvcId=INQRY&amp;upNo=${fileList.upNo}&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" data-lightbox="inqryThumb" data-title="${fileList.orgnlFileNm}">미리보기</a>
					</c:forEach>
				</td>
			</tr>
			<tr>
				<th scope="row">등록일</th>
				<td><fmt:formatDate value="${mbrInqryVO.regDt}" pattern="yyyy-MM-dd" /></td>
			</tr>
		</tbody>
	</table>
	</fieldset>
	<fieldset class="mt-13">
		<form:form action="./ansAction" method="post" id="frmAns" name="frmAns" modelAttribute="mbrInqryVO">
		<form:hidden path="crud" />
		<form:hidden path="eml" />
		<input type="hidden" id="inqryNo" name="inqryNo" value="${mbrInqryVO.inqryNo }">
		<input type="hidden" name="srchRegBgng" id="srchRegBgng" value="${param.srchRegBgng}" >
		<input type="hidden" name="srchRegEnd" id="srchRegEnd" value="${param.srchRegEnd}" >
		<input type="hidden" name="srchId" id="srchId" value="${param.srchId}" >
		<input type="hidden" name="srchName" id="srchName" value="${param.srchName}" >
		<input type="hidden" name="srchInqryTy" id="srchInqryTy" value="${param.srchInqryTy}" >
		<input type="hidden" name="srchAns" id="srchAns" value="${param.srchAns}" >
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}">
		<input type="hidden" name="curPage" id="curPage" value="${param.curPage}">
		<input type="hidden" name="ansYn" id="ansYn" value="${param.ansYn}">
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}">


		<legend class="text-title2">답변하기</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">상태</th>
					<td id="ansYnFrm">${ansYn[mbrInqryVO.ansYn]}</td>
				</tr>
				<tr>
					<th scope="row">답변 내용<span class="require"></span></th>
					<td><form:textarea path="ansCn" class="form-control w-full" value="${mbrInqryVO.ansCn}" maxlength="1000"/></td>
				</tr>
				<c:if test="${mbrInqryVO.ansDt ne null}">
					<tr>
						<th scope="row">등록일</th>
						<td id="regDtFrm">${mbrInqryVO.answr} (${mbrInqryVO.ansId}) / <fmt:formatDate value="${mbrInqryVO.ansDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<c:set var="pageParam" value="inqryNo=${param.inqryNo}&amp;ansYn=${param.ansYn}&amp;curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchRegBgng=${param.srchRegBgng}&amp;srchRegEnd=${param.srchRegEnd}
			&amp;srchId=${param.srchId}	&amp;srchName=${param.srchName}&amp;srchInqryTy=${param.srchInqryTy}&amp;srchAns=${param.srchAns}&amp;sortBy=${param.sortBy}" />
		<div class="btn-group mt-8 right">
			<button type="submit" class="btn-primary large shadow">저장</button>
			<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
		</div>
	</form:form>
	</fieldset>

</div>
<script>
	$(function(){

		  lightbox.option({
		      'resizeDuration': 200,
		      'wrapAround': true
		    });

		//tinymce editor
		tinymce.overrideDefaults(baseConfig);
		tinymce.init({selector:"#ansCn"});

		//유효성 검사
		$("form#frmAns").validate({
		    ignore: "input[type='text']:hidden",
		    rules : {
		    	ansCn : { required : true}
		    },
		    messages : {
		    	ansCn : { required : "답변 내용은 필수 입력 항목입니다." , maxlength : "답변 내용은 1000자 입니다."}
		    },
		    submitHandler: function (frm) {
			    	if(confirm("저장 하시겠습니까?")){
				    	frm.submit();
			    	} else{
			    		return false;
			    	}
		    }
		});

		if($("#ansYnFrm").html() == "답변미완료"){
			$("#regDtFrm").html(null);
		}
	});
</script>