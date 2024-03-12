<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<header>
      <nav class="top">
       <a class="btn_back waves-effect" onclick="backBtnEvent();">
         <c:if test="${param == null || empty param.noBackButtion}">
          <span class="icon"></span>
         </c:if>

         
         <c:if test="${param != null && !empty param.addTitle}">
          <span class="txt">${param.addTitle}</span>
         </c:if>
         
       </a>
       <c:if test="${param != null && !empty param.addButton}">
         <a class="waves-effect top_txt" href="#">${param.addButton}</a>
       </c:if>
       <c:if test="${param != null && !empty param.addShare}">
          <div class="icon_btn i_share"></div>
       </c:if>
       <c:if test="${param != null && !empty param.addCustom1}">
        <c:if test="${param != null && !empty param.addCustom1ModalTrigger}">
          <a class="top_txt modal-trigger" data-target="${param.addCustom1ModalTrigger}">${param.addCustom1Text}</a>
        </c:if>
        <c:if test="${param != null && empty param.addCustom1ModalTrigger}">
          <a class="waves-effect top_txt addCustom1">${param.addCustom1Text}</a> 
        </c:if>
          
       </c:if>
     </nav>
   </header>
   
   
   <script>
	  	function backBtnEvent() {
        <c:if test="${param != null && !empty param.noBackButtion}">
          return;
        </c:if>
	  		//history.back();
	  		
	  		//이전 페이지로 이동
	  		var history = popHistoryStack(-1);
	  		if (history) {
	  			location.href = history;
	  		}
	  	}
	  	
	  	$(function() {
	  		saveCurrentPageHistory();
	  	});
   </script>
   