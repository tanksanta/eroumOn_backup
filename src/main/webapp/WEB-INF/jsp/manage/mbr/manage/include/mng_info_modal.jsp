<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!-- 경고관리 내역 -->
		<div class="modal fade" id="modal1" tabindex="-1">
			<div class="modal-dialog modal-lg modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<p>변경 내역</p>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
					</div>
					<div class="modal-body">
						<ul class="nav tab-list">
							<li><a href="#modal-pane1" class="active" data-bs-toggle="pill" data-bs-target="#modifyModal" role="tab" aria-selected="true">경고내역</a></li>
							<li><a href="#modal-pane2" data-bs-toggle="pill" data-bs-target="#modal-pane2" role="tab" aria-selected="false">정지/해제 내역</a></li>
						</ul>
						<div class="tab-content mt-5">
							<div class="tab-pane fade show active" id="modifyModal" role="tabpanel">
								<table class="table-list">
									<colgroup>
										<col class="w-16">
										<col class="w-22">
										<col class="w-[25%]">
										<col>
										<col class="w-31">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">구분</th>
											<th scope="col">사유</th>
											<th scope="col">관리자메모</th>
											<th scope="col">변경일/처리자명</th>
										</tr>
									</thead>
									<tbody>
											<c:forEach var="resultList" items="${mdfrList}" varStatus="status">
											<tr>
												<td>${status.index +1}</td>
												<td>${warningCode[resultList.mngSe]}</td>
												<td>
													<c:if test="${resultList.resnCd ne 'CS'}">${resnCdCode[resultList.resnCd]}</c:if>
													<c:if test="${resultList.resnCd eq 'CS'}">고객 요청 </c:if>
												</td>
												<td>${resultList.mngrMemo ne null ? resultList.mngrMemo : '-'}</td>
												<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></br><fmt:formatDate value="${resultList.regDt}" pattern="HH:mm:ss" /></br>${resultList.rgtr} </td>
											</tr>
											</c:forEach>
											<c:if test="${empty mdfrList}"><td class="noresult" colspan="5">변경 내역이 없습니다.</td></c:if>
									</tbody>
								</table>
							</div>


							<div class="tab-pane fade" id="modal-pane2" role="tabpanel">
								<table class="table-list">
									<colgroup>
										<col class="w-16">
										<col class="w-22">
										<col class="w-[18%]">
										<col>
										<col class="w-28">
										<col class="w-31">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">구분</th>
											<th scope="col">사유</th>
											<th scope="col">관리자메모</th>
											<th scope="col">정지기간</th>
											<th scope="col">변경일/처리자명</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="result" items="${blackList}" varStatus="stts">
											<tr>
												<td>${stts.index +1}</td>
												<td>${blackCode[result.mngSe]}</td>
												<td>
													<c:if test="${result.resnCd ne 'CS'}">${blackResnCdCode[result.resnCd]}</c:if>
													<c:if test="${result.resnCd eq 'CS'}">고객 요청 </c:if>
												</td>
												<td>${result.mngrMemo ne null ? result.mngrMemo : '-'}</td>
												<td>
													<c:if test="${result.mngSe eq 'PAUSE' }">
														<fmt:formatDate value="${result.stopBgngYmd}" pattern="yyyy-MM-dd" />
														~<br>
														<fmt:formatDate value="${result.stopEndYmd}" pattern="yyyy-MM-dd" />
													</c:if>
													<c:if test="${result.mngSe ne 'PAUSE' }">
														-
													</c:if>
												</td>
												<td><fmt:formatDate value="${result.regDt}" pattern="yyyy-MM-dd" /><br> <fmt:formatDate value="${result.regDt}" pattern="HH:mm:ss" /><br> ${result.regId}
												</td>
											</tr>
										</c:forEach>
										<c:if test="${empty blackList}"><td class="noresult" colspan="6">변경 내역이 없습니다.</td></c:if>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- //경고관리 내역 -->