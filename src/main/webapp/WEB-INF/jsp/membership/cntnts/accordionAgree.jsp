<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<input type="hidden" id="termsDt" name="termsDt" value="<fmt:formatDate value="${mbrAgreementVO.termsDt}" pattern="yyyy-MM-dd HH:mm:ss" />" />
				<input type="hidden" id="privacyDt" name="privacyDt" value="<fmt:formatDate value="${mbrAgreementVO.privacyDt}" pattern="yyyy-MM-dd HH:mm:ss" />" />
				
				<div class="content-accordion" id="accordionAgree">
					<div class="accordion-item">
						<div class="accordion-header">
							<div class="form-check">
								<input class="form-check-input agree-check" type="checkbox" id="termsYn" name="termsYn" value="Y">
										<label class="form-check-label" for="termsYn"> <span class="text-danger">필수</span> 이용약관에 동의합니다
								</label>
							</div>
							<button class="accordion-button" type="button" data-bs-target="#collapse-agree1" data-bs-toggle="collapse" aria-expanded="false">펼치기/접기</button>
						</div>
						<div id="collapse-agree1" class="accordion-collapse collapse" data-bs-parent="#accordionAgree">
	                        <div class="accordion-body py-3.5 px-4">
								${termsTerms}
	                        </div>
						</div>
					</div>
					<div class="accordion-item">
						<div class="accordion-header">
							<div class="form-check">
								<input class="form-check-input agree-check" type="checkbox" id="privacyYn" name="privacyYn" value="Y">
								<label class="form-check-label" for="privacyYn"> <span class="text-danger">필수</span> 
									개인정보 처리방침에 동의합니다
								</label>
							</div>
							<button class="accordion-button" type="button" data-bs-target="#collapse-agree2" data-bs-toggle="collapse" aria-expanded="false">펼치기/접기</button>
						</div>
						<div id="collapse-agree2" class="accordion-collapse collapse" data-bs-parent="#accordionAgree">
	                        <div class="accordion-body py-3.5 px-4">
	                            ${termsPrivacy}
	                        </div>
						</div>
					</div>

				</div>
				
				<script>
					$(function() {
						function dateFormat(date) {
					        let month = date.getMonth() + 1;
					        let day = date.getDate();
					        let hour = date.getHours();
					        let minute = date.getMinutes();
					        let second = date.getSeconds();

					        month = month >= 10 ? month : '0' + month;
					        day = day >= 10 ? day : '0' + day;
					        hour = hour >= 10 ? hour : '0' + hour;
					        minute = minute >= 10 ? minute : '0' + minute;
					        second = second >= 10 ? second : '0' + second;

					        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
						}
						
						// 전체 약관 동의
						$("#check-all").on("click",function(){
							if(!$("#check-all").is(":checked")){
								$("#termsYn, #privacyYn").prop("checked",false);
							}else{
								$("#termsYn, #privacyYn").prop("checked",true);
							}
							
							$('#termsDt').attr('value', dateFormat(new Date()));
							$('#privacyDt').attr('value', dateFormat(new Date()));
						});
						
						$(".agree-check").on("click",function(){
							if(!$(this).is(":checked")){
								$("#check-all").prop("checked",false);
							}else{
								if($(".agree-check:checked").length == 4){
									$("#check-all").prop("checked",true);
								}
							}
							
							var inputName = $(this).attr('name');
							$('#' + inputName.replace('Yn', '') + 'Dt').attr('value', dateFormat(new Date()));
						});
					});
				</script>
