<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form action="./action" id="couponFrm" name="couponFrm" method="post" modelAttribute="couponVO">
<form:hidden path="couponNo" />
<form:hidden path="crud" />

	<fieldset>
		<legend class="text-title2 relative">
			기본정보 <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
			</span>
		</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">쿠폰번호</th>
					<td colspan="3" class="text-danger">${couponVO.couponCd}<c:if test="${couponVO.couponCd eq null}">시스템 자동 부여</c:if></td>

				</tr>
				<tr>
					<th scope="row"><label for="form-item1" class="require">쿠폰종류</label></th>
					<td colspan="3">
						<div class="form-check-group">
							<c:forEach var="couponTy" items="${couponTy}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="couponTy" id="couponTy${status.index}" value="${couponTy.key}" />
									<label class="form-check-label" for="couponTy${status.index}">${couponTy.value }</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="couponNm">고객쿠폰명</label></th>
					<td colspan="3"><form:input class="form-control w-full" path="couponNm" placeholder="(100자 이내)" maxlength="100"  /></td>
				</tr>
				<tr>
					<th scope="row"><label for="mngrMemo">관리자설명</label></th>
					<td colspan="3"><form:input class="form-control w-full" path="mngrMemo" placeholder="(100자 이내)" maxlength="100"  /></td>
				</tr>
				<tr>
					<th scope="row"><label for="dscntTy" class="require">할인구분</label></th>
					<td>
						<div class="form-check-group">
							<c:forEach var="dscntTy" items="${dscntTy}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="dscntTy" id="dscntTy${status.index}" value="${dscntTy.key}" />
									<label class="form-check-label" for="dscntTy${status.index}">${dscntTy.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
					<th scope="row"><label for="dscntAmt" class="require">할인금액/율</label></th>
					<td>
						<div class="form-group">
							<form:input type="number" class="form-control w-30 numbercheck" path="dscntAmt" min="0" max="99"/><span>(%/원)</span>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item6" class="require">최소구매금액</label></th>
					<td>
						<div class="form-group">
							<form:input type="number" class="form-control w-30 numbercheck" path="mummOrdrAmt" min="0" /> <span>원 이상 구매 시 사용가능</span>
						</div>
					</td>
					<th scope="row"><label for="form-item7">최대할인금액</label></th>
					<td>
						<div class="form-group">
							<form:input type="number" class="form-control w-30 numbercheck" path="mxmmDscntAmt" min="0" />
							<span>원 <small class="text-secondary">(정율일 때만 사용)</small></span>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item8" class="require">발급기간</label></th>
					<td colspan="3">
						<div class="form-group">
								<input type="date" class="form-control w-40 calendar" id="bgngDt" name="bgngDt" value="<fmt:formatDate value="${couponVO.issuBgngDt}" pattern="yyyy-MM-dd" />"/>
								<input type="time" class="form-control w-35" name="bgngTime" id="bgngTime" value="<fmt:formatDate value="${couponVO.issuBgngTime}" pattern="HH:mm" />"/>
								<i>~</i>
								<input type="date" class="form-control w-35 calendar"  id="endDt" name="endDt" value="<fmt:formatDate value="${couponVO.issuEndDt}" pattern="yyyy-MM-dd" />"/>
								<input type="time" class="form-control w-35" name="endTime" id="endTime" value="<fmt:formatDate value="${couponVO.issuEndTime}" pattern="HH:mm" />"/>
							<div class="form-check ml-2">
								<input class="form-check-input" type="checkbox" name="unlimitDt" id="unlimitDt" value="unlimitDt">
								<label class="form-check-label" for="unlimitDt">종료일 무한</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item9">발급수량</label></th>
					<td colspan="3">
						<div class="form-group">
							<form:input type="number" class="form-control w-30 numbercheck" path="issuQy"/>
							<div class="form-check ml-2">
								<input class="form-check-input" type="checkbox" name="unlimitQy" id="unlimitQy" value="unlimitQy">
								<label class="form-check-label" for="unlimitQy">무제한</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item10" class="require">발급방식</label></th>
					<td colspan="3">
						<div class="form-check-group">
							<c:forEach var="issuTy" items="${issuTy}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="issuTy" id="issuTy${status.index}" value="${issuTy.key}"/>
									<label class="form-check-label" for="issuTy${status.index}">${issuTy.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item11" class="require">사용기간/일수</label></th>
					<td colspan="3">
						<div class="form-group w-full">
							<div class="form-check w-30">
								<form:radiobutton class="form-check-input" path="usePdTy" id="usePdTy1" value="FIX"/>
								<label class="form-check-label" for="usePdTy1">고정기간</label>
							</div>
							<form:input type="date" class="form-control w-35" path="useBgngYmd" id="useBgngYmd" />
							<i>~</i>
							<form:input type="date" class="form-control w-35" path="useEndYmd" id="useEndYmd" />
							<small class="text-secondary ml-2">(쿠폰 등록 후 시작일 수정 불가능)</small>
						</div>
						<div class="form-group w-full mt-1">
							<div class="form-check w-30">
								<form:radiobutton class="form-check-input" path="usePdTy" id="usePdTy2" value="ADAY" />
								<label class="form-check-label" for="usePdTy2">사용가능일수</label>
							</div>
							<p>
								(발행일로부터 <form:input type="number" class="form-control w-25 text-center numbercheck" path="usePsbltyDaycnt" min="0" /> 일)
								<small class="text-secondary">(고객이 보유한 시점부터 사용가능)</small>
							</p>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item12" class="require">상태</label></th>
					<td>
						<div class="form-check-group">
							<c:forEach var="sttsTy" items="${sttsTy}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="sttsTy" id="sttsTy${status.index}" value="${sttsTy.key}"/>
									<label class="form-check-label" for="sttsTy${status.index}">${sttsTy.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative">
			쿠폰대상정보 <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
			</span>
		</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="require">회원</span></th>
					<td>
						<div class="form-group w-full">
							<div class="form-check">
								<form:radiobutton class="form-check-input" path="issuMbr" id="issuMbr0" value="D" />
								<label class="form-check-label" for="issuMbr0">회원구분/회원등급</label>
							</div>
							<div class="ml-5">
								<div class="form-group w-full">
									<div class="form-check w-25">
										<form:checkbox class="form-check-input" path="issuMbrTy" id="issuMbrTy0" value="G" />
										<label class="form-check-label" for="issuMbrTy0">일반회원</label>
									</div>
									<form:select path="issuMbrGrad" class="form-control w-50">
										<option value="">전체</option>
										<c:forEach var="grade" items="${grade}">
											<form:option value="${grade.key}">${grade.value}</form:option>
										</c:forEach>
									</form:select>
								</div>
								<div class="form-group w-full">
									<div class="form-check w-25">
										<form:checkbox class="form-check-input" path="issuMbrTy" id="issuMbrTy1" value="R" />
										<label class="form-check-label" for="issuMbrTy1">수급자회원</label>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group w-full mt-2">
							<div class="form-check">
								<form:radiobutton class="form-check-input" path="issuMbr" id="issuMbr1" value="I" />
								<label class="form-check-label" for="issuMbr1"> 개별회원
									<small class="text-secondary">(쿠폰을 등록한 후, 관리자 발급화면에서 발급 받을 회원을 수동 지정)</small>
								</label>
							</div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative">
			쿠폰적용상품 <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
			</span>
		</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="issuGds" class="require">상품</label></th>
					<td>
						<div class="form-check-group">
							<c:forEach var="issuGds" items="${issuGds}" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="issuGds" id="issuGds${status.index}" value="${issuGds.key}"/>
									<label class="form-check-label" for="issuGds${status.index}">${issuGds.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr class="gdsView">
					<th scope="row"><span class="require">대상</span></th>
					<td>
						<p class="text-right mb-2">
							<button type="button" class="btn f_srchGds" data-bs-toggle="modal" data-bs-target="#gdsModal">상품검색</button>
						</p>
						<table class="table-list" id="relGdsList">
							<colgroup>
								<col class="w-15">
								<col class="w-22">
								<col class="w-40">
								<col>
								<col class="w-35">
								<col class="w-30">
							</colgroup>
							<thead>
								<tr>
									<th scope="col"></th>
									<th scope="col">NO</th>
									<th scope="col">상품코드</th>
									<th scope="col">상품명</th>
									<th scope="col">판매가</th>
									<th scope="col">판매여부</th>
								</tr>
							</thead>
							<tbody>
							<%--
								<tr class="draggableTr">
									<td>
										<div class="form-check">
											<input class="form-check-input" type="checkbox">
										</div>
									</td>
									<td>111</td>
									<td><a href="#">CODE</a></td>
									<td><a href="#" class="text-left block">상품명</a></td>
									<td>111,111,111</td>
									<td>판매중</td>
								</tr>
								 --%>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<c:set var="pageParam" value="curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;sortBy=${param.sortBy}&amp;srchCouponTy=${param.srchCouponTy}&amp;srchCouponNm=${param.srchCouponNm}&amp;srchCouponCd=${param.srchCouponCd}
	&amp;srchIssuTy=${param.srchIssuTy}&amp;srchSttusTy=${param.srchSttusTy}&amp;srchDt=${param.srchDt}&amp;srchBgngDt=${param.srchBgngDt}&amp;srchEndDt=${param.srchEndDt}" />
	<div class="btn-group right mt-8">
		<button type="submit" class="btn-primary large shadow">저장</button>
		<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	</div>
</form:form>

<c:import url="/_mng/gds/gds/modalGdsSearch" />


<script>

	const mxDate = "9999-12-31"

	//노출 상태
	var useYn = {
	<c:forEach items="${useYn}" var="iem" varStatus="status">
	${iem.key} : "${iem.value}",
	</c:forEach>
	}

	//상품검색 콜백
	function f_modalGdsSearch_callback(gdsNos){
		//console.log("callback: " + gdsNos);
		if($("#relGdsList tbody td").hasClass("no-data")){
			$("#relGdsList tbody tr").remove();
		}

		// 자신 번호도 추가x
		gdsNos = arrayRemove(gdsNos, ${gdsVO.gdsNo});
			// 중복된 상품이 있을 경우 추가x
			$("input[name='gdsNo']").each(function(){
	   		gdsNos = arrayRemove(gdsNos, $(this).val());
			});

		gdsNos.forEach(function(gdsNo){
			console.log('gdsNo', gdsNo);
			//console.log(gdsMap.get(parseInt(gdsNo)));
			var gdsJson = gdsMap.get(parseInt(gdsNo));
			$(".noresult").remove();
			//relGdsList
			var html ="";
			html += '<tr class="draggableTr">'
			html += '<td>'
			html += '<button type="button" class="btn-danger tiny btn-relGds-remove"><i class="fa fa-trash"></i></button>';
			html += '<input type="hidden" name="gdsNo"  value="'+gdsJson.gdsNo+'">';
			html += '<input type="hidden" name="gdsCd"  value="'+gdsJson.gdsCd+'">';
			html += '</td>'
			html += '<td>'+gdsJson.gdsNo+'</td>'
			html += '<td><a href="#">'+gdsJson.gdsCd+'</a></td>'
			html += '<td><a href="#" class="text-left block">'+gdsJson.gdsNm+'</a></td>'
			html += '<td>'+gdsJson.pc+'</td>'
			html += '<td>'+useYn[gdsJson.useYn]+'</td>'
			html += '</tr>'

			$("#relGdsList tbody").append(html);
		});

		$(".btn-close").click();
	}

   	var Dragable = function(){
		return {
			init: function(){

				var containers = document.querySelectorAll('#relGdsList tbody');
				if (containers.length === 0) {
					return false;
				}
				var sortable = new Sortable.default(containers, {
					draggable: '.draggableTr',
					handle: '.draggable',
					delay:100,
					mirror: {
						appendTo: "#relGdsList tbody",
						constrainDimensions: true
					}
				});

			}
		};
	}();


$(function(){
	$("#issuTy0").attr("disabled",true);

	//발급 방식
	$("input[name='couponTy']").on("click",function(){
		var couponTy = $(this).val();
		console.log("쿠폰 값 : " + couponTy);

		// 쿠폰 개수 체크
		$.ajax({
				type : "post",
				url  : "./checkCouponTy.json",
				data : {couponTy : couponTy},
				dataType : 'json'
			})
			.done(function(data) {
				if(data.result == false){
					alert("이미 등록된 해당 타입의 쿠폰이 존재합니다.");
					for(var i=0; i < 5; i++){
						if($("#couponTy"+i).val() == couponTy){
							$("#couponTy"+i).prop("checked",false);
							$("#couponTy"+i).attr("disabled",true);
							$("#couponTy0").prop("checked",true);
						}

					}
					return false;
				}else{
					if($("#couponTy0").is(":checked")){
						$("#issuTy1").prop("checked",true);
						$("#issuTy0").attr("disabled",true);
						$("#issuTy1").attr("disabled",false);
						$("#issuTy2").attr("disabled",false);
						$("#issuQy").attr("readonly",false);
						$("#issuQy").val(0);
						$("#unlimitQy").attr("disabled",false);
						$("#unlimitQy").prop("checked",false);
					}else if($("#couponTy5").is(":checked")){
						$("#dscntAmt").attr("disabled",true);
						$("#mxmmDscntAmt").attr("disabled",true);
						$("input[name='dscntTy']").prop("checked",false);
						$("input[name='dscntTy']").attr("disabled",true);
						$("#issuTy0").attr("disabled",false);
						$("#issuTy0").prop("checked",true);
					}else{
						$("#issuTy0").attr("disabled",false);
						$("#issuTy0").prop("checked",true);
						$("input[name='issuTy']").attr("disabled",true);
						$("#issuQy").val(9999);
						$("#issuQy").attr("readonly",true);
						$("#unlimitQy").prop("checked",true);
						$("#unlimitQy").attr("disabled",true);
						$("#dscntAmt").attr("disabled",false);
						$("#mxmmDscntAmt").attr("disabled",false);
						$("input[name='dscntTy']").attr("disabled",false);
						$("#dscntTy0").prop("checked",true);
					}
				}
			})
			.fail(function(data, status, err) {
				alert("쿠폰 개수 체크 과정에 오류가 발생했습니다.");
				console.log('error forward : ' + data);
			});
	});

	//전체 회원일때 자동 발급 선택
	$("#issuMbr0").on("click",function(){
		if($("#issuMbr0").is(":checked") && !$("#couponTy5").is(":checked") && !$("#couponTy0").is(":checked")){
			$("#issuTy0").attr("disabled",false);
			$("#issuTy1").attr("disabled",true);
			$("#issuTy0").prop("checked",true);
			alert("수동 발급은 불가합니다.");
		}
	});

	//개별 회원 클릭 시
	$("#issuMbr1").on("click",function(){
		if(($("#couponTy5").is(":checked") && $("#issuTy2").is(":checked")) || ($("#couponTy0").is(":checked") && $("#issuTy2").is(":checked"))){
			alert("다운로드 발급은 개별회원 선택이 불가합니다.");
			return false;
		}else{
			if($("#issuMbr1").is(":checked")){
				$("#issuTy1").prop("checked",true);
				$("#issuTy0").attr("disabled",true);
				$("#issuTy1").attr("disabled",false);
				alert("자동 발급은 불가 합니다.");
			}
		}
	});


	//회원구분
	/*$("input[name='issuMbr']").on("click",function(){
		if($("#issuMbr1").is(":checked")){
			$("input[name='issuMbrTy']").attr("disabled",true);
			$("#issuMbrGrad").attr("disabled",true);
		}else{
			$("input[name='issuMbrTy']").attr("disabled",false);
			$("#issuMbrGrad").attr("disabled",false);
		}
	});*/

	//종료일 무한
	$("#unlimitDt").on("click",function(){
		$("#endDt").val(mxDate);
		$("#endTime").val('23:59');
	});

	//무제한 수량
	$("#unlimitQy").on("click",function(){
		if($("#unlimitQy").is(":checked")){
			$("#issuQy").val(9999);
			$("#issuQy").attr("readonly", true);
		}else{
			$("#issuQy").attr("readonly", false);
			$("#issuQy").val(0);
		}
	});

	//정율 > 할인금액
	$("input[name='dscntTy']").on("click",function(){
		if($("#dscntTy1").is(":checked")){
			$("#mxmmDscntAmt").attr("disabled",true);
			$("#dscntAmt").attr("max","99999");
		}else{
			$("#mxmmDscntAmt").attr("disabled",false);
			$("#dscntAmt").attr("max","99");
		}
	});

	//사용기간/일수
	$("input[name='usePdTy']").on("click",function(){
		if($("#usePdTy1").is(":checked",true)){
			$("#usePsbltyDaycnt").attr("disabled",true);
			$("#useBgngYmd").attr("disabled",false);
			$("#useEndYmd").attr("disabled",false);
		}else{
			$("#useBgngYmd").attr("disabled",true);
			$("#useEndYmd").attr("disabled",true);
			$("#usePsbltyDaycnt").attr("disabled",false);
		}
	});

	//쿠폰 적용 상품
	if($("#issuGds1").is(":checked")){
		$(".gdsView").hide();
	}

	$("input[name='issuGds']").on("click",function(){
		if($("#issuGds0").is(":checked")){
			$(".gdsView").show();
		}else{
			$(".gdsView").hide();
		}
	});

	//draggable js loading
	$.getScript("<c:url value='/html/core/vendor/draggable/draggable.bundle.js'/>", function(data,textStatus,jqxhr){
		if(jqxhr.status == 200) {
			Dragable.init();
		} else {
			console.log("draggable is load failed")
		}
	});

	// 상품검색 모달
	$(".f_srchGds").on("click", function(){
		if ( !$.fn.dataTable.isDataTable('#gdsDataTable') ) { //데이터 테이블이 있으면x
 			GdsDataTable.init();
 		}
	});

	// 관련상품 목록 삭제
	$(document).on("click", ".btn-relGds-remove", function(e){
		e.preventDefault();
		$(this).parents(".draggableTr").remove();
		if($("#relGdsList tbody tr").length < 1){
			$("#relGdsList tbody").append("<tr><td colspan='6' class='noresult'>등록된 관련상품이 없습니다.</td></tr>");
		}
	});

	//유효성
	$("form#couponFrm").validate({
	    ignore: "input[type='text']:hidden",
	    rules : {
	    	endTime : {issuChk : true, dtValidate:true},
	    	usePdTy : {required : true},
	    	issuMbr : {required : true},
	    	issuMbrTy : {mbrChk : true},
	    	issuGds : {gdsCheck : true},
	    	useEndYmd : {useChk : true},
	    	issuQy : {min : true},
	    	issuMbrGrad : {gradeChk : true}
	    },
	    messages : {
	    	bgngDt : {required : true},
	    	usePdTy : {required : "사용기간/일수는 필수 입력 항목입니다."},
	    	issuMbr : {required : "회원은 필수 선택 항목입니다."},
	    	issuQy : {min : "최소 수량은 1입니다."},
	    	dscntAmt : {max : "최대 금액/율은 {0} 입니다" }
	    },

	    submitHandler: function (frm) {
	    	if(confirm("저장 하시겠습니까?")){
		    	frm.submit();
	    	} else{
	    		return false;
	    	}
	    }
	});

	//회원 체크
	$.validator.addMethod("mbrChk", function(value,element){
		if($("#issuMbr0").is(":checked")){
			if(!$("#issuMbrTy0").is(":checked") && !$("#issuMbrTy1").is(":checked")){
				return false;
			}else{
				return true;
			}
		}else{
			return true;
		}
	}, "대상 회원을 선택해주세요.");

	//대상 체크
	$.validator.addMethod("gdsCheck", function(value,element){
		if($("#issuGds0").is(":checked")){
			if($(".draggableTr").length <1){
				return false;
			}else{
				return true;
			}
		}else{
			return true;
		}
	}, "대상은 필수 선택 항목입니다.");

	//발급 기간 체크
	$.validator.addMethod("issuChk", function(value,element){
		var bgng = $("#bgngDt").val();
		var end = $("#endDt").val();
		if(end != '' && end < bgng){
			return false;
		}else {
			return true;
		}
	}, "기간을 확인해주세요.");

	//고정 기간 체크
	$.validator.addMethod("useChk", function(value,element){
		var start = $("#useBgngYmd").val();
		var stop = $("#useEndYmd").val();
		if(stop < start){
			return false;
		}else {
			return true;
		}
	}, "기간을 확인해주세요.");

	//날짜, 시간 체크 추가 유효성 검사 메소드
	$.validator.addMethod("dtValidate", function(value,element){
		var arrDate = [];
			arrDate.push($("#bgngDt").val() == "");
			arrDate.push($("#bgngTime").val() == "");
			arrDate.push($("#endDt").val() == "");
			arrDate.push($("#endTime").val() == "");
			for (var i=0; i < 4; i ++){
				if(arrDate.includes(true)){
					return false;
				}else{
					return true;
				}
			}
	}, "항목을 입력해주세요.");

	//회원 등급 체크
	$.validator.addMethod("gradeChk", function(value,element){
		if($("#couponTy3").is(":checked")){
			if($("#issuMbrGrad").val() == ''){
				return false;
			}else{
				return true;
			}
		}else{
			return true;
		}
	}, "회원 등급을 선택하세요.");

	});
</script>
