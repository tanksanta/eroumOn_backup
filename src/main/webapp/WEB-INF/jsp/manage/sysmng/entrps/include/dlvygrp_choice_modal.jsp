<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!-- 묶음배송 그룹 생성 -->
	
	<div class="modal fade divDlvyGrpChoice" id="divDlvyGrpChoice" tabindex="-1">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<p>묶음배송 그룹 선택</p>
					<input type="hidden" name="entrpsDlvygrpNo" id="entrpsDlvygrpNo" value="0" />
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
							<col>
							<col class="w-55">
							<col class="w-42">
						</colgroup>
						<thead>
							<tr>
								<th scope="col">묶음 그룹명</th>
								<th scope="col">배송비 계산방식</th>
								<th scope="col">선택</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${entrpsDlvyGrpList}" var="itemone" varStatus="status">
							<tr>
								<td >${itemone.entrpsDlvygrpNm}</td>
								<td >
									${dlvyCalcTyCode[itemone.dlvyCalcTy]}
								</td>
								<td >
									<div class="form-check">
										<input class="form-check-input" type="radio" 
												name="entrpsDlvygrpNo" value="${itemone.entrpsDlvygrpNo}" 
												entrpsDlvygrpNo="${itemone.entrpsDlvygrpNo}" entrpsNo="${itemone.entrpsNo}"
												entrpsDlvygrpNm="${itemone.entrpsDlvygrpNm}" 
												dlvyCalcTy="${itemone.dlvyCalcTy}" dlvyCalcTyNm="${dlvyCalcTyCode[itemone.dlvyCalcTy]}"
												useYn="${itemone.useYn}" dlvyAditAmt="${itemone.dlvyAditAmt}" >
									</div>
								</td>
							</tr>
							</c:forEach>
							
							<c:if test="${entrpsDlvyGrpList.size() < 1 }">
							<tr>
								<td colspan="3">등록된 데이터가 없습니다.</td>
							</tr>
							</c:if>
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn-primary large shadow btn f_confm_save">확인</button>
					<button type="button" class="btn-secondary large shadow" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
		
		<!-- // 묶음배송 그룹 생성 -->