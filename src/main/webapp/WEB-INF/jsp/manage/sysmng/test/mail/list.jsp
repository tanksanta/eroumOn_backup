<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	
	<div style="">이 페이지는 메일발송 테스트 목적으로만 만들어진 페이지 입니다.</div>
	
	<br>
	<div>
		<button class="btn-primary shadow w-52" onclick="sendBrdtEmail()">생일 축하</button>
	</div>
	
	<br>
	<br>
	<div>
		테스트 서버에서 발송 시 테스트 MAIL에 한번만 발송되도록 조치<br>
		<button class="btn-primary shadow w-52" onclick="sendInfoEmail()">개인정보 이용내역 통지안내</button>
	</div>
	
	<br>
	<br>
	<div>
		<button class="btn-primary shadow w-52" onclick="guideExtinctPoint()">소멸예정 포인트 안내</button>
	</div>
	
	<br>
	<br>
	<div>
		<button class="btn-primary shadow w-52" onclick="guideExtinctMlg()">소멸예정 마일리지 안내</button>
	</div>
	
	<br>
	<br>
	<div>
		<button class="btn-primary shadow w-52" onclick="guidDrmcMbrMail()">휴면계정 대상 안내</button>
	</div>
	
	<br>
	<br>
	<div>
		<button class="btn-primary shadow w-52" onclick="sleepMbr()">휴면계정 전환 안내</button>
	</div>
</div>

<script>
	function callAjaxPost(url, data, callback) {
		$.ajax({
    		type : "post",
			url,
			data,
			dataType : 'json'
    	})
    	.done(function(result) {
    		if(result.success) {
    			callback(result);
    		}else{
    			alert(result.msg);
    		}
    	})
    	.fail(function(result, status, err) {
    		alert('서버와 연결이 좋지 않습니다.');
		});
	}
	
	function sendBrdtEmail() {
		callAjaxPost("/_mng/sysmng/test/mail/brdt.json"
			,{}
			,function(result) {
				alert('생일 축하 메일 발송 성공');
			}
		);
	}
	
	function sendInfoEmail() {
		callAjaxPost("/_mng/sysmng/test/mail/info.json"
			,{}
			,function(result) {
				alert('개인정보 이용내역 통지안내 메일 발송 성공');
			}
		);
	}
	
	function guideExtinctPoint() {
		callAjaxPost("/_mng/sysmng/test/mail/guideExtinctPoint.json"
			,{}
			,function(result) {
				alert('소멸예정 포인트 안내 메일 발송 성공');
			}
		);
	}
	
	function guideExtinctMlg() {
		callAjaxPost("/_mng/sysmng/test/mail/guideExtinctMlg.json"
			,{}
			,function(result) {
				alert('소멸예정 마일리지 안내 메일 발송 성공');
			}
		);
	}
	
	function guidDrmcMbrMail() {
		callAjaxPost("/_mng/sysmng/test/mail/guidDrmcMbrMail.json"
			,{}
			,function(result) {
				alert('휴면계정 대상 안내 메일 발송 성공');
			}
		);
	}
	
	function sleepMbr() {
		callAjaxPost("/_mng/sysmng/test/mail/sleepMbr.json"
			,{}
			,function(result) {
				alert('휴면계정 전환 안내 메일 발송 성공');
			}
		);
	}
</script>