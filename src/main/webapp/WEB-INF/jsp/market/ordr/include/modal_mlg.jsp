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
                            <p class="text-alert">본인 마일리지를 <strong>모두 소진</strong>후에 가족계정 다른 회원의 마일리지를 사용할 수 있습니다</p>
                            <p class="text-alert">사용금액 입력 후 반드시 <strong>적용</strong> 버튼을 눌러주세요  </p>
                        </div>
                        <div class="mt-4.5 md:mt-5.5 space-y-4.5 md:space-y-5.5">

                            <div class="order-point">
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
                                    <dl class="mile">
                                        <dt>잔여 마일리지</dt>
                                        <dd>${_mbrEtcInfoMap.totalMlg}</dd>
                                    </dl>
                                </div>
                                <div class="order-form">
                                    <dl>
                                        <dt>사용 마일리지</dt>
                                        <dd><input type="number" name="useMlg" value="0" data-max-mlg="${_mbrEtcInfoMap.totalMlg}" data-unique-id="${_mbrSession.uniqueId}" class="form-control numbercheck mlg_input"> 원</dd>
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
                                    <dl class="mile">
                                        <dt>잔여 마일리지</dt>
                                        <dd>${prtcr.mbrMlg}</dd>
                                    </dl>
                                </div>
                                <div class="order-form">
                                    <dl>
                                        <dt>사용 마일리지</dt>
                                        <dd><input type="number" name="useMlg" value="0" data-max-mlg="${prtcr.mbrMlg}" data-unique-id="${prtcr.mbrUniqueId}" class="form-control numbercheck mlg_input" readonly="readonly"> 원</dd>
                                    </dl>
                                </div>
                            </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="modal-footer modal-footer-gradient">
                        <button type="button" class="btn btn-refresh2 is-reverse f_mlg_reset">마일리지 초기화</button>
                        <button type="button" class="btn btn-point f_mlg_use">마일리지 적용</button>
                    </div>
                </div>
            </div>
        </div>
        </form>


        <script>
        function f_readonlyTrue(){
        	$("#frmMlg input[name='useMlg']").each(function(index){
				if(index > 0){
					$($("#frmMlg input[name='useMlg']")[index]).val(0);
					$($("#frmMlg input[name='useMlg']")[index]).prop("readonly", true);
				}
			});
        }
        $(function(){

        	mlgMap.forEach(function(value, key){
        		$("input[data-unique-id='"+ key +"']").val(value);
        		$("input[data-unique-id='"+ key +"']").prop("readonly", false);
        		$("input[data-unique-id='"+ key +"']").parents(".order-point").addClass("is-active");
        	})


			$("#frmMlg .f_mlg_reset").on("click", function(e){
				$("#frmMlg input[name='useMlg']").val(0);
			});

			$($("#frmMlg input[name='useMlg']")[0]).on("keyup", function(){
				let maxMlg = $(this).data("maxMlg");
				let mlg = $(this).val();
				if(maxMlg == mlg){
					$("#frmMlg input[name='useMlg']").prop("readonly", false);
				}else{
					f_readonlyTrue();
				}
				//console.log("내꺼", mlg);
			}).trigger("keyup");

			$("#frmMlg input[name='useMlg']").on("keyup", function(){
				let maxMlg = $(this).data("maxMlg");
				let mlg = $(this).val();
				//console.log("maxMlg", maxMlg, mlg);

				if(mlg > maxMlg){
					alert("사용 가능한 마일리지는 "+ maxMlg +"원 입니다.")
					$(this).val(maxMlg);
					$("#frmMlg input[name='useMlg']").prop("readonly", false);

				}else{
					if(mlg > 0){//사용
						$(this).parents(".order-point").addClass("is-active");
					}else{
						$(this).parents(".order-point").removeClass("is-active");
					}
				}

				// 본인 마일리지를 전부 사용했는지 확인
				let myMlg = $($("#frmMlg input[name='useMlg']")[0]).val();
				let myMaxMlg = $($("#frmMlg input[name='useMlg']")[0]).data("maxMlg");
				if(myMaxMlg > myMlg){

				}

			});

			$("#frmMlg input[name='useMlg']").on("focusout", function(){
				if($(this).val() == ''){
					$(this).val(0);
				}
			});

			$("#frmMlg .f_mlg_use").on("click", function(){

				mlgMap.clear();

				let totalMlg = 0;
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

				//console.log("mlgMap", mlgMap);
				//console.log("totalMlg", totalMlg, stlmAmt);

				if(0 < totalMlg && totalMlg < 100){
					alert("마일리지는 5,000원 이상부터 사용 가능합니다.");
				}else if(totalMlg > stlmAmt) {
					alert("결제금액("+ comma(stlmAmt) +") 보다 많은 마일리지를 입력하셨습니다.");

				}else{
					$(".payment-result .total-mlg-txt").text(comma(totalMlg));
					$("#frmOrdr #useMlg").val(comma(totalMlg));

					f_calStlmAmt();

					$("#mlg-modal .modal-close .btn-close").click();
				}


			});

        });
        </script>