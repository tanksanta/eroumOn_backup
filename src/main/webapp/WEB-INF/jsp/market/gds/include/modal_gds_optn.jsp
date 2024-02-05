<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--옵션변경--%>
<c:set var="now">
<fmt:formatDate value="<%= new java.util.Date() %>" type="time" pattern="YYYYMMDDHHmmss" />
</c:set>

<form name="frmOrdr" id="frmOrdr" method="post" enctype="multipart/form-data">
<input type="hidden" name="ordrTy" value="N"> <!-- 고정 -->

<div class="modal fade" id="optnModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p class="text-title">옵션/수량 선택</p>
			</div>
			<div class="modal-close">
				<button type="button" data-bs-dismiss="modal">모달 닫기</button>
			</div>
			<div class="modal-body">
				<div class="order-quantity-layer">

					<div class="order-thumb">
						<c:if test="${not empty gdsVO.thumbnailFile.fileNo}">
							<img src="/comm/getImage?srvcId=GDS&amp;upNo=${gdsVO.thumbnailFile.upNo}&amp;fileTy=${gdsVO.thumbnailFile.fileTy }&amp;fileNo=${gdsVO.thumbnailFile.fileNo}&amp;thumbYn=Y" alt="썸네일 이미지" class="w-50" />
						</c:if>
						<c:if test="${empty gdsVO.thumbnailFile.fileNo}">
							<img src="/html/page/market/assets/images/noimg.jpg" alt="">
						</c:if>
					</div>

					<div class="order-content">
						<dl class="code">
							<dt>${gdsTyCode[gdsVO.gdsTy]}</dt>
							<dd>${gdsVO.gdsCd}</dd>
						</dl>
						<p class="name">${gdsVO.gdsNm}</p>
						<p class="price">
							판매가 : <strong><fmt:formatNumber value="${gdsVO.pc}" pattern="###,###" /></strong> 원
						</p>
						</div>
					<div class="order-option">

					<!-- <p class="option-title">필수옵션</p> -->
					<c:set var="optnTtl" value="${fn:split(gdsVO.optnTtl, '|')}" />
                    <c:set var="optnVal" value="${fn:split(gdsVO.optnVal, '|')}" />

						<div class="product-option">
							<c:if test="${!empty optnTtl[0]}">
								<div class="product-option" id="optnVal1_${now}">
									<button type="button" class="option-toggle" disabled="true">
										<small>필수</small> <strong>${optnTtl[0]} 선택</strong>
									</button>
									<ul class="option-items">
									</ul>
								</div>
							</c:if>
							<c:if test="${!empty optnTtl[1]}">
								<div class="product-option" id="optnVal2_${now}">
									<button type="button" class="option-toggle" disabled="true">
										<small>필수</small> <strong>${optnTtl[1]} 선택</strong>
									</button>
									<ul class="option-items">
									</ul>
								</div>
							</c:if>
							<c:if test="${!empty optnTtl[2]}">
								<div class="product-option" id="optnVal3_${now}">
									<button type="button" class="option-toggle" disabled="true">
										<small>필수</small> <strong>${optnTtl[2]} 선택</strong>
									</button>
									<ul class="option-items">
									</ul>
								</div>
							</c:if>

							<c:if test="${!empty gdsVO.aditOptnTtl}">
								<c:set var="aditOptnTtl" value="${fn:split(gdsVO.aditOptnTtl, '|')}" />
								<p class="option-title">추가옵션</p>
								<c:forEach var="aditOptn" items="${aditOptnTtl}" varStatus="status">
									<div class="product-option" id="aditOptnVal_${now}${status.index }">
										<button type="button" class="option-toggle">
											<small>추가</small> <strong>추가 ${aditOptn} 선택</strong>
										</button>
										<ul class="option-items">
											<c:forEach var="aditOptnList" items="${gdsVO.aditOptnList}" varStatus="status">
												<c:set var="spAditOptnTtl" value="${fn:split(aditOptnList.optnNm, '*')}" />
												<c:if test="${fn:trim(aditOptn) eq fn:trim(spAditOptnTtl[0])}">
													<li><a href="#" data-optn-ty="ADIT" ' data-opt-val="${aditOptnList.optnNm}|${aditOptnList.optnPc}|${aditOptnList.optnStockQy}|ADIT">${spAditOptnTtl[1]}</a></li>
												</c:if>
											</c:forEach>
										</ul>
									</div>
								</c:forEach>
							</c:if>
							</div>
					</div>
					<table class="table-list order-list">
						<colgroup>
							<col>
							<col class="w-1/4">
							<col class="w-20 md:w-40">
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><p>상품/옵션 정보</p></th>
								<th scope="col"><p>상품가격</p></th>
								<th scope="col"><p>수량</p></th>
							</tr>
						</thead>
						<tbody>
							<input type="hidden" name="gdsTy" id="_gdsTy" value="${gdsVO.gdsTy}">
							<%-- <input type="hidden" name="gdsNo" value="${gdsVO.gdsNo}">
							<input type="hidden" name="gdsCd" value="${gdsVO.gdsCd}">
							<input type="hidden" name="gdsNm" value="${gdsVO.gdsNm}">
							<input type="hidden" name="pc" value="${gdsVO.pc}"> --%>


							<%-- 옵션 --%>

						</tbody>
					</table>
					</div>
			</div>
			<div class="modal-footer">
                <button type="button" class="btn btn-primary btn-submit f_cart_put_${now}">장바구니</button>
                <button type="button" class="btn btn-outline-primary btn-cancel_${now}" data-bs-dismiss="modal">닫기</button>
            </div>
		</div>
	</div>
</div>

</form>

<script>

var Goods_${now} = (function(){

	var gdsPc = ${gdsVO.pc};// 중요함
	var gdsDscntPc = ${gdsVO.dscntPc};
	var ordrTy = "N"; // fix

	function f_optnVal1_${now}(optnVal, optnTy){
		$('.product-option').removeClass('is-active');
		$("#optnVal1_${now} ul.option-items li").remove();

		$.ajax({
			type : "post",
			url  : "${_marketPath}/gds/optn/getOptnInfo.json",
			data : {
				gdsNo:'${gdsVO.gdsNo}'
				, optnTy:optnTy
				, optnVal:optnVal
			},
			dataType : 'json'
		})
		.done(function(json) {
			if(json.result){
				$("#optnVal1_${now} button").prop("disabled", false);
				var oldOptnNm = "";
				$.each(json.optnList, function(index, data){
					var optnNm =data.optnNm.split("*");
					if(oldOptnNm != optnNm[0]){
						if(optnNm.length < 2){
							var optnPc = "";
							var optnSoldout = "";
							if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
							if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
							if(data.soldOutYn === 'Y') { optnSoldout = " [일시품절]"; }
							$("#optnVal1_${now} ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE|"+ data.gdsOptnNo +"'>"+ optnNm[0] + optnPc + optnSoldout +"</a></li>");
						}else{
							$("#optnVal1_${now} ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"'>"+ optnNm[0] +"</li>");
						}
						oldOptnNm = optnNm[0];
					}
				});
			}else{
				$("#optnVal1_${now} button").prop("disabled", true);
			}

		})
		.fail(function(data, status, err) {
			console.log('error forward : ' + data);
		});
	}

	function f_optnVal2_${now}(optnVal1, optnTy){
		$('.product-option').removeClass('is-active');
		$("#optnVal2_${now} ul.option-items li").remove();
		$("#optnVal3_${now} ul.option-items li").remove();
		if(optnVal1!=""){
			$.ajax({
				type : "post",
				url  : "${_marketPath}/gds/optn/getOptnInfo.json",
				data : {
					gdsNo:'${gdsVO.gdsNo}'
					, optnTy:optnTy
					, optnVal:optnVal1
				},
				dataType : 'json'
			})
			.done(function(json) {
				if(json.result){
					$("#optnVal2_${now} button").prop("disabled", false);
					var oldOptnNm = "";
					$.each(json.optnList, function(index, data){
						var optnNm = data.optnNm.split("*");
						if(oldOptnNm != optnNm[1]){
	    					if(optnNm.length < 3){
	    						var optnPc = "";
	    						var optnSoldout = "";
	    						if(data.optnPc > 0){ optnPc = " + " + comma(data.optnPc) +"원"; }
	    						if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
	    						if(data.soldOutYn === 'Y') { optnSoldout = " [일시품절]"; }
	    						$("#optnVal2_${now} ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE|"+ data.gdsOptnNo +"'>"+ optnNm[1] + optnPc + optnSoldout +"</a></li>");
	    					}else{
	    						$("#optnVal2_${now} ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"'>"+ optnNm[1] +"</li>");
	    					}
	    					oldOptnNm = optnNm[1];
						}
	                });
					$('.product-option .option-toggle')[1].click();
				}else{
					$("#optnVal2_${now}").prop("disabled", true);
				}

			})
			.fail(function(data, status, err) {
				console.log('error forward : ' + data);
			});
		}else{
			$("#optnVal2_${now}").prop("disabled", true);
			$("#optnVal3_${now}").prop("disabled", true);
		}
	}

	function f_optnVal3_${now}(optnVal2, optnTy){ // 추후 사용자에서도 사용할 예정
		$('.product-option').removeClass('is-active');
		$("#optnVal3_${now} ul.option-items li").remove();
		if(optnVal2!=""){
			$.ajax({
				type : "post",
				url  : "${_marketPath}/gds/optn/getOptnInfo.json",
				data : {
					gdsNo:'${gdsVO.gdsNo}'
					, optnTy:optnTy
					, optnVal:optnVal2
				},
				dataType : 'json'
			})
			.done(function(json) {
				if(json.result){
					$("#optnVal3_${now} button").prop("disabled", false);
					var oldOptnNm = "";
					$.each(json.optnList, function(index, data){
						var optnNm = data.optnNm.split("*");
						var optnPc = "";
						var optnSoldout = "";
						if(data.optnPc > 0){ optnPc = " + " + data.optnPc +"원"; }
						if(data.optnStockQy < 1){ optnSoldout = " [품절]"; }
						if(data.soldOutYn === 'Y') { optnSoldout = " [일시품절]"; }
						$("#optnVal3_${now} ul.option-items").append("<li><a href='#' data-optn-ty='BASE' data-opt-val='"+ data.optnNm +"|"+ data.optnPc +"|"+ data.optnStockQy +"|BASE|"+ data.gdsOptnNo +"'>"+ optnNm[2] + optnPc + optnSoldout +"</a></li>");
	                });
					//$('.product-option .option-toggle')[1].click();
					$('.product-option .option-toggle')[2].click();
				}else{
					$("#optnVal3_${now}").prop("disabled", true);
				}

			})
			.fail(function(data, status, err) {
				console.log('error forward : ' + data);
			});
		}else{
			$("#optnVal2_${now}").prop("disabled", true);
		}
	}


	function f_baseOptnChg_${now}(optnVal){
		var spOptnVal = optnVal.split("|");
		var spOptnTxt = spOptnVal[0].split("*");
		var skip = false;
		var gdsLastPc = gdsPc;

		if (gdsDscntPc > 0) {
			gdsLastPc = gdsDscntPc;
		}

		//console.log("gdsPc", gdsLastPc);
		//console.log("optnVal", optnVal); // R * 10 * DEF|1000|0|BASE

		if(spOptnVal[0].trim() != ""){
			$(".order-list tbody input[name='ordrOptn']").each(function(){
				if($(this).val() == spOptnVal[0].trim()){
					alert("["+spOptnVal[0] + "]은(는) 이미 추가된 옵션상품입니다.");
					skip = true;
				}

			});
		}

		//console.log("재고:", spOptnVal[2]);
		if(spOptnVal[2] < 1){
			alert("선택하신 옵션은 품절상태입니다.");
			skip = true;
		}
		if(spOptnVal.length > 5 && spOptnVal[5] === 'Y') {
			alert("선택하신 옵션은 일시품절상태입니다.");
			skip = true;
		}

		if(!skip){
			var gdsHtml = '';
				gdsHtml += '<tr class="tr_${gdsVO.gdsNo} optn_BASE">';
				gdsHtml += '	<td>';
				gdsHtml += '		<input type="hidden" name="gdsNo" value="${gdsVO.gdsNo}">';
				gdsHtml += '		<input type="hidden" name="gdsCd" value="${gdsVO.gdsCd}">';
				gdsHtml += '		<input type="hidden" name="bnefCd" value="${gdsVO.bnefCd}">';
				gdsHtml += '		<input type="hidden" name="gdsNm" value="${gdsVO.gdsNm}">';
				gdsHtml += '		<input type="hidden" name="gdsPc" value="'+ gdsLastPc +'">';
				if(typeof spOptnVal[4] != "undefined"){
					gdsHtml += '		<input type="hidden" name="gdsOptnNo" value="'+spOptnVal[4]+'">';
				}else{
					gdsHtml += '		<input type="hidden" name="gdsOptnNo" value="0">';
				}

				gdsHtml += '		<input type="hidden" name="ordrOptnTy" value="BASE">';
				gdsHtml += '		<input type="hidden" name="ordrOptn" value="'+spOptnVal[0]+'">';
				gdsHtml += '		<input type="hidden" name="ordrOptnPc" value="'+spOptnVal[1]+'">';

				gdsHtml += '		<div class="baseitem">';
				gdsHtml += '			<div class="content">';
				gdsHtml += '				<p class="code">${gdsVO.gdsCd}</p>';
				gdsHtml += '				<p class="name">${gdsVO.gdsNm}</p>';
				if(spOptnVal[0] != ""){
					gdsHtml += '				<dl class="option">';
					gdsHtml += '					<dt>옵션</dt>';
					gdsHtml += '					<dd class="ordrOptn">';
					gdsHtml += '						<span class="label-flat">'+spOptnVal[0] +'</span>';
					gdsHtml += '					</dd>';
					gdsHtml += '				</dl>';
				}
				gdsHtml += '			</div>';
				gdsHtml += '		</div>';
				gdsHtml += '	</td>';
				gdsHtml += '	<td class="price">';
				gdsHtml += '		<strong>'+ comma(Number(gdsLastPc) + Number(spOptnVal[1])) +'</strong> 원';
				gdsHtml += '	</td>';

				gdsHtml += '	<td class="count">';
				gdsHtml += '		<p>';
				gdsHtml += '		<input type="number" name="ordrQy" class="form-control numbercheck" value="1" min="1" max="9999" data-stock-qy="'+ spOptnVal[2] +'">';
				gdsHtml += '		</p>';
				gdsHtml += '		<button type="button" class="btn btn-small btn-outline-primary f_cart_del" >삭제</button>';
				gdsHtml += '	</td>';
				gdsHtml += '</tr>';

				$(".order-list tbody").append(gdsHtml);

		}

		$('.product-option').removeClass('is-active');

	}

	//추가옵션
	function f_aditOptnChg_${now}(optnVal){
		var spAditOptnVal = optnVal.split("|");
		var spAditOptnTxt = spAditOptnVal[0].split("*"); // AA * BB
		var skip = false;

		$(".order-list tbody input[name='ordrOptn']").each(function(){
			if($(this).val() == spAditOptnVal[0].trim()){
				alert("["+spAditOptnVal[0] + "]은(는) 이미 추가된 옵션상품입니다.");
				skip = true;
			}
		});
		if(spAditOptnVal[2] < 1){
			alert("선택하신 옵션은 품절상태입니다.");
			skip = true;
		}

		if(!skip){
			var gdsHtml = '';
			gdsHtml += '';
			gdsHtml += '<tr class="tr_${gdsVO.gdsNo} optn_ADIT">';
			gdsHtml += '	<td>';
			gdsHtml += '		<input type="hidden" name="gdsNo" value="${gdsVO.gdsNo}">';
			gdsHtml += '		<input type="hidden" name="gdsCd" value="${gdsVO.gdsCd}">';
			gdsHtml += '		<input type="hidden" name="bnefCd" value="${gdsVO.bnefCd}">';
			gdsHtml += '		<input type="hidden" name="gdsNm" value="${gdsVO.gdsNm}">';
			gdsHtml += '		<input type="hidden" name="gdsPc" value="0">';
			if(typeof spAditOptnVal[4] != "undefined"){
				gdsHtml += '		<input type="hidden" name="gdsOptnNo" value="'+spAditOptnVal[4]+'">';
			}else{
				gdsHtml += '		<input type="hidden" name="gdsOptnNo" value="0">';
			}

			gdsHtml += '		<input type="hidden" name="ordrOptnTy" value="ADIT">';
			gdsHtml += '		<input type="hidden" name="ordrOptn" value="'+spAditOptnVal[0]+'">';
			gdsHtml += '		<input type="hidden" name="ordrOptnPc" value="'+spAditOptnVal[1]+'">';

			gdsHtml += '		<div class="additem">';
			gdsHtml += '			<span class="label-outline-primary">';
			gdsHtml += '			<span>'+ spAditOptnTxt[0] +'</span>';
			gdsHtml += '			<i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>';
			gdsHtml += '			</span>';
			gdsHtml += '			<div class="content">';
			gdsHtml += '				<p class="name">'+ spAditOptnTxt[1] +'</p>';
			gdsHtml += '			</div>';
			gdsHtml += '		</div>';
			gdsHtml += '	</td>';
			gdsHtml += '	<td class="price">';
			gdsHtml += '		<strong>'+ spAditOptnVal[1] +'</strong> 원';
			gdsHtml += '	</td>';

			gdsHtml += '	<td class="count">';
			gdsHtml += '		<p>';
			gdsHtml += '		<input type="number" name="ordrQy" class="form-control numbercheck" value="1" min="1" max="9999" data-stock-qy="'+ spAditOptnVal[2] +'">';
			gdsHtml += '		</p>';
			gdsHtml += '		<button type="button" class="btn btn-small btn-outline-primary f_cart_del">삭제</button>';
			gdsHtml += '	</td>';
			gdsHtml += '</tr>';

			$(".order-list tbody").append(gdsHtml);
		}

		$('.product-option').removeClass('is-active');

		//f_totalPrice();
	}


	$(function(){

		$(".option-toggle").on("click", function(){
			$(this).closest('.product-option').toggleClass('is-active');
			$('.product-option').not($(this).closest('.product-option')).removeClass('is-active');
		});

		<c:if test="${empty optnTtl[0]}">
	    // 옵션이 없는 경우 //|0|10
	    f_baseOptnChg_${now}("|0|${gdsVO.stockQy}|BASE"); //R * 10 * DEF|1000|0|BASE
	    $(".btn-delete").remove();
	    </c:if>

	    <c:if test="${!empty optnTtl[0]}">
		// 기본 옵션 1번
		f_optnVal1_${now}('', 'BASE');
		<c:if test="${empty optnTtl[1]}">
		$(document).on("click", "#optnVal1_${now} ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal1 = $(this).data("optVal");
			//console.log(optnVal1);
			if(optnVal1 != ""){
				f_baseOptnChg_${now}(optnVal1);
			}
		});
		</c:if>
		</c:if>

		<c:if test="${!empty optnTtl[1]}">
		// 기본 옵션 2번
		$(document).on("click", "#optnVal1_${now} ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal1 = $(this).data("optVal").split("*");
			const optnTy = $(this).data("optnTy");

			//console.log("optnVal1 :", optnVal1, optnTy);

			f_optnVal2_${now}(optnVal1[0].trim(), optnTy);
		});

		<c:if test="${empty optnTtl[2]}">
		$(document).on("click", "#optnVal2_${now} ul.option-items li a", function(e){
			e.preventDefault();

			const optnVal2 = $(this).data("optVal");//.split("*");
			const optnTy = $(this).data("optnTy");

			//console.log("optnVal2 :", optnVal2, optnTy);

			if(optnVal2 != ""){
				f_baseOptnChg_${now}(optnVal2);
			}



		});
		</c:if>

		</c:if>

		<c:if test="${!empty optnTtl[2]}">
		// 기본 옵션 3번
		$(document).on("click", "#optnVal2_${now} ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal2 = $(this).data("optVal").split("*");
			const optnTy = $(this).data("optnTy");
			//console.log("optnVal2 :", optnVal2, optnTy);
			f_optnVal3_${now}(optnVal2[0].trim() +" * " +optnVal2[1].trim(), optnTy);

		});


		$(document).on("click", "#optnVal3_${now} ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal3 = $(this).data("optVal");//.split("*");
			const optnTy = $(this).data("optnTy");
			//console.log("optnVal3 :", optnVal3, optnTy);
			if(optnVal3 != ""){
				f_baseOptnChg_${now}(optnVal3);
			}
		});
		</c:if>


		<%--추가옵션--%>
		$(document).on("click", "[id^=aditOptnVal_${now}] ul.option-items li a", function(e){
			e.preventDefault();
			const optnVal = $(this).data("optVal");
			//기본상품이 있는지 먼저 체크해야함
			if($(".order-list tbody input[name='ordrOptnTy'][value='BASE']").length > 0 && optnVal != ""){
				f_aditOptnChg_${now}(optnVal);
			}else{
				alert("기본 옵션을 먼저 선택해야 합니다.");
				$('.product-option').removeClass('is-active');
			}
		});

		$(document).on("keyup", "input[name='ordrQy']",function(){
			//console.log($("#_gdsTy").val());
			if($(this).val() > 15 && $("#_gdsTy").val() == 'R'){
				alert("최대 수량은 15개 입니다.");
				$(this).val(15);
			}
		})


		$(document).on("click", ".f_cart_del", function(){
			$(this).parents("tr").remove();
		});

		// 장바구니 버튼
		$(document).on("click", ".f_cart_put_${now}", function(){

	        if((ordrTy == "R" || ordrTy == "L") && $("#bplcUniqueId").val() == "" ){
				alert("급여상품 구입은 멤버스(사업소)를 선택해야 합니다.");
				return false;
	        }else if($(".order-list tbody input[name='ordrOptn']").length < 1){
	        	alert("필수 옵션을 선택하세요");
	        	return false;
	        }else{
	        	var formData = $("#frmOrdr").serialize();
				$.ajax({
					type : "post",
					url  : "${_marketPath}/mypage/cart/putCart.json",
					data : formData,
					dataType : 'json'
				})
				.done(function(json) {
					if(json.result){
						if(json.resultMsg == "ALREADY"){
							alert("장바구니에 담겨있는 상품입니다.");
						}else{
							$('.navigation-util .util-item3 i').text(Number($('.navigation-util .util-item3 i').text()) + 1);
							alert("장바구니에 담았습니다.");
							$("#optnModal").modal('hide');
						}
					}else{
						alert("장바구니 담기에 실패하였습니다.\n잠시후 다시 시도해 주시기 바랍니다.")
						$("#optnModal").modal('hide');
					}
				})
				.fail(function(data, status, err) {
					console.log('error forward : ' + data);
					$("#optnModal").modal('hide');
				});

	        }

		});


	});
})();

</script>