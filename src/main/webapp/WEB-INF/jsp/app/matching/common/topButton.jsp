<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.topBtnDiv {
	    display: flex;
    	justify-content: space-between;
	}
</style>

<div class="topBtnDiv">
	<a href="javascript:history.back();">&lt;</a>
	
	<c:if test="${!empty param.addButton}">
		<a href="#">${param.addButton}</a>
	</c:if>
</div>