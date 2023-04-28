<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<%--교환--%>

        <!-- 교환신청 -->
        <form name="frmOrdrExchng" id="frmOrdrExchng" method="post" enctype="multipart/form-data">
			<input type="hidden" id="ordrDtlNo" name="ordrDtlCd" value="${ordrDtlCd}">
			<input type="hidden" id="ordrNo" name="ordrNo" value="${ordrNo}">
        <div class="modal fade" id="ordr-exchng-modal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">교환신청</p>
                    </div>
                    <div class="modal-close">
                        <button type="button" data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">

					<div class="space-y-2.5 md:space-y-5">
                    <c:forEach items="${ordrDtlList}" var="ordrDtl" varStatus="status">
	                	<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

	                    <c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">
						<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
						<c:set var="ordrQy" value="${ordrDtl.ordrQy }" />
	                    <div class="order-product" ${ordrDtl.sttsTy ne 'OR08'?'style="display:none;"':''}>

	                    	<div class="order-header">
	                            <dl>
	                                <dt>주문번호</dt>
	                                <dd><strong>${ordrDtl.ordrDtlCd}</strong></dd>
	                            </dl>
	                        </div>

	                        <div class="order-body">

	                            <%-- 베네핏 바이어 --%>
								<c:if test="${!empty ordrDtl.recipterUniqueId}">
								<div class="order-buyer">
	                                <c:if test="${!empty ordrDtl.recipterInfo.proflImg}">
		                            <img src="/comm/proflImg?fileName=${ordrDtl.recipterInfo.proflImg}" alt="">
		                            </c:if>
	                                <strong>${ordrDtl.recipterInfo.mbrNm}</strong>
	                            </div>
	                            </c:if>

	                            <div class="order-item">
	                                <div class="order-item-thumb">
	                                    <c:choose>
											<c:when test="${!empty ordrDtl.gdsInfo.thumbnailFile }">
										<img src="/comm/getImage?srvcId=GDS&amp;upNo=${ordrDtl.gdsInfo.thumbnailFile.upNo }&amp;fileTy=${ordrDtl.gdsInfo.thumbnailFile.fileTy }&amp;fileNo=${ordrDtl.gdsInfo.thumbnailFile.fileNo }&amp;thumbYn=Y" alt="">
											</c:when>
											<c:otherwise>
										<img src="/html/page/market/assets/images/noimg.jpg" alt="">
											</c:otherwise>
										</c:choose>
	                                </div>
	                                <div class="order-item-content">
	                                	<div class="order-item-group">
			                                <div class="order-item-base">
			                                    <p class="code">
			                                        <span class="label-primary">
			                                            <span>${gdsTyCode[ordrDtl.gdsInfo.gdsTy]}</span>
			                                            <i></i>
			                                        </span>
			                                        <u>${ordrDtl.gdsInfo.gdsCd }</u>
			                                    </p>
			                                    <div class="product">
			                                        <p class="name">${ordrDtl.gdsInfo.gdsNm }</p>
			                                        <c:if test="${!empty spOrdrOptn[0]}">
			                                        <dl class="option">
			                                            <dt>옵션</dt>
			                                            <dd>
			                                            	<c:forEach items="${spOrdrOptn}" var="ordrOptn">
			                                                <span class="label-flat">${ordrOptn}</span>
			                                                </c:forEach>
			                                            </dd>
			                                        </dl>
			                                        </c:if>
			                                    </div>
			                                </div>
						</c:if>

						<c:if test="${ordrDtl.ordrOptnTy eq 'ADIT'}">
							<c:set var="sumOrdrPc" value="${sumOrdrPc + ordrDtl.ordrPc}" />

		                                    <div class="order-item-add">
		                                        <span class="label-outline-primary">
		                                            <span>${spOrdrOptn[0]}</span>
		                                            <i><img src="/html/page/market/assets/images/ico-plus-white.svg" alt=""></i>
		                                        </span>
		                                        <div class="name">
		                                            <p><strong>${spOrdrOptn[1]}</strong></p>
		                                            <p>수량 ${ordrDtl.ordrQy}개 (+<fmt:formatNumber value="${ordrDtl.ordrPc}" pattern="###,###" />원)</p>
		                                        </div>
		                                    </div>

						</c:if>

						<c:if test="${ordrDtlList[status.index+1].ordrOptnTy eq 'BASE' || status.last}">
										</div>

										<div class="order-item-count">
			                                <p><strong>${ordrQy}</strong>개</p>
			                            </div>
			                            <p class="order-item-price"><fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />원</p>

										<div class="order-item-info">
	                                        <div class="payment">
	                                        	<%-- 멤버스 --%>
	                                        	<c:if test="${!empty ordrDtl.bplcInfo}">
	                                        	<dl>
	                                                <dt>멤버스</dt>
	                                                <dd>${ordrDtl.bplcInfo.bplcNm}</dd>
	                                            </dl>
	                                            </c:if>
	                                            <dl>
	                                                <dt>배송비</dt>
	                                                <dd>
	                                                	<c:if test="${ordrDtl.gdsInfo.dlvyCtTy eq 'FREE'}">
	                                                	무료배송
	                                                	</c:if>
	                                                	<c:if test="${ordrDtl.gdsInfo.dlvyCtTy ne 'FREE'}">
	                                                	<fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyBassAmt}" pattern="###,###" />원
	                                                	</c:if>
	                                                </dd>
	                                            </dl>
	                                            <c:if test="${ordrDtl.gdsInfo.dlvyAditAmt > 0}">
	                                            <dl>
	                                                <dt>추가 배송비</dt>
	                                                <dd><fmt:formatNumber value="${ordrDtl.gdsInfo.dlvyAditAmt}" pattern="###,###" />원</dd>
	                                            </dl>
	                                            </c:if>
	                                        </div>
											<div class="status">
	                                        <%-- TO-DO : 주문상태에 따라 다름 --%>
	                                       	<c:choose>
	                                       		<c:when test="${ordrDtl.sttsTy eq 'OR07'}">
	                                            <dl>
	                                                <dt>배송중</dt>
	                                                <dd><fmt:formatDate value="${ordrDtl.sndngDt}" pattern="yyyy-MM-dd" /></dd>
	                                            </dl>
	                                            <c:set var="dlvyUrl" value="#" />
	                                            <c:forEach items="${dlvyCoList}" var="dlvyCoInfo" varStatus="status">
	                                            	<c:if test="${dlvyCoInfo.coNo eq ordrDtl.dlvyCoNo}">
	                                            	<c:set var="dlvyUrl" value="${dlvyCoInfo.dlvyUrl}" />
	                                            	</c:if>
	                                            </c:forEach>

	                                            <a href="${dlvyUrl}${ordrDtl.dlvyInvcNo}" target="_blank" class="btn btn-delivery">
	                                                <span class="name">
	                                                    <img src="/html/page/market/assets/images/ico-delivery.svg" alt="">
	                                                    ${ordrDtl.dlvyCoNm}
	                                                </span>
	                                                <span class="underline">${ordrDtl.dlvyInvcNo}</span>
	                                            </a>
	                                       		</c:when>
	                                       		<c:when test="${ordrDtl.sttsTy eq 'OR08'}"> <%-- 배송완료 --%>
	                                       		<div class="box-gray">
	                                                <p class="flex-1">배송완료</p>
	                                            </div>
	                                       		</c:when>
	                                       		<c:otherwise>
	                                       		<div class="box-gray">
	                                                <p class="flex-1">${ordrSttsCode[ordrDtl.sttsTy]}</p>
	                                            </div>
	                                       		</c:otherwise>
	                                       	</c:choose>
	                                        </div>
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </div>

	                	</c:if>

	                    </c:forEach>
	                    </div>

                        <p class="mt-5.5 md:mt-7 text-alert">주문상품과 동일한 상품/옵션으로 교환 가능하며, 다른 상품(옵션)으로 교환 시에는 <a href="${_marketPath}/etc/faq/list" class="font-bold underline">고객센터</a> 또는 <a href="${_marketPath}/etc/inqry/form" class="font-bold underline">1:1문의</a> 를 통해 문의해 주시기 바랍니다.</p>

                        <p class="text-lg font-bold mt-8 mb-2.5 md:mb-3 md:mt-10 md:text-xl">교환사유</p>
                        <div class="order-reason">
                            <select id="resnTy" name="resnTy" class="form-control w-75">
                                <option value="">교환사유를 선택해주세요.</option>
                            	<c:forEach items="${ordrExchngTyCode}" var="iem">
                                <option value="${iem.key}">${iem.value}</option>
                                </c:forEach>
                            </select>
                            <textarea id="resn" name="resn" class="form-control w-full mt-2.5" cols="30" rows="5" placeholder="상세사유를 200자 이내로 입력해주세요"></textarea>
                        </div>

                        <p class="text-lg font-bold mt-18 mb-2 md:mb-2.5 md:mt-24 md:text-xl">교환/반품 이용안내</p>
                        <p class="text-alert">교환/반품 사유가 구매자 책임인 경우 최초 발송 비용을 포함한 왕복 배송비가 부과될 수 있습니다.</p>
                        <table class="table-list mt-3 md:mt-4">
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col"><p class="text-center justify-center">교환/반품비용 <strong>구매자</strong> 부담</p></th>
                                    <th scope="col"><p class="text-center justify-center">교환/반품비용 <strong>쇼핑몰</strong> 부담</p></th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                        - 상품에 이상은 없으나 구매의사 없음<br>
                                        - 옵션을 잘못 선택함
                                    </td>
                                    <td>
                                        - 상품에 결함이 있음<br>
                                        - 도착한 상품이 상품상세 정보와 다름
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary btn-submit f_ordr_exchng_save">확인</button>
                        <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- //교환신청 -->
        </form>



        <script>
        $(function(){

        	$(".f_ordr_exchng_save").on("click", function(){
        		if($("#resnTy").val() == ""){
					alert("교환사유를 선택하세요");
        		}else {
        			if(confirm("선택하신 상품을 교환신청 하시겠습니까?")) {

		          		$.ajax({
		      				type : "post",
		      				url  : "${_marketPath}/mypage/ordr/ordrExchngRcpt.json",
		      				data : {
		      					ordrNo:'${ordrDtlList[0].ordrNo}'
		        				, ordrDtlCd:'${ordrDtlList[0].ordrDtlCd}'
		      					, resnTy:$("#resnTy").val()
								, resn:$("#resn").val()
		      				},
		      				dataType : 'json'
		      			})
		      			.done(function(data) {
		      				if(data.result){
		      					console.log("success");
		      					location.reload();
		      				}

		      			})
		      			.fail(function(data, status, err) {
		      				console.log('error forward : ' + data);
		      			});
        			}
        		}
       		});

        });

        </script>