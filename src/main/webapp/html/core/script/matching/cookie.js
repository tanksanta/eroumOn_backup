// cookie 저장
var setCookie = function(name, value, expDay) { 
	var date = new Date();
 	date.setTime(date.getTime() + expDay*24*60*60*1000);
 	document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
};

// cookie 가져오기 
var getCookie = function(name) {      
	var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
	return value? value[2] : null;  
};

// cookie 삭제
var deleteCookie = function(name) {	
 	document.cookie = name + '=;expires=Thu, 01 Jan 1999 00:00:10 GMT;path=/';
}