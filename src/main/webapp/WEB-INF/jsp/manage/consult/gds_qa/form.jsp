<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form:form modelAttribute="gdsQaVO" id="qaFrm" name="qaFrm" action="./action" method="post">
	<form:hidden path="crud" />
	<form:hidden path="qaNo" />
	<form:hidden path="ansUniqueId" />

	<input type="hidden" id="curPage" name="curPage" value="${param.curPage}" >
	<input type="hidden" id="cntPerPage" name="cntPerPage" value="${param.cntPerPage}">
	<input type="hidden" id="sortBy" name="sortBy" value="${param.sortBy}">
	<input type="hidden" id="srchRegYmdBgng" name="srchRegYmdBgng" value="${param.srchRegYmdBgng}">
	<input type="hidden" id="srchRegYmdEnd" name="srchRegYmdEnd" value="${param.srchRegYmdEnd}">
	<input type="hidden" id="srchRgtrId" name="srchRgtrId" value="${param.srchRgtrId}">
	<input type="hidden" id="srchRgtr" name="srchRgtr" value="${param.srchRgtr}">
	<input type="hidden" id="srchQestnCn" name="srchQestnCn" value="${param.srchQestnCn}">
	<input type="hidden" id="srchDspyYn" name="srchDspyYn" value="${param.srchDspyYn}">
	<input type="hidden" id="srchAnsYn" name="srchAnsYn" value="${param.srchAnsYn}">


		<p class="text-title2">상세정보</p>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">상품코드/상품명</th>
					<td>${gdsQaVO.gdsCd}/ ${gdsQaVO.gdsNm}</td>
				</tr>
				<tr>
					<th scope="row">작성자</th>
					<td>${gdsQaVO.rgtr}/ ${gdsQaVO.regUniqueId}</td>
				</tr>
				<tr>
					<th scope="row">등록일</th>
					<td><fmt:formatDate value="${gdsQaVO.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td>${gdsQaVO.qestnCn}</td>
				</tr>
			</tbody>
		</table>

		<p class="text-title2 relative mt-13">
			답변하기 <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
			</span>
		</p>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="form-item1">사용여부 <sup class="badge-require"></sup></label></th>
					<td>
						<div class="form-check-group">
							<c:forEach var="useYn" items="${useYnCode}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="useYn" id="useYn${status.index}" value="${useYn.key}" />
									<label class="form-check-label" for="useYn${status.index}">${useYn.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">상태</th>
					<td>${ansYnCode[gdsQaVO.ansYn]}</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item2">답변내용 <sup class="badge-require"></sup></label></th>
					<td><form:textarea path="ansCn" cols="30" rows="4" class="form-control w-full" /></td>
				</tr>
				<c:if test="${gdsQaVO.ansDt ne null}">
					<tr>
						<th scope="row">등록일</th>
						<td>${gdsQaVO.answr}(${gdsQaVO.ansId})/ <fmt:formatDate value="${gdsQaVO.ansDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
				</c:if>
			</tbody>

		</table>

		<c:set var="pageParam" value="curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;sortBy=${param.sortBy}&amp;srchRegYmdBgng=${param.srchRegYmdBgng}&amp;srchRegYmdEnd=${param.srchRegYmdEnd}&&amp;srchRgtrId=${param.srchRgtrId}&amp;srchRgtr=${param.srchRgtr}&amp;srchQestnCn=${param.srchQestnCn}&amp;srchUseYn=${param.srchUseYn}&amp;srchUseYn=${param.srchUseYn}" />
		<div class="btn-group right mt-8">
			<button type="submit" class="btn-primary large shadow">저장</button>
			<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
		</div>
	</form:form>
</div>

<script>
$(function(){

	//유효성 검사
	$("form#qaFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	ansCn : { required : true}
	    },
	    messages : {
	    	ansCn : { required : "답변 내용은 필수 입력 항목입니다."}
	    },
	    submitHandler: function (frm) {
		    	if(confirm("저장 하시겠습니까?")){
			    	frm.submit();
		    	} else{
		    		return false;
		    	}
	    }
	});

})
</script>
