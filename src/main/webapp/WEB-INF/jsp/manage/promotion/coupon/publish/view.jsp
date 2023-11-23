<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<ul class="nav tab-list">
		<li><a href="#coupon-pane1" class="active" data-bs-toggle="pill" data-bs-target="#coupon-pane1" role="tab" aria-selected="true" id="listBtn">발행내역</a></li>
		<li><a href="#coupon-pane2" data-bs-toggle="pill" data-bs-target="#coupon-pane2" role="tab" aria-selected="false" id="mngBtn">관리자 발급</a></li>
	</ul>

	<table class="table-detail mt-10">
		<colgroup>
			<col class="w-43">
			<col>
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">쿠폰번호</th>
				<td>${couponVO.couponNo}</td>
			</tr>
			<tr>
				<th scope="row">쿠폰종류</th>
				<td>${couponTyCode[couponVO.couponTy]}</td>
			</tr>
			<tr>
				<th scope="row">고객쿠폰명</th>
				<td>${couponVO.couponNm}</td>
			</tr>
		</tbody>
	</table>

	<c:set var="pageParam" value="curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;sortBy=${param.sortBy}&amp;srchCouponTy=${param.srchCouponTy}&amp;srchCouponNm=${param.srchCouponNm}&amp;srchCouponCd=${param.srchCouponCd}&amp;srchIssuTy=${param.srchIssuTy}&amp;srchSttusTy=${param.srchSttusTy}&amp;srchDt=${param.srchDt}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${parm.srchEndDt}" />
	<div class="tab-content mt-13">
		<div class="tab-pane fade show active" id="coupon-pane1" role="tabpanel">
			<p class="text-title2">쿠폰발급 받은 회원 목록</p>
			<table class="table-list">
				<colgroup>
					<col class="w-35">
					<col>
					<col>
					<col class="w-1/5">
					<col class="w-1/5">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
						<th scope="col">이름</th>
						<th scope="col">아이디</th>
						<th scope="col">발급일</th>
						<th scope="col">사용일</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
					<c:if test="${resultList.uniqueId ne NULL }">
					<tr>
						<td>${listVO.startNo - status.index}</td>
						<td>${resultList.mbrNm}</td>
						<td>${resultList.mbrId}</td>
						<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
						<c:if test="${resultList.useDt ne NULL}"><td><fmt:formatDate value="${resultList.useDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td></c:if>
						<c:if test="${resultList.useDt eq NULL}"><td>-</td></c:if>
					</tr>
					</c:if>
				</c:forEach>
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

			<div class="btn-group right mt-8">
				<a href="./list?${pageParam}" class="btn-primary large shadow">목록</a>
			</div>
		</div>

		<!-- 관리자 발급 -->
		<div class="tab-pane fade" id="coupon-pane2" role="tabpanel">
		<input type="hidden" id="couponNo" name="couponNo" value="${couponVO.couponNo}">
		<input type="hidden" id="issuQy" name="issuQy" value="${couponVO.issuQy}">
				<fieldset>
					<p class="text-right mb-3">
						<button type="button" class="btn f_srchMbr" data-bs-toggle="modal" data-bs-target="#mbrModal">회원검색</button>
						<button type="button" class="btn" data-bs-toggle="modal" data-bs-target="#fileModal">파일선택</button>
						<button type="button" class="btn" id="deleBtn">선택삭제</button>
					</p>
					<legend class="text-title2 relative">
						관리자 발급 <span class="text-sm absolute whitespace-nowrap left-full top-1 ml-2">선택된 회원만 적용됩니다.</span>
					</legend>
					<table class="table-list" id="relMbrList">
						<colgroup>
							<col class="w-1/5">
							<col class="w-32">
							<col>
							<col>
							<col class="w-1/5">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">
									<div class="form-check">
										<input class="form-check-input" type="checkbox" name="allChkBtn" id="allChkBtn">
										<label class="form-check-label" for="allChkBtn"></label>
									</div>
								</th>
								<th scope="col">번호</th>
								<th scope="col">고객코드</th>
								<th scope="col">고객명</th>
								<th scope="col">아이디</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="noresult" colspan="5">[회원검색] 버튼을 눌러 대상회원을 추가해주세요.</td>
							</tr>
						</tbody>
					</table>
				</fieldset>


				<div class="btn-group right mt-8">
					<button type="button" class="btn-success large shadow" id="couponSubmit">쿠폰발급</button>
					<a href="./list?${pageParam}" class="btn-primary large shadow">목록</a>
				</div>
		</div>
		<!-- 관리자 발급 -->

		<c:import url="/_mng/promotion/coupon/modalMbrSearch" />
		<c:import url="/_mng/promotion/coupon/modalFileUpload" />

	</div>
</div>

<script>
//삭제
var arrDelChk = [];
//회원선택
var arrMbrChk = [];
var cnt = 1 ;

//회원검색 콜백
function f_modalMbrSearch_callback(mbrUniqueIds){
	console.log("callback: " + mbrUniqueIds);
	if($("#relMbrList tbody td").hasClass("no-data")){
		$("#relMbrList tbody tr").remove();
	}

	//중복 추가x
	mbrUniqueIds = arrayRemove(mbrUniqueIds, ${mbrVO.uniqueId});
		// 중복된 회원이 있을 경우 추가x
		$("input[name='uniqueId']").each(function(){
			mbrUniqueIds = arrayRemove(mbrUniqueIds, $(this).val());
		});

	mbrUniqueIds.forEach(function(uniqueId){

		var mbrJson = mbrMap.get(uniqueId);
		$(".noresult").remove();
		//relGdsList
		var html ="";
		html += '<tr class="trCnt '+mbrJson.uniqueId+'">';
		html += '<td>';
		html += '<div class="form-check">';
		html += '<input class="form-check-input chkBox" type="checkbox" name="mbrChkBox" value="'+mbrJson.uniqueId+'" id="idx'+cnt+'">';
		html += '<input type="hidden" name="uniqueId" value="'+mbrJson.uniqueId+'">';
		html += '</div>';
		html += '</td>';
		html += '<td>'+cnt+'</td>';
		html += '<td>'+mbrJson.uniqueId+'</td>';
		html += '<td>'+mbrJson.mbrNm+'</td>';
		html += '<td>'+mbrJson.mbrId+'</td>';
		html += '</tr>';

		$("#relMbrList tbody").append(html);

		cnt += 1;
	});

	$(".btn-close").click();
}

$(function(){

	console.log("${param.issuBtn}" == "Y");
	if("${param.issuBtn}" == "Y"){
		$("#coupon-pane1").removeClass("active show");
		$("#coupon-pane2,#mngBtn").addClass("active show");
		$("#listBtn").removeClass("active");
	}

	//관리자 발급 제한
	if("${couponVO.issuTy}" != "MNG"){
		$("#mngBtn").attr("disabled",true);
	}else{
		$("#mngBtn").attr("disabled",false);
	}

	//회원 검색 모달
	$(".f_srchMbr").on("click", function(){
		if ( !$.fn.dataTable.isDataTable('#mbrDataTable') ) { //데이터 테이블이 있으면x
 			MbrDataTable.init();
 		}
	});

	//회원 선택 목록
	$(document).on("click", "input[name='mbrChkBox']", function(){
		if($(this).is(":checked")){
			arrMbrChk.push($(this).val());
		}else{
			arrMbrChk = arrMbrChk.filter((element) => element !== $(this).val());
			arrDelChk = arrMbrChk;
		}
	});

	//전체 선택
	$(document).on("click", "#allChkBtn", function(){
		if($("#allChkBtn").is(":checked")){
			$("input[name='mbrChkBox']").prop("checked",true);
			$("input:checkbox[name='mbrChkBox']:checked").each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
				arrDelChk.push(this.value);
				arrMbrChk.push(this.value);
		    });
		}else{
			$("input[name='mbrChkBox']").prop("checked",false);
			arrDelChk = [];
			arrMbrChk = [];
		}
	});

	$("#couponSubmit").on("click",function(){

	    	var totalCnt = $("input[name='mbrChkBox']").length;
	    	var arrChk = [];

	    	if(totalCnt < 1){
	    		alert("발급할 대상 회원을 검색해주세요.");
	    		return false;
	    	}else{
	    		for(var i=0; i<totalCnt; i++){
					if($("#idx"+(i+1)).is(":checked")){
						arrChk.push(true);
					}
	    		}
				if(arrChk.length < 1){
					alert("발급할 대상 회원을 선택해주세요.");
					return false;
				}else{
			    	if(confirm("발급 하시겠습니까?")){
			    		$.ajax({
							type: 'post',
							url : '/_mng/promotion/coupon/issuList.json',
							data: {arrMbrList : arrMbrChk
										, couponNo : $("#couponNo").val()
										, issuQy : $("#issuQy").val()}
							, dataType: 'json'
						})
						.done(function(data){
							if(data == 1){
								alert("처리되었습니다. 발급내역에서 확인 가능합니다.");
								location.href="./view?couponNo="+$("#couponNo").val();
							}else if(data == 0){
								alert("쿠폰 잔여수량을 확인해주세요.");
								return false;
							}else if(data == 10){
								alert("중복된 회원이 존재합니다.");
								return false;
							}
						})
						.fail(function(){
							alert("쿠폰 발행 중 오류가 발생하였습니다.");
						})
			    	} else{
			    		return false;
			    	}
				}
	    	}
	});

});
</script>