<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<header>
     <nav class="top">
       <a class="btn_back waves-effect" href="javascript:history.back();">
         <span class="icon"></span>
       </a>
       <c:if test="${!empty param.addButton}">
         <a class="waves-effect top_txt" href="#">둘러보기</a>
       </c:if>
     </nav>
   </header>