<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form:form name="frmEntrps" id="frmEntrps" modelAttribute="entrpsVO" method="post" action="./action">
		<form:hidden path="entrpsNo" />
		<form:hidden path="crud" />

		<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />
		<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
		<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn}" />
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
		<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />

		<fieldset>
			<legend class="text-title2">입점업체 기본정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="form-item1" class="require">입점업체명</label></th>
						<td>
							<div class="form-group w-90">
								<form:input class="form-control flex-1" path="entrpsNm" maxlength="40" />
								<button type="button" class="btn-primary w-20" data-bs-toggle="modal" data-bs-target="#modal1">검색</button>
							</div>
							<!-- <div class="alert alert-danger fade show">
								<p class="moji">:(</p>
								<p class="text">이미 사용중인 업체명입니다.</p>
								<button type="button" data-bs-dismiss="alert" aria-label="close">닫기</button>
							</div>

							<div class="alert alert-success fade show">
								<p class="moji">:)</p>
								<p class="text">사용 가능한 업체명입니다.</p>
								<button type="button" data-bs-dismiss="alert" aria-label="close">닫기</button>
							</div> -->
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="brno" class="require">사업자번호</label></th>
						<td><form:input class="form-control w-90" path="brno" value="${entrpsVO.brno}" maxlength="10" placeholder="- 없이 입력해주세요."/></td>
					</tr>
					<tr>
						<th scope="row"><label for="rprsvNm" class="require">대표자명</label></th>
						<td><form:input class="form-control w-90" path="rprsvNm" value="${entrpsVO.rprsvNm }" maxlength="40"  /></td>
					</tr>
					<tr>
						<th scope="row"><label for="induty" class="require">업태/업종</label></th>
						<td>
							<div class="form-group">
								<form:input class="form-control w-40" path="bizcnd" maxlength="30" /> <form:input type="text" class="form-control w-49" path="induty" maxlength="30"/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item1-5" class="require">사업자 주소</label></th>
						<td>
							<div class="form-group">
								<form:input path="zip" class="form-control w-50" />
								<button type="button" class="btn-primary w-30" onclick="f_findAdres('zip', 'addr', 'daddr'); return false;">우편번호 검색</button>
							</div>
							<form:input class="form-control w-full mt-1" path="addr" />
							<form:input class="form-control w-full mt-1" path="daddr" maxlength="40"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item1-6" class="require">사업자 전화번호</label></th>
						<td>
							<div class="form-group w-90">
								<form:input class="form-control flex-1" path="telno" value="${entrpsVO.telno}" maxlength="15" placeholder="-을 포함해주세요."/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item1-7">사업자 팩스번호</label></th>
						<td>
							<div class="form-group w-90">
								<form:input type="tel" class="form-control flex-1" path="fxno" value="${entrpsVO.fxno}" maxlength="15" placeholder="-을 포함해주세요."/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item1-8">대표 이메일</label></th>
						<td>
							<div class="form-group w-90">
								<form:input class="form-control flex-1" path="eml" value="${entrpsVO.eml}" maxlength="40"/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item1-9">담당 MD</label></th>
						<td><select name="" id="form-item1-9" class="form-control w-90">
								<option value="">선택</option>
						</select></td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item1-10" class="require">상태</label></th>
							<td>
								<div class="form-group">
									<div class="form-check-group">
										<c:forEach var="sttus" items="${useYn}">
											<div class="form-check">
												<form:radiobutton path="useYn" class="form-check-input" id="${sttus.value}" value="${sttus.key}" />
												<label class="form-check-label" for="${sttus.value}">${sttus.value}</label>
											</div>
										</c:forEach>
									</div>
								</div>
							</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<fieldset class="mt-13">
			<legend class="text-title2">배송비 정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="form-item2" class="require">배송비 무료조건</label></th>
						<td>
							<div class="form-group">
								<span class="mr-2">주문금액</span> <form:input type="number" class="form-control w-42" path="dlvyCtCnd" min="0"/> <span>원 이상</span>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item3" class="require">기본 배송비</label></th>
						<td>
							<div class="form-group">
								<form:input type="number" class="form-control w-42" path="dlvyBaseCt" min="0"/>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<fieldset class="mt-13">
			<legend class="text-title2">정산/계약 정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="clclnCycle" class="require">정산주기</label></th>
						<td><form:select path="clclnCycle" class="form-control w-90" >
								<option value="">선택</option>
								<c:forEach var="cycle" items="${cycle}">
									<form:option value="${cycle.key}">${cycle.value}</form:option>
								</c:forEach>
						</form:select></td>
					</tr>
					<tr>
						<th scope="row"><label for="bankNm" class="require">은행/계좌번호/예금주</label></th>
						<td>
							<div class="form-group" style="width:550px;">
								<form:select path="bankNm" class="form-control w-32" >
								<option value="">선택</option>
								<c:forEach var="bank" items="${bank}">
									<form:option value="${bank.key}">${bank.value}</form:option>
								</c:forEach>
								</form:select>
								<form:input class="form-control flex-2" path="actno" placeholder="-을 포함해주세요"/>
								<form:input class="form-control flex-1" path="dpstr" maxlength="15" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="ctrtBgngYmd">계약기간</label></th>
						<td>
							<div class="form-group">
								<form:input type="date" class="form-control w-42 calendar" path="ctrtBgngYmd" /> <i>~</i> <form:input type="date" class="form-control w-42 calendar" path="ctrtEndYmd" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="ctrtYmd">계약일</label></th>
						<td><form:input type="date" class="form-control w-42 calendar" path="ctrtYmd" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="fee">수수료</label></th>
						<td>
							<div class="form-group">
								<form:input type="number" class="form-control w-42" path="fee" min="0" max="99"/> <span>%</span>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<fieldset class="mt-13">
			<legend class="text-title2">업체 담당자 정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="picNm" class="require">담당자명</label></th>
						<td><form:input class="form-control w-90" path="picNm" maxlength="40"/></td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item4-2" class="require">전화번호</label></th>
						<td>
							<div class="form-group w-90">
								<form:input type="tel" class="form-control flex-1" path="picTelno" value="${entrpsVO.picTelno}"  maxlength="15" placeholder="-을 포함해주세요."/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item4-3">연락처</label></th>
						<td>
							<div class="form-group w-90">
								<form:input class="form-control flex-1" path="picTelnoHp" value="${entrpsVO.picTelnoHp}" maxlength="15" placeholder="-을 포함해주세요."/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item4-4">이메일</label></th>
						<td>
							<div class="form-group w-90">
								<form:input  class="form-control flex-1" path="picEml" value="${entrpsVO.picEml}" maxlength="40"/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="picJob">업무구분</label></th>
						<td>
							<form:select path="picJob" class="form-control w-90" >
									<option value="">선택</option>
									<c:forEach var="job" items="${job}">
										<form:option value="${job.key}">${job.value}</form:option>
									</c:forEach>
							</form:select>
						</td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<c:set var="pageParam" value="curPage=${param.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}&srchText=${param.srchText}&srchYn=${param.srchYn}&srchTarget=${param.srchTarget }" />
		<div class="btn-group mt-8 right">
			<button type="submit" class="btn-primary large shadow">저장</button>
			<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
		</div>
	</form:form>
</div>
<!-- //page content -->


<!-- 입점업체 -->
<div class="modal fade" id="modal1" tabindex="-1">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p>입점신청 업체 검색</p>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
			</div>
			<div class="modal-body">
				<p class="text-title2">입점업체 검색</p>
				<table class="table-detail">
					<colgroup>
						<col class="w-35">
						<col>
					</colgroup>
					<tbody>
						<tr>
							<th scope="row"><label for="form-mitem1">입점업체명</label></th>
							<td><input type="text" class="form-control w-full" id="form-mitem1"></td>
						</tr>
						<tr>
							<th scope="row"><label for="form-mitem2">사업자등록번호</label></th>
							<td><input type="text" class="form-control w-full" id="form-mitem2"></td>
						</tr>
					</tbody>
				</table>
				<div class="btn-group mt-5">
					<button type="button" class="btn-primary large shadow w-30">검색</button>
				</div>

				<p class="text-title2 mt-13">입점업체 목록</p>
				<table class="table-list">
					<colgroup>
						<col class="w-15">
						<col>
						<col class="w-40">
						<col class="w-35">
						<col class="w-35">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="check-mitema">
								</div>
							</th>
							<th scope="col">입점업체명</th>
							<th scope="col">사업자등록번호</th>
							<th scope="col">대표자명</th>
							<th scope="col">기간계코드</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="check-mitem1">
								</div>
							</td>
							<td>입점업체명</td>
							<td>123-45-67890</td>
							<td>대표자명</td>
							<td>123456</td>
						</tr>
					</tbody>
				</table>

				<div class="pagination mt-7">
					<div class="paging">
						<a href="#" class="prev">이전</a> <a href="#" class="page active">1</a> <a href="#" class="page">2</a> <a href="#" class="page">3</a> <a href="#" class="page">4</a> <a href="#" class="page">5</a> <a href="#" class="page">6</a> <a href="#" class="page">7</a> <a href="#" class="next">다음</a>
					</div>

					<div class="sorting2">
						<label for="sort-item">출력</label> <select name="" id="sort-item" class="form-control">
							<option value="">20개</option>
						</select>
					</div>

					<div class="counter">
						총 <strong>200</strong>건, <strong>1</strong>/60 페이지
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="btn-group">
					<button type="button" class="btn-primary large shadow">선택</button>
					<button type="button" class="btn-secondary large shadow">취소</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$(function(){

	//정규식
	var phonechk =  /^[0-9]+-/;
	var numchk =  /^[0-9]+$/;
	var emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	var faxchk = /^[0-9]+-[0-9]+-[0-9]+$/;

	$.validator.addMethod("regex", function(value, element, regexpr) {
		if(value != ''){
			return regexpr.test(value)
		}else{
			return true;
		}
	}, "형식이 올바르지 않습니다.");

	//날짜 시작일 < 마감일 체크
	$.validator.addMethod("sizeDate", function(value,element){
		var bgng = $("#ctrtBgngYmd").val();
		var end = $("#ctrtEndYmd").val();
		if(end < bgng){
			return false;
		}else {
			return true;
		}
	}, "기간을 확인해주세요.");


	//유효성 검사
	  $("form[name='frmEntrps']").validate({
			ignore: "input[type='text']:hidden",
			rules: {
				entrpsNm : {required : true},
				brno : {required : true , regex : numchk},
				rprsvNm : {required : true},
				bizcnd : {required : true},
				induty : {required : true},
				zip : {required : true},
				addr : {required : true},
				daddr : {required : true},
				telno : {required : true,  regex : phonechk},
				fxno : { regex : faxchk},
				eml : {regex : emailchk},
				dlvyCtCnd : {required : true},
				dlvyBaseCt : {required : true},
				clclnCycle : {required : true},
				bankNm : {required : true},
				actno : {required : true ,regex : phonechk},
				dpstr : {required : true},
				ctrtBgngYmd : {sizeDate : true},
				picNm : {required : true},
				picTelno : {required : true, regex : phonechk},
				picTelnoHp : {regex : phonechk},
				picEml : {regex : emailchk}
			},
			messages : {
				entrpsNm : {required : "업체명은 필수 입력 사항입니다."},
				brno : {required : "사업자번호는 필수 입력 사항입니다."},
				rprsvNm : {required : "대표자명은 필수 입력 사항입니다."},
				bizcnd : {required : "업태는 필수 입력 사항입니다."},
				induty : {required : "업종은 필수 입력 사항입니다."},
				zip : {required : "우편번호는 필수 입력 사항입니다."},
				addr : {required : "지번/도로명 주소는 필수 입력 사항입니다."},
				daddr : {required : "상세주소는 필수 입력 사항입니다."},
				telno : {required : "전화번호는 필수 입력 사항입니다." },
				fxno : {regex : "펙스 형식이 올바르지 않습니다. \n(000-000-0000)"},
				eml : {regex :  "형식이 올바르지 않습니다. \n(0000@naver.com)"},
				dlvyCtCnd : {required : "주문 금액은 필수 입력 사항입니다.", min : "최솟값은 0입니다."},
				clclnCycle : {required : "정산 주기는 필수 입력 사항입니다."},
				bankNm : {required : "은행명은 필수 입력 사항입니다."},
				actno : {required : "계좌번호는 필수 입력사항입니다.", regex : "형식이 올바르지 않습니다."},
				dpstr : {required : "예금주 명은 필수 입력사항입니다."},
				picNm : {required : "담당자 명은 필수 입력 사항입니다."},
				picTelno : {required : "전화번호는 필수 입력 사항입니다."},
				picEml : {regex :  "형식이 올바르지 않습니다. \n(0000@naver.com)"},
				fee : {min : "최솟값은 0입니다.", max : "최댓값은 99입니다."}
			},
		    submitHandler: function (frm) {
		    	if(confirm("저장 하시겠습니까?")){
		    		frm.submit();
		    	} else{
		    		return false;
		    	}
		    }
		});

});
</script>
