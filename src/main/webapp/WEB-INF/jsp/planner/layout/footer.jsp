<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!-- footer -->
    <footer id="footer" class="global-footer">
        <div class="footer-link">
            <!-- 회사 메뉴 -->
            <nav class="footer-menu">
                <ul>
                    <li><a href="${_plannerPath}/cntnts/company">회사소개</a></li>
                    <li><a href="${_membershipPath}/cntnts/terms" target="_blank">이용약관</a></li>
                    <li><a href="${_membershipPath}/cntnts/privacy" target="_blank"><strong>개인정보처리방침</strong></a></li>
                    <li><a href="${_plannerPath}/inqry/list" target="_blank"><strong>제휴/입점 문의</strong></a></li>
                </ul>
            </nav>
            <!-- //회사 메뉴 -->

            <!-- 패밀리 사이트 -->
            <dl class="footer-family">
                <dt>패밀리 사이트</dt>
                <dd>
                    <ul class="global-link">
                       <%--  <li>
                            <a href="${_plannerPath}" class="family-link1">
                                <div class="bubble">
                                    <small>시니어 라이프 케어 플랫폼</small>
                                    <strong>"이로움"</strong>
                                </div>
                            </a>
                        </li> --%>
                        <li>
                            <a href="${_membersPath}" class="link-item2" target="_blank" title="새창열림">
                                <div class="bubble">
                                    <strong>이로움ON 멤버스</strong>
                                    <small>전국 1,600개 업체와 함께합니다</small>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="${_marketPath}" class="link-item3" target="_blank" title="새창열림">
                                <div class="bubble">
                                    <strong><img src="/html/core/images/txt-brand-link3.png" alt="이로움ON 마켓"></strong>
                                    <small>복지용구부터 시니어 생활용품까지 한번에!</small>
                                </div>
                            </a>
                        </li>
                    </ul>
                </dd>
            </dl>
            <!-- //패밀리 사이트 -->
        </div>

        <hr>

        <div class="footer-center">
            <!-- 사이트 정보-->
            <dl class="footer-company">
                <dt><a href="#footer-collapse" data-bs-toggle="collapse" aria-expanded="false">(주)티에이치케이컴퍼니</a></dt>
                <dd id="footer-collapse" class="collapse">
                    <p>대표 : 신종호</p>
                    <p>사업자등록번호 : 617-86-14330 [<a href="javascript:;" onclick="window.open('https://www.ftc.go.kr/bizCommPop.do?wrkr_no=6178614330','communicationViewPopup','width=750,height=700,scrollbars=yes')">사업자정보확인</a>]</p>
                    <p>통신판매신고번호 : 2016-부산금정-0114</p>
                    <address>
                        <p>주소 : 부산광역시 금정구 중앙대로 1815, 5층(구서동, 가루라빌딩)</p>
                        <p>사무소 : 서울시 금천구 서부샛길 606 대성디폴리스 B동 1401호</p>
                        <p>물류센터 : 인천광역시 서구 이든1로 21</p>
                    </address>
                </dd>
            </dl>
            <!-- //사이트 정보-->

            <!-- 고객센터 -->
            <dl class="footer-customer">
                <dt>고객센터 <a href="mailto:help@thkc.co.kr">help@thkc.co.kr</a></dt>
                <dd><p><strong>운영시간 :</strong> 월~금 오전 8:30 ~ 오후 5:30 점심시간 오후 12시 ~ 1시 (주말 및 공휴일 휴무)</p></dd>
            </dl>
            <!-- //고객센터 -->
        </div>

        <hr>

        <!-- 카피 라이트 -->
        <div class="footer-copyright">Copyright ⓒ<strong>이로움ON</strong> All rights reserved</div>
        <!-- //카피 라이트 -->
    </footer>
    <!-- //footer -->