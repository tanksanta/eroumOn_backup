<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<a id="aTagDeeplink" href="intent://home?type=test
#Intent;
	scheme=myapp;
	action=android.intent.action.VIEW;
	category=android.intent.category.BROWSABLE;
	package=com.thkc.eroumon.mvpapp;
end;">
	딥링크
</a>


<script>
	$(function() {
		$('#aTagDeeplink').get(0).click();
		
		//브라우저 종료
		var ret = window.open("about:blank", "_self");
		ret.close();
	})
</script>