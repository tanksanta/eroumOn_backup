<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form:form name="frmBplc" id="frmBplc" modelAttribute="bplcVO" method="post" action="./action" enctype="multipart/form-data">
	<!-- 검색조건 -->
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
	<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
	<input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" />
	<input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" />
	<input type="hidden" name="srchBplcId" id="srchBplcId" value="${param.srchBplcId}" />
	<input type="hidden" name="srchBplcNm" id="srchBplcNm" value="${param.srchBplcNm }" />
	<input type="hidden" name="srchRprsvNm" id="srchRprsvNm" value="${param.srchRprsvNm }" />
	<input type="hidden" name="srchBrno" id="srchBrno" value="${param.srchBrno }" />
	<input type="hidden" name="srchPicNm" id="srchPicNm" value="${param.srchPicNm }" />
	<input type="hidden" name="srchPicTelno" id="srchPicTelno" value="${param.srchPicTelno }" />
	<input type="hidden" name="srchAprvTy" id="srchAprvTy" value="${param.srchAprvTy }" />

	<form:hidden path="crud" />
	<form:hidden path="uniqueId" />

	<fieldset>
		<legend class="text-title2 relative">
			멤버스 ${bplcVO.crud eq 'CREATE'?'등록':'수정' } <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
			</span>
		</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="bplcId" class="require">아이디</th>
					<td>
						<div class="form-group w-90">
							<form:input path="bplcId" cssClass="form-control flex-1" autocomplete="off" maxlength="50" value="${bplcVO.bplcId}"/>
							<button type="button" class="btn-primary w-20" id="bplcId_checker">중복확인</button>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="bplcNm" class="require">기업명</th>
					<td><form:input path="bplcNm" class="form-control w-90" maxlength="100" value="${bplcVO.bplcNm}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="telno" class="require">전화번호</th>
					<td><form:input path="telno" class="form-control w-90" maxlength="15" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="fxno">팩스번호</th>
					<td><form:input path="fxno" class="form-control w-90" maxlength="15" /></td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 업체정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="brno" class="require">사업자등록번호</th>
					<td><form:input path="brno" class="form-control w-90" maxlength="12" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="rcperInstNo" class="require">장기요양기관번호</th>
					<td><form:input path="rcperInstNo" class="form-control w-90" maxlength="50" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="rprsvNm" class="require">대표자명</th>
					<td><form:input path="rprsvNm" class="form-control w-90" maxlength="100" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bizcnd" class="require">업태</th>
					<td><form:input path="bizcnd" class="form-control w-90" maxlength="100" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="iem" class="require">종목</th>
					<td><form:input path="iem" class="form-control w-90" maxlength="100" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bplcId" class="require">사업장주소</th>
					<td>
						<div class="form-group">
							<form:input path="zip" class="form-control w-50" />
							<button type="button" class="btn-primary w-30" onclick="f_findAdres('zip', 'addr', 'daddr'); return false;">우편번호 검색</button>
						</div> <form:input class="form-control w-full mt-1" path="addr" maxlength="200" /> <form:input class="form-control w-full mt-1" path="daddr" maxlength="200" /> <form:input class="form-control w-full" path="lat" /> <form:input class="form-control w-full" path="lot" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="dlvyZip" class="require">배송지주소</th>
					<td>
						<div class="form-group">
							<form:input path="dlvyZip" class="form-control w-50" />
							<button type="button" class="btn-primary w-30" onclick="f_findAdres('zip', 'addr', 'daddr'); return false;">우편번호 검색</button>
						</div> <form:input class="form-control w-full mt-1" path="dlvyAddr" maxlength="200" /> <form:input class="form-control w-full mt-1" path="dlvyDaddr" maxlength="200" />
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="taxbilEml" class="require">세금계산서 수신메일</th>
					<td><form:input path="taxbilEml" class="form-control w-90" maxlength="200" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bizrFile" class="require">사업자 등록증</th>
					<td><c:if test="${not empty bplcVO.bizrFile.fileNo}">
							<div style="display: block;" id="bizrFileViewDiv${bplcVO.bizrFile.fileNo}">
								<img src="/comm/getImage?srvcId=BPLC&amp;upNo=${bplcVO.bizrFile.upNo}&amp;fileTy=${bplcVO.bizrFile.fileTy }&amp;fileNo=${bplcVO.bizrFile.fileNo}&amp;bizrYn=Y" alt="사업자등록증" class="w-50" /> <a href="/comm/getFile?srvcId=BPLC&amp;upNo=${bplcVO.bizrFile.upNo }&amp;fileTy=${bplcVO.bizrFile.fileTy }&amp;fileNo=${bplcVO.bizrFile.fileNo }"> ${bplcVO.bizrFile.orgnlFileNm} (용량 : ${fnc:fileSize(bplcVO.bizrFile.fileSz)}, 다운로드 : ${bplcVO.bizrFile.dwnldCnt}회)</a>&nbsp; <a href="#f_delFile" onclick="f_delFile('${bplcVO.bizrFile.fileNo}', 'BIZR', '${bplcVO.bizrFile.fileNo}'); return false;"><i class="fa fa-trash"></i></a>
							</div>
						</c:if>

						<div id="bizrFileDiv" <c:if test="${not empty bplcVO.bizrFile.fileNo}">style="display: none;"</c:if>>
							<input type="file" id="bizrFile" name="bizrFile" onchange="f_fileCheck(this);" class="form-control w-full" accept="image/*" />
						</div></td>
				</tr>
				<tr>
					<th scope="row"><label for="offcsFile" class="require">사업자 직인</th>
					<td><c:if test="${not empty bplcVO.offcsFile.fileNo}">
							<div style="display: block;" id="offcsFileViewDiv${bplcVO.offcsFile.fileNo}">
								<img src="/comm/getImage?srvcId=BPLC&amp;upNo=${bplcVO.offcsFile.upNo}&amp;fileTy=${bplcVO.offcsFile.fileTy }&amp;fileNo=${bplcVO.offcsFile.fileNo}&amp;bizrYn=Y" alt="사업자등록증" class="w-50" /> <a href="/comm/getFile?srvcId=BPLC&amp;upNo=${bplcVO.offcsFile.upNo }&amp;fileTy=${bplcVO.offcsFile.fileTy }&amp;fileNo=${bplcVO.offcsFile.fileNo }"> ${bplcVO.offcsFile.orgnlFileNm} (용량 : ${fnc:fileSize(bplcVO.offcsFile.fileSz)}, 다운로드 : ${bplcVO.offcsFile.dwnldCnt}회)</a>&nbsp; <a href="#f_delFile" onclick="f_delFile('${bplcVO.offcsFile.fileNo}', 'BIZR', '${bplcVO.offcsFile.fileNo}'); return false;"><i class="fa fa-trash"></i></a>
							</div>
						</c:if>

						<div id="offcsFileDiv" <c:if test="${not empty bplcVO.offcsFile.fileNo}">style="display: none;"</c:if>>
							<input type="file" id="offcsFile" name="offcsFile" onchange="f_fileCheck(this);" class="form-control w-full" accept="image/*" />
						</div></td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 담당자정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="bplcId" class="require">담당자명</th>
					<td><form:input path="bplcId" class="form-control w-90" maxlength="100" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bplcNm" class="require">담당자 연락처</th>
					<td><form:input path="bplcNm" class="form-control w-90" maxlength="100" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="telno" class="require">담당자 이메일</th>
					<td><form:input path="telno" class="form-control w-90" maxlength="15" /></td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 정산정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="bplcId">은행</th>
					<td><form:input path="bplcId" class="form-control w-90" maxlength="100" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bplcNm">계좌번호</th>
					<td><form:input path="bplcNm" class="form-control w-90" maxlength="100" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="telno">예금주</th>
					<td><form:input path="telno" class="form-control w-90" maxlength="15" /></td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<fieldset class="mt-13">
		<legend class="text-title2 relative"> 등록정보 </legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="bplcId" class="require">등록일</th>
					<td><form:input path="bplcId" class="form-control w-90" maxlength="100" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bplcNm" class="require">사용여부</th>
					<td><form:input path="bplcNm" class="form-control w-90" maxlength="100" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="telno" class="require">추천멤버스</th>
					<td>
						<div class="form-check-group">
							<c:forEach items="${aprvTyCode}" var="aprvTy" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="aprvTy" id="aprvTy${status.index}" value="${aprvTy.key}" />
									<label class="form-check-label" for="aprvTy${status.index}">${aprvTy.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>


	<div class="btn-group right mt-8">

		<button type="button" class="btn-success large shadow">임시 비밀번호 발급</button>

		<button type="submit" class="btn-primary large shadow">저장</button>

		<c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage}&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}" />
		<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	</div>
</form:form>

<script>
                $(function(){

                });
                </script>