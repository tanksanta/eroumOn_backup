<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	<form:form name="frmDlvy" id="frmDlvy" modelAttribute="dlvyCoMngVO" method="post" action="./action">
	<form:hidden path="crud" />
	<form:hidden path="coNo" />

		<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
		<input type="hidden" name="srchUseYn" id="srchUseYn" value="${param.srchUseYn}" />
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
		<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />

		<fieldset>
			<legend class="text-title2 relative">
				${dlvyCoMngVO.crud eq 'CREATE'?'등록':'수정' }<span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
				</span>
			</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="dlvyCoNm" class="require">배송업체명</label></th>
						<td><form:input class="form-control w-90" path="dlvyCoNm" maxlength="40" value="${dlvyCoMngVO.dlvyCoNm}" />
							</td>
					</tr>
					<tr>
						<th scope="row"><label for="telnoInfo">안내전화번호</label></th>
						<td><form:input type="tel" class="form-control w-90" path="telnoInfo" value="${dlvyCoMngVO.telnoInfo }" maxlength="13" placeholder="숫자만 입력해주세요." oninput="autoHyphen(this);"/></td>
					</tr>
					<tr>
						<th scope="row"><label for="dlvyUrl" class="require">배송추적 URL</label></th>
						<td><form:input class="form-control w-full" path="dlvyUrl" value="${dlvyCoMngVO.dlvyUrl }"/>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="form-item4">상태</label></th>
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
					<!-- <tr>
						<th scope="row"><label for="dlvyCoCd">배송사코드(하단참조)</label></th>
						<td><form:input class="form-control w-90" path="dlvyCoCd" value="${dlvyCoMngVO.dlvyCoCd }" />
						</td>
					</tr> -->
				</tbody>
			</table>
		</fieldset>

		<c:set var="pageParam" value="curPage=${param.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}&cntPerPage=${param.cntPerPage}&srchText=${param.srchText}&srchUseYn=${param.srchUseYn}" />
		<div class="btn-group right mt-8">
			<button type="submit" class="btn-primary large shadow">저장</button>
			<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
		</div>
	</form:form>

	<!-- <p class="text-title2 mt-13">배송업체 코드표</p>
	<table class="table-list">
		<colgroup>
			<col class="w-1/6">
			<col class="w-2/6">
			<col class="w-1/6">
			<col class="w-2/6">
		</colgroup>
		<thead>
			<tr>
				<th scope="col">코드</th>
				<th scope="col">택배사</th>
				<th scope="col">코드</th>
				<th scope="col">택배사</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>DC01</td>
				<td>대한통운</td>
				<td>DC01</td>
				<td>대한통운</td>
			</tr>
			<tr>
				<td>DC01</td>
				<td>대한통운</td>
				<td>DC01</td>
				<td>대한통운</td>
			</tr>
		</tbody>
	</table> -->
</div>

<script>
$(function(){

	$.validator.addMethod("regex", function(value, element, regexpr) {
		if(value != ''){
			console.log(regexpr.test(value));
			return regexpr.test(value)
		}else{
			return true;
		}
	}, "형식이 올바르지 않습니다.");

	var phonechk =  /^[0-9]+-/;
	var engNum =  /^[a-zA-Z0-9./]*$/;

	//유효성 검사
	 $("form[name='frmDlvy']").validate({
		ignore: "input[type='text']:hidden",
		rules: {
			dlvyCoNm : {required : true, remote : "NmDup"},
			telnoInfo : {regex : phonechk},
			//dlvyUrl : {required : true, regex : engNum}, >> http:// https:// ? & 전부 허용되어야함
			dlvyUrl : {required : true},
			dlvyCoCd : {required : true},

		},
		messages : {
			dlvyCoNm : {required : "배송 업체명은 필수 입력 사항입니다.", remote : "이미 사용중인 배송업체명 입니다."},
			dlvyUrl : {required : "배송 추적 URL은 필수 입력 사항입니다."},
			dlvyCoCd : {required : "배송사코드는 필수입력 사항입니다."},
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
