<%@page import="javax.servlet.annotation.WebServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="page-content">
	<form action="./list" method="get" id="searchFrm" name="searchFrm">
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
		<input type="hidden" name="grade" id="grade" value="" />
		<fieldset>
			<legend class="text-title2">검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item1">조회기간</label></th>
						<td colspan="3">
							<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchRegDtBgng" name="srchRegDtBgng" value="${param.srchRegDtBgng}">
								<i>~</i>
								<input type="date" class="form-control w-39 calendar" id="srchRegDtEnd" name="srchRegDtEnd" value="${param.srchRegDtEnd}">
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('0'); return false;">초기화</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchJoinSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
                        <th scope="row"><label for="search-item1">검색어</label></th>
                        <td>
                            <div class="form-group w-84">
                                <select name="srchTarget" id="srchTarget" class="form-control w-40">
                                    <option value="srchMngrId" <c:if test="${param.srchTarget == 'srchMngrId'}">selected</c:if>>아이디</option>
                                    <option value="srchUseHist" <c:if test="${param.srchTarget == 'srchUseHist'}">selected</c:if>>이용내역</option>
                                </select>
                                <input type="text" class="form-control flex-1" name="srchText" id="srchText" value="${param.srchText}">
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

	<p class="text-title2 mt-13">이용내역 목록</p>
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-28">
			<col class="w-28">
			<col class="w-40">
			<col class="w-40">
			<col class="w-32">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">아이디</th>
				<th scope="col">관리자명</th>
				<th scope="col">이용내역</th>
				<th scope="col">사유</th>
				<th scope="col">작업일시</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
		<c:set var="pageParam" value="curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage }&amp;srchMbrId=${param.srchMbrId}&amp;srchNm=${param.srchNm}&amp;srchLastTelnoOfMbl=${param.srchLastTelnoOfMbl}&amp;srchBrdt=${param.srchBrdt}" />
			<tr>
				<td>${listVO.startNo - status.index}</td>
				<td>${resultList.mngrId}</td>
				<td>${resultList.mngrNm}</td>
				<td>${resultList.useHist}</td>
				<td>${resultList.resn}</td>
				<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			</c:forEach>
			   <c:if test="${empty listVO.listObject}">
				<tr>
					<td class="noresult" colspan="6">검색조건을 만족하는 결과가 없습니다.</td>
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
		function f_srchJoinSet(ty){
			$("#srchRegDtEnd").val(f_getToday());
			if(ty == "1"){//오늘
		   		$("#srchRegDtBgng").val(f_getToday());
			}else if(ty == "2"){//일주일
				$("#srchRegDtBgng").val(f_getDate(-7));
			}else if(ty == "3"){//15일
				$("#srchRegDtBgng").val(f_getDate(-15));
			}else if(ty == "4"){//한달
				$("#srchRegDtBgng").val(f_getDate(-30));
			}else if(ty == "0"){//초기화
				$("#srchRegDtBgng").val(null);
				$("#srchRegDtEnd").val(null);
			}
		}
	</script>