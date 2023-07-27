<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- page content -->
<div id="page-content">
	<form action="./list" id="searchFrm" name="searchFrm" method="get">
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
		<fieldset>
			<legend class="text-title2">상품Q&amp;A 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item1">등록일</label></th>
						<td colspan="3">
							<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchRegYmdBgng" name="srchRegYmdBgng" value="${param.srchRegYmdBgng}">
								<i>~</i>
								<input type="date" class="form-control w-39 calendar" id="srchRegYmdEnd" name="srchRegYmdEnd" value="${param.srchRegYmdEnd}">&nbsp;
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item2">작성자/ID</label></th>
						<td colspan="3">
							<div class="form-group w-84">
								<input type="text" class="form-control flex-1" id="srchRgtr" name="srchRgtr" maxlength="20" value="${param.srchRgtr}"/>
								<i>/</i>
								<input type="text" class="form-control flex-1" id="srchRgtrId" name="srchRgtrId" maxlength="20" value="${param.srchRgtrId}"/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="qestnCn">내용</label></th>
						<td colspan="3"><input type="text" class="form-control w-full" id="srchQestnCn" name="srchQestnCn" value="${param.srchQestnCn}"/></td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item4">사용여부</label></th>
						<td>
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchUseYn" id="srchUseYn" value="" checked>
									<label class="form-check-label" for="srchUseYn">전체</label>
								</div>
								<c:forEach var="useYnCode" items="${useYnCode}" varStatus="status">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="srchUseYn" id="srchUseYn${status.index}" value="${useYnCode.key}" <c:if test="${useYnCode.key eq param.srchUseYn }">checked="checked"</c:if>>
										<label class="form-check-label" for="srchUseYn${status.index}">${useYnCode.value}</label>
									</div>
								</c:forEach>
							</div>
						</td>
						<th scope="row"><label for="search-item5">답변상태</label></th>
						<td>
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchAnsYn" id="srchAnsYn" value="" checked>
									<label class="form-check-label" for="srchAnsYn">전체</label>
								</div>
								<c:forEach var="ansYnCode" items="${ansYnCode}" varStatus="status">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="srchAnsYn" id="srchAnsYn${status.index}" value="${ansYnCode.key}" <c:if test="${ansYnCode.key eq param.srchAnsYn }">checked="checked"</c:if>/>
										<label class="form-check-label" for="srchAnsYn${status.index}">${ansYnCode.value}</label>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group mt-5">
			<button type="submit" class="btn-primary large shadow w-52">검색</button>
		</div>
	</form>

	<p class="text-title2 mt-13">상품Q&amp;A 목록</p>
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-30">
			<col class="w-[15%]">
			<col>
			<col class="w-25">
			<col class="w-32">
			<col class="w-25">
			<col class="w-30">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">상품코드</th>
				<th scope="col">상품명</th>
				<th scope="col">내용</th>
				<th scope="col">작성자</th>
				<th scope="col">등록일</th>
				<th scope="col">사용여부</th>
				<th scope="col">답변상태</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
			<c:set var="pageParam" value="qaNo=${resultList.qaNo}&amp;curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;sortBy=${param.sortBy}&amp;srchRegYmdBgng=${param.srchRegYmdBgng}&amp;srchRegYmdEnd=${param.srchRegYmdEnd}&&amp;srchRgtrId=${param.srchRgtrId}&amp;srchRgtr=${param.srchRgtr}&amp;srchQestnCn=${param.srchQestnCn}&amp;srchUseYn=${param.srchUseYn}&amp;srchAnsYn=${param.srchAnsYn}" />
				<tr>
					<td>${listVO.startNo - status.index }</td>
					<td><a href="./form?${pageParam}">${resultList.gdsCd}</a></td>
					<td class="text-left"><a href="./form?${pageParam}">${resultList.gdsNm}</a></td>
					<td class="text-left"><a href="./form?${pageParam}">${fn:substring(resultList.qestnCn,0,30)}&nbsp;...</a></td>
					<td>${resultList.rgtr}</td>
					<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /><br><fmt:formatDate value="${resultList.regDt}" pattern="HH:mm:ss" />
					</td>
					<td>${useYnCode[resultList.useYn]}</td>
					<td>${ansYnCode[resultList.ansYn]}</td>
				</tr>
			</c:forEach>
			<c:if test="${empty listVO.listObject}">
				<tr>
					<td class="noresult" colspan="8">검색조건을 만족하는 결과가 없습니다.</td>
				</tr>
			</c:if>
		</tbody>
	</table>

	<div class="pagination mt-7">
		<mngr:mngrPaging listVO="${listVO}" />
		<div class="sorting2">
			<label for="countPerPage">출력</label>
			<select name="countPerPage" id="countPerPage" class="form-control">
				<option value="10" ${listVO.cntPerPage eq '10' ? 'selected' : '' }>10개</option>
				<option value="20" ${listVO.cntPerPage eq '20' ? 'selected' : '' }>20개</option>
				<option value="30" ${listVO.cntPerPage eq '30' ? 'selected' : '' }>30개</option>
			</select>
		</div>

		<div class="counter">
			총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지
		</div>
	</div>
</div>
<!-- //page content -->

<script>
function f_srchJoinSet(ty){
	$("#srchRegYmdEnd").val(f_getToday());
	if(ty == "1"){//오늘
   		$("#srchRegYmdBgng").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchRegYmdBgng").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchRegYmdBgng").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchRegYmdBgng").val(f_getDate(-30));
	}
}
</script>