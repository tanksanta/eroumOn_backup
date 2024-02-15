<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main class="mainContainer">
		<br>
		<br>
		<div id="mbrInfo">
			<div>
				휴대폰번호<br>
				<input class="form-control" type="text" />
			</div>
			<div>
				통신사<br>
				<select>
					<option value="SKT">SKT</option>
					<option value="KT">KT</option>
					<option value="LGT">LG U+</option>
					<option value="SKT_MVNO">SKT 알뜰폰</option>
					<option value="KT_MVNO">KT 알뜰폰</option>
					<option value="LGT_MVNO">LG U+ 알뜰폰</option>
				</select>
			</div>
			<div id="residentNumDiv" style="display: none;">
				주민등록번호<br>
				<input class="form-control" type="text" />
			</div>
			<div id="nameDiv">
				이름<br>
				<!-- 
				<input id="nameInput" class="form-control" type="text" onblur="nameInputBlurEvent();" onkeypress="return nameInputKeypressEvent(event);" />
				-->
				<input id="nameInput" class="form-control" type="text"/>
			</div>
			
			<div>
				<dl class="member-social">
	                <dd>
	                    <a class="btn w-full" onclick="requestVerification()">
			            	<span>본인인증하기</span>
			            </a>
	                </dd>
	            </dl>
			</div>
		</div>
		<div id="smsAction" style="display: none;">
			<h2>
				문자로 받은<br>
				인증번호 6자리를 입력해주세요
			</h2>
			<br>
			<div>
				인증번호<br>
				<input class="form-control" id="otpNum" text="text" />
			</div>
			
			<div>
				<dl class="member-social">
	                <dd>
	                    <a class="btn w-full" onclick="confirmVerification()">
			            	<span>본인인증 확인</span>
			            </a>
	                </dd>
	            </dl>
			</div>
		</div>
	</main>
	
	
	<script>
		var receiptId = '';
		
		//본인인증 요청
		function requestVerification() {
			const name = 'a';
			const identityNo = 'b';
			const carrier = 'c';
			const phone = 'd';
			
			const param = {
				name,
				identityNo,
				carrier,
				phone,
			};
			
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/info/requestVerification',
				param,
				function(result) {
					receiptId = result.receiptId;
					$('#mbrInfo').css('display', 'none');
					$('#smsAction').css('display', 'block');
				}
			);
		}
		
		//본인인증 OTP 재전송
		function realarmVerification() {
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/info/realarmVerification',
				{receiptId},
				function(result) {
				}
			);
		}
		
		//본인인증 확인
		function confirmVerification() {
			const otpNum = '112233';
			
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/info/confirmVerification',
				{receiptId, otpNum},
				function(result) {
					var type = '${type}';
					if (type === 'regist') {
						registMbr();
					}
				}
			);
		}
	
		//회원가입
		function registMbr() {
			callPostAjaxIfFailOnlyMsg(
				'/matching/membership/regist.json', 
				{},
				function(result) {
					location.href = result.location;
				}
			);
		} 
		
		
		//이름 이벤트
		function nameInputKeypressEvent(e) {
			if (e.keyCode == 13) {
				$('#residentNumDiv').css('display', 'block');
				return false;
			} else {
				return true;
			}
		}
		function nameInputBlurEvent() {
			$('#residentNumDiv').css('display', 'block');
		}
	</script>