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
                            <p class="text-alert">본인 포인트를 <strong>모두 소진</strong>후에 가족계정 다른 회원의 포인트를 사용할 수 있습니다</p>
                            <p class="text-alert">사용금액 입력 후 반드시 <strong>적용</strong> 버튼을 눌러주세요  </p>
                        </div>
                        <div class="mt-4.5 md:mt-5.5 space-y-4.5 md:space-y-5.5">
                            <div class="order-point is-active">
                                <div class="order-user">
                                    <div class="photo">
                                          <c:choose>
                                    		<c:when test="${_mbrSession.proflImg ne null}">
                                    			   <img src="/comm/proflImg?fileName=${_mbrSession.proflImg}" alt="">
                                    		</c:when>
                                    		<c:otherwise>
                                        		<img src="/html/page/market/assets/images/dummy/img-dummy-partners.png" alt="">
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
                                        <dd>${_mbrEtcInfoMap.totalPoint}</dd>
                                    </dl>
                                </div>
                                <div class="order-form">
                                    <dl>
                                        <dt>사용 포인트</dt>
                                        <dd><input type="number" name="usePoint" value="0" data-max-point="${_mbrEtcInfoMap.totalPoint}" data-unique-id="${_mbrSession.uniqueId}" class="form-control numbercheck point_input"> 원</dd>
                                    </dl>
                                </div>
                            </div>

                            <c:forEach items="${prtcrList}" var="prtcr" varStatus="status">
                            <div class="order-point">
                                <div class="order-user">
                                    <div class="photo">
                                    	<c:if test="${!empty prtcr.proflImg}">
			                            <img src="/comm/proflImg?fileName=${prtcr.proflImg}" alt="">
			                            </c:if>
                                        <span class="label-outline-primary">
                                            <span>
                                            	<c:if test="${prtcr.prtcrRlt ne 'E'}">
                                            	${prtcrRltCode[prtcr.prtcrRlt]}
                                            	</c:if>
                                            	<c:if test="${prtcr.prtcrRlt eq 'E'}">
												${prtcr.rltEtc}
                                            	</c:if>
                                            </span>
                                            <i></i>
                                        </span>
                                    </div>
                                    <dl>
                                        <dt>회원 아이디</dt>
                                        <dd>${prtcr.mbrId}</dd>
                                    </dl>
                                    <dl>
                                        <dt>회원 명</dt>
                                        <dd>${prtcr.mbrNm}</dd>
                                    </dl>
                                    <dl class="point">
                                        <dt>잔여 포인트</dt>
                                        <dd>${prtcr.mbrPoint}</dd>
                                    </dl>
                                </div>
                                <div class="order-form">
                                    <dl>
                                        <dt>사용 포인트</dt>
                                        <dd><input type="number" name="usePoint" value="0" data-max-point="${prtcr.mbrPoint}" data-unique-id="${prtcr.mbrUniqueId}" class="form-control numbercheck point_input" readonly="readonly"> 원</dd>
                                    </dl>
                                </div>
                            </div>
                            </c:forEach>

                        </div>
                    </div>
                    <div class="modal-footer modal-footer-gradient">
                        <button type="button" class="btn btn-refresh2 is-reverse f_point_reset">포인트 초기화</button>
                        <button type="button" class="btn btn-point f_point_use">포인트 적용</button>
                    </div>
                </div>
            </div>
        </div>
        </form>

        <script>
        function f_readonlyTrue(){
        	$("#frmPoint input[name='usePoint']").each(function(index){
				if(index > 0){
					$($("#frmPoint input[name='usePoint']")[index]).val(0);
					$($("#frmPoint input[name='usePoint']")[index]).prop("readonly", true);
				}
			});
        }
        $(function(){

        	pointMap.forEach(function(value, key){
        		$("input[data-unique-id='"+ key +"']").val(value);
        		$("input[data-unique-id='"+ key +"']").prop("readonly", false);
        		$("input[data-unique-id='"+ key +"']").parents(".order-point").addClass("is-active");
        	})


			$("#frmPoint .f_point_reset").on("click", function(e){
				$("#frmPoint input[name='usePoint']").val(0);
			});

			$($("#frmPoint input[name='usePoint']")[0]).on("keyup", function(){
				let maxPoint = $(this).data("maxPoint");
				let point = $(this).val();
				if(maxPoint == point){
					$("#frmPoint input[name='usePoint']").prop("readonly", false);
				}else{
					f_readonlyTrue();
				}
				//console.log("내꺼", point);
			}).trigger("keyup");

			$("#frmPoint input[name='usePoint']").on("keyup", function(){
				let maxPoint = $(this).data("maxPoint");
				let point = $(this).val();
				//console.log("maxPoint", maxPoint, point);

				if(point > maxPoint){
					alert("사용 가능한 포인트는 "+ maxPoint +"원 입니다.")
					$(this).val(maxPoint);
					$("#frmPoint input[name='usePoint']").prop("readonly", false);

				}else{
					if(point > 0){//사용
						$(this).parents(".order-point").addClass("is-active");
					}else{
						$(this).parents(".order-point").removeClass("is-active");
					}

				}

				// 본인 포인트를 전부 사용했는지 확인
				let myPoint = $($("#frmPoint input[name='usePoint']")[0]).val();
				let myMaxPoint = $($("#frmPoint input[name='usePoint']")[0]).data("maxPoint");
				if(myMaxPoint > myPoint){

				}

			});

			$("#frmPoint input[name='usePoint']").on("focusout", function(){
				if($(this).val() == ''){
					$(this).val(0);
				}
			});

			$("#frmPoint .f_point_use").on("click", function(){

				pointMap.clear();

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

				if(0 < totalPoint && totalPoint < 100){
					alert("포인트는 5,000원 이상부터 사용 가능합니다.");
				}else if(totalPoint > stlmAmt) {
					alert("결제금액("+ comma(stlmAmt) +") 보다 많은 포인트를 입력하셨습니다.");

				}else{
					$(".payment-result .total-mlg-txt").text(comma(totalPoint));
					$("#frmOrdr #usePoint").val(comma(totalPoint));

					f_calStlmAmt();

					$("#point-modal .modal-close .btn-close").click();
				}


			});

        });
        </script>