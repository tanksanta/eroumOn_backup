<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form action="./list" method="get" id="searchFrm" name="searchFrm">
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
		<fieldset>
			<legend class="text-title2">블랙리스트회원 검색</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="search-item1">처리일</label></th>
						<td colspan="3">
							<div class="form-group">
								<input type="date" class="form-control w-39 calendar" id="srchRegBgng" name="srchRegBgng" value="${param.srchRegBgng}">
								<i>~</i>
								<input type="date" class="form-control w-39 calendar" id="srchRegEnd" name="srchRegEnd" value="${param.srchRegEnd}">
								<button type="button" class="btn shadow" onclick="f_srchRegSet('0'); return false;">초기화</button>
								<button type="button" class="btn shadow" onclick="f_srchRegSet('1'); return false;">오늘</button>
								<button type="button" class="btn shadow" onclick="f_srchRegSet('2'); return false;">7일</button>
								<button type="button" class="btn shadow" onclick="f_srchRegSet('3'); return false;">15일</button>
								<button type="button" class="btn shadow" onclick="f_srchRegSet('4'); return false;">1개월</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchId">회원아이디</label></th>
						<td><input type="text" class="form-control w-84" id="srchId" name="srchId" value="${param.srchId}"></td>
						<th scope="row"><label for="srchName">회원이름</label></th>
						<td><input type="text" class="form-control w-84" id="srchName" name="srchName" value="${param.srchName}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="srchTel">휴대폰 (4자리)</label></th>
						<td><input type="text" class="form-control w-84" id="srchLastTelnoOfMbl" name="srchLastTelnoOfMbl" value="${param.srchLastTelnoOfMbl}" placeholder="뒷자리"></td>
						<th scope="row"><label for="srchEml">이메일</label></th>
						<td><input type="text" class="form-control w-84" id="srchEml" name="srchEml" value="${param.srchEml}"></td>
					</tr>
					<tr>
						<th scope="row"><label for="search-item6">블랙리스트 유형</label></th>
						<td>
							<div class="form-check-group">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="srchMngSe" id="srchMngSe" value="" checked>
									<label class="form-check-label" for="srchMngSe">전체</label>
								</div>
								<c:forEach var="mngSe" items="${mngSeCode}" varStatus="status" end="1">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="srchMngSe" id="srchMngSe${status.index}" value="${mngSe.key}" <c:if test="${param.srchMngSe eq mngSe.key }">checked="cheked"</c:if>>
										<label class="form-check-label" for="srchMngSe${status.index}">${mngSe.value}</label>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="srchResnCd">사유</label></th>
						<td colspan="3">
							<select name="srchResnCd" class="form-control w-84" id="srchResnCd">
								<option value="">전체</option>
								<c:forEach var="resnCd" items="${resnCdCode}">
									<option value="${resnCd.key}"<c:if test="${resnCd.key eq param.srchResnCd}">selected="selected"</c:if>>${resnCd.value}</option>
								</c:forEach>
							</select>
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

	<p class="text-title2 mt-13">블랙리스트회원 목록</p>
	<table class="table-list">
		<colgroup>
			<col class="w-20">
			<col class="w-[10%]">
			<col class="w-30">
			<col class="w-20">
			<col class="w-[15%]">
			<col class="w-30">
			<col class="w-30">
			<col>
			<col class="w-32">
			<col class="w-30">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">회원아이디</th>
				<th scope="col">회원이름</th>
				<th scope="col">성별</th>
				<th scope="col">이메일</th>
				<th scope="col">휴대폰번호</th>
				<th scope="col">블랙리스트 유형</th>
				<th scope="col">사유</th>
				<th scope="col">블랙리스트 처리일
				</th>
				<th scope="col">내역</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
				<tr>
					<td>${listVO.startNo - status.index }</td>
					<td><a href="/_mng/mbr/${resultList.uniqueId}/view" class="btn shadow w-full">${resultList.joinTy == "E" ? resultList.mbrId : mbrJoinTy[resultList.joinTy]}</a></td>
					<td><a href="/_mng/mbr/${resultList.uniqueId}/view" class="btn shadow w-full">${resultList.mbrNm }</a></td>
					<td>${genderCode[resultList.gender] }</td>
					<td>${resultList.eml }</td>
					<td>${resultList.mblTelno }</td>
					<td>${mngSeCode[resultList.mngSe] }</td>
					<td>${resnCdCode[resultList.resnCd] }</td>
					<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
					<td><button type="button" class="btn-primary w-full listUpBtn" data-unique-id="${resultList.mbrVO.uniqueId}" data-click-type="modify">변경내역보기</button></td>
				</tr>
				</c:forEach>
				<c:if test="${empty listVO.listObject}">
					<tr>
						<td class="noresult" colspan="10">검색조건을 만족하는 결과가 없습니다.</td>
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

	<div id="modifyList"></div>

	</div>
	<script>
		function f_srchRegSet(ty) {
			$("#srchRegEnd").val(f_getToday());
			if(ty == "0"){
				$("#srchRegBgng").val('');
		  		$("#srchRegEnd").val('');
			}else if (ty == "1") {//오늘
				$("#srchRegBgng").val(f_getToday());
			} else if (ty == "2") {//일주일
				$("#srchRegBgng").val(f_getDate(-7));
			} else if (ty == "3") {//15일
				$("#srchRegBgng").val(f_getDate(-15));
			} else if (ty == "4") {//한달
				$("#srchRegBgng").val(f_getDate(-30));
			}
		}

		$(function(){
			 //변경내역
			 $(".listUpBtn").on("click",function(){
				 var uniqueId = $(this).data("uniqueId");

				 $("#modifyList").load("./mbrMngInfoList.json", {uniqueId : uniqueId}, function(){
						$("#modal1").addClass("fade").modal("show");
					});
			 });

		   	$(".btn-excel").on("click", function(){
		   		var jsPopupExcelPwd = new JsPopupExcelPwd(this, '', 'jsPopupExcelPwd', 1, {});
	            async function fn_excel_down(){
	                const asyncConfirm = await jsPopupExcelPwd.fn_show_popup({})
	                // console.log(asyncConfirm)
	                if (asyncConfirm != "confirm"){
	                    return;
	                }
	                
	                $("#searchFrm").attr("action","excel").submit();
					$("#searchFrm").attr("action","list");
	            }
	            fn_excel_down();
			});

		});
	</script>