<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<!-- header -->
        <header id="header">
            <h1 class="logo">
                <a href="${_bplcPath}">${bplcSetupVO.bplcNm}</a>
            </h1>

            <button type="button" class="infomation-close">모바일 소개 닫기</button>

            <div class="infomation">
            	<c:if test="${empty bplcSetupVO.proflImg}">
            		<p class="photo"></p>
            	</c:if>
            	<c:if test="${!empty bplcSetupVO.proflImg}">
				<p><img src="/comm/PROFL/getFile?fileName=${bplcSetupVO.proflImg}" id="proflImg" class="photo"></p>
               	</c:if>
                <p class="map"><a href="${_bplcPath}/lctn">${bplcSetupVO.addr} &nbsp;${bplcSetupVO.daddr}</a></p>
                <p class="tel"><a href="tel:${bplcSetupVO.telno}">${bplcSetupVO.telno}</a></p>

                <c:if test="${bplcSetupVO.bsnHrBgng ne null || !empty bplcSetupVO.hldy}">
                <p class="time">
                	<c:if test="${bplcSetupVO.bsnHrBgng ne null}">
	                	${bplcSetupVO.bsnHrBgng} ~ ${bplcSetupVO.bsnHrEnd}
	                	<i></i>
                	</c:if>
                </p>
                <p class="rest">
                	<c:if test="${!empty bplcSetupVO.hldy}">
	                	휴무 :
	               		<c:forEach var="day" items="${fn:replace(bplcSetupVO.hldy,' ','')}" varStatus="status">
	               		<c:if test="${day ne 'Z'}">
	               		${bplcRstdeCode[day]}${!status.last?', ':'' }
	               		</c:if>
	               		</c:forEach>
	                   	${bplcSetupVO.hldyEtc}
                	</c:if>
                </p>
                </c:if>
                <p class="park">${bplcSetupVO.parkngYn eq 'Y'?'주차가능':'주차불가'}</p>
                <p class="desc">${bplcSetupVO.intrcn}</p>
                <dl class="banner2">
                    <dt class="sr-only">배너영역</dt>
                    <dd><a href="/"><img src="/html/page/office/assets/images/banner/img-eroum-banner1-small.png" alt=""></a></dd>
                    <dd><a href="/market"><img src="/html/page/office/assets/images/banner/img-eroum-banner2-small.png" alt=""></a></dd>
                </dl>
                <c:if test="${!empty bplcNtceTop5 }">
                <dl class="notice">
                    <dt>공지사항</dt>
                    <dd>
                        <ul>
                        	<c:forEach items="${bplcNtceTop5}" var="bplcNtce">
                            <li>
                                <a href="${_bplcPath}/bbs/notice/view?nttNo=${bplcNtce.nttNo}">
                                    <span>${bplcNtce.ttl}</span>
                                    <em>${bplcNtce.wrtYmd}</em>
                                </a>
                            </li>
                            </c:forEach>
                        </ul>
                    </dd>
                </dl>
                </c:if>
            </div>
        </header>
        <!-- //header -->