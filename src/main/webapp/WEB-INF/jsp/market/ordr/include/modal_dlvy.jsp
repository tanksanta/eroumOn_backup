<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="/html/page/market/assets/script/order.js" ></script>
<script>var setMap = new Map();</script>
		<form:form id="dlvyFrm" name="dlvyFrm" method="post" action="/comm/dlvy/action" modelAttribute="dlvyVO">
		<form:hidden path="dlvyMngNo" />
		<input type="hidden" id="ordrDlvyCd" name="ordrDlvyCd" value="${ordrCd}" />

		<div class="modal modal-default fade" id="deliModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">배송지 목록</p>
                    </div>
                    <div class="modal-close">
                        <button type="button" data-bs-dismiss="modal" id="hide-btn">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs tabs is-small" id="tabs-tab" role="tablist">
                            <li class="nav-item" role="presentation"><a href="#tabs-delicont1" class="nav-link tabs-link active dlvylink" data-bs-toggle="pill" data-bs-target="#tabs-delicont1" role="tab" aria-selected="true">최근 배송지</a></li>
                            <li class="nav-item" role="presentation"><a href="#tabs-delicont2" class="nav-link tabs-link dlvylink" data-bs-toggle="pill" data-bs-target="#tabs-delicont2" role="tab" aria-selected="false">나의 주소록</a></li>
                            <c:if test="${fn:indexOf(path,'/mypage/') > 0}"><li class="nav-item" role="presentation"><a href="#tabs-delicont3" class="nav-link tabs-link dlvylink" data-bs-toggle="pill" data-bs-target="#tabs-delicont3" role="tab" aria-selected="false" id="newDlvy">새로운 주소</a></li></c:if>
                        </ul>
                        <div class="tab-content mt-3 md:mt-4">

                        	<!-- 최근 배송지 Start -->
                            <div class="tab-pane fade show active" id="tabs-delicont1" role="tabpanel">
                                <p class="text-alert">최근 배송지 중 주문에 사용할 배송지 정보를 선택해 주세요 (최대 5개까지 제공)</p>

                                <c:forEach var="resultList" items="${recentList}" varStatus="status">
                                <div class="order-delivery mt-3 md:mt-4 recentView">
                                <input type="hidden" name="myPkNo" class="recent-pk" value="${ordrCd}" />
                                <input type="hidden" name="myCurPath" class="recent-curpath" value="${path}" />
                                    <dl class="order-name">
                                        <dt>받는사람</dt>
                                        <dd class="recent-nm">${resultList.recptrNm}</dd>
                                    </dl>
                                    <div class="order-addr">
                                        <dl>
                                            <dt>연락처</dt>
                                            <dd>
                                                <strong  class="recent-mbl-telno">${resultList.recptrMblTelno}</strong>
                                            </dd>
                                            <input type="hidden" name="recentTelno" class="recent-telno" value="${resultList.recptrTelno}" />
                                        </dl>
                                        <dl>
                                            <dt>주소</dt>
                                            <dd>
                                                <address>
                                                    <strong class="recent-zip">${resultList.recptrZip}</strong>
                                                    <p class="recent-addr">${resultList.recptrAddr}</p>&nbsp;
                                                    <span class="recent-daddr">${resultList.recptrDaddr}</span>
                                                </address>
                                            </dd>
                                        </dl>
                                    </div>
                                    <label class="order-select">
                                        <input type="radio"  name="dlvyRadioBtn" />
                                        <span>선택</span>
                                    </label>
                                </div>
                                </c:forEach>
                                <c:if test="${empty recentList}"><p class="box-result mt-3 md:mt-4">최근 배송지가 없습니다.</p></c:if>
                            </div>
                            <!-- 최근 배송지 END -->

                            <!--  나의 주소록 Start -->
                            <div class="tab-pane fade" id="tabs-delicont2" role="tabpanel">
                                <p class="text-alert">최근 배송지 중 주문에 사용할 배송지 정보를 선택해 주세요 (최대 5개까지 제공)</p>
                                <c:forEach var="dlvyList" items="${dlvyList}" varStatus="status">
	                                <div class="order-delivery mt-3 md:mt-4 recentView">
	                                <input type="hidden" name="myPkNo" class="recent-pk" value="${ordrCd}" />
	                                <input type="hidden" name="myCurPath" class="recent-curpath" value="${path}" />
	                                    <dl class="order-name">
	                                        <dt>받는사람</dt>
	                                        <dd>
	                                        	<div class="recent-nm">${dlvyList.nm}</div>
	                                            <c:if test="${dlvyList.bassDlvyYn eq 'Y'}">
	                                            <span class="label-outline-primary">
	                                                <span>기본배송지</span>
	                                                <i></i>
	                                            </span>
	                                            </c:if>
	                                        </dd>
	                                    </dl>
	                                    <div class="order-addr">
	                                        <dl>
	                                            <dt>연락처</dt>
	                                            <dd>
	                                                <strong class="recent-mbl-telno">${dlvyList.mblTelno}</strong>
	                                            </dd>
	                                            <input type="hidden" name="telnos" class="recent-telno" value="${dlvyList.telno}" />
	                                        </dl>
	                                        <dl>
	                                            <dt>주소</dt>
	                                            <dd>
	                                                <address>
	                                                    <strong class="recent-zip">${dlvyList.zip}</strong>
	                                                    <p class="recent-addr">${dlvyList.addr}</p>&nbsp;
	                                                    <span class="recent-daddr">${dlvyList.daddr}</span>
	                                                </address>
	                                            </dd>
	                                        </dl>
	                                    </div>
	                                    <label class="order-select">
	                                        <input type="radio" name="dlvyRadioBtn">
	                                        <input type="hidden" name="memos" class="recent-memo" value="${dlvyList.memo}" />
	                                        <span>선택</span>
	                                    </label>
	                                </div>
                                </c:forEach>
                                <c:if test="${empty dlvyList}"><p class="box-result mt-3 md:mt-4">나의 배송지가 없습니다.</p></c:if>
                            </div>

                            <!--  나의 주소록 End -->

                            <!--  새로운 주소 Start -->
                            <div class="tab-pane fade" id="tabs-delicont3" role="tabpanel">
                                <table class="table-detail">
                                    <colgroup>
                                        <col class="w-22 md:w-40">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                        <tr class="top-border">
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="newNm"></label>받는 사람</p></th>
                                            <td>
                                                <form:input class="form-control w-57" id="newNm" path="nm" maxlength="50"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="newDlvyNm"></label>배송지 명</p></th>
                                            <td>
                                                <form:input class="form-control w-57" id="newDlvyNm" path="dlvyNm" maxlength="100" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="newMblTelno"></label>연락처</p></th>
                                            <td>
                                                <form:input class="form-control w-57" id="newMblTelno" path="mblTelno" maxlength="15" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="newTelno"></label>추가 연락처</p></th>
                                            <td>
                                                   <form:input type="text" class="form-control w-57" id="newTelno" path="telno" maxlength="15" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="deli-layer-item5"></label>주소</p></th>
                                            <td>
                                                <div class="form-group w-76">
                                                    <form:input class="form-control" id="newZip" path="zip" maxlength="5" />
                                                    <button type="button" class="btn btn-primary" id="deli-layer-item5" onclick="f_findAddres('newZip','newAddr','newDaddr'); return false;">우편번호 검색</button>
                                                </div>
                                                <form:input class="form-control mt-1.5 w-full md:mt-2" id="newAddr" path="addr" maxlength="100"/>
                                                <form:input class="form-control mt-1.5 w-full md:mt-2" id="newDaddr" path="daddr" maxlength="100" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="deli-item7"></label>배송 메시지</p></th>
                                            <td>
                                                <div class="flex flex-wrap">
                                                    <select name="" id="deli-item7" class="form-control w-full sm:w-50">
                                                        <option value="">배송 메시지</option>
														<option value="배송 전 연락 부탁드립니다">배송 전 연락 부탁드립니다</option>
														<option value="빠른 배송 부탁드립니다">빠른 배송 부탁드립니다</option>
														<option value="부재 시 경비실에 보관해 주세요">부재 시 경비실에 보관해 주세요</option>
													</select>
                                                    <form:input class="form-control w-full sm:flex-1 mt-1.5 sm:mt-0 sm:ml-2 sm:w-auto" id="newMemo" path="memo" maxlength="250"/>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="bot-border">
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!--  새로운 주소 end -->

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary btn-submit" onclick="f_dlvyRraw(setMap); return false;" id="subButton">확인</button>
                        <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
	</form:form>
        <script>

     // 주소검색 DAUM API
        function f_findAddres(zip, addr, daddr) {
        	$.ajaxSetup({ cache: true });
        	$.getScript( "//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js", function() {
        		$.ajaxSetup({ cache: false });
        		new daum.Postcode({
        			oncomplete: function(data) {
        				$("#"+zip).val(data.zonecode); // 우편번호
        				$("#"+addr).val(data.roadAddress); // 도로명 주소 변수
        				$("#"+daddr).focus(); //포커스
        	        }
        	    }).open();
        	});
        }

        $(function(){

        	const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;

        	$(".recentView").on("click",function(){
        		//선택 정보 담기
        		if($(this).hasClass("is-active")){
           			setMap = f_setInfo(this);
        		}
        	});

        	// 버튼 속성 change
        	$(".dlvylink").on("click",function(){
            	if($("#newDlvy").hasClass("active")){
            		$("#subButton").attr("type","submit");
            		$("#subButton").attr("onclick","");
            	}else{
            		$("#subButton").attr("type","button");
            		$("#subButton").attr("onclick","f_dlvyRraw(setMap); return false;");
            	}
        	});

        	//유효성

    	    $("form[name='dlvyFrm']").validate({
    		    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
    		    rules : {
    		    	dlvyNm		: { required : true}
    		    	, nm		: { required : true}
    		    	, mblTelno	: { required : true, regex : telchk}
    		    	, telno : {regex : telchk}
    		    	, zip		: { required : true}
    		    	, addr		: { required : true}
    		    	, daddr		: { required : true}
    		    },
    		    messages : {
    		    	dlvyNm		: { required : "! 배송지명을 입력해 주세요"}
    		    	, nm		: { required : "! 받는 사람을 입력해 주세요"}
    		    	, mblTelno	: { required : "! 휴대폰 번호를 입력해 주세요", regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"}
    		    	, telno  : {regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"}
    		    	, zip		: { required : "! 우편번호 검색을 해 주세요"}
    		    	, addr		: { required : "! 주소를 입력해 주세요"}
    		    	, daddr		: { required : "! 상세 주소를 입력해 주세요"}
    		    },
    		    errorElement:"p",
    		    errorPlacement: function(error, element) {
    			    var group = element.closest('.form-group, .form-check');
    			    if (group.length) {
    			        group.after(error.addClass('text-danger'));
    			    } else {
    			        element.after(error.addClass('text-danger'));
    			    }
    			},
    		    submitHandler: function (frm) {
    	            if (confirm('수정하시겠습니까?')) {
    	            	frm.submit();
    	        	}else{
    	        		return false;
    	        	}
    		    }
    		});

        });
        </script>