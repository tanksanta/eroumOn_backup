<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
                <form:form name="frmMkr" id="frmMkr" modelAttribute="mkrVO" method="post" action="./action">
                <form:hidden path="crud" />
                <form:hidden path="mkrNo" />

		<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
		<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn}" />
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
		<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
				<fieldset>
                        <legend class="text-title2 relative">
                            ${mkrVO.crud eq 'CREATE'?'등록':'수정' }
                            <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                                (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                            </span>
                        </legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">제조사코드</th>
                                    <td>${mkrVO.mkrNo}</td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="mkrNm" class="require">제조사명</label></th>
                                    <td>
                                        <div class="form-group w-90 idChk">
                                            <form:input type="text" class="form-control flex-1" path="mkrNm" value="${mkrVO.mkrNm }" maxlength="40"/>
                                            <button type="button" class="btn-primary w-20" id="searchNm" >검색</button>
                                        </div>
                                        <input type="hidden" id="nmVal" name="nmVal" value="N">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="form-item2">상태</label></th>
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

					<c:set var="pageParam" value="curPage=${param.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}" />
                    <div class="btn-group mt-8 right">
                        <button type="submit" class="btn-primary large shadow">저장</button>
                        <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
                    </div>
                </form:form>
            </div>

<script>

$(function(){

	if($("#mkrNm").val() == ''){
		$("#searchNm").attr("disabled",true);
	}

	$("#mkrNm").keyup(function(){
		$("#searchNm").attr("disabled",false);
	});

	 if($("#crud").val() === 'UPDATE'){
		  $("#searchNm").attr("disabled",true);
		  $("#mkrNm").attr("readonly",true);
	  }


	//제조사명 중복검사
	$("#searchNm").on("click", function(){
		$.ajax({
			type : "post",
			url  : "mkrDuplicate.json",
			data : {
				mkrNm : $("#mkrNm").val()
				, crud : $("#crud").val()
				, no : $("#mkrNo").val()
			},
			dataType : 'json'
		})
		.done(function(data) {
			console.log("넘어온 데이터 : " + data);
				 if(data == 4){
            	alert("이미 사용중인 제조사입니다.");
			}else{
				alert("사용 가능한 제조사입니다.");
				$("#nmVal").val("Y");
			}
		})
		.fail(function(data, status, err) {
			alert("아이디 사용 가능 여부 확인 중 오류가 발생했습니다.");
			console.log('error forward : ' + data);
		});

	});

	//버튼체크 메소드
	$.validator.addMethod("chkDup", function(){
		if($("#crud").val() != 'UPDATE'){
			if($("#nmVal").val() == "Y"){
				return true;
			}else {
				return false;
			}
		}else{
			return true;
		}
		}, "검색은 필수 입니다.");

	//검사 실패시 메소드
		$.validator.addMethod("NmVal", function(value,element){
		if($(".useCan").length == 0){
			$(".useCan").remove();
			return true;
		}else{
			return false;
		}
		}, "사용 가능한 제조사를 검색해주세요.");



	//유효성 검사
	 $("form[name='frmMkr']").validate({
		ignore: "input[type='text']:hidden",
		rules: {
			mkrNm : {required : true, chkDup : true, NmVal : true}
		},
		messages : {
			mkrNm : {required : "제조사 명은 필수 입력 사항입니다."}
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

