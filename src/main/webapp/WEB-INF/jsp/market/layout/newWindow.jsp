<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/html/page/market/assets/style/style.min.css?v=<spring:eval expression="@version['assets.version']"/>">
<script>
$(function(){

	<c:forEach var="newList" items="${_popupList}" varStatus="status">

		<c:if test="${newList.linkTy eq 'S'}">

		if($.cookie("popup"+${newList.popNo}) != "none"){
			var popup${newList.popNo} = window.open("/comm/popup/${newList.popNo}", "이로움ON 팝업${newList.popNo}", "width=${newList.popWidth},height=${newList.popHeight},top=${newList.popTop},left=${newList.popLeft},resizable=no,status=no,location=no,directories=no,toolbar=no,menubar=no,scrollbars=no");
			popup${newList.popNo}.focus();
		}

		</c:if>
	</c:forEach>

});
</script>