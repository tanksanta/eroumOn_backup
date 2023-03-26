<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form action="./action" id="useYnFrm" name="useYnFrm" method="post" modelAttribute="gdsReivewVO">
<form:hidden path="gdsReivewNo" />

<input type="hidden" id="curPage" name="curPage" value="${param.curPage}" >
<input type="hidden" id="cntPerPage" name="cntPerPage" value="${param.cntPerPage}" >
<input type="hidden" id="sortBy" name="sortBy" value="${param.sortBy}" >
<input type="hidden" id="srchRegYmdBgng" name="srchRegYmdBgng" value="${param.srchRegYmdBgng}" >
<input type="hidden" id="srchRegYmdEnd" name="srchRegYmdEnd" value="${param.srchRegYmdEnd}" >
<input type="hidden" id="srchRgtrId" name="srchRgtrId" value="${param.srchRgtrId}" >
<input type="hidden" id="srchRgtr" name="srchRgtr" value="${param.srchRgtr}" >
<input type="hidden" id="srchTtl" name="srchTtl" value="${param.srchTtl}" >
<input type="hidden" id="srchGdsNm" name="srchGdsNm" value="${param.srchGdsNm}" >
<input type="hidden" id="srchGdsCd" name="srchGdsCd" value="${param.srchGdsCd}" >
<input type="hidden" id="srchDspyYn" name="srchDspyYn" value="${param.srchDspyYn}" >
<input type="hidden" id="srchAnsYn" name="srchAnsYn" value="${param.srchAnsYn}" >

<div id="page-content">
	<p class="text-title2">상세정보</p>
	<table class="table-detail">
		<colgroup>
			<col class="w-43">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">상품코드/상품명</th>
				<td>${gdsReivewVO.gdsCd} / ${gdsReivewVO.gdsNm}</td>
			</tr>
			<tr>
				<th scope="row">작성자</th>
				<td>${gdsReivewVO.rgtr} / ${gdsReivewVO.regId}</td>
			</tr>
			<tr>
				<th scope="row">등록일</th>
				<td><fmt:formatDate value="${gdsReivewVO.regDt}" pattern="yyyy-MM-dd" /></td>
			</tr>
			<tr>
				<th scope="row">평점</th>
				<td class="star">총 평점 : ${gdsReivewVO.dgstfn}.0
				(<script>
					for(var i=0; i<${gdsReivewVO.dgstfn}; i++){
						$(".star").append("★")
					}
					</script>)

				</td>
			</tr>
			<tr>
				<th scope="row">내용</th>
				<td>${gdsReivewVO.cn}</td>
			</tr>
			<tr>
				<th scope="row">첨부이미지</th>
				<td>
					<c:forEach var="fileList" items="${gdsReivewVO.thumbnailFile}">
						<a href="/comm/getFile?srvcId=REVIEW&amp;upNo=${gdsReivewVO.gdsReivewNo }&amp;fileTy=ATTACH&amp;fileNo=${fileList.fileNo}">
						${fileList.orgnlFileNm}
						</a>
					</c:forEach>
				</td>
			</tr>
		</tbody>
	</table>

	<p class="text-title2 mt-13">수정정보</p>
	<table class="table-detail">
		<colgroup>
			<col class="w-43">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row"><label for="form-item1">상태</label></th>
				<td>
					<div class="form-check-group">
						<c:forEach var="useYnCode" items="${useYnCode}" varStatus="status">
						<div class="form-check">
							<form:radiobutton class="form-check-input" path="useYn" id="useYn${status.index}" value="${useYnCode.key}" />
							<label class="form-check-label" for="useYn${status.index}">${useYnCode.value}</label>
						</div>
						</c:forEach>
						</div>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="row">등록일</th>
				<td>${gdsReivewVO.rgtr}(${gdsReivewVO.regId}) / <fmt:formatDate value="${gdsReivewVO.regDt}" pattern="yyyy-MM-dd" /></td>
			</tr>
		</tbody>
	</table>

	<c:set var="pageParam" value="curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;sortBy=${param.sortBy}&amp;srchRegYmdBgng=${param.srchRegYmdBgng}&amp;srchRegYmdEnd=${param.srchRegYmdEnd}&&amp;srchRgtrId=${param.srchRgtrId}&amp;srchRgtr=${param.srchRgtr}&amp;srchTtl=${param.srchTtl}&amp;srchUseYn=${param.srchUseYn}&amp;srchUseYn=${param.srchUseYn}" />
	<div class="btn-group mt-8 right">
		<button type="submit" class="btn-primary large shadow">저장</button>
		<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	</div>
</div>
</form:form>

<script>
//유효성 검사
$("form#useYnFrm").validate({
    ignore: "input[type='text']:hidden",
    submitHandler: function (frm) {
	    	if(confirm("수정 하시겠습니까?")){
		    	frm.submit();
	    	} else{
	    		return false;
	    	}
    }
});

</script>

