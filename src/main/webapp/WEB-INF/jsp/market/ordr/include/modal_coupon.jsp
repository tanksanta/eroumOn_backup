<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="modal fade" id="coupon-modal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p class="text-title">쿠폰 사용</p>
			</div>
			<div class="modal-close">
				<button type="button" data-bs-dismiss="modal" id="clssModal">모달 닫기</button>
			</div>
			<div class="modal-body">
				<div class="space-y-4 md:space-y-5">
					<c:forEach var="resultList" items="${itemList}" varStatus="status">
						<div class="order-coupon">
							<div class="order-content view${resultList.gdsCd}">
								<div class="thumb">
									<c:if test="${resultList.thumbnailFile ne null}">
										<img src="/comm/getImage?srvcId=GDS&amp;upNo=${resultList.thumbnailFile.upNo }&amp;fileTy=${resultList.thumbnailFile.fileTy }&amp;fileNo=${resultList.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="">
									</c:if>
									<c:if test="${resultList.thumbnailFile eq null}">
										<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
									</c:if>
								</div>
								<div class="content">
									<p class="code">${resultList.gdsCd}</p>
									<p class="name">${resultList.gdsNm}</p>
									<p class="price price${status.index}">
										<input type="hidden" class="hdPrice" value="${resultList.pc * ordrQy[status.index]}" />
										<!--<fmt:formatNumber value="${resultList.pc * ordrQy[status.index]}" pattern="###,###" />원--></p>
								</div>
								<p class="minus minus${resultList.gdsNo}_${status.index+1}" style="display:none;">
									<strong class="dscmtPc"></strong> 원
								</p>
							</div>
							<button type="button" class="order-trigger ${resultList.gdsNo}_${status.index+1}" data-gds-cd = "${resultList.gdsCd}" data-gds-pc = "${resultList.pc}" data-gds-no = "${resultList.gdsNo}" data-dlvy-amt="${resultList.dlvyBassAmt}" data-ordr-idx="${status.index}">
								<img src="" alt="" class="img${resultList.gdsNo}_${status.index+1} default">
								<span class="img${resultList.gdsNo}_${status.index+1} default">적용할 쿠폰을 선택하세요</span>
							</button>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="modal-footer modal-footer-gradient">
				<button type="button" class="btn btn-refresh2 is-reverse" id="btn-reset">쿠폰 선택 초기화</button>
				<button type="button" class="btn btn-coupon" id="apply">선택 쿠폰 적용</button>
			</div>

			<div class="order-coupon-layer">
				<div class="container">
					<div class="text-title">
						사용 가능 쿠폰
						<button type="button"  id="clsModal">닫기</button>
					</div>
					<div class="scrollbars">
						<table class="table-list order-coupon-list">
							<colgroup>
								<col class="w-38 xs:w-[48.5%]">
								<col>
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><p>쿠폰</p></th>
									<th scope="col"><p>기간 / 혜택</p></th>
								</tr>
							</thead>
							<tbody>
								<c:set var="getNow" value="<%=new java.util.Date()%>" />
									<c:if test="${empty couponList}">
										<td colspan="2"><div class="box-result">사용 가능한 쿠폰이 없습니다</div></td>
									</c:if>
								<c:forEach var="cpnList" items="${couponList}" varStatus="status">
									<c:if test="${(cpnList.couponInfo.useBgngYmd < getNow && getNow <  cpnList.couponInfo.useEndYmd) || (cpnList.useLstBgngYmd < getNow && getNow <  cpnList.useLstEndYmd)}">
										<tr>
											<td>
												<div>
													<jsp:include page="../../mypage/coupon/event_type.jsp">
														<jsp:param value="${cpnList.couponInfo.couponTy}" name="eventType" />
														<jsp:param value="${cpnList.couponInfo.mummOrdrAmt}" name="mummOrdrAmt" />
														<jsp:param value="${cpnList.couponInfo.mxmmDscntAmt}" name="mxmmDscntAmt" />
														<jsp:param value="${cpnList.couponInfo.dscntAmt}" name="dscntAmt" />
														<jsp:param value="${cpnList.couponInfo.dscntTy}" name="dscntTy" />
													</jsp:include>
												</div>
												<input type="hidden" name="dsAmt" value="${cpnList.couponInfo.dscntAmt}" />
												<input type="hidden" name="cpnNo" value="${cpnList.couponInfo.couponNo}" />
												<input type="hidden" name="cpnCd" value="${cpnList.couponCd}" />
												<input type="hidden" name="dscmtTy" value="${cpnList.couponInfo.dscntTy}" />
												<input type="hidden" name="cpnTy" value="${cpnList.couponInfo.couponTy}" />
												<input type="hidden" name="cpnNm" value="${cpnList.couponInfo.couponNm}" />
												<input type="hidden" name="issuBgngDt" value="${cpnList.couponInfo.issuBgngDt}" />
												<input type="hidden" name="usePdTy" value="${cpnList.couponInfo.usePdTy}" />
												<input type="hidden" name="useBgngYmd" value="${cpnList.couponInfo.useBgngYmd}" />
												<input type="hidden" name="useEndYmd" value="${cpnList.couponInfo.useEndYmd}" />
												<input type="hidden" name="usePsbltyDaycnt" value="${cpnList.couponInfo.usePsbltyDaycnt}" />
												<input type="hidden" name="mummOrdrAmt" value="${cpnList.couponInfo.mummOrdrAmt}" />
												<input type="hidden" name="mxmmDscntAmt" value="${cpnList.couponInfo.mxmmDscntAmt}" />
												<input type="hidden" name="issuMbrTy" value="${cpnList.couponInfo.issuMbrTy}" />

												<button type="button" class="use_coupon">이 쿠폰 사용하기</button>
											</td>
											<td>
												<div class="coupon-item-name">
													${cpnList.couponInfo.couponNm}
													<strong>
														<c:choose>
															<c:when test="${cpnList.couponInfo.usePdTy eq 'FIX'}">
																<fmt:formatDate value="${cpnList.couponInfo.useBgngYmd}" pattern="yyyy-MM-dd" />
																~
																<fmt:formatDate value="${cpnList.couponInfo.useEndYmd}" pattern="yyyy-MM-dd" />
															</c:when>
															<c:otherwise>
																<fmt:formatDate value="${cpnList.useLstBgngYmd}" pattern="yyyy-MM-dd" />
																~
																<fmt:formatDate value="${cpnList.useLstEndYmd}" pattern="yyyy-MM-dd" />
															</c:otherwise>
														</c:choose>
													</strong>
												</div>
												<div class="coupon-item-desc">
													<fmt:formatNumber value="${cpnList.couponInfo.mummOrdrAmt}" pattern="###,###" />원 이상 구매시
													<c:if test="${cpnList.couponInfo.dscntTy eq 'PRCS' }">
														<br> 최대<fmt:formatNumber value="${cpnList.couponInfo.mxmmDscntAmt}" pattern="###,###" />원 할인
													</c:if>
												</div>
											</td>
										</tr>
									</c:if>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
//천단위 콤마
function f_addComma(val){
	return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}


$(function(){
	var gdsCd = "";
	var sumAmt = 0;
	var amt = 0;
	var cpnCd = "";
	var cpnNo = 0;
	var gdsNo = 0;
	var totalAmt = 0;
	var dlvyTy = "";
	var arrGdsNo = []; // 배송비 초기화를 위한 배열
	var ordrIdx = 0;
	var arrOrdrPc = "${arrOrdrPc}";
	arrOrdrPc = arrOrdrPc.replaceAll("[","")
	arrOrdrPc = arrOrdrPc.replaceAll("]","")
	arrOrdrPc = arrOrdrPc.replaceAll(' ','');
	arrOrdrPc = arrOrdrPc.replaceAll('원','');
	arrOrdrPc = arrOrdrPc.split(',');

	$("input[name='gdsNo']").each(function(){
		arrGdsNo.push($(this).val());
	});

	//가격 텍스트
	for(var i=0; i<$(".order-coupon").length; i++){
		$(".price"+i).text(comma(arrOrdrPc[i])+"원");
	}


   //쿠폰사용
    $('.order-trigger').on('click', function() {
    	gdsCd = $(this).data("gdsCd");
    	gdsPc = $(this).data("gdsPc");
       	gdsNo = $(this).data("gdsNo");
       	arrGdsNo.push(gdsNo);
       	dlvyBassAmt = $(this).data("dlvyAmt");
       	ordrIdx = $(this).data("ordrIdx");

       	if($("#couponNo_BASE_"+gdsNo+"_"+(ordrIdx+1)).val() != ''){
       		alert("이미 적용된 쿠폰이 있습니다.");
       	}else{
            if($('.order-coupon-layer').hasClass('is-active')) {
                $('.order-coupon-layer').removeClass('is-active');
            } else {
                $('.order-coupon-layer').addClass('is-active');
            }
       	}

    });

    $('.order-coupon-layer .text-title button').on('click', function() {
        $('.order-coupon-layer').removeClass('is-active');
    });

    // 이 쿠폰 사용하기
    $(".use_coupon").on("click",function(){
		var obj = $(this);
    	var html = $(this).siblings("div").html();
    	var dscmtTy = $(this).siblings("input[name='dscmtTy']").val();
    	var cpnNm = $(this).siblings("input[name='cpnNm']").val();
    	var issuBgngDt = $(this).siblings("input[name='issuBgngDt']").val();
    	var usePdTy = $(this).siblings("input[name='usePdTy']").val();
    	var useBgngYmd = $(this).siblings("input[name='useBgngYmd']").val();
    	var useEndYmd = $(this).siblings("input[name='useEndYmd']").val();
    	var usePsbltyDaycnt = $(this).siblings("input[name='usePsbltyDaycnt']").val();
    	var mummOrdrAmt = $(this).siblings("input[name='mummOrdrAmt']").val();
    	var mxmmDscntAmt = $(this).siblings("input[name='mxmmDscntAmt']").val();
    	var couponTy = $(this).siblings("input[name='cpnTy']").val();
    	var mbrTy = "${mbrSession.recipterYn}";

    	if(mbrTy == "Y"){
    		mbrTy = "R"
    	}else{
    		mbrTy = "G"
    	}

    	var issuMbrTy = $(this).siblings("input[name='issuMbrTy']").val();
    	issuMbrTy = issuMbrTy.replaceAll(' ','');
    	issuMbrTy = issuMbrTy.split(',');

    	amt = $(this).siblings("input[name='dsAmt']").val();
    	cpnCd = $(this).siblings("input[name='cpnCd']").val();
    	cpnNo = $(this).siblings("input[name='cpnNo']").val();
    	cpnTy = couponTy;


      	// 적용 상품 검사
		$.ajax({
			type : "post",
			url  : "/market/etc/coupon/ChkGdsInfo.json",
			data : {
				gdsNo : gdsNo
				, couponNo : cpnNo
			},
			dataType : 'json'
		})
		.done(function(data) {
			if(data.result != true){
				alert("해당 상품에 사용 할 수 없는 쿠폰입니다.");
			}else{
				if(issuMbrTy[0] != mbrTy && issuMbrTy[1] != mbrTy){
					alert("회원님은 이 쿠폰을 사용하실 수 없습니다.");
				}else{
			    	if(Number(gdsPc) < amt){
			    		alert("상품 가격이 할인가격보다 작습니다.");
			    		return false;
			    	}else{
			    		// 최소 금액 체크
			    		const total = "${total}";
			    		if(Number(mummOrdrAmt) >  total){
			    			alert("최소금액을 확인해주세요.");
			    			return false;
			    		}else{
			    			// 초기화
			    			$("."+gdsCd).children("div").remove();
			    			totalAmt = 0;

				        	// 정율,정액 구분
				        	if(dscmtTy == "PRCS"){
				        		var ordrPc = $("#ordrPc_BASE_"+gdsNo+"_"+(ordrIdx+1)).val();
				        		amt = Math.round(Number(ordrPc) * Number(amt / 100));
				        		totalAmt = Number(total) * Number(amt / 100);

				        		if(Number(amt) > Number(mxmmDscntAmt)){
				        			amt = Number(mxmmDscntAmt);
				        			console.log("최대 할인 금액 적용");
				        		}
				        		if(Number(amt) > Number(ordrPc)){
				        			amt = Number(gdsPc);
				        			console.log("할인금액이 상품 금액 초과");
				        		}

				        	}else if(cpnTy == 'FREE'){
				        		amt = dlvyBassAmt;
				        		$("#dlvyBassAmt_BASE"+"_"+gdsNo+"_"+(ordrIdx+1)).val(0);
				        	}else{
				            	if(Number(gdsPc) < Number(amt)){
				            		amt = Number(gdsPc);
				            	}
				        	}

				        	if(totalAmt < mxmmDscntAmt){ // 주문 금액을 넘어간다면
				        		alert("최대 할인 금액을 확인해주세요.");
				        		return false;
				        	}else{
				           		// 텍스트 추가
					        	html += '<div class="coupon-item-name addView">';
					        	html += cpnNm;

					        	// 기간 유형
					        	/*if(usePdTy == "FIX"){
					        		html += '<strong>'+useBgngYmd+' ~ '+useEndYmd+'</strong>';
					        	}else{
					        		issuBgngDt = issuBgngDt + usePsbltyDaycnt;
					        		//html += '<strong>'+issuBgngDt+'</strong>';
					        	}*/
					        	html += '</div>';
					        	$("."+gdsNo+"_"+(ordrIdx+1)).append(html);

					        	$("#"+gdsNo+"_"+(ordrIdx+1)).hide();
					        	$(".img"+gdsNo+"_"+(ordrIdx+1)).hide();
					        	$(".minus"+gdsNo+"_"+(ordrIdx+1)).show();

					        	$("#couponAmt_BASE_"+gdsNo+"_"+(ordrIdx+1)).val(amt);
					        	$("#couponNo_BASE_"+gdsNo+"_"+(ordrIdx+1)).val(cpnNo);
					        	$("#couponCd_BASE_"+gdsNo+"_"+(ordrIdx+1)).val(cpnCd);
					        	//$("#ordrPc_BASE_"+gdsNo+"_"+(ordrIdx+1)).val($("#plusOrdrPc_BASE_"+gdsNo+"_"+(ordrIdx+1)).val()-amt);

					        	sumAmt = Number(sumAmt) + Number(amt);


					        	$(".minus"+gdsNo+"_"+(ordrIdx+1)).children(".dscmtPc").text(comma(amt));

					        	//console.log("배송비 : " + sumAmt);
					        	//console.log("할인가 : " + amt);

					        	$("#clsModal").click();
					        	obj.hide();
				        	}
				    	}
			    	}
				}
			}
		})
		.fail(function(data, status, err) {
			alert("쿠폰 적용 상품 검사 중 오류가 발생하였습니다. /n 관리자에게 문의바랍니다.");
			console.log('error forward : ' + data);
		});


    });

    // 쿠폰 선택 초기화
    $("#btn-reset").on("click",function(){
    	$(".minus").hide();
    	$(".default").show();
    	$(".order-trigger").children("div").remove();

		$("#totalCouponAmt").val(0);
		$(".total-coupon-txt").text(0);
		$(".total-stlmAmt-txt").text(comma("${total}"));

    	for(var i=0; i<arrOrdrPc.length; i++){

    		$("#dlvyBassAmt_BASE_"+arrGdsNo[i]+"_"+(i+1)).val($("#plusDlvyBassAmt_BASE_"+arrGdsNo[i]+"_"+(i+1)).val()); //배송비 초기화
    		$("#ordrPc_BASE_"+arrGdsNo[i]+"_"+(i+1)).val($("#plusOrdrPc_BASE_"+arrGdsNo[i]+"_"+(i+1)).val()); //주문금액 초기화

    		$("input[name='couponNo']").val(''); //쿠폰 번호 초기화
    		$("input[name='couponCd']").val(''); //쿠폰 코드 초기화
    		$("input[name='couponAmt']").val(''); //쿠폰 할인 금액 초기화

    	}

		//초기화
		arrGdsNo = [];
		sumAmt = 0;
		amt = 0;
		cpnCd = "";
		cpnNo = 0;
		gdsNo = 0;
		$(".use_coupon").show();
    });

    // 선택 쿠폰 적용
    $("#apply").on("click",function(){
    	var couponAmt = $("#totalCouponAmt").val();

    	if(typeof couponAmt == "string"){
    		couponAmt = uncomma(couponAmt);
    	}else{
    		couponAmt = comma(couponAmt);
    	}

   		$("#totalCouponAmt").val(comma(Number(sumAmt)));
   		$(".total-coupon-txt").text(comma(sumAmt));

    	$("#clssModal").click();
    	f_calStlmAmt();
    	//sumAmt = 0;
    });

});
</script>

