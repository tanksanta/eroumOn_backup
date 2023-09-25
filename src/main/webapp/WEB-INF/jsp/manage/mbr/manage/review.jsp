<%@page import="javax.servlet.annotation.WebServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="/html/page/admin/assets/script/_mng/mbr/JsHouseMngMbrDetail.js"></script>

<div id="page-content">
		<%@include file="./include/header.jsp"%>

	<form action="./review" class="mt-13" id="searchFrm" name="searchFrm" method="get">
	<input type="hidden" id="cntPerPage" name="cntPerPage" value="${param.cntPerPage}" />

		<fieldset>
			<legend class="text-title2">상품후기 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item7-1">등록일자</label></th>
						<td colspan="3">
							<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchBgngDt" name="srchBgngDt" value="${param.srchBgngDt}">
								<i>~</i>
								 <input type="date" class="form-control w-39 calendar" id="srchEndDt" name="srchEndDt" value="${param.srchEndDt}">
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchGdsCd">상품코드</label></th>
						<td><input type="text" class="form-control w-84" id="srchGdsCd" name="srchGdsCd" value="${param.srchGdsCd}"></td>
						<th scope="row"><label for="srchGdsNm">상품명</label></th>
						<td><input type="text" class="form-control w-full" id="srchGdsNm" name="srchGdsNm" value="${param.srchGdsNm}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="srchCn">내용</label></th>
						<td colspan="3"><input type="text" class="form-control w-full" id="srchCn" name="srchCn" value="${param.srchCn}"></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group mt-5">
			<button type="submit" class="btn-primary large shadow w-52">검색</button>
		</div>
	</form>

	<p class="text-title2 mt-13">상품후기 목록</p>
	<table class="table-list">
		<colgroup>
			<col class="w-23">
			<col class="w-30">
			<col class="w-[18%]">
			<col>
			<col class="w-30">
			<col class="w-30">
			<col class="w-30">
			<col class="w-35">
			<col class="w-42">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">상품코드</th>
				<th scope="col">상품명</th>
				<th scope="col">내용</th>
				<th scope="col">평점</th>
				<th scope="col">작성자</th>
				<th scope="col">상태</th>
				<th scope="col">카테고리 전시여부</th>
				<th scope="col">등록일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
			<tr>
				<td>${listVO.startNo - status.index}</td>
				<td>${resultList.gdsCd}</td>
				<td><a href="/market/gds/2/${resultList.gdsNo}/${resultList.gdsCd}" target="_blank" class="btn shadow">${resultList.gdsNm}</a></td>
				<td class="text-left"><a href="/_mng/consult/gdsReview/form?gdsReviewNo=${resultList.gdsReivewNo}" class="btn shadow">${fn:substring(resultList.cn,0,30)}&nbsp;...</a></td>
				<td>${resultList.dgstfn}.0</td>
				<td>${resultList.rgtr}</td>
				<td>${useYnCode[resultList.useYn]}</td>
				<td>${dspyYnCode[resultList.dspyYn]}</td>
				<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			</c:forEach>
			<c:if test="${empty listVO.listObject}">
			<tr>
				<td class="noresult" colspan="9">검색조건을 만족하는 결과가 없습니다.</td>
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
			총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지
		</div>
	</div>
</div>

<script>
	var ctlMaster;
	$(document).ready(function(){
		ctlMaster = new JsHouseMngMbrReview();
		ctlMaster.fn_searched_data(`<%= request.getParameter("searched_data") != null ? request.getParameter("searched_data") : "" %>`);
		ctlMaster.fn_page_init();
	});

function f_srchJoinSet(ty){
  	//srchJoinBgng, srchJoinEnd
	$("#srchEndDt").val(f_getToday());
	if(ty == "1"){//오늘
   		$("#srchBgngDt").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchBgngDt").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchBgngDt").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchBgngDt").val(f_getDate(-30));
	}
}

$(function(){

});
</script>
