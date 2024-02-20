<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/app/matching/common/appCommon.jsp" />

<script>
$(async function() {
	var appMsg = '${appMsg}';
	var appLocation = '${appLocation}';
	if (appMsg) {
		await showAlertPopup(appMsg);
		
		if (!appLocation) {
			history.back();
		}
	}
	if (appLocation) {
		location.href = appLocation;
	}
});
</script>