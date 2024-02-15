// 매칭앱 전용 AJAX Call 함수 지원 JS 파일

// 성공 콜백만 인자로 받고 실패시 메세지만 alert 해주는 함수
var doubleClickCheck = false;
function callPostAjaxIfFailOnlyMsg(url, param, successCallback) {
	viewProgressLoadingBar();
	if (doubleClickCheck) {
		return;
	}
	doubleClickCheck = true;

	$.ajax({
		type : "post",
		url  : url,
		data : param,
		dataType : 'json'
	})
	.done(function(result) {
		doubleClickCheck = false;
		hiddenProgressLoadingBar();
	
		if(result.success) {
			successCallback(result);
		}else{
			if (result.msg) {
				alert(result.msg);
			}
		}
	})
	.fail(function(data, status, err) {
		alert('서버와 연결이 좋지 않습니다.');
	});
}


// 로딩바 만들기
var bodyTagInMatching;
var LoadingDivInMatching
function createProgressLoadingBar() {
	var template = `
		<div class="progress-loading lazy is-dark">
			<div class="icon">
				<span></span><span></span><span></span>
			</div>
			<p class="text">데이터를 불러오는 중입니다.</p>
		</div>
	`;
	
	bodyTagInMatching = $('body'); 
	bodyTagInMatching.append(template);
	
	LoadingDivInMatching = $('body div.progress-loading');
}

// 로딩바 보이기
function viewProgressLoadingBar() {
	LoadingDivInMatching.removeClass('off');
	bodyTagInMatching.addClass('overlay-wait1');
}

// 로딩바 숨기기
function hiddenProgressLoadingBar() {
	LoadingDivInMatching.addClass('off');
	bodyTagInMatching.removeClass('overlay-wait1');
}


$(function() {
	createProgressLoadingBar();
	hiddenProgressLoadingBar();
});