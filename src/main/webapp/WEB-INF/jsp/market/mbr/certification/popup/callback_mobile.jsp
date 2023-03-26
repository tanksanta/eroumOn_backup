<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>본인인증</title>
<style>
	body {
		margin : 0;
		overflow : hidden;
	}
</style>
</head>
<body>
<script type="text/javascript">
if(opener==null || opener==undefined) {opener= window.open("", "niceIdPopup")};
<c:if test="${!empty mbrVO}">
	<c:choose>
		<c:when test="${rtnTy eq 'findPwd'}">
		//opener.fnConfirm('${findMbrVO.mbrId}', '${findMbrVO.mbrNm}', '${findMbrVO.email}'); //재확인
		self.close();
		</c:when>
		<c:otherwise>
		opener.location.href="/market/mbr/registStep2";
		self.close();
		</c:otherwise>
	</c:choose>
</c:if>
<c:if test="${empty mbrVO}">
alert("인증에 실패하였습니다.");
self.close();
</c:if>
</script>
</body>
</html>
