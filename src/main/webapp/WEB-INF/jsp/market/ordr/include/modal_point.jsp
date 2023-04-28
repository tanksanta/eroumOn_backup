<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<form name="frmPoint" id="frmPoint" method="post" enctype="multipart/form-data">
		<div class="modal fade" id="point-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">포인트 사용</p>
                    </div>
                    <div class="modal-close">
                        <button type="button" class="btn-close" data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="space-y-0.5 md:space-y-1">
                            <p class="text-alert">포인트는 10원 단위로만 사용 가능합니다</p>
                            <p class="text-alert">사용금액 입력 후 반드시 <strong>적용</strong> 버튼을 눌러주세요  </p>
                        </div>
                        <div class="mt-4.5 md:mt-5.5 space-y-4.5 md:space-y-5.5">
                            <div class="order-point is-active">
                                <div class="order-user">
                                    <div class="photo">
                                          <c:choose>
                                    		<c:when test="${!empty _mbrSession.proflImg}">
                                    			   <img src="/comm/proflImg?fileName=${_mbrSession.proflImg}" alt="">
                                    		</c:when>
                                    		<c:otherwise>
                                        		<img src="/html/page/market/assets/images/ico-human3.svg" />
                                        	</c:otherwise>
                                        </c:choose>
                                        <span class="label-primary">
                                            <span>본인</span>
                                            <i></i>
                                        </span>
                                    </div>
                                    <dl>
                                        <dt>회원 아이디</dt>
                                        <dd>${_mbrSession.mbrId}</dd>
                                    </dl>
                                    <dl>
                                        <dt>회원 명</dt>
                                        <dd>${_mbrSession.mbrNm}</dd>
                                    </dl>
                                    <dl class="point">
                                        <dt>잔여 포인트</dt>
                                        <dd class="rest-point"><fmt:formatNumber value="${_mbrEtcInfoMap.totalPoint}" pattern="###,###" /></dd>
                                    </dl>
                                </div>
                                <div class="order-form">
                                    <dl>
                                        <dt>사용 포인트</dt>
                                        <dd><input type="number" name="usePoint" id="modalPoint" value="0" data-max-point="${_mbrEtcInfoMap.totalPoint}" data-unique-id="${_mbrSession.uniqueId}" class="form-control numbercheck point_input" max="${_mbrEtcInfoMap.totalPoint}" step="10" min="0"> 원</dd>
                                        <input type="text" name="preventInput" style="display:none;"/>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modal-footer-gradient">
                        <button type="button" class="btn btn-refresh2 is-reverse f_point_reset">포인트 초기화</button>
                        <button type="button" class="btn btn-point f_point_use">포인트 적용</button>
                        <button type="button" class="btn is-reverse f_point_all">전액 사용</button>
                    </div>
                </div>
            </div>
        </div>
        </form>

        <script>
        $(function(){

        	pointMap.forEach(function(value, key){
        		$("input[data-unique-id='"+ key +"']").val(value);
        		//$("input[data-unique-id='"+ key +"']").prop("readonly", false);
        		$("input[data-unique-id='"+ key +"']").parents(".order-point").addClass("is-active");
        	})


			$("#frmPoint .f_point_reset").on("click", function(e){
				$("#frmPoint input[name='usePoint']").val(0);
				$("#frmMlg input[name='useMlg']").val(0);
			});

			$("#frmPoint input[name='usePoint']").on("keyup", function(){
				let maxPoint = $(this).data("maxPoint");
				let point = $(this).val();
				//console.log("maxPoint", maxPoint, point);

				if(point > maxPoint){
					if(maxPoint > 50000){
						maxPoint = 	50000;
					}
					alert("사용 가능한 포인트는 "+ comma(maxPoint) +"원 입니다.")
					$(this).val(maxPoint);
					$(".rest-point").text(0);
				}else{
					// 잔여 포인트
					$(".rest-point").text(comma(Number(maxPoint)-Number(point)));

				}
			});

			$("#frmPoint input[name='usePoint']").on("focusout", function(){
				// 1원 절사
				if(Number($(this).val()) > 99){
					$(this).val((Math.floor($(this).val() / 10)) * 10);
				}else if($(this).val() == ''){
					$(this).val(0);
				}
			});

			$("#frmPoint .f_point_use").on("click", function(){

				pointMap.clear();

				let totalMlg = 0;
				let totalPoint = 0;
				let stlmAmt = 0;

				$("input[name='ordrPc']").each(function(){
					stlmAmt += Number($(this).val());
				});
				$("input[name='plusDlvyBassAmt']").each(function(){
					stlmAmt += Number($(this).val());
				});
				$("input[name='dlvyAditAmt']").each(function(){
					stlmAmt += Number($(this).val());
				});

				$("#frmMlg input[name='useMlg']").each(function(){
					let mlg = $(this).val();
					let mlgOwner = $(this).data("uniqueId");
					if(mlg > 0){
						totalMlg = Number(totalMlg) + Number(mlg);
						mlgMap.set(mlgOwner, $(this).val());
					}
				});

				$("#frmPoint input[name='usePoint']").each(function(){
					let point = $(this).val();
					let pointOwner = $(this).data("uniqueId");
					if(point > 0){
						totalPoint = Number(totalPoint) + Number(point);
						pointMap.set(pointOwner, $(this).val());
					}
				});

				//console.log("pointMap", pointMap);
				//console.log("totalPoint", totalPoint, stlmAmt);

				if(0 < totalPoint && totalPoint < 3000){
					alert("포인트는 3,000원 이상부터 사용 가능합니다.");
				}else if(totalPoint > 50000){
					alert("1회 최대 사용한도는 50,000원 입니다.");
				}else if(totalPoint > stlmAmt) {
					alert("결제금액("+ comma(stlmAmt) +") 보다 많은 포인트를 입력하셨습니다.");
				}else{
					$(".payment-result .total-mlg-txt").text(comma(totalPoint + totalMlg));
					$("#frmOrdr #usePoint").val(comma(totalPoint));

					f_calStlmAmt();

					$("#point-modal .modal-close .btn-close").click();
				}


			});

			// 엔터키 적용
			$(document).keyup(function (key) {
		        if (key.keyCode == 13) {
		        	$("input[name='usePoint']").each(function(){
		        		if(Number($(this).val()) > 99){
							$(this).val((Math.floor($(this).val() / 10)) * 10);
						}
		        	});
	        		$(".f_point_use").click();
		        }
		    });

			// 전액 사용
			$(".f_point_all").on("click",function(){
				if(Number($("#modalPoint").val()) < 1){
					$("#modalPoint").val($("#modalPoint").data("maxPoint"));
				}else{
					$("#modalPoint").val(0);
				}
			});

        });
        </script>