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
							<col class="w-26">
							<col>
							<col class="w-26">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">입점업체</th>
								<td>${entrpsVO.entrpsNm}</td>
								<th scope="row">그룹명</th>
								<td class="leading-tight flex">
									<input type="text" id="schEntrpsDlvygrpNm" name="schEntrpsDlvygrpNm" class="form-control" >
									<button type="button" class="btn-primary ml-1 btn f_search">검색</button>
								</td>
							</tr>

						</tbody>
					</table>
					<table class="table-list display mt-10 con-datatables">
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