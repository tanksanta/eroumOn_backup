<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 주문진행 내역 --%>


			<!-- 주문진행내역 -->
            <div class="modal fade modal-inner" id="ordr-stts-hist-modal" tabindex="-1">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <p>주문진행내역</p>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                        </div>
                        <div class="modal-body">
                            <table class="table-detail">
                                <colgroup>
                                    <col class="w-32">
                                    <col>
                                    <col class="w-32">
                                    <col>
                                    <col class="w-32">
                                    <col>
                                </colgroup>
                                <tbody>

                                    <tr>
                                        <th scope="row">상품코드</th>
                                        <td><span class="badge-outline-success">${ordrDtlVO.gdsCd}</span></td>
                                        <th scope="row">상품/옵션정보</th>
                                        <td class="leading-tight">
                                            ${ordrDtlVO.gdsNm}<br>
                                            ${ordrDtlVO.ordrOptn}
                                        </td>
                                        <th scope="row">현재상태</th>
                                        <td>${ordrSttsCode[ordrDtlVO.sttsTy]}</td>
                                    </tr>

                                </tbody>
                            </table>
                            <table class="table-list mt-10 ordr-stts-list">
                                <colgroup>
                                    <col class="w-32">
                                    <col>
                                    <col class="w-55">
                                    <col class="w-42">
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">상태</th>
                                        <th scope="col">사유</th>
                                        <th scope="col">담당자 또는 주문자</th>
                                        <th scope="col">처리일</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:forEach items="${sttsChgHistList}" var="chgHist" varStatus="status">
                                    <tr>
                                        <td>${ordrSttsCode[chgHist.chgStts]}</td>
                                        <td>
                                        	<c:choose>
                                        		<c:when test="${chgHist.chgStts eq 'CA01'}"> <%--취소 사유--%>
                                        	[${ordrCancelTyCode[chgHist.resnTy]}]<br>
                                        		</c:when>
                                        		<c:when test="${chgHist.chgStts eq 'EX01'}"> <%--교환 사유--%>
                                        	[${ordrExchngTyCode[chgHist.resnTy]}]<br>
                                        		</c:when>
                                        		<c:when test="${chgHist.chgStts eq 'RE01'}"> <%--반품 사유--%>
                                        	[${ordrReturnTyCode[chgHist.resnTy]}]<br>
                                        		</c:when>
                                        	</c:choose>
                                        	${!empty chgHist.resn?chgHist.resn:'-'}
                                        </td>
                                        <td>${chgHist.regId} (${chgHist.rgtr})</td>
                                        <td><fmt:formatDate value="${chgHist.regDt}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    </tr>
                                    </c:forEach>
                                    <c:if test="${sttsChgHistList.size() < 1 }">
                                    <tr>
                                    	<td colspan="4">등록된 데이터가 없습니다.</td>
                                    </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn-secondary large shadow w-26" data-bs-dismiss="modal" aria-label="close">취소</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- //주문진행내역 -->

            <script>
            $(function(){
            	// foucs
            	$("#ordr-stts-hist-modal").on("shown.bs.modal", function () {
            		$(".btn-close").focus();
            	});

            	$(".ordr-stts-list").DataTable({
            		bFilter: false,
        			bInfo: false,
        			bSort : false,
        			bAutoWidth: false,
        			bLengthChange: false
            	});
            });

            </script>