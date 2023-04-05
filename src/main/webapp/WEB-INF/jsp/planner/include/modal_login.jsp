<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


    <!-- 로그인 레이어 -->
    <div class="modal fade" id="modal-login" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <p class="text-title"><img src="/html/page/planner/assets/images/img-main-logo.svg" alt="eroum"></p>
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
                        <button type=button class="btn btn-primary mt-2.5 w-full f_loginSubmit">로그인</button>
                    </div>
                    </form>

                    <div class="modal-login-search">
                        <a href="${_membershipPath}/srchId">아이디 찾기</a>
                        <a href="${_membershipPath}/srchPswd">비밀번호 찾기</a>
                    </div>
                    <div class="modal-login-join">
                        <dl>
                            <dt>아직 회원이 아니신가요?</dt>
                            <dd>이로움과 함께<br> 새 삶을 누리세요!</dd>
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

    	const f_rsa_enc = function(v, rpkm, rpke) {
			let rsa = new RSAKey();
			rsa.setPublic(rpkm,rpke);
			return rsa.encrypt(v);
		}

    	$(".f_loginSubmit").on("click", function(){

    		console.log("submit");

    		var rsaPublicKeyModulus = $("#rsaPublicKeyModulus").val();
		    var rsaPublicKeyExponent = $("#rsaPublicKeyExponent").val();
		    var encPassword = f_rsa_enc($("#mbrPw").val(), rsaPublicKeyModulus, rsaPublicKeyExponent);

		    $.ajax({
				type : "post",
				url  : "/membership/modalLoginAction.json",
				data : {loginId:$("#mbrId").val(), encPw:encPassword},
				dataType : 'json'
			})
			.done(function(data) {
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

					$(".userinfo-count").prepend(html);

					$(".select-sido ul a:contains('"+ data.mbrAddr1 +"')").click();
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
					if(field != "null"){
						for(var i=0; i<field.length; i++){
							switch(field[i]){
								case "1" : $("#opt-item7").prop("checked",true);break;
								case "2" : $("#opt-item8").prop("checked",true);break;
								case "3" : $("#opt-item6").prop("checked",true);break;
								case "4" : $("#opt-item3").prop("checked",true);break;
								case "5" : $("#opt-item2").prop("checked",true);break;
								case "6" : break;
								case "7" : $("#opt-item1").prop("checked",true);break;
								case "8" : $("#opt-item5").prop("checked",true);break;

							}
						}
					}else{
						$("input[name='category']").prop("checked",true);
					}

					$(".non_login").hide();
					$(".on_login").show();

				}else{
					alert("로그인 정보가 올바르지 않습니다.");
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