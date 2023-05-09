<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<ul class="nav tab-list tab-full tab-sticky" id="scollspy">
                    <li><a href="#section1" role="button" class="nav-link active">기본정보</a></li>
                    <li><a href="#section2" role="button" class="nav-link">상품요약정보</a></li>
                    <li><a href="#section3" role="button" class="nav-link">가격/재고/배송비</a></li>
                    <li><a href="#section4" role="button" class="nav-link">배송/교환/반품</a></li>
                    <li><a href="#section5" role="button" class="nav-link">이미지</a></li>
                    <li><a href="#section6" role="button" class="nav-link">관련상품</a></li>
                    <li><a href="#section7" role="button" class="nav-link">기타사항</a></li>
                </ul>

                <form:form name="frmGds" id="frmGds" modelAttribute="gdsVO" method="post" action="./action" enctype="multipart/form-data" class="mt-7.5 relative">
                <form:hidden path="crud" />
                <form:hidden path="gdsNo" />

                <input type="hidden" name="cntPerPage" value="${param.cntPerPage}" />
                <input type="hidden" name="sortBy" value="${param.sortBy}" />
                <input type="hidden" name="srchGdsCd" value="${param.srchGdsCode}" />
                <input type="hidden" name="srchBnefCd" value="${param.srchBnefCode}" />
                <input type="hidden" name="srchItemCd" value="${param.srchItemCd}" />
                <input type="hidden" name="srchGdsTy" value="${param.srchGdsTy}" />
                <input type="hidden" name="srchUpCtgryNo" value="${param.srchUpCtgryNo}" />
                <input type="hidden" name="srchCtgryNo" value="${param.srchCtgryNo}" />
                <input type="hidden" name="srchDspyYn" value="${param.srchDspyYn}" />
                <input type="hidden" name="srchGdsNm" value="${param.srchGdsNm}" />
                <input type="hidden" name="srchGdsTag" value="${param.srchGdsTag}" />
                <input type="hidden" name="srchTarget" value="${param.srchTarget}" />
                <input type="hidden" name="srchText" value="${param.srchText}" />
                <input type="hidden" name="tempYn" value="${gdsVO.tempYn}" />

                <%--2023-03-23 더블 서브밋 방지 추가 --%>
                <double-submit:preventer tokenKey="preventTokenKey" />

                <input type="hidden" id="delThumbFileNo" name="delThumbFileNo" value="" />
				<input type="hidden" id="delImageFileNo" name="delImageFileNo" value="" />

                    <fieldset id="section1">
                        <legend class="text-title2">기본정보</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="gdsTy" class="require">상품구분</label></th>
                                    <td colspan="3">
                                        <form:select path="gdsTy" class="form-control w-50">
                                            <form:option value="" label="선택" />
                                        <c:forEach items="${gdsTyCode}" var="iem" varStatus="status">
                                            <form:option value="${iem.key}" label="${iem.value}" />
                                        </c:forEach>
                                        </form:select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="form-item1-2" class="require">카테고리</label></th>
                                    <td colspan="3">
                                        <div class="form-group">

                                            <form:select path="upCtgryNo" class="form-control w-50">
                                                <form:option value="0" label="선택" />
                                            	<c:forEach items="${gdsCtgryList}" var="ctgryList" varStatus="status">
                                            	<form:option value="${ctgryList.ctgryNo}" label="${ctgryList.ctgryNm}" />
                                                </c:forEach>
                                            </form:select>

                                            <form:select path="ctgryNo" class="form-control w-50">
                                                <form:option value="0" label="선택" />
                                            </form:select>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="gdsCd" class="require">상품관리코드</label></th>
                                    <td colspan="3">
                                        <div class="form-group">
                                        	${gdsVO.gdsCd}
                                            <form:hidden path="gdsCd" class="form-control w-70" maxlength="10" readonly="true" />
                                            <p class="ml-2">
                                                상품관리코드는 자동 생성됩니다.
                                            </p>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="itemCd">품목코드</label></th>
                                    <td colspan="3">
                                    	<form:input path="itemCd" class="form-control w-70" maxlength="10" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="gdsNm" class="require">상품명</label></th>
                                    <td colspan="3">
                                    	<form:input path="gdsNm" class="form-control w-full" maxlength="250" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="bnefCd">급여코드</label></th>
                                    <td colspan="3">
                                    	<form:input path="bnefCd" class="form-control w-70" maxlength="20" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="wrhsYmdNtcn">입고예정일 알림</label></th>
                                    <td colspan="3">
                                    	<form:input path="wrhsYmdNtcn" class="form-control w-70" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="mngrMemo">관리자메모</label></th>
                                    <td colspan="3">
										<form:input path="mngrMemo" class="form-control w-full" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="bassDc">기본설명</label></th>
                                    <td colspan="3">
										<form:input path="bassDc" class="form-control w-full" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="mtrqlt">재질</label></th>
                                    <td>
                                    	<form:input path="mtrqlt" class="form-control w-79" /></td>
                                    <th scope="row"><label for="wt">중량</label></th>
                                    <td>
                                    	<form:input path="wt" class="form-control w-70" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="size">사이즈상세정보</label></th>
                                    <td colspan="3">
                                    	<form:input path="size" class="form-control w-full" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="stndrd">규격</label></th>
                                    <td colspan="3"><form:input path="stndrd" class="form-control w-70" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="sortNo">출력순서</label></th>
                                    <td colspan="3">
                                        <div class="form-group">
                                        	<form:input type="number" path="sortNo" class="form-control w-25" min="0" />
                                            <p class="ml-2">숫자가 작을 수록 상위에 출력되며, 미입력시 자동으로 출력됩니다.</p>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="gdsTag0">상품태그</label></th>
                                    <td colspan="3">
                                        <p class="py-1">상품전시화면에 유형별로 출력할 때 사용합니다. 목록에서 유형별로 정렬할 때 체크된 것이 가장 먼저 출력됩니다.</p>
                                        <c:forEach items="${gdsTagCode}" var="iem" varStatus="status">
                                        <div class="form-check mr-4">
                                        	<form:checkbox cssClass="form-check-input" path="gdsTag" id="gdsTag${status.index}" value="${iem.key}"/>
                                            <label class="form-check-label" for="gdsTag${status.index}">${iem.value}</label>
                                        </div>
                                        </c:forEach>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="mkr">제조사</label></th>
                                    <td>
                                    	<form:select path="mkr" class="form-control w-70">
                                    		<form:option value="" label="선택" />
                                    		<c:forEach items="${mkrList}" var="mkr" varStatus="status">
                                            	<form:option value="${mkr.mkrNo}" label="${mkr.mkrNm}" />
                                                </c:forEach>
                                    	</form:select>
                                    	<%-- <form:input path="mkr" class="form-control w-70" /> --%>
                                    </td>
                                    <th scope="row"><label for=plor>원산지</label></th>
                                    <td>
                                    	<form:input path="plor" class="form-control w-70" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="brand">브랜드</label></th>
                                    <td>
                                        <form:select path="brand" class="form-control w-70">
                                    		<form:option value="" label="선택" />
                                    		<c:forEach items="${brandList}" var="brand" varStatus="status">
                                           	<form:option value="${brand.brandNo}" label="${brand.brandNm}" />
                                            </c:forEach>
                                    	</form:select>
                                    	<%-- <form:input path="brand" class="form-control w-70" /> --%>
                                    </td>
                                    <th scope="row"><label for="modl">모델</label></th>
                                    <td>
                                    	<form:input path="modl" class="form-control w-70" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="dspyYn0">상품 노출여부</label></th>
                                    <td colspan="3">
                                    	<div class="form-check-group">
	                                    	<c:forEach items="${dspyYnCode}" var="iem" varStatus="status">
	                                            <div class="form-check">
	                                            	<form:radiobutton cssClass="form-check-input" path="dspyYn" id="dspyYn${status.index}" value="${iem.key}"/>
	                                            	<label class="form-check-label" for="dspyYn${status.index}">${iem.value}</label>
	                                            </div>
	                                        </c:forEach>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <th scope="row"><label for="mlgUseYn0">마일리지 사용여부</label></th>
                                    <td>
                                        <div class="form-check-group">
                                        	<c:forEach items="${useYnCode}" var="iem" varStatus="status">
                                            <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="mlgUseYn" id="mlgUseYn${status.index}" value="${iem.key}"/>
                                            	<label class="form-check-label" for="mlgUseYn${status.index}">${iem.value}</label>
                                            </div>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <th scope="row"><label for="mlgPvsnYn0">마일리지 부여여부</label></th>
                                    <td>
                                        <div class="form-check-group">
                                        	<c:forEach items="${useYnCode}" var="iem" varStatus="status">
                                            <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="mlgPvsnYn" id="mlgPvsnYn${status.index}" value="${iem.key}"/>
                                            	<label class="form-check-label" for="mlgPvsnYn${status.index}">${iem.value}</label>
                                            </div>
                                            </c:forEach>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <th scope="row"><label for="couponUseYn0">쿠폰 사용여부</label></th>
                                    <td>
                                        <div class="form-check-group">
                                        	<c:forEach items="${useYnCode}" var="iem" varStatus="status">
                                            <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="couponUseYn" id="couponUseYn${status.index}" value="${iem.key}"/>
                                            	<label class="form-check-label" for="couponUseYn${status.index}">${iem.value}</label>
                                            </div>
                                            </c:forEach>
                                        </div>
                                    </td>
                                    <th scope="row"><label for="pointUseYn0">포인트 사용여부</label></th>
                                    <td>
                                        <div class="form-check-group">
                                        	<c:forEach items="${useYnCode}" var="iem" varStatus="status">
                                            <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="pointUseYn" id="pointUseYn${status.index}" value="${iem.key}"/>
                                            	<label class="form-check-label" for="pointUseYn${status.index}">${iem.value}</label>
                                            </div>
                                            </c:forEach>
                                        </div>
                                    </td>
                                </tr>

                                <tr>
                                    <th scope="row"><label for="form-item1-20">상품설명</label></th>
                                    <td colspan="3">
                                    	<form:textarea path="gdsDc" class="form-control w-full" title="내용" cols="30" rows="10" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>

                    <fieldset id="section2" class="mt-13">
                    	<legend class="text-title2">상품요약정보</legend>

                    	<div class="clear-both pt-4">
                            전자상거래 등에서의 상품 등의 정보제공에 관한 고시에 따라 총 35개 상품군에 대해 상품 특성 등을 양식에 따라 입력할 수 있습니다.
                        </div>
                        <div class="clear-both bg-gray2 p-5">
                        	상품군을 선택하면 자동으로 항목이 변환됩니다.
                        	<br>
                        	<div class="form-group">
                            <form:select path="ancmntTy" class="form-control w-90">
                            	<form:option value="" label="선택" />
                            	<c:forEach items="${gdsAncmntTyCode}" var="iem" varStatus="status">
                                <form:option value="${iem.key}" label="${iem.value}" />
                                </c:forEach>
                            </form:select>
                            </div>
                        </div>

						<jsp:include page="/WEB-INF/jsp/common/ancmnt_items.jsp" />

						<table class="table-detail" id="ancmntTable">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                            </tbody>
						</table>

                    </fieldset>

                    <fieldset id="section3" class="mt-13">
                        <legend class="text-title2">가격/재고</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="pc">판매가</label></th>
                                    <td>
                                        <div class="form-group">
                                        	<form:input type="number" path="pc" class="form-control w-50 numbercheck" maxlength="10" min="0"/>
                                            <span>원</span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="dscntRt">할인가</label></th>
                                    <td>
                                        <div class="form-group">
                                            <form:input type="number" path="dscntRt" class="form-control w-30 numbercheck" maxlength="3" min="0" />
                                            <span>%</span>
                                            <form:input type="number" path="dscntPc" class="form-control w-50 ml-6 numbercheck" maxlength="10" min="0" />
                                            <span>원</span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="bnefPc">급여가 / 대여가</label></th>
                                    <td>
                                        <div class="form-group">
                                        	<form:input type="number" path="bnefPc" class="form-control w-50 numbercheck" maxlength="10" min="0"/>
                                            <span>원</span>

                                            <span class="ml-6 mr-2">15%</span>
                                            <form:input type="number" path="bnefPc15" class="form-control w-25 numbercheck" maxlength="10" min="0"/>
                                            <span>원</span>

                                            <span class="ml-6 mr-2">9%</span>
                                            <form:input type="number" path="bnefPc9" class="form-control w-25 numbercheck" maxlength="10" min="0"/>
                                            <span>원</span>

                                            <span class="ml-6 mr-2">6%</span>
                                            <form:input type="number" path="bnefPc6" class="form-control w-25 numbercheck" maxlength="10" min="0"/>
                                            <span>원</span>
                                        </div>
                                    </td>
                                </tr>

                                <%-- <tr>
                                    <th scope="row"><label for="lendPc">대여가(월)</label></th>
                                    <td>
                                        <div class="form-group">
                                            <form:input type="number" path="lendPc" class="form-control w-50 numbercheck" maxlength="10" min="0"/>
                                            <span>원</span>
                                        </div>
                                    </td>
                                </tr> --%>

                                <tr>
                                    <th scope="row"><label for="lendDuraYn1">대여(내구연한설정)</label></th>
                                    <td>
                                        <div class="form-check mt-1">
                                            <form:checkbox cssClass="form-check-input" path="lendDuraYn" value="Y" />
                                            <label class="form-check-label" for="lendDuraYn1">사용</label>
                                        </div>
                                        <div class="form-group w-full">
                                            <label for="usePsbltyTrm" class="mr-2">사용가능햇수</label>
                                            <form:input path="usePsbltyTrm" class="form-control w-25" />
                                            <span>년</span>
                                        </div>
                                        <div class="form-group w-full mt-1">
                                            <label for="extnLendTrm" class="mr-2">연장대여햇수</label>
                                            <form:input path="extnLendTrm" class="form-control w-25" />
                                            <span>년</span>
                                            <i>/</i>
                                            <label for="extnLendPc" class="mr-2">월 대여금액</label>
                                            <form:input type="number" path="extnLendPc" class="form-control w-40 numbercheck" maxlength="10" min="0"/>
                                            <span>원</span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="soldoutYn0">상품 품절여부</label></th>
                                    <td>
                                        <div class="form-group">
                                            <div class="form-check-group">
												<c:forEach items="${ynCode}" var="iem" varStatus="status">
	                                            <div class="form-check">
	                                            	<form:radiobutton cssClass="form-check-input" path="soldoutYn" id="soldoutYn${status.index}" value="${iem.key}"/>
	                                            	<label class="form-check-label" for="soldoutYn${status.index}">${iem.value}</label>
	                                            </div>
	                                            </c:forEach>
                                            </div>
                                            <p class="ml-6">잠시 판매를 중단하거나 재고가 없을 경우에 체크해 놓으면 품절상품으로 표시됩니다.</p>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="stockQy">재고수량</label></th>
                                    <td>
                                        <div class="form-group">
                                            <form:input type="number" path="stockQy" class="form-control w-25 numbercheck" min="0"/>
                                            <span>개</span>
                                        </div>
                                    </td>
                                </tr>

								<%--<tr>
                                    <th scope="row"><label for="stockNtcnQy">재고통보수량</label></th>
                                    <td>
                                        <div class="form-group">
                                            <form:input path="stockNtcnQy" class="form-control w-25" />
                                            <span>개</span>
                                            <p class="ml-6">
                                                상품의 재고가 통보수량보다 작을 때 쇼핑몰 현황 재고부족상품에 표시됩니다.<br>
                                                옵션이 있는 상품은 개별 옵션의 통보수량이 적용됩니다.
                                            </p>
                                        </div>
                                    </td>
                                </tr> --%>

                                <tr>
                                    <th scope="row"><label for="form-item2=7">상품 옵션설정</label></th>
                                    <td>


                                    	<input type="hidden" id="optnTotalRow" name="optnTotalRow" value="${empty gdsVO.optnList?0:gdsVO.optnList.size()}" />
										<input type="hidden" id="delOptnNo" name="delOptnNo" value="" />

                                        <p class="py-1">
                                            옵션항목은 콤마(,) 로 구분하여 여러개를 입력할 수 있습니다. 예시) 라지,미디움,스몰<br>
                                            옵션명과 옵션항목에 따옴표(', ")는 입력할 수 없습니다.
                                        </p>
                                        <c:set var="optnTtl" value="${fn:split(gdsVO.optnTtl, '|')}" />
                                        <c:set var="optnVal" value="${fn:split(gdsVO.optnVal, '|')}" />

                                        <div class="form-group mt-3 w-full items-start">
                                            <div class="flex-1">
                                                <div class="form-group w-full">
                                                    <label for="optnTtl1" class="w-15">옵션 1</label>
                                                    <input type="text" class="form-control w-50 optcheck" name="optnTtl1" id="optnTtl1" value="${optnTtl[0]}" maxlength="200">
                                                    <label for="optnVal1" class="ml-6 w-21">옵션 1 항목</label>
                                                    <input type="text" class="form-control flex-1 optcheck" name="optnVal1" id="optnVal1" value="${optnVal[0]}" maxlength="200">
                                                </div>
                                                <div class="form-group w-full mt-1">
                                                    <label for="optnTtl2" class="w-15">옵션 2</label>
                                                    <input type="text" class="form-control w-50 optcheck" name="optnTtl2" id="optnTtl2" value="${optnTtl[1]}" maxlength="200">
                                                    <label for="optnVal2" class="ml-6 w-21">옵션 2 항목</label>
                                                    <input type="text" class="form-control flex-1 optcheck" name="optnVal2" id="optnVal2" value="${optnVal[1]}" maxlength="200">
                                                </div>
                                                <div class="form-group w-full mt-1">
                                                    <label for="optnTtl3" class="w-15">옵션 3</label>
                                                    <input type="text" class="form-control w-50 optcheck" name="optnTtl3" id="optnTtl3" value="${optnTtl[2]}" maxlength="200">
                                                    <label for="optnVal3" class="ml-6 w-21">옵션 3 항목</label>
                                                    <input type="text" class="form-control flex-1 optcheck" name="optnVal3" id="optnVal3" ${optnVal[2]} maxlength="200">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="text-center mt-3.5">
                                            <button class="btn-primary shadow f_optn_table_create" type="button">옵션 목록생성</button>
                                        </div>

										<div class="border border-gray3 overflow-auto h-73 mt-5" id="optnDiv" <c:if test="${gdsVO.optnList.size() < 1}">style="display:none;"</c:if>>
	                                        <table class="table-list" id="optnTable">
	                                            <colgroup>
	                                                <col class="w-15">
	                                                <col>
	                                                <col class="w-1/5">
	                                                <col class="w-1/5">
	                                                <col class="w-1/5">
	                                                <col class="w-1/5">
	                                            </colgroup>
	                                            <thead>
	                                                <tr>
	                                                    <th scope="col">
	                                                        <div class="form-check">
	                                                            <input class="form-check-input" type="checkbox" name="">
	                                                        </div>
	                                                    </th>
	                                                    <th scope="col">옵션</th>
	                                                    <th scope="col">추가금액</th>
	                                                    <th scope="col">재고수량</th>
	                                                    <th scope="col">사용여부</th>
	                                                    <th scope="col">품목코드</th>
	                                                </tr>
	                                            </thead>
	                                            <tbody>
	                                            	<c:forEach var="optnList" items="${gdsVO.optnList}" varStatus="status">
	                                                <tr class="optnTr">
					                					<td>
					                						<div class="form-check">
					                							<input type="hidden" name="optnNo${status.index}" value="${optnList.gdsOptnNo }">
					                							<input class="form-check-input" type="checkbox" name="arrOptnNo" value="${optnList.gdsOptnNo }">
					                						</div>
					                					</td>
					                					<td>
					                						${optnList.optnNm}
					                						<input type="hidden" name="optnNm${status.index}" value="${optnList.optnNm}"></td>
					                					<td><input type="number" name="optnPc${status.index}" value="${optnList.optnPc}" class="form-control w-full numbercheck" min="0"></td>
					                					<td><input type="number" name="optnStockQy${status.index}" value="${optnList.optnStockQy}" class="form-control w-full numbercheck" min="0"></td>
					                					<td>
					                						<select name="optUseYn${status.index}" class="form-control w-full">
					                							<option value="Y" ${optnList.useYn eq 'Y'?'selected="selected"':'' }>사용</option>
					                							<option value="N" ${optnList.useYn eq 'N'?'selected="selected"':'' }>미사용</option>
					                						</select>
					                					</td>
					                					<td><input type="text" name="optnItemCd${status.index}" value="${optnList.optnItemCd}" class="form-control w-full" maxlength="20" /></td>
					                				</tr>
	                                                </c:forEach>
	                                            </tbody>
	                                        </table>
                                        </div>

                                        <div class="text-left mt-3" id="optnDivBtn" <c:if test="${gdsVO.optnList.size() < 1}">style="display:none;"</c:if>>
                                            <button class="btn-primary shadow f_optnTableDelete" type="button">선택삭제</button>
                                        </div>

                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="form-item2-8">상품 추가옵션</label></th>
                                    <td>
										<c:set var="aditOptnTtl" value="${fn:split(gdsVO.aditOptnTtl, '|')}" />

                                    	<input type="hidden" id="aditOptnTotalRow" name="aditOptnTotalRow" value="${fn:length(aditOptnTtl) < 1?0:fn:length(aditOptnTtl)}" />
										<input type="hidden" id="aditOptnListCnt" name="aditOptnListCnt" value="${empty gdsVO.aditOptnList?0:gdsVO.aditOptnList.size()}" />
										<input type="hidden" id="delAditOptnNo" name="delAditOptnNo" value="" />

										<form:hidden path="aditOptnTtl" />


                                        <p class="py-1">
                                            옵션항목은 콤마(,) 로 구분하여 여러개를 입력할 수 있습니다. 예시) 라지,미디움,스몰<br>
                                            옵션명과 옵션항목에 따옴표(', ")는 입력할 수 없습니다.
                                        </p>

                                        <div class="form-group mt-3 w-full items-start">
                                            <div class="flex-1 aditOptnDummyWrap">
                                            	<!-- dummy html -->
												<div class="aditOptnDummy">
	                                                <div class="form-group w-full original" style="display:none;">
	                                                    <label for="aditOptnTtl{num}" class="w-15">옵션 {display-num}</label>
	                                                    <input type="text" class="form-control w-50 optcheck" name="aditOptnTtl{num}" id="aditOptnTtl{num}" maxlength="200">
	                                                    <label for="aditOptnVal{num}" class="ml-6 w-21">옵션 {display-num} 항목</label>
	                                                    <input type="text" class="form-control flex-1 optcheck" name="aditOptnVal{num}" id="aditOptnVal{num}" maxlength="200">
	                                                </div>
                                                </div>
                                                <c:forEach var="aditOptnTtl" items="${aditOptnTtl}" varStatus="status">
                                                	<c:set var="aditOptnVal" value="" />
                                                	<c:forEach var="aditOptnList" items="${gdsVO.aditOptnList}">
                                                		<c:set var="spAditOptnTtl" value="${fn:split(aditOptnList.optnNm, '*')}" />
                                                		<c:if test="${aditOptnTtl eq fn:trim(spAditOptnTtl[0])}">
                                                			<c:set var="aditOptnVal">
                                                				${empty aditOptnVal?fn:trim(spAditOptnTtl[1]):aditOptnVal.concat(',').concat(fn:trim(spAditOptnTtl[1]))}
                                                			</c:set>
                                                		</c:if>
													</c:forEach>

                                               	<div class="form-group w-full clone">
                                                    <label for="aditOptnTtl${status.index}" class="w-15">옵션 ${status.index+1}</label>
                                                    <input type="text" class="form-control w-50 optcheck" name="aditOptnTtl${status.index}" id="aditOptnTtl${status.index}" value="${aditOptnTtl}" maxlength="200">
                                                    <label for="aditOptnVal${status.index}" class="ml-6 w-21">옵션 ${status.index+1} 항목</label>
                                                    <input type="text" class="form-control flex-1 optcheck" name="aditOptnVal${status.index}" id="aditOptnVal${status.index}" value="${aditOptnVal}" maxlength="200">
                                                </div>
                                                </c:forEach>
                                            </div>

                                            <button type="button" class="btn-primary f_adit_optn_plus">옵션추가</button>
                                        </div>
                                        <div class="text-center mt-3.5">
                                            <button class="btn-primary shadow f_adit_optn_table" type="button">옵션 목록생성</button>
                                        </div>

										<div class="border border-gray3 overflow-auto h-73 mt-5" id="aditOptnDiv" <c:if test="${gdsVO.aditOptnList.size() < 1}">style="display:none;"</c:if>>
	                                        <table class="table-list mt-5" id="aditOptnTable">
	                                            <colgroup>
	                                                <col class="w-15">
	                                                <col>
	                                                <col>
	                                                <col class="w-1/5">
	                                                <col class="w-1/5">
	                                                <col class="w-1/5">
	                                                <col class="w-1/5">
	                                            </colgroup>
	                                            <thead>
	                                                <tr>
	                                                    <th scope="col">
	                                                        <div class="form-check">
	                                                            <input class="form-check-input" type="checkbox" name="">
	                                                        </div>
	                                                    </th>
	                                                    <th scope="col">옵션명</th>
	                                                    <th scope="col">옵션항목</th>
	                                                    <th scope="col">추가금액</th>
	                                                    <th scope="col">재고수량</th>
	                                                    <th scope="col">사용여부</th>
	                                                    <th scope="col">품목코드</th>
	                                                </tr>
	                                            </thead>
	                                            <tbody>
	                                            	<c:forEach var="aditOptnList" items="${gdsVO.aditOptnList}" varStatus="status">
	                                            	<c:set var="spAditOptnTtl" value="${fn:split(aditOptnList.optnNm, '*')}" />

	                                                <tr class="aditOptnTr">
			        	                				<td>
			        	                					<div class="form-check">
			        	                						<input type="hidden" name="aditOptnNo${status.index}" value="${aditOptnList.gdsOptnNo }">
			        	                						<input class="form-check-input" type="checkbox" name="arrAditOptnNo" value="${aditOptnList.gdsOptnNo }">
			        	                					</div>
			        	                				</td>
			        	                				<td>${spAditOptnTtl[0]}</td>
			        	                				<td>
			        	                					${spAditOptnTtl[1]}
															<input type="hidden" name="aditOptnNm${status.index}" value="${aditOptnList.optnNm}">
														</td>
			        	                				<td><input type="number" name="aditOptnPc${status.index}" value="${aditOptnList.optnPc}" class="form-control w-full numbercheck" min="0"></td>
			        	                				<td><input type="number" name="aditOptnStockQy${status.index}" value="${aditOptnList.optnStockQy}" class="form-control w-full numbercheck" min="0"></td>
			        	                				<td>
			        	                					<select name="aditOptUseYn${status.index}"  class="form-control w-full">
			        	                						<option value="Y" ${aditOptnList.useYn eq 'Y'?'selected="selected"':'' }>사용</option>
			        	                						<option value="N" ${aditOptnList.useYn eq 'N'?'selected="selected"':'' }>미사용</option>
			        	                					</select>
			        	                				</td>
			        	                				<td>
			        	                					<input type="text" name="aditOptnItemCd${status.index}" value="${aditOptnList.optnItemCd}" class="form-control w-full" maxlength="20"/>
			        	                				</td>
	        	                					</tr>
	        	                					</c:forEach>
	                                            </tbody>
	                                        </table>
                                        </div>
                                        <div class="text-left mt-3" id="aditOptnDivBtn" <c:if test="${gdsVO.aditOptnList.size() < 1}">style="display:none;"</c:if>>
                                            <button class="btn-primary shadow f_adit_optn_table_delete" type="button">선택삭제</button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>


                    <fieldset class="mt-13">
                        <legend class="text-title2">배송비</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="dlvyCtTy">배송비 유형</label></th>
                                    <td>
                                        <div class="form-group">
                                            <form:select path="dlvyCtTy" class="form-control w-50">
												<form:option value="" label="선택" />
	                                        <c:forEach items="${dlvyCostTyCode}" var="iem" varStatus="status">
	                                            <form:option value="${iem.key}" label="${iem.value}" />
	                                        </c:forEach>
                                            </form:select>
                                            <p class="ml-2">배송비 유형을 선택하면 자동으로 항목이 변환됩니다.</p>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="dlvy-ct-ty-tr" style="display:none;">
                                    <th scope="row"><label for="dlvyCtStlm">배송비 결제</label></th>
                                    <td>
                                        <form:select path="dlvyCtStlm" class="form-control w-50">
                                            <form:option value="" label="선택" />
                                        <c:forEach items="${dlvyPayTyCode}" var="iem" varStatus="status">
                                            <form:option value="${iem.key}" label="${iem.value}" />
                                        </c:forEach>
                                        </form:select>
                                    </td>
                                </tr>
                                <tr class="dlvy-ct-ty-tr" style="display:none;">
                                    <th scope="row"><label for="dlvyBassAmt">기본 배송료</label></th>
                                    <td>
                                        <div class="form-group">
                                            <form:input type="number" path="dlvyBassAmt" class="form-control w-50 numbercheck" min="0" />
                                            <span>원</span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="dlvyAditAmt">산간지역 추가 배송비</label></th>
                                    <td>
                                        <div class="form-group">
                                            <form:input type="number" path="dlvyAditAmt" class="form-control w-50 numbercheck" min="0" />
                                            <span>원</span>
                                            <p class="ml-6">도서산간지역 배송 요청 시 배송비용 추가 금액</p>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>

                    <!-- 배송/교환/반품 -->
                    <fieldset id="section4" class="mt-13">
                    	<legend class="text-title2">배송</legend>
                    	<table class="table-detail">
                    		<colgroup>
                                <col class="w-35">
                                <col class="w-35">
                                <col >
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">상품</th>
                                    <th scope="col">배송비</th>
                                    <th scope="col">내용</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row"><p>복지용구<br>(급여구매)</p></th>
                                    <th scope="row"><p>무료</p></th>
                                    <td rowspan="3">
                                        <form:textarea path="dlvyDc" class="form-control w-full" cols="30" rows="5" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>복지용구<br>(일반구매)</p></th>
                                    <th scope="row"><p>무료</p></th>
                                </tr>
                                <tr>
                                    <th scope="row"><p>일반상품</p></th>
                                    <th scope="row"><p>상품별 상이</p></th>
                                </tr>
                                <tr class="bot-border">
                                    <td colspan="2"></td>
                                    <td></td>
                                </tr>
                            </tbody>
                    	</table>

                    </fieldset>

                    <fieldset class="mt-13">
                    	<legend class="text-title2">
                    		교환/반품
                    	</legend>
                    	<table class="table-detail">
                            <colgroup>
                                <col class="w-35">
                                <col class="w-35">
                                <col >
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row" colspan="2"><p>공통</p></th>
                                    <td>
                                        <form:textarea path="dcCmmn" class="form-control w-full" cols="30" rows="5" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="rowgroup" rowspan="2"><p>무료<br> 교환/반품</p></th>
                                    <th scope="row"><p>복지용구<br> (급여구매)</p></th>
                                    <td rowspan="2">
                                        <form:textarea path="dcFreeSalary" class="form-control w-full" cols="30" rows="5" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>일반상품<br>(&amp;CMK)</p></th>
                                </tr>
                                <tr>
                                    <th scope="rowgroup" rowspan="3"><p>단순변심<br> 교환/반품</p></th>
                                    <th scope="row"><p>복지용구<br> (급여구매)</p></th>
                                    <td>
                                        <form:textarea path="dcPchrgSalary" class="form-control w-full" cols="30" rows="5" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>복지용구<br> (일반구매)</p></th>
                                    <td>
                                        <form:textarea path="dcPchrgSalaryGnrl" class="form-control w-full" cols="30" rows="5" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><p>일반상품<br>(&amp;CMK)</p></th>
                                    <td>
                                        <form:textarea path="dcPchrgGnrl" class="form-control w-full" cols="30" rows="2" />
                                    </td>
                                </tr>
                                <tr class="bot-border">
                                    <td colspan="2"></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>

                    <!-- 배송/교환/반품 -->

                    <fieldset id="section5" class="mt-13">
                        <legend class="text-title2">
                        	상품 이미지
                        	<span class="absolute left-full top-1 ml-2 whitespace-nowrap text-sm">
                        		권장 사이즈 : 썸네일 이미지 (285px * 359px), 상세 이미지 (1000px * 755px)
		                        <!--
								(<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
		                        목록 썸네일 : 285px x 359px
								상세 사진 : 1000px x 755px
		                          -->
                            </span>
                        </legend>
                        <!--
                        목록 썸네일 : 285px x 359px
						상세 사진 : 1000px x 755px
                          -->
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>

								<tr>
	                                <th scope="row"><label for="thumbFile" class="require">대표이미지</label></th>
	                                <td>
	                                	<c:if test="${not empty gdsVO.thumbnailFile.fileNo}">
										<div style="display:block;" id="thumbFileViewDiv${gdsVO.thumbnailFile.fileNo}">
											<img src="/comm/getImage?srvcId=GDS&amp;upNo=${gdsVO.thumbnailFile.upNo}&amp;fileTy=${gdsVO.thumbnailFile.fileTy }&amp;fileNo=${gdsVO.thumbnailFile.fileNo}&amp;thumbYn=Y" alt="썸네일 이미지" class="w-50" />
											<a href="/comm/getFile?srvcId=GDS&amp;upNo=${gdsVO.thumbnailFile.upNo }&amp;fileTy=${gdsVO.thumbnailFile.fileTy }&amp;fileNo=${gdsVO.thumbnailFile.fileNo }">
												${gdsVO.thumbnailFile.orgnlFileNm} (용량 : ${fnc:fileSize(gdsVO.thumbnailFile.fileSz)}, 다운로드 : ${gdsVO.thumbnailFile.dwnldCnt}회)</a>&nbsp;
											<a href="#f_delFile" onclick="f_delFile('${gdsVO.thumbnailFile.fileNo}', 'THUMB', '${gdsVO.thumbnailFile.fileNo}'); return false;"><i class="fa fa-trash"></i></a>
										</div>
										</c:if>

										<div id="thumbFileDiv" <c:if test="${not empty gdsVO.thumbnailFile.fileNo}">style="display: none;"</c:if>>
											<input type="file" id="thumbFile" name="thumbFile" onchange="f_fileCheck(this);" class="form-control w-full" accept="image/*"/>
										</div>
	                                </td>
	                            </tr>

							<c:forEach var="fileList" items="${gdsVO.imageFileList }" varStatus="status">
								<tr id="imageFileViewTr${fileList.fileNo}">
									<th scope="row"><label for="form-item3">이미지 ${status.index + 1 }</label></th>
									<td>
									<a href="/comm/getFile?srvcId=GDS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">
										${fileList.orgnlFileNm} (용량 : ${fnc:fileSize(fileList.fileSz)}, 다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;
									<a href="#f_delFile" onclick="f_delFile('${fileList.fileNo}', 'IMAGE', '${status.index}'); return false;"><i class="fa fa-trash"></i></a>
									</td>
								</tr>
							</c:forEach>

							<c:forEach begin="0" end="9" varStatus="status"><!-- 첨부파일 갯수 -->
								<tr id="imageFileInputTr${status.index}" <c:if test="${status.index < fn:length(gdsVO.imageFileList) }">style="display:none;"</c:if>>
									<th scope="row"><label for="imageFile${status.index}">이미지 ${status.index + 1}</label></th>
									<td>
									<input type="file" id="imageFile${status.index}" name="imageFile${status.index}" onchange="f_fileCheck(this);" class="form-control w-full" accept="image/*" />
									</td>
								</tr>
							</c:forEach>

							<tr>
								<th scope="row">동영상URL</th>
								<td>
									<div class="form-group">
										<form:input path="youtubeUrl" class="form-control w-100" maxlength="250" />
										<p class="ml-2">유튜브에 등록하신 동영상URL을 입력해 주세요</p>
									</div>
								</td>
							</tr>
                            </tbody>
                        </table>
                    </fieldset>

                    <fieldset id="section6" class="mt-13">
                        <legend class="text-title2">관련 상품</legend>
						<table class="table-detail mb-5">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">상품선택</th>
                                    <td>
                                    	<button type="button" class="btn-primary f_srchGds" data-bs-toggle="modal" data-bs-target="#gdsModal">상품선택하기</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

						<p>
			                상품목록
			            </p>
                        <table class="table-list" id="relGdsList">
                            <colgroup>
                                <col class="w-15">
                                <col>
                                <col>
                                <col>
                                <col>
                                <col>
                                <col>
                                <!-- <col> -->
                                <col class="w-15">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">
                                        -
                                    </th>
                                    <th scope="col">상품구분</th>
                                    <th scope="col">이미지</th>
                                    <th scope="col">상품코드</th>
                                    <th scope="col">상품명</th>
                                    <th scope="col">판매가</th>
                                    <th scope="col">급여가</th>
                                    <!-- <th scope="col">대여가</th> -->
                                    <th scope="col">-</th>
                                </tr>
                            </thead>
                            <tbody>
                            	<c:if test="${empty gdsVO.gdsRelList}">
                                <tr>
                                    <td colspan="8" class="no-data">등록된 관련상품이 없습니다.</td>
                                </tr>
                                </c:if>
                                <c:forEach items="${gdsVO.gdsRelList}" var="gdsRelList" varStatus="status">
	                    		<tr class="draggableTr">
	                    		    <td>
	                    				<button type="button" class="btn-danger tiny btn-relGds-remove"><i class="fa fa-trash"></i></button>
	                    				<input type="hidden" name="relGdsNo" value="${gdsRelList.relGdsNo}">
	                    		    </td>
	                    		    <td>${gdsTyCode[gdsRelList.gdsTy]}</td>
	                    			<td>
	                    				<c:choose>
	                    					<c:when test="${gdsRelList.fileNo > 0}">
	                    				<img style="max-width:120px;" src="/comm/getImage?srvcId=GDS&upNo=${gdsRelList.relGdsNo}&fileTy=THUMB&fileNo=${gdsRelList.fileNo}&thumbYn=Y">
	                    					</c:when>
	                    					<c:otherwise>
										no image
	                    					</c:otherwise>
	                    				</c:choose>
	                    			</td>
	                    		    <td>${gdsRelList.gdsCd}</td>
	                    		    <td>${gdsRelList.gdsNm}</td>
	                    		    <td>${gdsRelList.pc}</td>
	                    		    <td>${gdsRelList.bnefPc}</td>
			                        <!-- <td>${gdsRelList.lendPc}</td> -->
			                        <td class="draggable" style="cursor:pointer;">
			                    	 	<button type="button" class="btn-warning tiny"><i class="fa fa-arrow-down-up-across-line"></i></button>
			                        </td>
			                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>

                    </fieldset>

                    <fieldset id="section7" class="mt-13">
                        <legend class="text-title2">기타사항</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="aditGdsDc">추가상품설명</label></th>
                                    <td>
                                        <form:textarea path="aditGdsDc" class="form-control w-full" cols="30" rows="5" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="seoAuthor">검색엔진 최적화(SEO)</label></th>
                                    <td>
                                        <div class="form-group w-full">
                                            <label for="seoAuthor" class="w-37">메타태그1(Author)</label>
                                            <form:input path="seoAuthor" class="form-control flex-1" />
                                        </div>
                                        <div class="form-group w-full mt-1">
                                            <label for="seoDesc" class="w-37">메타태그2(Description)</label>
                                            <form:input path="seoDesc" class="form-control flex-1" />
                                        </div>
                                        <div class="form-group w-full mt-1">
                                            <label for="seoKeyword" class="w-37">메타태그3(Keywords)</label>
                                            <form:input path="seoKeyword" class="form-control flex-1" />
                                        </div>
                                        <p class="py-1 text-danger">* 키워드는 콤마(,)로 구분해서 입력해주세요.</p>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="form-item5-3">메모</label></th>
                                    <td>
                                        <form:textarea path="memo" class="form-control w-full" cols="30" rows="5" />
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>

                    <div class="btn-group sticky right !mt-4 save_btn_grp">
                    	<c:if test="${gdsVO.tempYn eq 'Y'}">
                    		<a href="/_mng/gds/gds/${gdsVO.upCtgryNo}/${gdsVO.ctgryNo}/${gdsVO.gdsCd}" target="_blank" class="btn-warning large shadow show-detail">미리보기</a>
						</c:if>
                    	<button type="button" class="btn-success large shadow tempSave">임시저장</button>
                        <button type="submit" class="btn-primary large shadow saveGds">저장</button>
                        <c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}&amp;srchGdsCd=${param.srchGdsCd}&amp;srchBnefCd=${param.srchBnefCd}&amp;srchGdsTy=${param.srchGdsTy}&amp;srchUpCtgryNo=${param.srchUpCtgryNo}&amp;srchCtgryNo=${param.srchCtgryNo}&amp;srchGdsNm=${param.srchGdsNm}&amp;srchGdsTag=${fn:replace(param.srchGdsTag, '|', '%7C')}" />
	                    <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
                    </div>
                </form:form>

                <%--
                	상품 모달
                	1. f_modalGdsSearch_callback 함수와 같이 사용할 것
                 --%>
                <c:import url="/_mng/gds/gds/modalGdsSearch" />

                <script>
                    let spyTarget = document.getElementById('container');
                    spyTarget.setAttribute('data-bs-spy', 'scroll');
                    spyTarget.setAttribute('data-bs-offset', '200');
                    spyTarget.setAttribute('data-bs-target', '#scrollspy');

                    function f_fileCheck(obj) {
                		if(obj.value != ""){
                			/* 첨부파일 확장자 체크*/
                			var file = obj.value;
	                		var fileExt = file.substring(file.lastIndexOf('.') + 1, file.length).toLowerCase();
	                		var reg = /gif|jpg|png/i;

	                		if(reg.test(fileExt) == false) {
	                			alert("상품이미지는 확장자가 gif, jpg, png로 된\n파일만 첨부 가능합니다.");
	                			obj.value = "";
	                			return false;
	                		}
                			/* 첨부파일 확장자 체크*/

                			/* 첨부파일 사이즈 체크*/
                			var uploadFileSize = 0;
                			var limitSize = 10;
                			var	uploadFileSize = (obj.files[0].size / 1024);

                			//메가바이트(MB)단위 변환
                			uploadFileSize = (Math.round((uploadFileSize / 1024) * 100) / 100);

                			if(limitSize != 0 && uploadFileSize > limitSize){
                				alert("파일 제한 사이즈("+ limitSize +"MB)를 초과하였습니다.\\n첨부파일 사이즈 "+ uploadFileSize +"MB");
                				obj.value = "";
                				return false;
                			}
                			/* 첨부파일 사이즈 체크*/
                		}
                	}

                    function f_delFile(fileNo, type, wrapNo){
                    	if(confirm("삭제하시겠습니까?")){
                    		if(type == "IMAGE"){
                    			if($("#delImageFileNo").val()==""){
                    				$("#delImageFileNo").val(fileNo);
                    			}else{
                    				$("#delImageFileNo").val($("#delImageFileNo").val()+","+fileNo);
                    			}
                    			$("#imageFileViewTr"+fileNo).remove();
                    			$("#imageFileInputTr"+wrapNo).show();
                    		}else{
                    			$("#delThumbFileNo").val(fileNo);
                    			$("#thumbFileViewDiv" + wrapNo).remove();
                    			$("#thumbFileDiv").show();
                    		}
                    	}
                    }

                    //상품타입코드
                	var gdsTyCode = {
                	<c:forEach items="${gdsTyCode}" var="iem" varStatus="status">
                	${iem.key} : "${iem.value}",
                    </c:forEach>
                    }

                    // 상품검색 콜백
                    function f_modalGdsSearch_callback(gdsNos){
                    	//console.log("callback: " + gdsNos);
                    	if($("#relGdsList tbody td").hasClass("no-data")){
                    		$("#relGdsList tbody tr").remove();
                    	}

                    	// 자신 번호도 추가x
                    	gdsNos = arrayRemove(gdsNos, ${gdsVO.gdsNo});
                   		// 중복된 상품이 있을 경우 추가x
                   		$("input[name='relGdsNo']").each(function(){
	                   		gdsNos = arrayRemove(gdsNos, $(this).val());
                   		});

                    	gdsNos.forEach(function(gdsNo){
                    		console.log('gdsNo', gdsNo);
                    		//console.log(gdsMap.get(parseInt(gdsNo)));
                    		var gdsJson = gdsMap.get(parseInt(gdsNo));
							//relGdsList
                    		var html = '';
                    		html += '<tr class="draggableTr">';
                    		html += '    <td>';
                    		html += '		<button type="button" class="btn-danger tiny btn-relGds-remove"><i class="fa fa-trash"></i></button>';
                    		html += '		<input type="hidden" name="relGdsNo" value="'+ gdsJson.gdsNo +'">';
                    		html += '    </td>';
                    		html += '    <td>'+ gdsTyCode[gdsJson.gdsTy] +'</td>';
                    		if(gdsJson.thumbnailFile != null){
                    			html += '    <td><img style="max-width:120px;" src="/comm/getImage?srvcId=GDS&upNo='+gdsJson.thumbnailFile.upNo+'&fileTy='+gdsJson.thumbnailFile.fileTy+'&fileNo='+gdsJson.thumbnailFile.fileNo+'&thumbYn=Y"></td>';
                    		}else{
                    			html += '    <td>no image</td>';
                    		}
                    		html += '    <td>'+ gdsJson.gdsCd +'</td>';
                    		html += '    <td>'+ gdsJson.gdsNm +'</td>';
                    		html += '    <td>'+ gdsJson.pc +'</td>';
                    		html += '    <td>'+ gdsJson.bnefPc +'</td>';
		                    //html += '    <td>'+ gdsJson.lendPc +'</td>';
		                    html += '    <td class="draggable" style="cursor:pointer;">';
		                    html += '	 	<button type="button" class="btn-warning tiny"><i class="fa fa-arrow-down-up-across-line"></i></button>';
		                    html += '    </td>';
		                    html += '</tr>';

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



                	//옵션+추가옵션
                	var AditOptnAct = {
                		add(){ //옵션추가
                			const cloneCnt = eval($("#aditOptnTotalRow").val());
                			var html = $(".aditOptnDummy").clone().html();
                			html = html.replace("original", "clone");
                			html = html.replace(/{num}/gi, cloneCnt);
                			html = html.replace(/{display-num}/gi, cloneCnt + 1);
                			$(".aditOptnDummyWrap").append(html);
                			if(cloneCnt === 0){
	                			$(".aditOptnDummyWrap .clone").css({"display":"", "marginTop":"0px"});
                			}else{
                				$(".aditOptnDummyWrap .clone").css({"display":""}).addClass("mt-1");
                			}
                			$("#aditOptnTotalRow").val(parseInt(cloneCnt) + 1);
                		},
                		addList(){ //옵션설정 생성
                			if($("#aditOptnTtl0").val().trim() == ""){ //1개는 필수
                				alert("추가 옵션명을 1개 이상 입력해주세요");
                				return;
                			}else if($("#aditOptnVal0").val().trim() == ""){
                				alert("추가 옵션항목을 1개 이상 입력해주세요");
                				return;
                			}else{

                				//reset (초기화)
                				//let arrAditOptnNos = $(":checkbox[name=arrAditOptnNo]").map(function(){return $(this).val();}).get();
                				//$("#delAditOptnNo").val(arrAditOptnNos);
                				$("#aditOptnTtl").val("");
                				$("#delAditOptnNo").val('<c:forEach var="aditOptnList" items="${gdsVO.aditOptnList}" varStatus="status">${aditOptnList.gdsOptnNo}${!status.last?',':''}</c:forEach>');
                				$("#aditOptnTable tbody tr").remove();

                				let objAditOptnTtl = $(".aditOptnDummyWrap .clone input[name^='aditOptnTtl']");
                				let objAditOptnVal = $(".aditOptnDummyWrap .clone input[name^='aditOptnVal']");
                				let html = "";
                				let cnt = 0;
                				objAditOptnTtl.each(function(index){
                					//console.log("objAditOptnTtl: ", $(this).val(), index);
                					let aditOptnTtl = $(this).val();
                					if($(this).val() != ""){
                						if($("#aditOptnTtl").val() ==""){
                            				$("#aditOptnTtl").val(aditOptnTtl);
                            			}else{
                            				$("#aditOptnTtl").val($("#aditOptnTtl").val()+"|"+aditOptnTtl);
                            			}
                						//console.log("objAditOptnVal: ", $(objAditOptnVal[index]).val());
                						var arrAditOptnVal = $(objAditOptnVal[index]).val().split(",");
                						arrAditOptnVal.forEach(function(aditOptnVal, index){
                							//console.log("index", index);
                							if(aditOptnVal != ""){
	                							html += '<tr class="aditOptnTr">';
	        	                				html += '	<td>';
	        	                				html += '		<div class="form-check">';
	        	                				html += '			<input type="hidden" name="aditOptnNo'+ cnt +'" value="0">';
	        	                				html += '			<input class="form-check-input" type="checkbox" name="arrAditOptnNo" value="0">';
	        	                				html += '		</div>';
	        	                				html += '	</td>';
	        	                				html += '	<td>'+ aditOptnTtl +'</td>';
	        	                				html += '	<td>'+ aditOptnVal +'<input type="hidden" name="aditOptnNm'+ cnt +'" value="'+ aditOptnTtl +' * '+ aditOptnVal +'"></td>';
	        	                				html += '	<td><input type="number" name="aditOptnPc'+ cnt +'" value="0" class="form-control w-full numbercheck" min="0"></td>';
	        	                				html += '	<td><input type="number" name="aditOptnStockQy'+ cnt +'" value="9999" class="form-control w-full numbercheck" min="0"></td>';
	        	                				html += '	<td>';
	        	                				html += '		<select name="aditOptUseYn'+ cnt +'"  class="form-control w-full">';
	        	                				html += '			<option value="Y">사용</option>';
	        	                				html += '			<option value="N">미사용</option>';
	        	                				html += '		</select>';
	        	                				html += '	</td>';
	        	                				html += '	<td><input type="text" name="aditOptnItemCd'+cnt+'" class="form-control w-full" maxlength="20"></td>';
	        	                				html += '</tr>';

	                							cnt = cnt + 1; //카운트용
                							}
                						});

                					}
                				});

                				$("#aditOptnListCnt").val(cnt);
                				$("#aditOptnTable tbody").append(html);
	                			$("#aditOptnDiv, #aditOptnDivBtn").css({"display":""});

                			}
                		},
                		removeList(){ //옵션설정 삭제
                			let arrAditOptnNos = $(":checkbox[name=arrAditOptnNo]:checked").map(function(){return $(this).val();}).get();
                			if(arrAditOptnNos==null||arrAditOptnNos.length==0) {
                    			alert("삭제할 추가 옵션 항목을 먼저 선택해주세요");
                    		}else{
                    			if($("#delAditOptnNo").val()==""){
                    				$("#delAditOptnNo").val(arrAditOptnNos);
                    			}else{
                    				$("#delAditOptnNo").val($("#delAditOptnNo").val()+","+arrAditOptnNos);
                    			}
                    			arrAditOptnNos.forEach(function(v){
                    				if(v == 0){
                    					$(":checkbox[name=arrAditOptnNo]:checked").parents(".aditOptnTr").remove();
                    				}else{
                    					$(":checkbox[name=arrAditOptnNo][value='"+ v +"']").parents(".aditOptnTr").remove();
                    				}
                    			});
                    		}
                		}
                	}


                    $(function(){
                    	var tempFlag = false;

                    	// 추가옵션
                    	// 추가 옵션항목 체크박스
                    	$("#aditOptnTable th :checkbox").click(function(){
			 				let isChecked = $(this).is(":checked");
			 				$("#aditOptnTable td :checkbox").prop("checked",isChecked);
			 			});
                    	$(".f_adit_optn_plus").on("click", function(e){
                    		e.preventDefault();AditOptnAct.add();
                    	});
                    	<c:if test="${empty gdsVO.aditOptnTtl}">
                    	AditOptnAct.add();
                    	</c:if>
                    	$(".f_adit_optn_table").on("click", function(e){
                    		e.preventDefault();AditOptnAct.addList();
                    	});
                    	$(".f_adit_optn_table_delete").on("click", function(e){
                    		e.preventDefault();AditOptnAct.removeList();
                    	});


                    	// 옵션 테이블 생성
                    	$(".f_optn_table_create").on("click", function(e){
                    		//e.preventDefault();

                    		if($("#optnTtl1").val().trim() == ""){ //1개는 필수
                				alert("옵션1 명을 입력해주세요");
                				return;
                			}else if($("#optnVal1").val().trim() == ""){
                				alert("옵션1 항목을 입력해주세요");
                				return;
                			}else{

                				//reset (기존자료 삭제) + tr 재생성
                				$("#delOptnNo").val('<c:forEach var="optnList" items="${gdsVO.optnList}" varStatus="status">${optnList.gdsOptnNo}${!status.last?',':''}</c:forEach>');
                				$("#optnTable tbody tr").remove();

                				let arrOptnNm = [];
                				let arrOptnVal1 = $("#optnVal1").val().split(",");
                				let arrOptnVal2 = $("#optnVal2").val().split(",");
                				let arrOptnVal3 = $("#optnVal3").val().split(",");

                				//console.log(arrOptnVal1.length, arrOptnVal2.length, arrOptnVal3.length);

                				// n^3
                				arrOptnVal1.forEach(function(optnVal1){ //option1
                					//console.log("o1", optnVal1);
                					if($("#optnVal2").val() != ""){
                						arrOptnVal2.forEach(function(optnVal2){ //option2
	                						if(optnVal2 != ""){
	                							if($("#optnVal3").val() != ""){
		                							arrOptnVal3.forEach(function(optnVal3){ //option3
		                								if(optnVal3 != ""){
		    	                							arrOptnNm.push(optnVal1 +" * "+ optnVal2 +" * "+ optnVal3);
		                								}
		                							});
	                							}else{
	                								arrOptnNm.push(optnVal1 +" * "+ optnVal2);
	                							}
	                						}
	                					});
                					}else{
                						arrOptnNm.push(optnVal1);
                					}
                				});


                				$("#optnTotalRow").val(arrOptnNm.length);
                				//console.log("arrOptnNm: ", arrOptnNm, arrOptnNm.length);

                				var html ='';
                				arrOptnNm.forEach(function(optnNm, index){
	                				html += '<tr class="optnTr">';
	                				html += '	<td>';
	                				html += '		<div class="form-check">';
	                				html += '			<input type="hidden" name="optnNo'+index+'" value="0">';
	                				html += '			<input class="form-check-input" type="checkbox" name="arrOptnNo" value="0">';
	                				html += '		</div>';
	                				html += '	</td>';
	                				html += '	<td>'+ optnNm +'<input type="hidden" name="optnNm'+index+'" value="'+ optnNm +'"></td>';
	                				html += '	<td><input type="number" name="optnPc'+index+'" value="0" class="form-control w-full numbercheck" min="0"></td>';
	                				html += '	<td><input type="number" name="optnStockQy'+index+'" value="9999" class="form-control w-full numbercheck" min="0"></td>';
	                				html += '	<td>';
	                				html += '		<select name="optUseYn'+index+'"  class="form-control w-full">';
	                				html += '			<option value="Y">사용</option>';
	                				html += '			<option value="N">미사용</option>';
	                				html += '		</select>';
	                				html += '	</td>';
	                				html += '	<td><input type="text" name="optnItemCd'+index+'" class="form-control w-full" maxlength="20"></td>';
	                				html += '</tr>';
                				});

	                			$("#optnTable tbody").append(html);
	                			$("#optnDiv, #optnDivBtn").css({"display":""});
                			}
                    	});

                    	// 옵션항목 체크박스
                    	$("#optnTable th :checkbox").click(function(){
			 				let isChecked = $(this).is(":checked");
			 				$("#optnTable td :checkbox").prop("checked",isChecked);
			 			});

                    	// 옵션항목 삭제
                    	$(".f_optnTableDelete").on("click", function(e){
                    		e.preventDefault();
                    		let arrOptnNos = $(":checkbox[name=arrOptnNo]:checked").map(function(){return $(this).val();}).get();
                    		//console.log("arrOptnNos", arrOptnNos);

                    		if(arrOptnNos==null||arrOptnNos.length==0) {
                    			alert("삭제할 옵션 항목을 먼저 선택해주세요");
                    		}else{
                    			if($("#delOptnNo").val()==""){
                    				$("#delOptnNo").val(arrOptnNos);
                    			}else{
                    				$("#delOptnNo").val($("#delOptnNo").val()+","+arrOptnNos);
                    			}

                    			arrOptnNos.forEach(function(v){
                    				if(v == 0){
                    					$(":checkbox[name=arrOptnNo]:checked").parents(".optnTr").remove();
                    				}else{
                    					$(":checkbox[name=arrOptnNo][value='"+ v +"']").parents(".optnTr").remove();
                    				}
                    			});
                    		}
                    	});

                    	// 고시정보
                    	let infoJson = eval('(${!empty gdsVO.ancmntInfo?gdsVO.ancmntInfo:'{}'})');
						$("#ancmntTy").on("change", function(){
							$("#ancmntTable tbody tr").remove();

							if($(this).val() != ""){
								var html = '';
		                    	$.each(item[$(this).val()].article, function(key, value){
		                    		//console.log("key", key, "value", value);
		                    		html += '<tr>';
	                				html += '	<th scope="row"><label for="article_ttl">'+ value[0] +'</label></th>';
	                				html += '	<td>';
	                				if(value[1] != ''){
	                					html += '	<p class="py-1">'+ value[1] +'</p>';
		                    		}
	                				html += '	<input type="hidden" name="article_ttl" value="'+ key +'">';
	                				html += '	<input type="text" class="form-control w-full" name="article_val" value="'+ (infoJson[key]==undefined?'상세설명페이지 참고':infoJson[key]) +'">';
	                				html += '	</td>';
	                				html += '</tr>';

		                    	});
		                    	$("#ancmntTable tbody").append(html);
							}

						}).trigger("change");

                    	$(document).on('keyup','.optcheck',function(){/** 옵션 input */
                    		$(this).val( $(this).val().replace(/[\'\"\|\*]/gi,"") );
                    	});


                    	//draggable js loading
                    	$.getScript("<c:url value='/html/core/vendor/draggable/draggable.bundle.js'/>", function(data,textStatus,jqxhr){
                    		if(jqxhr.status == 200) {
                    			Dragable.init();
                    		} else {
                    			console.log("draggable is load failed")
                    		}
                    	});

                    	//tinymce editor
                   		tinymce.overrideDefaults(baseConfig);
                   		tinymce.init({selector:"#gdsDc, #aditGdsDc, #memo, #dlvyDc, #dcCmmn, #dcFreeSalary, #dcPchrgSalary, #dcPchrgSalaryGnrl, #dcPchrgGnrl"});

                   		//배송비 유형
                   		$("#dlvyCtTy").on("change", function(){
                   			$("#dlvyCtStlm").val('');
                   			$("#dlvyBassAmt").val(0);
                   			$("#dlvyAditAmt").val(0);
                   			$(".dlvy-ct-ty-tr").hide();
							if($(this).val() == "PAY"){
								$(".dlvy-ct-ty-tr").show();
							}
                   		});//.trigger("change");
                   		if($("#dlvyCtTy").val() == "PAY"){
							$(".dlvy-ct-ty-tr").show();
						}


                   		//할인가 계산
                   		$("#pc, #dscntRt").on("change, keyup", function(){
	                   		 var price = $("#pc").val();
	                         var percent = $("#dscntRt").val();

	                         if(price != "" && price >= 1000){
		                         var dscnt_price = (price - (price * ( percent / 100 )) );
		                         console.log("할인금액: " + dscnt_price);
		                         dscnt_price = Math.round(dscnt_price/100) * 100; //10원단위 절사
		                         console.log("10원단위 절사: " + dscnt_price);
	                        	 $('#dscntPc').val(dscnt_price);
	                        }
                   		});

                   		//급여가 계산
                   		$("#bnefPc").on("change, keyup", function(){
	                   		 var price = $("#bnefPc").val();
	                         if(price != ""){
	                        	 //15%
	                        	 var a_price = price * ( 15 / 100 ) ;
		                         //var a_price = (price - (price * ( 15 / 100 )) );
		                         //a_price = Math.round(a_price/1000) * 1000; //100원단위 절사
	                        	 $('#bnefPc15').val(a_price);

	                        	 //9%
		                         var b_price = price * ( 9 / 100 );
	                        	 //var b_price = (price - (price * ( 9 / 100 )) );
		                         //b_price = Math.round(b_price/1000) * 1000; //100원단위 절사
	                        	 $('#bnefPc9').val(b_price);

	                        	 //6%
	                        	 var c_price = price * ( 6 / 100 );
		                         //var c_price = (price - (price * ( 6 / 100 )) );
		                         //c_price = Math.round(c_price/1000) * 1000; //100원단위 절사
	                        	 $('#bnefPc6').val(c_price);
	                        }
                  		});

						//상품유형 변경
                   		//data-rule-required="true" data-msg-required="급여코드 입력!!"
                   		$("#gdsTy").on("change", function(){
                   			if($(this).val() == "R"){//급여상품일 경우 급여코드, 급여가 필수로
                   				$("#bnefCd, #bnefPc").parents("tr").find("label").addClass("require");
                   				$("#bnefCd, #bnefPc").data("ruleRequired", true);
                   				$("#bnefCd").data("msgRequired", "급여상품일 경우 급여코드를 입력해주세요.");
                   				$("#bnefPc").data("msgRequired", "급여상품일 경우 급여가를 입력해주세요.");

                   			}else{
                   				$("#bnefCd, #bnefPc").parents("tr").find("label").removeClass("require");
                   				$("#bnefCd, #bnefPc").removeClass("is-invalid").data("ruleRequired", false);
                   				$("#bnefCd-error, #bnefPc-error").parent().remove();
                   			}
                   		});

						//상품 카테고리
						$("#upCtgryNo").on("change", function(){
							const ctgryNoVal = "${gdsVO.ctgryNo}";

							$("#ctgryNo").empty();
							$("#ctgryNo").append("<option value='0'>선택</option>");

							let upCtgryNoVal = $(this).val();
							if(upCtgryNoVal > 0){ //값이 있을경우만..
								$.ajax({
									type : "post",
									url  : "../ctgry/getGdsCtgryListByFilter.json",
									data : {upCtgryNo:upCtgryNoVal},
									dataType : 'json'
								})
								.done(function(data) {
									for(key in data){
										if(ctgryNoVal == key){
											$("#ctgryNo").append("<option value='"+ key +"' selected='selected'>"+ data[key] +"</option>");
										}else{
											$("#ctgryNo").append("<option value='"+ key +"'>"+ data[key] +"</option>");
										}
									}
								})
								.fail(function(data, status, err) {
									alert("카테고리 호출중 오류가 발생했습니다.");
									console.log('error forward : ' + data);
								});
							}
						}).trigger("change");


						// 상품검색 모달
						$(".f_srchGds").on("click", function(){
							if ( !$.fn.dataTable.isDataTable('#gdsDataTable') ) { //데이터 테이블이 있으면x
					 			GdsDataTable.init();
					 		}
						});

						// 관련상품 목록 삭제
						$(document).on("click", ".btn-relGds-remove", function(e){
							e.preventDefault();
							$(this).parents("tr").remove();
							if($("#relGdsList tbody tr").length < 1){
								$("#relGdsList tbody").append("<tr><td colspan='9' class='no-data'>등록된 관련상품이 없습니다.</td></tr>");
							}
						});

                    	$("form[name='frmGds']").validate({
                    	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
                    	    rules : {
                    	    	gdsTy		: { required : true}
                    	    	, ctgryNo   : { required : true, min:1}
                    	    	, gdsNm		: { required : true}
                    	    	, ancmntTy	: { required : true}
                    	    	, thumbFile : { required : function(element){ return $("#thumbFileDiv").css("display") == "block"; }}
                    	    	//, wt		: { required : true}
                    	    },
                    	    messages : {
                    	    	gdsTy 		: { required : "상품구분을 선택하세요"}
                    	    	, ctgryNo 	: { required : "카테고리를 선택하세요", min:"카테고리를 선택하세요"}
                    	    	, gdsNm 	: { required : "상품명을 입력하세요"}
                    	    	, ancmntTy 	: { required : "상품요약(고시)정보를 선택하세요."}
                    	    	, thumbFile : { required : "대표이미지는 필수 선택 항목 입니다."}
                    	    	//, wt	 	: { required : "중량을 입력하세요"}
                    	    },
                    	    submitHandler: function (frm) {
                    	    	if($("#aditOptnTtl0").val() == ''){
                    	    		$("#aditOptnTtl").val('');
                    	    	}
                    	    	if(tempFlag){
                    	    		if(confirm("임시 저장하시겠습니까?")){
                    	    			frm.submit();
                       	            	$(".saveGds").attr("disabled", "true");
                    	    		}else{
                    	    			return false;
                    	    		}
                    	    	}else{
                    	    		if (confirm('<spring:message code="action.confirm.save"/>')) {
                    	            	$("input[name='tempYn']").val("N");
                       	            	frm.submit();
                       	            	$(".saveGds").attr("disabled", "true");
                       	        	}else{
                       	        		return false;
                       	        	}
                    	    	}
                    	    }
                    	});

                    	//탭 클릭 이벤트
                    	$('.nav-link').on('click', function() {
                    		$('#container').scrollTop(($('#container').scrollTop() + $($(this).attr('href')).offset().top) - 180);
                    		$(this).addClass('active').parent().siblings().find('.nav-link').removeClass('active');
                    		return false;
                    	})

                    	// 임시 저장 이벤트
                    	$(".tempSave").on("click",function(){
                    		tempFlag = true;
                   			$("input[name='tempYn']").val("Y");
                       		$("#frmGds").submit();
                    	});


                    });
                </script>



