<%@page import="javax.servlet.annotation.WebServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="/html/page/admin/assets/script/_mng/mbr/JsHouseMngMbrList.js"></script>

<div id="page-content">
	<form action="./list" method="get" id="searchFrm" name="searchFrm">
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
		<input type="hidden" name="grade" id="grade" value="" />
		<fieldset>
			<legend class="text-title2">회원 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item1">가입일</label></th>
						<td colspan="3">
							<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchJoinBgng" name="srchJoinBgng" value="${param.srchJoinBgng}">
								<i>~</i>
								<input type="date" class="form-control w-39 calendar" id="srchJoinEnd" name="srchJoinEnd" value="${param.srchJoinEnd}">
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('0'); return false;">초기화</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchMbrId">아이디</label></th>
						<td><input type="text" class="form-control w-84" id="srchMbrId" name="srchMbrId" value="${param.srchMbrId}" maxlength="30"></td>
						<th scope="row"><label for="srchMbrNm">이름</label></th>
						<td><input type="text" class="form-control w-84" id="srchMbrNm" name="srchMbrNm" value="${param.srchMbrNm}" maxlength="30"></td>
					</tr>
					<tr>
						<th scope="row"><label for="srchLastTelnoOfMbl">휴대전화 (4자리)</label></th>
						<td><input type="tel" class="form-control w-84" id="srchLastTelnoOfMbl" name="srchLastTelnoOfMbl" value="${param.srchLastTelnoOfMbl}" maxlength="4"></td>
						<th scope="row"><label for="srchBrdt">생년월일</label></th>
						<td><input type="text" class="form-control w-84" id="srchBrdt" name="srchBrdt" value="${param.srchBrdt }" maxlength="8"></td>
					</tr>
					<tr>
						<th scope="row"><label for="srchRecipterYn0">회원구분</label></th>
						<td>
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchRecipterYn" id="srchRecipterYn" value="" checked>
									<label class="form-check-label" for="srchRecipterYn">전체</label>
								</div>
								<c:forEach var="recipter" items="${recipterYn}" varStatus="status">
									<div class="form-check">
										<input type="radio" value="${recipter.key}" id="srchRecipterYn${status.index + 1}" name="srchRecipterYn" class="form-check-input" <c:if test="${recipter.key eq param.srchRecipterYn}">checked="checked"</c:if>> <label class="form-check-label" for="srchRecipterYn${status.index + 1}">${recipter.value}</label>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchGrade">회원등급</label></th>
						<td colspan="2">
							<div class="form-check-group w-full">
								<c:forEach var="grade" items="${grade}" varStatus="status">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" name="srchGrade${status.index}" id="srchGrade${status.index}" value="${grade.key}"<c:if test="${grade.key eq param.srchGrade0 || grade.key eq param.srchGrade1 || grade.key eq param.srchGrade2 || grade.key eq param.srchGrade3 || grade.key eq param.srchGrade4}">checked="checked"</c:if>>
										<label class="form-check-label" for="srchGrade${status.index}">${grade.value}</label>
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

		<p class="text-right">
			<button type="button" class="btn-primary btn-excel">엑셀 다운로드</button>
		</p>

	</form>

	<p class="text-title2 mt-13">회원 목록(기본리스트)</p>
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-30">
			<col class="w-28">
			<col class="w-20">
			<col class="w-28">
			<col>
			<col class="w-28">
			<!-- <col class="w-28"> -->
			<col class="w-25">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">아이디</th>
				<th scope="col">회원이름</th>
				<th scope="col">성별</th>
				<th scope="col">생년월일</th>
				<th scope="col">회원분류(회원등급)</th>
				<th scope="col">가입일</th>
				<!-- <th scope="col">가입구분</th> -->
				<th scope="col">가입매체</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
		<c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchMbrId=${param.srchMbrId}&amp;srchNm=${param.srchNm}&amp;srchLastTelnoOfMbl=${param.srchLastTelnoOfMbl}&amp;srchBrdt=${param.srchBrdt}" />
			<tr>
				<td>${listVO.startNo - status.index }</td>
				<td><a href="./${resultList.uniqueId}/view?${pageParam}" uniqueId="${resultList.uniqueId}" class="btn view mbr shadow w-full" style="padding-right: 0.5rem; padding-left: 0.5rem;">${resultList.mbrId}</a></td>
				<td><a href="./${resultList.uniqueId}/view?${pageParam}" uniqueId="${resultList.uniqueId}" class="btn view mbr shadow w-full" style="padding-right: 0.5rem; padding-left: 0.5rem;">${resultList.mbrNm }</a></td>
				<td>${gender[resultList.gender]}</td>
				<td><fmt:formatDate value="${resultList.brdt}" pattern="yyyy-MM-dd" /></td>
				<td class="cateVal${status.index}">${recipterYn[resultList.recipterYn] }<span class="badge-primary ml-2 gradeVal">${grade[resultList.mberGrade]}</span></td>
				<td><fmt:formatDate value="${resultList.joinDt}" pattern="yyyy-MM-dd" /></td>
				<!-- <td>온라인회원</td> -->
				<td>${resultList.joinCours}</td>
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


<script>
	var ctlMaster;
	$(document).ready(function(){
		ctlMaster = new JsHouseMngMbrList();
		ctlMaster.fn_searched_data(`<%= request.getParameter("searched_data") != null ? request.getParameter("searched_data") : "" %>`);
		ctlMaster.fn_page_init();
	});
function f_srchJoinSet(ty){
  	//srchJoinBgng, srchJoinEnd
	$("#srchJoinEnd").val(f_getToday());
  	if(ty == "0"){//초기화
  		$("#srchJoinBgng").val('');
  		$("#srchJoinEnd").val('');
  	}else if(ty == "1"){//오늘
   		$("#srchJoinBgng").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchJoinBgng").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchJoinBgng").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchJoinBgng").val(f_getDate(-30));
	}
}

$(function(){
	var oObj = "${listVO.listObject}";
	var arrObj = oObj.split(",");

	for(var i=0; i<arrObj.length; i++){
		if($(".cateVal"+i).text() == ''){
			$(".cateVal"+i).remove();
		}
	}

	var gradeVal = [];
	for(var i=0; i<5; i++){
		if($("#srchGrade"+i).is(":checked") ){
			gradeVal.push($("#srchGrade"+i).val());
		}
	}
	$("#grade").attr("value",gradeVal);

   	$(".btn-excel").on("click", function(){
		$("#searchFrm").attr("action","excel").submit();
		$("#searchFrm").attr("action","list");
	});

});
</script>

