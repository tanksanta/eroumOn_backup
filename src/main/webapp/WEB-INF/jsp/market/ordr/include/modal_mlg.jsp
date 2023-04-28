<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<form name="frmMlg" id="frmMlg" method="post" enctype="multipart/form-data">
		<div class="modal fade" id="mlg-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">마일리지 사용</p>
                    </div>
                    <div class="modal-close">
                        <button type="button" class="btn-close" data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="space-y-0.5 md:space-y-1">
                            <p class="text-alert">마일리지는 10원 단위로만 사용 가능합니다</p>
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
                                    <dl class="mile">
                                        <dt>잔여 마일리지</dt>
                                        <dd class="rest-mlg"><fmt:formatNumber value="${_mbrEtcInfoMap.totalMlg}" pattern="###,###" /></dd>
                                    </dl>
                                </div>
                                <div class="order-form">
                                    <dl>
                                        <dt>사용 마일리지</dt>
                                        <dd><input type="number" name="useMlg" id="modalMlg" value="0" data-max-mlg="${_mbrEtcInfoMap.totalMlg}" data-unique-id="${_mbrSession.uniqueId}" class="form-control numbercheck mlg_input" max="${_mbrEtcInfoMap.totalMlg}" min="0" step="10"> 원</dd>
                                        <input type="text" name="preventInput" style="display:none;"/>
                                    </dl>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modal-footer-gradient">
                        <button type="button" class="btn btn-refresh2 is-reverse f_mlg_reset">마일리지 초기화</button>
                        <button type="button" class="btn btn-mileage f_mlg_use">마일리지 적용</button>
                        <button type="button" class="btn is_revers f_mlg_all">전액 사용</button>
                    </div>
                </div>
            </div>
        </div>
        </form>


        <script>
        $(function(){

        	mlgMap.forEach(function(value, key){
        		$("input[data-unique-id='"+ key +"']").val(value);
        		//$("input[data-unique-id='"+ key +"']").prop("readonly", false);
        		$("input[data-unique-id='"+ key +"']").parents(".order-point").addClass("is-active");
        	})


			$("#frmMlg .f_mlg_reset").on("click", function(e){
				$("#frmMlg input[name='useMlg']").val(0);
				$("#frmPoint input[name='usePoint']").val(0);
			});

			$("#frmMlg input[name='useMlg']").on("keyup", function(){
				let maxMlg = $(this).data("maxMlg");
				let mlg = $(this).val();
				//console.log("maxMlg", maxMlg, mlg);

				if(mlg > maxMlg){
					if(maxMlg > 50000){
						maxMlg = 50000;
					}
					alert("사용 가능한 마일리지는 "+ comma(maxMlg) +"원 입니다.")
					$(this).val(maxMlg);
					$(".rest-mlg").text(0);
				}else{
					// 잔여 마일리지
					$(".rest-mlg").text(comma(Number(maxMlg)-Number(mlg)));
				}

			});

			$("#frmMlg input[name='useMlg']").on("focusout", function(){
				// 1원 절사
				if(Number($(this).val()) > 99){
					$(this).val((Math.floor($(this).val() / 10)) * 10);
				}else if($(this).val() == ''){
					$(this).val(0);
				}
			});

			$("#frmMlg .f_mlg_use").on("click", function(){

				mlgMap.clear();

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

				console.log("포인트 : " + totalPoint);

				//console.log("mlgMap", mlgMap);
				//console.log("totalMlg", totalMlg, stlmAmt);

				if(0 < totalMlg && totalMlg < 3000){
					alert("마일리지는 3,000원 이상부터 사용 가능합니다.");
				}else if(totalMlg > 50000){
					alert("1회 최대 사용한도는 50,000원 입니다.");
				}else if(totalMlg > stlmAmt) {
					alert("결제금액("+ comma(stlmAmt) +") 보다 많은 마일리지를 입력하셨습니다.");
				}else{
					$(".payment-result .total-mlg-txt").text(comma(totalMlg + totalPoint));
					$("#frmOrdr #useMlg").val(comma(totalMlg));

					f_calStlmAmt();

					$("#mlg-modal .modal-close .btn-close").click();
				}


			});

			// 엔터키 적용
			$(document).keyup(function (key) {
		        if (key.keyCode == 13) {
		        	$("input[name='useMlg']").each(function(){
		        		if(Number($(this).val()) > 99){
							$(this).val((Math.floor($(this).val() / 10)) * 10);
						}
		        	});
		            $(".f_mlg_use").click();
		        }
		    });

			// 전액 사용
			$(".f_mlg_all").on("click",function(){
				if(Number($("#modalMlg").val()) < 1){
					$("#modalMlg").val($("#modalMlg").data("maxMlg"));
				}else{
					$("#modalMlg").val(0);
				}
			});

        });
        </script>