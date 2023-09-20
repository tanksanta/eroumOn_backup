<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<p class="text-title2 relative">
                    내정보
                    <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                        (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                    </span>
                </p>
                <div class="tree-content">
                
						<form:form name="frmMngr" id="frmMngr" modelAttribute="mngrVO" method="post" action="./mypage/action" enctype="multipart/form-data">
						<form:hidden path="uniqueId" />
						<form:hidden path="mngrPswd" />

                        <fieldset>
                            <legend class="sr-only">관리자 등록/수정</legend>
                            <table class="table-detail mb-7"> <!-- mb-8이 없어서 임시, btn-group에 mt-8 안됨..important -->
                                <colgroup>
                                    <col class="w-43">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row"><label for="form-item1" class="require">아이디</label></th>
                                        <td>
                                        	<form:hidden path="mngrId" />
											<input type="text" id="mngrId_view" readonly="readonly" class="form-control flex-1" value="${mngrVO.mngrId}"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="mngrNm" class="require">이름</label></th>
                                        <td>
                                        	<form:input path="mngrNm" cssClass="form-control w-90" autocomplete="off" maxlength="50" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="newPswd" class="require">비밀번호</label></th>
                                        <td>
                                        	<form:password path="newPswd" cssClass="form-control w-90" autocomplete="off" maxlength="50"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="newPswd1" class="require">비밀번호 확인</label></th>
                                        <td>
                                        	<input type="password" name="newPswd1" id="newPswd1" class="form-control w-90" autocomplete="off" maxlength="50"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="form-item5">로그인 오류 횟수</label></th>
                                        <td>
                                            <div class="form-group">
                                                <input type="text" class="form-control w-30" id="form-item5" value="${passCk}" disabled>
                                                <span class="ml-2 text-danger">* 비밀번호 변경 시 초기화됩니다.</span>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="mngrNm" >프로필 이미지</label></th>
                                        <td>
                                        	<div class="flex w-90">

											<c:if test="${!empty mngrVO.proflImg}">
												<div class="flex-none mr-1.5 border border-gray3 w-19 profile-div">
	                                            	<img src="/comm/proflImg?fileName=${mngrVO.proflImg}" id="profile" class="object-cover w-full h-full">
	                                            </div>
	                                            <div class="flex-1">
	                                            	<button type="button" class="btn-primary small mb-1 delProfileImgBtn">삭제 <i class="fa fa-trash ml-1"></i></button>
		                                            <input type="file" id="profileImg" name="profileImg" class="form-control w-full" />
	                                            </div>
											</c:if>
											<c:if test="${empty mngrVO.proflImg}">
												<div class="flex-1">
		                                            <input type="file" id="profileImg" name="profileImg" class="form-control w-full" />
	                                            </div>
											</c:if>
                                            	<input type="hidden" id="delProfileImg" name="delProfileImg" value="N" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="telno" class="require">휴대폰</label></th>
                                        <td>
                                            <form:input type="text" path="telno" class="form-control w-90" maxlength="13" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="eml" class="require">이메일</label></th>
                                        <td>
                                            <form:input type="text" path="eml" class="form-control w-90" maxlength="200" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>


	                        <div class="btn-group">
	                            <button type="submit" class="btn-primary large shadow">저장</button>
	                        </div>
                        </fieldset>

                        </form:form>
                </div>


				<script>
				$(function(){

					$(".delProfileImgBtn").on("click", function(){
						$("#delProfileImg").val("Y");
						//$(this).closest("div").slideUp(10);
						$(this).remove();
						$(".profile-div").remove();
					});

					// method 사용시
					$.validator.addMethod("passwordCk",  function( value, element ) {
						return this.optional(element) ||  /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/.test(value);
					});

					$.validator.addMethod("regex", function(value, element, regexpr) {
					    return regexpr.test(value);
					}, "형식이 올바르지 않습니다.");

					// 정규식
					var passwordChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
					var emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
					var phonechk = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;

					$("form[name='frmMngr']").validate({
					    ignore: "input[type='text']:hidden",
					    rules : {
					    	mngrNm	: { required : true},
					    	newPswd	: { required:${mngrVO.crud eq 'CREATE' ? 'true' : 'false'}, minlength: 8, maxlength:25, passwordCk: true},
					    	newPswd1 : { required:${mngrVO.crud eq 'CREATE' ? 'true' : 'false'}, equalTo:"#newPswd" },
					    	telno : { required : true, regex: phonechk },
					    	eml : { required : true, regex: emailchk },
					    },
					    messages : {
					    	mngrNm	: { required : "이름을 입력 해주세요"},
					    	newPswd  : { required: "비밀번호를 입력 해주세요", minlength: jQuery.validator.format("{0}자 이상 입력 해주세요"),
										maxlength: jQuery.validator.format("{0}자 이하로 입력해 주십시요"), passwordCk : "비밀번호는 영문자, 숫자, 특수문자 조합을 입력해야 합니다."},
							newPswd1 : { required: "비밀번호 확인을 해주세요", equalTo: "비밀번호가 일치하지 않습니다." },
							telno : { required : "휴대폰 번호를 입력 해주세요", regex: "휴대전화번호 형식이 잘못되었습니다.\n(010-0000-0000)"  },
					    	eml : { required : "이메일 주소를 입력 해주세요", regex: "이메일 형식이 잘못되었습니다.\n(abc@def.com)" },
					    },
					    submitHandler: function (frm) {
					    	setMngMenu();
							if(confirm('<spring:message code="action.confirm.save"/>')){
								frm.submit();
							}else{
								return false;
							}
					    }
					});
				});
				</script>
