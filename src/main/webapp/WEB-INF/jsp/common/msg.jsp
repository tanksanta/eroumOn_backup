<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>E-ROUM SYSTEM</title>
	<script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>

    <script>
	$(document).ready(function() {
		alert("${alertMsg}");
		<c:choose>
			<c:when test="${not empty goUrl}">
			location.href = "${goUrl}";
			</c:when>
			<c:otherwise>
			history.back();
			</c:otherwise>
		</c:choose>
	});
	</script>
</head>
</html>