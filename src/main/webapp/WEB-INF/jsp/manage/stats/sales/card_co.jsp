<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- page content -->
<div id="page-content">
	<jsp:include page="./include/tab.jsp" />

	<form action="#" class="mt-7.5" id="searchFrm">
		<fieldset>
			<legend class="text-title2">검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item1">조회기간</label></th>
						<td>
							<div class="form-group">
                                            <input type="date" class="form-control w-39 calendar" id="srchOrdrYmdBgng" name="srchOrdrYmdBgng" value="${srchOrdrYmdBgng}">
                                            <i>~</i>
                                            <input type="date" class="form-control w-39 calendar" id="srchOrdrYmdEnd" name="srchOrdrYmdEnd" value="${srchOrdrYmdEnd}">
                                            <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('1'); return false;">오늘</button>
	                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('2'); return false;">7일</button>
	                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('3'); return false;">15일</button>
	                                        <button type="button" class="btn shadow" onclick="f_srchOrdrYmdSet('4'); return false;">1개월</button>
                                        </div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchCardCoNm">카드사선택</label></th>
						<td><select name="srchCardCoNm" id="srchCardCoNm" class="form-control w-84" for="srchCardCo">
								<option value="">전체</option>
								<c:forEach items="${cardCoNmList}" var="iem">
									<c:choose>
										<c:when test="${iem.cardCoNm eq ''}">
											<option value="${iem.stlmTy}">${iem.stlmTy}</option>
										</c:when>
										<c:when test="${iem.stlmTy eq 'REBILL' }">
											<option value="${iem.stlmTy}">${iem.cardCoNm}(정기결제)</option>
										</c:when>
										<c:otherwise>
											<option value="${iem.stlmTy}">${iem.cardCoNm}</option>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</select></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group mt-5">
			<button type="submit" class="btn-primary large shadow w-52">검색</button>
		</div>
	</form>

	<div class="mt-13 text-right mb-3">
		<button type="button" class="btn-primary" id="btn-excel">엑셀 다운로드</button>
	</div>

	<p class="text-title2 mt-13">조회결과</p>
	<div class="scroll-table">
		<table class="table-list">
			<colgroup>
				<col class="min-w-40 w-40">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
				<col class="min-w-25">
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="2">카드사명</th>
					<th scope="colgroup" colspan="2">주문</th>
					<th scope="colgroup" colspan="2">취소</th>
					<th scope="colgroup" colspan="2">판매</th>
					<th scope="colgroup" colspan="2">반품</th>
					<th scope="colgroup" colspan="2">매출</th>
				</tr>
				<tr>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
					<th scope="col">건수</th>
					<th scope="col">금액</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${!empty resultList}">
					<c:set var="totalACnt" value="0" />
					<c:set var="totalBCnt" value="0" />
					<c:set var="totalCCnt" value="0" />
					<c:set var="totalCaCnt" value="0" />
					<c:set var="totalReCnt" value="0" />

					<c:set var="totalASum" value="0" />
					<c:set var="totalBSum" value="0" />
					<c:set var="totalCSum" value="0" />
					<c:set var="totalCaSum" value="0" />
					<c:set var="totalReSum" value="0" />

					<c:forEach items="${resultList}" var="result" varStatus="status">
						<c:set var="totalACnt" value="${totalACnt + result.totalACnt}" />
						<c:set var="totalBCnt" value="${totalBCnt + result.totalBCnt}" />
						<c:set var="totalCCnt" value="${totalCCnt + result.totalCCnt}" />
						<c:set var="totalASum" value="${totalASum + result.totalASum}" />
						<c:set var="totalBSum" value="${totalBSum + result.totalBSum}" />
						<c:set var="totalCSum" value="${totalCSum + result.totalCSum}" />

						<c:set var="totalCaCnt" value="${totalCaCnt + result.totalCaCnt}" />
						<c:set var="totalCaSum" value="${totalCaSum + result.totalCaSum}" />
						<c:set var="totalReCnt" value="${totalReCnt + result.totalReCnt}" />
						<c:set var="totalReSum" value="${totalReSum + result.totalReSum}" />

						<tr>
							<td><c:choose>
									<c:when test="${result.cardCoNm eq ''}">
                               			${result.stlmTy}
                               		</c:when>
									<c:when test="${result.stlmTy eq 'REBILL' }">
                               			${result.cardCoNm} (정기결제)
                               		</c:when>
									<c:otherwise>
                               			${result.cardCoNm}
                               		</c:otherwise>
								</c:choose></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalACnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalASum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCaCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCaSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalBCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalBSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalReCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalReSum}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCCnt}" pattern="###,###" /></td>
							<td class="text-right"><fmt:formatNumber value="${result.totalCSum}" pattern="###,###" /></td>
						</tr>


					</c:forEach>
					<tr class="total">
						<td>합계</td>
						<td class="text-right"><fmt:formatNumber value="${totalACnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalASum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalCaCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalCaSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalBCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalBSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalReCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalReSum}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalCCnt}" pattern="###,###" /></td>
						<td class="text-right"><fmt:formatNumber value="${totalCSum}" pattern="###,###" /></td>
					</tr>
				</c:if>
				<c:if test="${empty resultList}">
					<tr>
						<td class="noresult" colspan="11">검색조건을 만족하는 결과가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<!-- 카드사 주문내역 -->
	<div class="modal fade" id="modal1" tabindex="-1">
		<div class="modal-dialog modal-xl modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<p>카드사명 주문내역보기</p>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
				</div>
				<div class="modal-body">
					<div class="text-right mb-3">
						<button type="button" class="btn-primary">엑셀 다운로드</button>
					</div>

					<table class="table-list">
						<colgroup>
							<col class="w-14">
							<col class="w-24">
							<col class="w-24">
							<col class="w-24">
							<col>
							<col class="w-22">
							<col class="w-13">
							<col class="w-21">
							<col class="w-21">
							<col class="w-21">
							<col class="w-19">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">주문일</th>
								<th scope="col">주문번호</th>
								<th scope="col">상품코드</th>
								<th scope="col">상품명</th>
								<th scope="col">상품가격</th>
								<th scope="col">수량</th>
								<th scope="col">주문금액</th>
								<th scope="col">할인금액</th>
								<th scope="col">결제금액</th>
								<th scope="col">주문상태</th>
							</tr>
						</thead>
						<tbody>

							<tr>
								<td>12113</td>
								<td>2022-02-02<br>12:34:56
								</td>
								<td>10378347</td>
								<td>10378347</td>
								<td class="text-left">주문상품명</td>
								<td>1,999,999</td>
								<td>12</td>
								<td>1,999,999</td>
								<td>1,999,999</td>
								<td>11,999,999</td>
								<td>배송완료</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
	<!-- //카드사 주문내역 -->
</div>
<!-- //page content -->
<script>

function f_srchOrdrYmdSet(ty){
	//srchOrdrYmdBgng, srchOrdrYmdEnd
	$("#srchOrdrYmdEnd").val(f_getToday());
	if(ty == "1"){//오늘
   		$("#srchOrdrYmdBgng").val(f_getToday());
	}else if(ty == "2"){//일주일
		$("#srchOrdrYmdBgng").val(f_getDate(-7));
	}else if(ty == "3"){//15일
		$("#srchOrdrYmdBgng").val(f_getDate(-15));
	}else if(ty == "4"){//한달
		$("#srchOrdrYmdBgng").val(f_getDate(-30));
	}
}

	$(function(){
		$("#btn-excel").on("click",function(){
			$("#searchFrm").attr("action","./cardCoExcel");
			$("#searchFrm").submit();
			$("#searchFrm").attr("action","./cardCo");
		});
	});
 </script>