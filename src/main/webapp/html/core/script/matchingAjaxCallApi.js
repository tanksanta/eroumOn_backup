// 매칭앱 전용 AJAX Call 함수 지원 JS 파일

//성공 콜백만 인자로 받고 실패시 메세지만 alert 해주는 함수
function callPostAjaxIfFailOnlyMsg(url, ) {
	$.ajax({
		type : "post",
		url  : url,
		data : { recipientsNo },
		dataType : 'json'
	})
	.done(function(data) {
		if(data.success) {
			location.href = '/membership/info/recipients/list';
		}else{
			alert(data.msg);
		}
	})
	.fail(function(data, status, err) {
		alert('서버와 연결이 좋지 않습니다.');
	});
}