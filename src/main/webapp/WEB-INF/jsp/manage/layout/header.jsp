<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<c:set var="visibleMenuPathHeader" value="/${_mngMenuPathList[0]}/${_mngMenuPathList[1]}/" />

	<!-- header -->
    <header id="header">
        <!-- header title -->
        <a href="/_mng/intro"><h1 class="system-title small white">Management<br> System</h1></a>
        <!-- //header title -->

        <!-- main navigation -->
        <nav id="navigation">
            <ul class="menu-items">
            	<c:forEach items="${_mngMenuList }" var="mngMenu" varStatus="status">
            		<c:if test="${mngMenu.levelNo eq '2'}">
            		<%--icon필드에 클래스명 넣었음 --%>
            		<c:choose>
            			<c:when test="${mngMenu.childCnt < 1}">
				<li><a href="${mngMenu.menuUrl}" class="menu-${mngMenu.icon} ${mngMenu.menuNo eq _mngMenuPathList[1] ? ' active' : ''}"">${mngMenu.menuNm}</a></li>
            			</c:when>
            			<c:otherwise>
                <li><a href="#list-items${mngMenu.menuNo}" class="menu-${mngMenu.icon} ${mngMenu.menuNo eq _mngMenuPathList[1] ? ' active' : ''}"">${mngMenu.menuNm}</a></li>
            			</c:otherwise>
            		</c:choose>
                	</c:if>
                </c:forEach>
            </ul>

             <c:forEach items="${_mngMenuList }" var="mngMenu" varStatus="status">
				<%-- 2depth open --%>
				<c:if test="${mngMenu.levelNo eq '2'}">
            <div class="list-items ${mngMenu.menuNo eq _mngMenuPathList[1] ? ' active' : ''}" id="list-items${mngMenu.menuNo}">
                <p>
                    ${mngMenu.menuNm}
                    <small> management</small>
                </p>
                <ul>
                </c:if>

				<%-- 3depth --%>
            	<c:if test="${mngMenu.levelNo eq '3'}">
            		<c:if test="${_mngMenuList[status.index - 1].levelNo eq '4'}"><%-- 4depth end --%>
						</ul>
					</c:if>

                    <li ${mngMenu.menuNo eq _mngMenuPathList[2] ? 'class="active"' : ''}>
                    	<a href="${mngMenu.menuUrl}">${mngMenu.menuNm}<%--  // ${mngMenu.menuNo} // ${mngMenu.upMenuNo} // ${mngMenu.childCnt } --%></a>
                    	<c:if test="${mngMenu.childCnt > 0}">
                    	<ul>
                    	</c:if>
				</c:if>

				<c:if test="${mngMenu.levelNo eq '4'}">
					<li><a href="${mngMenu.menuUrl}">${mngMenu.menuNm}</a></li>
				</c:if>

				<c:if test="${mngMenu.levelNo eq '3'}">
                    </li>
				</c:if>

                <%-- 2depth close --%>
                <c:if test="${status.last || _mngMenuList[status.index + 1].levelNo eq '2'}">
                </ul>
            </div>
            	</c:if>

            </c:forEach>
        </nav>
        <!-- //main navigation -->

        <!-- admin exit -->
        <a href="#" class="back" onclick="history.back(); return false;">뒤로가기</a>
        <!-- //admin exit -->
    </header>
    <!-- //header -->