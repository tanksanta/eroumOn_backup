<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<header>
      <nav class="top">
       <a class="btn_back waves-effect" onclick="backBtnEvent();">
         <span class="icon"></span>
         <c:if test="${param != null && !empty param.addTitle}">
          <span class="txt">${param.addTitle}</span>
         </c:if>
         
       </a>
       <c:if test="${param != null && !empty param.addButton}">
         <a class="waves-effect top_txt" href="#">${param.addButton}</a>
       </c:if>
     </nav>
   </header>
   
   
   <script>
	  	function backBtnEvent() {
	  		//history.back();
	  		
	  		//이전 페이지로 이동
	  		var history = popHistoryStack(-1);
	  		if (history) {
	  			location.href = history;
	  		}
	  	}
	  	
	  	$(function() {
	  		pushHistoryStack(location.pathname);
	  	});
   </script>
   