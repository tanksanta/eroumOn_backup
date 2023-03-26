<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

            <!-- page header -->
            <header id="page-header">
            	<c:choose>
            		<%-- <c:when test="${fn:indexOf(_curPath, '/dashboard/') > -1}"> --%>
            		<c:when test="${param.pageTitle eq 'TODAY REPORT'}">
            	<h1 class="text-title1 font-serif font-normal uppercase tracking-tight">${param.pageTitle} <span class="text-danger text-xl font-normal">${_today}</span></h1>
            		</c:when>
            		<c:otherwise>
                <h1 class="text-title1">${param.pageTitle}</h1>
            		</c:otherwise>
            	</c:choose>

                <a href="${_bplcPath}/mng/info/view" class="user-info">
                    <span class="name">
                        <strong>${_partnersSession.partnersId }</strong>
                        <small>접속중 <span>-</span></small>
                    </span>
                    <span class="thum">
                    	<c:if test="${!empty _partnersSession.proflImg}">
                    	<img src="/comm/PROFL/getFile?fileName=${_partnersSession.proflImg}" id="proflImg">
                    	</c:if>
                    </span>
                </a>
                <a href="/<spring:eval expression="@props['Globals.Members.path']"/>/logout" class="btn-logout">Logout</a>
            </header>
            <!-- //page header -->