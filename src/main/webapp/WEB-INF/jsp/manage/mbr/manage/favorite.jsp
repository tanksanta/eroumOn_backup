<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<%@include file="./include/header.jsp"%>

	<ul class="nav tab-list mt-13">
		<li><a href="#member-subpane1" ${param.modalType eq 'cart'?'class="active"':'' }  data-bs-toggle="pill" data-bs-target="#member-subpane1" role="tab" aria-selected="true">장바구니</a></li>
		<li ><a href="#member-subpane2" ${param.modalType eq 'wish'?'class="active"':'' } data-bs-toggle="pill" data-bs-target="#member-subpane2" role="tab" aria-selected="false">위시리스트</a></li>
	</ul>

	<div class="tab-content mt-10">
		<div class="tab-pane fade show active" id="member-subpane1" role="tabpanel">
				<form action="./favorite?modalType=${pararm.modalType}" class="mt-13" id="searchFrm" name="searchFrm" method="get">
				<input type="hidden" id="cntPerPage" name="cntPerPage" value="${param.cntPerPage}" />
				<input type="hidden" id="modalType" name="modalType" value="cart" />

				<fieldset>
					<legend class="text-title2">장바구니 검색</legend>
					<table class="table-detail">
						<colgroup>
							<col class="w-43">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="search-item10-1-1">등록일자</label></th>
								<td>
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
							</tr>
							<tr>
								<th scope="row"><label for="srchGdsNm">상품명</label></th>
								<td><input type="text" class="form-control w-full" id="srchGdsNm" name="srchGdsNm" value="${param.srchGdsNm}"></td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<div class="btn-group mt-5">
					<button type="submit" class="btn-primary large shadow w-52">검색</button>
				</div>
			</form>

			<p class="text-title2 mt-13">장바구니 내역</p>
			<table class="table-list">
				<colgroup>
					<col class="w-23">
					<col class="w-35">
					<col>
					<col class="w-25">
					<col class="w-40">
					<col class="w-42">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">상품코드</th>
						<th scope="col">상품명</th>
						<th scope="col">수량</th>
						<th scope="col">상품가격</th>
						<th scope="col">등록일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="resultList" items="${cartList}" varStatus="status">
					<tr>
						<td>${fn:length(cartList) - status.index}</td>
						<td>${resultList.gdsCd}</td>
						<td><a href="/market/gds/2/${resultList.gdsNo}/${resultList.gdsCd}" target="_blank" class="block text-left">${resultList.gdsNm}
							<c:if test="${resultList.ordrOptn ne null && resultList.ordrOptn ne '' }">
							/ 옵션 :
							<c:set var="optnList" value="${fn:split(resultList.ordrOptn,'*')}" />
							<c:forEach var="optn" items="${optnList}">
								${optn}
							</c:forEach>
							</c:if>
							</a></td>
						<td>${resultList.ordrQy}</td>
						<td>${resultList.gdsPc}</td>
						<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					</tr>
					</c:forEach>
					<c:if test="${empty cartList}">
						<tr>
							<td class="noresult" colspan="6">검색조건을 만족하는 결과가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>

		</div>

		<div class="tab-pane fade" id="member-subpane2" role="tabpanel">
			<form action="./favorite" class="mt-13" id="searchWishFrm" name="searchWishFrm" method="get">
			<input type="hidden" id="cntPerWishPage" name="cntPerPage" value="${param.cntPerPage}" />
			<input type="hidden" id="modalType" name="modalType" value="wish" />

				<fieldset>
					<legend class="text-title2">위시리스트 검색</legend>
					<table class="table-detail">
						<colgroup>
							<col class="w-43">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="search-item10-2-1">등록일자</label></th>
								<td>
									<div class="form-group">
									<input type="date" class="form-control w-39 calendar" id="srchBgngWishDt" name="srchBgngWishDt" value="${param.srchBgngWishDt}">
									<i>~</i>
									 <input type="date" class="form-control w-39 calendar" id="srchEndWishDt" name="srchEndWishDt" value="${param.srchEndWishDt}">
									<button type="button" class="btn shadow" onclick="f_srchWishSet('1'); return false;">오늘</button>
									<button type="button" class="btn shadow" onclick="f_srchWishSet('2'); return false;">7일</button>
									<button type="button" class="btn shadow" onclick="f_srchWishSet('3'); return false;">15일</button>
									<button type="button" class="btn shadow" onclick="f_srchWishSet('4'); return false;">1개월</button>
							</div>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="search-item10-2-2">상품코드</label></th>
								<td><input type="text" class="form-control w-84" id="srchGdsCd" name="srchGdsCd" value="${param.srchGdsCd}"></td>
							</tr>
							<tr>
								<th scope="row"><label for="search-item10-2-2">상품명</label></th>
								<td><input type="text" class="form-control w-full" id="srchGdsNm" name="srchGdsNm" value="${param.srchGdsNm}"></td>
							</tr>
						</tbody>
					</table>
				</fieldset>

				<div class="btn-group mt-5">
					<button type="submit" class="btn-primary large shadow w-52">검색</button>
				</div>
			</form>

			<p class="text-title2 mt-13">위시리스트 내역</p>
			<table class="table-list">
				<colgroup>
					<col class="w-23">
					<col class="w-35">
					<col>
					<col class="w-40">
					<col class="w-42">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">상품코드</th>
						<th scope="col">상품명</th>
						<th scope="col">상품가격</th>
						<th scope="col">등록일자</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result" items="${wishList}" varStatus="status">
					<tr>
						<td>${fn:length(wishList) - status.index}</td>
						<td>${result.gdsInfo.gdsCd}</td>
						<td class="text-left"><a href="/market/gds/2/${result.gdsNo}/${result.gdsInfo.gdsCd}" target="_blank">${result.gdsInfo.gdsNm}</a></td>
						<td><fmt:formatNumber value="${result.gdsInfo.pc}" pattern="###,###" /></td>
						<td><fmt:formatDate value="${result.regDt}" pattern="yyyy-MM-dd" /></td>
					</tr>
					</c:forEach>
					<c:if test="${empty wishList}">
						<tr>
							<td class="noresult" colspan="5">검색조건을 만족하는 결과가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>

		</div>
	</div>
</div>


<script>
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

function f_srchWishSet(ty){
  	//srchJoinBgng, srchJoinEnd
	$("#srchEndWishDt").val(f_getToday());
	if(ty == "1"){//오늘
   		$("#srchBgngWishDt").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchBgngWishDt").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchBgngWishDt").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchBgngWishDt").val(f_getDate(-30));
	}
}

$(function(){
	if("${param.modalType}" == "wish"){
		$("#member-subpane1").removeClass("active show");
		$("#member-subpane2").addClass("active show");
	}else{
		$("#member-subpane2").removeClass("active show");
		$("#member-subpane1").addClass("active show");
	}

	// 페이지 > 출력 갯수
    $("#countWishPerPage").on("change", function(){
		var cntperpage = $("#countWishPerPage option:selected").val();
		$("#cntPerWishPage").val(cntperpage);
		$("#searchWishFrm").submit();
	});
});
</script>