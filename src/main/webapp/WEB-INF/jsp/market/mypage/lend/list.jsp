<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container" class="is-mypage">
		<jsp:include page="../../layout/page_header.jsp">
			<jsp:param value="대여조회" name="pageTitle"/>
		</jsp:include>

        <div id="page-container">

            <jsp:include page="../../layout/page_sidenav.jsp" />

			<div id="page-content">
				<jsp:include page="../../layout/mobile_userinfo.jsp" />

                <!-- 검색 -->
                <form id="searchFrm" name="searchFrm" method="get" action="./list" class="order-search mt-7.5 md:mt-9">
                    <p class="search-title">조회기간</p>
                    <div class="form-check-group search-left">
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="selPeriod" id="selPeriod1" value="1" ${param.selPeriod eq '1'?'checked="checked"':'' }>
                            <label class="form-check-label" for="selPeriod1">7일</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="selPeriod" id="selPeriod2" value="2" ${param.selPeriod eq '2'?'checked="checked"':'' }>
                            <label class="form-check-label" for="selPeriod2">1개월</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="selPeriod" id="selPeriod3" value="3" ${param.selPeriod eq '3'?'checked="checked"':'' }>
                            <label class="form-check-label" for="selPeriod3">6개월</label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="radio" name="selPeriod" id="selPeriod4" value="4" ${param.selPeriod eq '4'?'checked="checked"':'' }>
                            <label class="form-check-label" for="selPeriod4">1년</label>
                        </div>
                    </div>
                    <div class="search-right">
                        <input type="date" class="form-control form-calendar" id="srchOrdrYmdBgng" name="srchOrdrYmdBgng" value="${param.srchOrdrYmdBgng}">
                        <i>-</i>
                        <input type="date" class="form-control form-calendar" id="srchOrdrYmdEnd" name="srchOrdrYmdEnd" value="${param.srchOrdrYmdEnd}">
                        <button type="submit" class="btn btn-primary">조회</button>
                    </div>
                </form>
                <!-- //검색 -->

                <!-- 목록 -->
                <div class="mt-12 space-y-6 md:mt-16 md:space-y-7.5">
               		<c:if test="${empty listVO.listObject}">
                    <p class="box-result">대여중인 상품이 없습니다</p>
                	</c:if>

					<c:forEach items="${listVO.listObject}" var="ordrDtl" varStatus="status">
					<c:set var="pageParam" value="curPage=${listVO.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />

					<c:set var="spOrdrOptn" value="${fn:split(ordrDtl.ordrOptn, '*')}" />

					<c:if test="${ordrDtl.ordrOptnTy eq 'BASE'}">

					<c:set var="sumOrdrPc" value="${ordrDtl.ordrPc }" />
					<c:set var="ordrQy" value="${ordrDtl.ordrQy }" />

					<%-- 통합 주문 번호 --%>
					<c:if test="${status.first}">

                    <div class="order-product">
                        <div class="order-header">
                   			<c:if test="${ordrDtl.ordrTy eq 'R' || ordrDtl.ordrTy eq 'L'}">
								<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
								<c:if test="${!empty ordrDtl.bplcInfo}">
									<dl class="large">
										<dt>멤버스</dt>
										<dd>${ordrDtl.bplcInfo.bplcNm}</dd>
									</dl>
								</c:if>
							</c:if>
                            <dl>
                                <dt>주문번호</dt>
                                <dd><strong><a href="./view/${ordrDtl.ordrCd}?${pageParam}">${ordrDtl.ordrCd}</a></strong></dd>
                            </dl>
                            <dl>
                                <dt>주문일시</dt><%--주문/취소 --%>
                                <dd><fmt:formatDate value="${ordrDtl.ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" /></dd>
                            </dl>
                            <!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
                        </div>
                        <div class="order-body">
                        	<c:if test="${!empty ordrDtl.recipterUniqueId }">
							<%-- 베네핏 바이어 --%>
                            <div class="order-buyer">
                            	<c:if test="${!empty ordrDtl.recipterInfo.proflImg}">
	                            <img src="/comm/proflImg?fileName=${ordrDtl.recipterInfo.proflImg}" alt="">
	                            </c:if>
                                <strong>${ordrDtl.recipterInfo.mbrNm}</strong>
                            </div>
                            </c:if>
					</c:if>
					<%-- 통합 주문 번호 --%>


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
                                    <div class="order-item-group" style="min-height:160px;">
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

					<c:if test="${listVO.listObject[status.index+1].ordrOptnTy eq 'BASE' || status.last}">

                                    </div>
                                    <div class="order-item-count">
                                        <p><strong>${ordrQy}</strong>개</p>
                                        <%-- 배송 준비전 --%>
                                        <c:if test="${ordrDtl.sttsTy eq 'OR01' || ordrDtl.sttsTy eq 'OR04'}">
                                        <button type="button" class="btn btn-primary btn-small f_optn_chg" data-gds-no="${ordrDtl.gdsNo}" data-dtl-no="${ordrDtl.ordrDtlNo}" data-dtl-cd="${ordrDtl.ordrDtlCd}">변경</button>
                                        </c:if>
                                    </div>
                                    <p class="order-item-price">
                                    	<small style="font-size:.875rem; color:rgb(51 51 51/var(--tw-text-opacity));">대여가(월)</small>
                                    	<fmt:formatNumber value="${sumOrdrPc}" pattern="###,###" />원
                                    </p>
                                    <div class="order-item-info">
                                        <div class="payment">
                                        	<c:if test="${ordrDtl.ordrTy eq 'R' || ordrDtl.ordrTy eq 'L'}"><%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
                                        	<c:if test="${!empty ordrDtl.bplcInfo}">
                                            <dl>
                                                <dt>멤버스</dt>
                                                <dd>${ordrDtl.bplcInfo.bplcNm }</dd>
                                            </dl>
                                            </c:if>
                                            </c:if>
                                            <dl>
                                                <dt>결제일</dt>
                                                <dd>매월 ${ordrDtl.billingDay}일</dd>
                                            </dl>
                                            <dl>
                                                <dt>회차</dt>
                                                <dd>${ordrDtl.rebillInfo.ordrCnt}회차 (${fn:substring(ordrDtl.rebillInfo.stlmDt, 0, 10)}.${ordrDtl.rebillInfo.stlmYn eq 'Y'?'결제완료':'결제실패'})</dd>
                                            </dl>
                                        </div>
                                    </div>
                                </div>
                            </div>

                    <%-- 통합 주문 번호 --%>
					<c:if test="${status.last || (ordrDtl.ordrCd ne listVO.listObject[status.index+1].ordrCd )}">
                        </div>

						<c:set var="ordrCancelBtn" value="false" />
						<c:if test="${ordrDtl.cancelBtn > 0}">
						<c:set var="ordrCancelBtn" value="true" />
						</c:if>
                        <c:if test="${(ordrCancelBtn || ordrDtl.sttsTy eq 'OR08')}">
                        <div class="order-footer">
                        	<c:if test="${ordrCancelBtn}">
                        	<button type="button" class="btn btn-outline-primary btn-small f_ordr_rtrcn" data-ordr-cd="${ordrDtl.ordrCd}">주문취소</button>
                        	</c:if>
                        	<c:if test="${ordrDtl.sttsTy eq 'OR08'}">
                            <button type="button" class="btn btn-outline-primary btn-small f_ordr_return" data-ordr-cd="${ordrDtl.ordrCd}">반품신청</button>
                            </c:if>
                        </div>
                        </c:if>

                    </div>
                    </c:if>
                    <c:if test="${!status.last && ordrDtl.ordrCd ne listVO.listObject[status.index+1].ordrCd}">

                    <div class="order-product">
                        <div class="order-header">
								<c:if test="${listVO.listObject[status.index+1].ordrTy eq 'R' || listVO.listObject[status.index+1].ordrTy eq 'L'}">
									<%-- 급여구매일 경우만 경우만 멤버스(사업소) 있음 --%>
									<c:if test="${!empty listVO.listObject[status.index+1].bplcInfo}">
										<dl class="large">
											<dt>멤버스</dt>
											<dd>${listVO.listObject[status.index+1].bplcInfo.bplcNm}</dd>
										</dl>
									</c:if>
								</c:if>
								<dl>
                                <dt>주문번호</dt>
                                <dd><strong><a href="./view/${listVO.listObject[status.index+1].ordrCd}?${pageParam}">${listVO.listObject[status.index+1].ordrCd}</a></strong></dd>
                            </dl>
                            <dl>
                                <dt>주문일시</dt><%--주문/취소 --%>
                                <dd><fmt:formatDate value="${listVO.listObject[status.index+1].ordrDt}" pattern="yyyy.MM.dd HH:mm:ss" /><br></dd>
                            </dl>
                            <!-- <button type="button" class="f_all_rtrcn">전체취소</button> -->
                        </div>
                        <div class="order-body">
                        	<c:if test="${!empty listVO.listObject[status.index+1].recipterUniqueId }">
                        	<%-- 베네핏 바이어 --%>
                            <div class="order-buyer">
                                <c:if test="${!empty listVO.listObject[status.index+1].recipterInfo.proflImg}">
	                            <img src="/comm/proflImg?fileName=${listVO.listObject[status.index+1].recipterInfo.proflImg}" alt="">
	                            </c:if>
                                <strong>${listVO.listObject[status.index+1].recipterInfo.mbrNm}</strong>
                            </div>
                            </c:if>
					</c:if>
                    <%-- 통합 주문 번호 --%>
                    </c:if>
					</c:forEach>

                </div>

                <div class="pagination">
                    <front:paging listVO="${listVO}" />
                </div>
                <!-- //목록 -->

                <ul class="mt-10 md:mt-12 space-y-1 md:space-y-1.5">
                    <li class="text-alert">현재 대여중인 상품 목록입니다. 대여 종료 관련 요청은 ‘고객센터 &gt; 1:1문의’에 요청내용을 등록해주세요.</li>
                    <li class="text-alert">결제일은 최초 결제 일자이며 매월 동일한 일자에 결제가 진행됩니다. (결제일 변경 불가)</li>
                    <li class="text-alert">신용카드의 유효기간 만료, 한도초과 등으로 결제일 당일 결제 실패 시 익일 추가 결제가 진행됩니다.</li>
                    <li class="text-alert">최초 결제 수단(카드)으로 자동 결제되며, 결제카드 변경 요청은’ 고객센터 > 1:1문의’에 요청내용을 등록해주세요.</li>
                </ul>

            </div>
        </div>


    </main>



    <script>
    	$(function(){

    		$("input[name='selPeriod']").on("click, change", function(){
    			//console.log("v", $(this).val());
    			const v = $(this).val();
    			$("#srchOrdrYmdEnd").val(f_getToday());
    			if(v == "1"){//일주일
            		$("#srchOrdrYmdBgng").val(f_getDate(-7));
            	}else if(v == "2"){//한달
            		$("#srchOrdrYmdBgng").val(f_getDate(-30));
            	}else if(v == "3"){//6개월
            		$("#srchOrdrYmdBgng").val(f_getDate(-180));
            	}else if(v== "4"){//1년
               		$("#srchOrdrYmdBgng").val(f_getDate(-365));
            	}
    		});


    		$("#srchOrdrYmdBgng, #srchOrdrYmdEnd").on("click", function(){
    			$("input[name='selPeriod']").prop("checked", false);
    		});

    		// 주문취소 모달
    		$(document).on("click", ".f_ordr_rtrcn", function(){
    			const ordrCd = $(this).data("ordrCd");
        		$("#ordr-rtrcn").load("${_marketPath}/mypage/ordr/ordrRtrcn",
       				{ordrCd:ordrCd
        			}, function(){
            			$("#ordr-rtrcn-modal").modal('show');
        			});
        	});

    		//옵션변경 모달
        	$(document).on("click", ".f_optn_chg", function(){
        		const gdsNo = $(this).data("gdsNo");
        		const ordrDtlNo = $(this).data("dtlNo");
        		const ordrDtlCd = $(this).data("dtlCd");
        		$("#ordr-optn-chg").load("${_marketPath}/mypage/ordr/optnChg",
       				{ordrDtlNo:ordrDtlNo
            			, gdsNo:gdsNo
            			, ordrDtlCd:ordrDtlCd
        			}, function(){
            			$("#optn-chg-modal").modal('show');
        			});
        	});

        	// 구매확정 처리
			$(".f_ordr_done").on("click", function(e){
				e.preventDefault();
				var ordrNo = $(this).data("ordrNo");
				var dtlCd = $(this).data("dtlCd");
				var msg = $(this).data("msg");
				var resn = $(this).data("resn");

				if(confirm("구매확정 처리하시겠습니까?")){
					$.ajax({
	       				type : "post",
	       				url  : "${_marketPath}/mypage/ordr/ordrDone.json",
	       				data : {
	       					ordrNo:ordrNo
	       					, ordrDtlCd:dtlCd
	       					, resn:resn
	       				},
	       				dataType : 'json'
	       			})
	       			.done(function(data) {
	       				if(data.result){
	       					console.log("상태변경 : success");
	       					location.reload();
	       				}
	       			})
	       			.fail(function(data, status, err) {
	       				console.log('상태변경 : error forward : ' + data);
	       			});
				}
			});

    		// 교환신청
    		$(document).on("click", ".f_gds_exchng", function(){
    			const ordrNo = $(this).data("ordrNo");
        		const ordrDtlCd = $(this).data("dtlCd");
        		$("#ordr-exchng").load("${_marketPath}/mypage/ordr/ordrExchng",
        			{ordrNo:ordrNo, ordrDtlCd:ordrDtlCd
        			}, function(){
            			$("#ordr-exchng-modal").modal('show');
        			});
        	});

    		// 반품신청
    		$(document).on("click", ".f_ordr_return", function(){
    			const ordrCd = $(this).data("ordrCd");
        		$("#ordr-return").load("${_marketPath}/mypage/ordr/ordrReturn",
       				{ordrCd:ordrCd
        			}, function(){
            			$("#ordr-return-modal").modal('show');
        			});
        	});


    		// 승인반려 메세지
    		$(document).on("click", ".f_partners_msg", function(){
    			const ordrNo = $(this).data("ordrNo");
        		const ordrDtlNo = $(this).data("dtlNo");
        		$("#ordr-partners-msg").load("${_marketPath}/mypage/ordr/partnersMsg",
        			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo
        			}, function(){
            			$("#partners-msg").modal('show');
        			});
        	});

    		// 취소사유 메세지
    		$(document).on("click", ".f_rtrcn_msg", function(){
    			const ordrNo = $(this).data("ordrNo");
        		const ordrDtlNo = $(this).data("dtlNo");
        		const ordrDtlCd = $(this).data("dtlCd");
        		$("#ordr-rtrcn-msg").load("${_marketPath}/mypage/ordr/rtrcnMsg",
        			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo, ordrDtlCd:ordrDtlCd
        			}, function(){
            			$("#rtrcn-msg").modal('show');
        			});
        	});

    		// 교환사유 메세지
    		$(document).on("click", ".f_exchng_msg", function(){
    			const ordrNo = $(this).data("ordrNo");
        		const ordrDtlNo = $(this).data("dtlNo");
        		const ordrDtlCd = $(this).data("dtlCd");
        		$("#ordr-exchng-msg").load("${_marketPath}/mypage/ordr/exchngMsg",
        			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo, ordrDtlCd:ordrDtlCd
        			}, function(){
            			$("#exchng-msg").modal('show');
        			});
        	});

    		// 반품 메세지
    		$(document).on("click", ".f_return_msg", function(){
    			const ordrNo = $(this).data("ordrNo");
        		const ordrDtlNo = $(this).data("dtlNo");
        		const ordrDtlCd = $(this).data("dtlCd");
        		$("#ordr-return-msg").load("${_marketPath}/mypage/ordr/returnMsg",
        			{ordrNo:ordrNo, ordrDtlNo:ordrDtlNo, ordrDtlCd:ordrDtlCd
        			}, function(){
            			$("#return-msg").modal('show');
        			});
        	});
    	});
    </script>