<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


    <!-- 로그인 레이어 -->
    <div class="modal fade" id="modal-login" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <p class="text-title"><img src="/html/core/images/img-brand-logo.svg" alt="eroum"></p>
                    <button data-bs-dismiss="modal">모달 닫기</button>
                </div>
                <div class="modal-body">
                    <p class="modal-login-desc"><strong>로그인</strong>이 필요한 서비스입니다</p>

                    <form action="/membership/loginAction" method="post" id="loginFrm" name="loginFrm" class="member-form">
		            <input type="hidden" id="rsaPublicKeyModulus" value="${publicKeyModulus}">
					<input type="hidden" id="rsaPublicKeyExponent" value="${publicKeyExponent}">
					<input type="hidden" id="encPw" name="encPw" value="">
                    <div class="modal-login-form">
                        <div class="form-group">
                            <label for="login-item3" class="form-label">아이디</label>
                            <input type="text" class="form-input" name="mbrId" id="mbrId" autocomplete="off" maxlength="30">
                        </div>
                        <div class="form-group">
                            <label for="login-item4" class="form-label">비밀번호</label>
                            <input type="password" class="form-input" name="mbrPw" id="mbrPw" autocomplete="off" maxlength="100">
                        </div>
                        <div class="form-check mt-3">
                        	<input class="form-check-input" type="checkbox" id="saveId" name="saveId" value="Y">
                        	<label class="form-check-label" for="saveId">아이디 저장</label>
                    	</div>
                        <button type=button class="btn btn-primary mt-4 w-full f_loginSubmit">로그인</button>
                        <%-- <a href="${_membershipPath}/naver/get" class="btn btn-success mt-4 w-full">네이버 로그인</a>
                        <a href="${_membershipPath}/kakao/auth" class="btn btn-success mt-4 w-full">카카오 로그인</a> --%>

                    </div>
                    </form>

                    <div class="modal-login-search">
                        <a href="${_membershipPath}/srchId">아이디 찾기</a>
                        <a href="${_membershipPath}/srchPswd">비밀번호 찾기</a>
                    </div>
                    <div class="modal-login-join">
                        <dl>
                            <dt>아직 회원이 아니신가요?</dt>
                            <dd>이로움ON과 함께<br> 새 삶을 누리세요!</dd>
                        </dl>
                        <a href="${_membershipPath}/registStep1" class="btn btn-outline-primary">회원가입</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${!_mbrSession.loginCheck}">
    </c:if>
    <!-- //로그인 레이어 -->
    <script src="/html/core/vendor/rsa/RSA.min.js" /></script>
    <script>

    $(function(){
  	 	<c:if test="${!empty saveId}">
		$("#mbrId").val("${saveId}");
		$("#saveId").prop("checked", true);
		</c:if>

    	const f_rsa_enc = function(v, rpkm, rpke) {
			let rsa = new RSAKey();
			rsa.setPublic(rpkm,rpke);
			return rsa.encrypt(v);
		}

    	$(".f_loginSubmit").on("click", function(){

    		console.log("submit");

    		var rsaPublicKeyModulus = $("#rsaPublicKeyModulus").val();
		    var rsaPublicKeyExponent = $("#rsaPublicKeyExponent").val();
		    var encPassword = f_rsa_enc($("#mbrPw").val().trim(), rsaPublicKeyModulus, rsaPublicKeyExponent);

		    $.ajax({
				type : "post",
				url  : "/membership/modalLoginAction.json",
				data : {loginId:$("#mbrId").val(), encPw:encPassword, saveId : $("#saveId").val()},
				dataType : 'json'
			})
			.done(function(data) {
				console.log(data.resultCode);
				if(data.resultCode == "PSWD LOCK"){
					alert("비밀번호를 5회 이상 틀렸습니다. \n비밀번호 찾기 화면으로 이동합니다.");
					location.href = "/membership/srchPswd";
				}else{
					if(data.resultCode != "HUMAN"){
						if(data.result){
							$(".userinfo-count .title, .userinfo-count .desc, .userinfo-count .dropbox").remove();
							var html ="";
							html += '<div class="user">';
							html += '    <p class="name">'+ data.mbrNm +' <small>'+ data.mbrAge +'세, '+ data.mbrAddr +'</small></p>';
							html += '    <p class="button">';
							html += '        <a href="${_membershipPath}/mypage/list" class="btn btn-outline-primary">설정</a>';
							html += '        <a href="${_membershipPath}/logout" class="btn btn-primary">로그아웃</a>';
							html += '    </p>';
							html += '</div>';
							html += '<div class="desc2">';
							html += '    <strong>내게 <em>딱</em> 맞는</strong><br>';
							html += '    <strong>복지서비스<span>를</span> 한 곳<span>에</span>…</strong>';
							html += '</div>';

							// index
							$(".userinfo-count").prepend(html);

							// mobile menu
							$(".allmenu-join dt").text("이로움ON과 함께하세요");
							//$(".allmenu-join .non_login").css({"display":"none"});
							//$(".allmenu-join .on_login").css({"display":"block"});

							var addr1 = data.mbrAddr1;
							if(addr1 == "충남"){
								addr1 = "충청남도";
				    		}else if(addr1 == "충북"){
				    			addr1 = "충청북도";
				    		}else if(addr1 == "경남"){
				    			addr1 = "경상남도";
				    		}else if(addr1 == "경북"){
				    			addr1 = "경상북도";
				    		}else if(addr1 == "전남"){
				    			addr1 = "전라남도";
				    		}else if(addr1 == "전북"){
				    			addr1 = "전라북도";
				    		}else if(addr1 == "서울"){
				    			addr1 = "서울특별시";
				    		}else if(addr1 == "강원" || addr1 == "경기"){
				    			addr1 = addr1 + "도";
				    		}else if(addr1 == "광주"){
				    			addr1 = "광주광역시";
				    		}else if(addr1 == "대구" || addr1 == "대전" || addr1 == "부산" || addr1 == "울산" || addr1 == "인천"){
				    			addr1 = addr1 + "광역시";
				    			console.log(addr1);
				    		}
							$(".select-sido ul a:contains('"+ addr1 +"')").click();
							$(".select-sido button").text(addr1);
							setTimeout(function(){
								$(".select-gugun button").text(data.mbrAddr2);
								$("button.srch-srvc").click();
							}, 100);

							var html2 = "";
							html2 += '';
							html2 += '<p>';
							html2 += '    <strong>'+ data.mbrNm +'</strong>';
							html2 += '    '+ data.mbrAge +'세, '+ data.mbrAddr;
							html2 += '</p>';
							html2 += '<a href="${_membershipPath}/mypage/list" class="btn btn-outline-primary">설정</a>';
							html2 += '<a href="${_membershipPath}/logout" class="btn btn-primary">로그아웃</a>';

							$("#account").removeClass('is-nologin').addClass('is-login').html(html2);

							$("#modal-login").modal("hide");
							$("#mobileClsBtn").click();

							if($("#bokjiId").val() > 0){
								srvcDtl($("#bokjiId").val());
							}

							$("input[name='category']").prop("checked",false);

							// 회원 관심 카테고리
							var field = (data.mbrItrst).replaceAll(' ','').split(',');
							var selCheckVal = "";
							console.log("필드 : " + field);
							if(field != "null"){
								for(var i=0; i<field.length; i++){
									switch(field[i]){
										case "1" : $("#opt-item7").prop("checked",true);break;
										case "2" : $("#opt-item8").prop("checked",true);break;
										case "3" : $("#opt-item6").prop("checked",true);break;
										case "4" : $("#opt-item3").prop("checked",true);break;
										case "5" : break;
										case "6" : $("#opt-item2").prop("checked",true);break;
										case "7" : $("#opt-item1").prop("checked",true);break;
										case "8" : $("#opt-item5").prop("checked",true);break;

									}
								}

							}else{
								//console.log("모두 체크");
								$("input[name='category']").prop("checked",true);
							}

							$(".non_login").hide();
							$(".on_login").show();

						}else{
							console.log(data.resultCode);
							if(data.resultCode == "PAUSE"){
								alert("일시정지된 회원입니다.");
							}else if(data.resultCode == "UNLIMIT"){
								alert("영구정지된 회원입니다.");
							}else{
								alert("로그인 정보가 올바르지 않습니다.");
							}
						}
					}else{
						alert("휴면 회원입니다.");
						location.href="${_membershipPath}" + "/drmt/view?mbrId="+data.mbrId;
					}
				}
			})
			.fail(function(data, status, err) {
				console.log('login error' + data);
			});

    	});

    	 $('input').keyup(function(event) {
    	        if (event.which === 13)
    	        {
    	            event.preventDefault();
    	            $(".f_loginSubmit").click();
    	        }
    	    });

    });
    </script>