<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  <!-- 배송지 모달 -->
  <form:form id="frmDlvy" name="frmDlvy" action="./action" method="post" modelAttribute="dlvyVO">
  <form:hidden path="crud"  />
  <form:hidden path="dlvyMngNo" />
  <form:hidden path="useYn" />
  <form:hidden path="uniqueId" />

  <div class="modal fade" id="dlvyModal" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content">
              <div class="modal-header">
                  <p class="text-title">배송지 등록</p>
              </div>
              <div class="modal-close">
                  <button type="button" data-bs-dismiss="modal">모달 닫기</button>
              </div>
              <div class="modal-body">
                  <table class="table-detail">
                      <colgroup>
                          <col class="w-22 md:w-40">
                          <col>
                      </colgroup>
                      <tbody>
                          <tr class="top-border">
                              <td></td>
                              <td></td>
                          </tr>
                          <tr>
                              <th scope="row"><p><label for="dlvyNm">배송지 명</label></p></th>
                              <td>
                              	<div class="form-group ${dlvyVO.bassDlvyYn eq 'N' ? 'w-100' : 'w-57'}" >
                                  <form:input type="text" class="form-control" path="dlvyNm" maxlength="100" />
                                  	<c:if test="${dlvyVO.bassDlvyYn eq 'N'}">
	                                  <div class="form-check mt-1.5 sm:mt-0 sm:ml-2">
	                                      <form:checkbox class="form-check-input" path="bassDlvyYn" value="${dlvyVO.bassDlvyYn}" />
	                                      <label class="form-check-label" for="bassDlvyYn1">기본 배송지로 설정</label>
	                                  </div>
	                                </c:if>
                                  </div>
                              </td>
                          </tr>
                          <tr>
                              <th scope="row"><p><label for="nm"></label>받는 사람</p></th>
                              <td>
                                  <form:input class="form-control w-57" path="nm" maxlength="50" />
                              </td>
                          </tr>
                          <tr>
                              <th scope="row"><p><label for="mblTelno"></label>휴대폰</p></th>
                              <td>
                                  <div class="form-group w-76">
                                      <form:input class="form-control w-full" path="mblTelno" maxlength="15" oninput="autoHyphen(this);"/>
                                  </div>
                              </td>
                          </tr>
                          <tr>
                              <th scope="row"><p><label for="telno"></label>추가 연락처</p></th>
                              <td>
                                  <div class="form-group w-76">
                                      <form:input class="form-control w-full" path="telno" maxlength="15" oninput="autoHyphen(this);"/>
                                  </div>
                              </td>
                          </tr>
                          <tr>
                              <th scope="row"><p><label for="findAdres"></label>주소</p></th>
                              <td>
                                  <div class="form-group w-76">
                                      <form:input class="form-control" path="zip" maxlength="5"/>
                                      <button type="button" class="btn btn-primary" id="findAdres" onclick="f_findAdres('zip', 'addr', 'daddr'); return false;">우편번호 검색</button>
                                  </div>
                                  <form:input class="form-control mt-1.5 w-full md:mt-2" path="addr" maxlength="250" />
                                  <form:input class="form-control mt-1.5 w-full md:mt-2" path="daddr" maxlength="200" />
                              </td>
                          </tr>
                          <tr>
                              <th scope="row"><p><label for="memo"></label>배송 메시지</p></th>
                              <td>
                                  <div class="flex flex-col">
                                      <select id="selMemo" name="selMemo" class="form-control">
											<option value="" checked>배송메세지</option>
											<option value="문 앞에 놓아주세요" <c:if test="${dlvyVO.memo eq '문 앞에 놓아주세요' }">selected="selected"</c:if>>문 앞에 놓아주세요</option>
											<option value="직접 받겠습니다 (부재시 문 앞)" <c:if test="${dlvyVO.memo eq '직접 받겠습니다 (부재시 문 앞)' }">selected="selected"</c:if>>직접 받겠습니다 (부재시 문 앞)</option>
											<option value="경비실에 보관해 주세요" <c:if test="${dlvyVO.memo eq '경비실에 보관해 주세요' }">selected="selected"</c:if>>경비실에 보관해 주세요</option>
											<option value="택배함에 넣어주세요" <c:if test="${dlvyVO.memo eq '택배함에 넣어주세요' }">selected="selected"</c:if>>택배함에 넣어주세요</option>
											<option value="직접입력" id="selfMemo" <c:if test="${dlvyVO.memo ne '문 앞에 놓아주세요' && dlvyVO.memo ne '직접 받겠습니다 (부재시 문 앞)' && dlvyVO.memo ne '경비실에 보관해 주세요' && dlvyVO.memo ne '택배함에 넣어주세요' && dlvyVO.crud ne 'CREATE' }">selected="selected"</c:if> >직접입력</option>
										</select>
                                      <form:input class="form-control mt-1.5 sm:mt-1" path="memo" maxlength="25" style="display:none;" placeholder="배송 요청 사항 입력(25자 이내)"/>
                                  </div>
                              </td>
                          </tr>
                          <tr class="top-border">
                              <td></td>
                              <td></td>
                          </tr>
                      </tbody>
                  </table>
              </div>
              <div class="modal-footer">
                  <button type="submit" class="btn btn-primary btn-submit">확인</button>
                  <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
              </div>
          </div>
      </div>
  </div>
  </form:form>
<!-- //배송지 모달 -->

<script>
    $(function(){

    	const telchk = /^0([0-9]{1,2})-?([0-9]{3,4})-?([0-9]{4})$/;

    	if($("#crud").val() == 'UPDATE'){
    		if($("#memo").val() != "문 앞에 놓아주세요" &&  $("#memo").val() != "직접 받겠습니다 (부재시 문 앞)" && $("#memo").val() != "경비실에 보관해 주세요"  && $("#memo").val() != "택배함에 넣어주세요"){
    			$("#memo").show();
    			$("#memo").val("${dlvyVO.memo}");
    			$("#selfMemo").prop("selected",true);
    		}
    	}

    	if("${dlvyVO.bassDlvyYn}" == "Y"){
    		$("#bassDlvyYn1").prop("checked",true);
    	}else{
    		$("#bassDlvyYn1").prop("checked",false);
    	}



    	$("#selMemo").on("change", function(){
    		if($(this).val() != ""){
    			if($(this).val() != "직접입력"){
    				$("#memo").val($(this).val());
    				$("#memo").hide();
    			}else{
    				$("#memo").show();
    				$("#memo").val('');
    			}
    		}
    	});

    	// 정규식 체크
    	$.validator.addMethod("regex", function(value, element, regexpr) {
    		if(value != ''){
    			return regexpr.test(value)
    		}else{
    			return true;
    		}
    	}, "{0}");

	    $("form[name='frmDlvy']").validate({
		    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
		    rules : {
		    	dlvyNm		: { required : true}
		    	, nm		: { required : true}
		    	, mblTelno	: { required : true, regex : telchk}
		    	, telno : {regex : telchk}
		    	, zip		: { required : true}
		    	, addr		: { required : true}
		    	, daddr		: { required : true}
		    },
		    messages : {
		    	dlvyNm		: { required : "! 배송지명을 입력해 주세요"}
		    	, nm		: { required : "! 받는 사람을 입력해 주세요"}
		    	, mblTelno	: { required : "! 휴대폰 번호를 입력해 주세요", regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"}
		    	, telno  : {regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)"}
		    	, zip		: { required : "! 우편번호 검색을 해 주세요"}
		    	, addr		: { required : "! 주소를 입력해 주세요"}
		    	, daddr		: { required : "! 상세 주소를 입력해 주세요"}
		    },
		    errorElement:"p",
		    errorPlacement: function(error, element) {
			    var group = element.closest('.form-group, .form-check');
			    if (group.length) {
			        group.after(error.addClass('text-danger'));
			    } else {
			        element.after(error.addClass('text-danger'));
			    }
			},
		    submitHandler: function (frm) {
	            if (confirm('등록하시겠습니까?')) {
	            	frm.submit();
	        	}else{
	        		return false;
	        	}
		    }
		});

	    //기본 배송지 검사
	    $("#bassDlvyYn1").on("click",function(){
	    	if($("#bassDlvyYn1").is(":checked")){
    			$("#bassDlvyYn1").val("Y");
    		}else{
    			$("#bassDlvyYn1").val("N");
    		}
	    });

    });

    </script>