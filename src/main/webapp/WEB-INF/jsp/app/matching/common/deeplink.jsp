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
		location.href = '/';
	})
</script>