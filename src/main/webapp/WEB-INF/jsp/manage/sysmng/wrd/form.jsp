<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
      <form:form name="frmWrd" id="frmWrd" modelAttribute="mngWrdVO" method="post" action="./action">
      <form:input type="hidden" path="wrdNo" />
      <form:input type="hidden" path="crud" />

		<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
		<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn}" />
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
		<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
		<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
		<fieldset>
              <legend class="text-title2 relative">
                  ${mngWrdVO.crud eq 'CREATE'?'등록':'수정' }
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
                          <th scope="row"><label for="form-item1" class="require">금지어</label></th>
                          <td>
                          		<div class="form-group">
	                              <form:input type="text" class="form-control w-90" path="prhibtWrd"  value="${mngWrdVO.prhibtWrd}" />&nbsp;&nbsp;
	                              <button type="button" class="btn-primary w-20" id="searchNm" data-chkbtn="unchecked">검색</button>
	                            </div>
                          </td>
                      </tr>
                      <tr>
                          <th scope="row"><label for="form-item2" class="require">상태</label></th>
                          <td>
                        		<div class="form-check-group">
									<c:forEach var="sttus" items="${useYn}">
										<div class="form-check">
											<form:radiobutton path="useYn" class="form-check-input" id="${sttus.value}" value="${sttus.key}" />
											<label class="form-check-label" for="${sttus.value}">${sttus.value}</label>
										</div>
									</c:forEach>
								</div>
                          </td>
                      </tr>
                  </tbody>
              </table>
          </fieldset>

		<c:set var="pageParam" value="curPage=${param.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}&srchText=${param.srchText}&srchYn=${param.srchYn}" />
          <div class="btn-group right mt-8">
              <button type="submit" class="btn-primary large shadow">저장</button>
              <a href="./list?&${pageParam}" class="btn-secondary large shadow">목록</a>
          </div>
      </form:form>
  </div>

  <script>
  $(function(){

	  if($("#crud").val() == "UPDATE"){
		$("#prhibtWrd").attr("readonly",true);
		$("#searchNm").attr("disabled",true);
	  }

	  //검색 기능
	  $("#searchNm").on("click",function(){
			$.ajax({
				type : "post",
				url  : "ChkDuplicate.json",
				data : {
					prhibtWrd : $("#prhibtWrd").val()
					, crud : $("#crud").val()
					, no : $("#wrdNo").val()
				},
				dataType : 'json'
			})
			.done(function(data) {
				if(data == false){
					$("#searchNm").attr("data-chkbtn","unchecked");
					alert("이미 등록된 금지어 입니다.");
				}else{
					$("#searchNm").attr("data-chkbtn","checked");
					alert("등록 가능한 금지어입니다. ");
				}
			})
			.fail(function(data, status, err) {
				alert("금지어 중복 검사 중 오류가 발생했습니다.");
				console.log('error forward : ' + data);
			});
	  });

	  //버튼 검사
	  $.validator.addMethod("searchchk", function(value,element){
		  if($("#crud").val() != 'UPDATE'){
			  if($("#searchNm").attr("data-chkbtn") == "unchecked"){
				  return false;
			  }else{
				  return true;
			  }
		  }else{
			  return true;
		  }
	  }, "사용 가능한 금지어를 검사해주세요.");

	  //유효성 검사
	  $("form[name='frmWrd']").validate({
			ignore: "input[type='text']:hidden",
			rules: {
				prhibtWrd : {required : true , searchchk : true}
			},
			messages : {
				prhibtWrd : {required : "금지어는 필수입력 사항입니다."}
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
