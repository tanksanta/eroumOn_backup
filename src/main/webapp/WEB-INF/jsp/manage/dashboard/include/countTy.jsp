<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <!-- 한자리 -->
 <c:if test="${param.countTy < 10 }">
 	<!-- <span></span> -->
 	<span></span>
 	<span></span>
 	<span data-num="${param.countTy}">${param.countTy}</span>
 </c:if>

 <!-- 두자리 -->
 <c:if test="${9 < param.countTy && param.countTy < 100}">
 	<!-- <span></span> -->
 	<span></span>
	<span data-num="${fn:substring(param.countTy,0,1)}">${fn:substring(param.countTy,0,1)}</span>
	<span data-num="${fn:substring(param.countTy,1,2)}">${fn:substring(param.countTy,1,2)}</span>
</c:if>

<!-- 세자리 -->
 <c:if test="${99 < param.countTy && param.countTy < 1000}">
  <!-- <span></span> -->
  <span data-num="${fn:substring(param.countTy,0,1)}">${fn:substring(param.countTy,0,1)}</span>
  <span data-num="${fn:substring(param.countTy,1,2)}">${fn:substring(param.countTy,1,2)}</span>
  <span data-num="${fn:substring(param.countTy,2,3)}">${fn:substring(param.countTy,2,3)}</span>
</c:if>

<!-- 네자리
 <c:if test="${999 < param.countTy && param.countTy < 10000}">
  <span data-num="${fn:substring(param.countTy,0,1)}">${fn:substring(param.countTy,0,1)}</span>
  <span data-num="${fn:substring(param.countTy,1,2)}">${fn:substring(param.countTy,1,2)}</span>
  <span data-num="${fn:substring(param.countTy,2,3)}">${fn:substring(param.countTy,2,3)}</span>
  <span data-num="${fn:substring(param.countTy,3,4)}">${fn:substring(param.countTy,3,4)}</span>
</c:if>-->


<!-- 주문과정 -->
	 <!-- 한자리 -->
	 <c:if test="${param.ordrPc < 10 }">
	 	<span></span>
	 	<span data-num="${param.ordrPc}">${param.ordrPc}</span>
	 </c:if>

	 <!-- 두자리 -->
	 <c:if test="${9 < param.ordrPc && param.ordrPc < 100}">
		<span data-num="${fn:substring(param.ordrPc,0,1)}">${fn:substring(param.ordrPc,0,1)}</span>
		<span data-num="${fn:substring(param.ordrPc,1,2)}">${fn:substring(param.ordrPc,1,2)}</span>
	</c:if>
<!-- 주문과정 -->


<!-- 회원 수  -->
<c:if test="${param.mbrCount != null }">
	<span data-num="${fn:substring(param.mbrCount,7,8)}">${fn:substring(param.mbrCount,7,8)}</span>
	<span data-num="${fn:substring(param.mbrCount,6,7)}">${fn:substring(param.mbrCount,6,7)}</span>
	<span class="space" data-num="${fn:substring(param.mbrCount,5,6)}">${fn:substring(param.mbrCount,5,6)}</span>
	<span data-num="${fn:substring(param.mbrCount,4,5)}">${fn:substring(param.mbrCount,4,5)}</span>
	<span data-num="${fn:substring(param.mbrCount,3,4)}">${fn:substring(param.mbrCount,3,4)}</span>
	<span class="space" data-num="${fn:substring(param.mbrCount,2,3)}">${fn:substring(param.mbrCount,2,3)}</span>
	<span data-num="${fn:substring(param.mbrCount,1,2)}">${fn:substring(param.mbrCount,1,2)}</span>
	<span data-num="${fn:substring(param.mbrCount,0,1)}">${fn:substring(param.mbrCount,0,1)}</span>
</c:if>

<!-- 멤버스 수 -->
<c:if test="${param.bplcCount != null }">

	<span data-num="${fn:substring(param.bplcCount,6,7)}">${fn:substring(param.bplcCount,6,7)}</span>
	<span class="space" data-num="${fn:substring(param.bplcCount,5,6)}">${fn:substring(param.bplcCount,5,6)}</span>
	<span data-num="${fn:substring(param.bplcCount,4,5)}">${fn:substring(param.bplcCount,4,5)}</span>
	<span data-num="${fn:substring(param.bplcCount,3,4)}">${fn:substring(param.bplcCount,3,4)}</span>
	<span class="space" data-num="${fn:substring(param.bplcCount,2,3)}">${fn:substring(param.bplcCount,2,3)}</span>
	<span data-num="${fn:substring(param.bplcCount,1,2)}">${fn:substring(param.bplcCount,1,2)}</span>
	<span data-num="${fn:substring(param.bplcCount,0,1)}">${fn:substring(param.bplcCount,0,1)}</span>
</c:if>
