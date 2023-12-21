<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<!-- 묶음배송 그룹 생성 -->
	<form:form name="frmDlvyGrpAdd" id="frmDlvyGrpAdd" class="frmDlvyGrpAdd" method="post" enctype="multipart/form-data">
		<div class="modal fade divDlvyGrpAdd" id="divDlvyGrpAdd" tabindex="-1">
			<div class="modal-dialog modal-lg modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<p>묶음배송 그룹 생성</p>
						<input type="hidden" name="entrpsDlvygrpNo" id="entrpsDlvygrpNo" value="0" />
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
					</div>
					<div class="modal-body">
						<table class="table-detail">
							<colgroup>
								<col class="w-48">
                                <col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">입점업체</th>
									<td>
										<select name="entrpsList" id="entrpsList" class="form-control form-small w-full" disabled="true">							
												<option value="0">전체</option>
											<c:forEach items="${entrpsList.listObject}" var="resultList" varStatus="status">
												<option value="${resultList.entrpsNo}" >${resultList.entrpsNm}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<th scope="row">묶음 그룹명</th>
									<td><input type="text" id="entrpsDlvygrpNm" name="entrpsDlvygrpNm" class="form-control w-full" maxlength="50"></td>
								</tr>
								<tr>
									<th scope="row">배송비 계산방식</th>
									<td>
										<div class="flex flex-wrap items-end gap-4">
											<c:forEach items="${dlvyCalcTyCode}" var="dlvyCalcTy" varStatus="status">
												<div class="form-check">
													<input class="form-check-input" type="radio" name="dlvyCalcTy" id="dlvyCalcTy${status.index}" 
														value="${dlvyCalcTy.key}" 
														dlvyCalcTy="${dlvyCalcTy.key}" dlvyCalcTyNm="${dlvyCalcTyCode[dlvyCalcTy.key]}" dlvyCalcTyNm2="${dlvyCalcTy2Code[dlvyCalcTy.key]}"
														<c:if test="${dlvyCalcTy.key eq 'MAX' }">checked="checked"</c:if>>
													<label class="form-check-label" for="dlvyCalcTy${status.index}">${dlvyCalcTy.value}</label>
												</div>
											</c:forEach>
											
										</div>
										
									</td>
								</tr>
								<tr>
									<th scope="row">제주/도서산간 추가비용</th>
									<td>
										<input type="text" class="form-control w-full expire-no keycontrol numbercomma" name="dlvyAditAmt" value="0" maxlength="10" />
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="useYn">사용여부</label></th>
									<td>
										<div class="flex flex-wrap items-end gap-4">
											<c:forEach items="${useYnCode}" var="useYn" varStatus="status">
												<div class="form-check">
													<input class="form-check-input" type="radio" name="useYn" id="useYn${status.index}" value="${useYn.key}" useYnNm="${useYn.value}" <c:if test="${useYn.key eq 'Y' }">checked="checked"</c:if>>
													<label class="form-check-label" for="useYn${status.index}">${useYn.value}</label>
												</div>
											</c:forEach>
											
										</div>
										
									</td>
								</tr>

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
	</form:form>
		
		<!-- // 묶음배송 그룹 생성 -->