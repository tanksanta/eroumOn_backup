<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


    <!-- quick -->
    <div id="quick">
        <button type="button">위로 이동</button>
    </div>
    <!-- //quick -->

	<footer id="footer">
        <div class="footer-link">
            <!-- 회사 메뉴 -->
            <nav class="footer-menu">
                <ul>
                    <li><a href="#">회사소개</a></li>
                    <li><a href="#">이용약관</a></li>
                    <li><a href="#">전자금융거래약관</a></li>
                    <li><a href="#"><strong>개인정보보호방침</strong></a></li>
                </ul>
            </nav>
            <!-- //회사 메뉴 -->

            <!-- 패밀리 사이트 -->
            <dl class="footer-family">
                <dt>
                    이로움
                    <small>패밀리 사이트</small>
                </dt>
                <dd>
                    <ul>
                        <li>
                            <a href="${_plannerPath}" target="_blank" title="새창열림" class="family-link1">
                                <div class="bubble">
                                    <small>시니어 라이프 케어 플랫폼</small>
                                    <strong>"이로움"</strong>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="${_membersPath}" target="_blank" title="새창열림" class="family-link2">
                                <div class="bubble">
                                    <strong>이로움 멤버스</strong>
                                    <small>전국 <fmt:formatNumber value="${_bplcCnt}" pattern="###,###" />개 업체와 함께합니다</small>
                                </div>
                            </a>
                        </li>
                        <!--
                        <li>
                            <a href="/market" target="_blank" title="새창열림" class="family-link3">
                                <div class="bubble">
                                    <strong><img src="/html/page/market/assets/images/txt-footer-family3.svg" alt="이로움마켓"></strong>
                                    <small>
                                        복지용구 사업소와 수급자 매칭부터<br>
                                        주문, 계약 및 결제까지 한번에!
                                    </small>
                                </div>
                            </a>
                        </li>
                        -->
                    </ul>
                </dd>
            </dl>
            <!-- //패밀리 사이트 -->
        </div>

        <hr>

        <div class="footer-center">
            <!-- 사이트 정보-->
            <dl class="footer-company">
                <dt>(주)티에이치케이컴퍼니</dt>
                <dd>
                    <p>대표 : 신종호</p>
                    <p>사업자등록번호 : 617-86-14330 [<a href="#">사업자정보확인</a>]</p>
                    <p>통신판매신고번호 : 2018-서울강남-04157</p>
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
                <dt>고객센터</dt>
                <dd>
                    <p><strong>주문안내 :</strong> <a href="tel:1588-1312">1588-1312</a></p>
                    <p><strong>시스템안내 :</strong> <a href="tel:02-830-1312">02-830-1312</a></p>
                </dd>
                <dd>
                    <p><strong>운영시간 :</strong> 월~금 오전 9:00~오후 6:00 점심시간 오후 12시 ~ 1시 (주말 및 공휴일 휴무)</p>
                </dd>
            </dl>
            <!-- //고객센터 -->
        </div>

        <hr>

        <!-- 카피 -->
        <div class="footer-copyright">Copyright ⓒ<strong>EROUMMARKET</strong> All righs reserved</div>
        <!-- //카피 -->
    </footer>

    <script>
    	// 사업자 정보 조회
		function f_searchBrnoInfo(brno) {
			var url = "http://www.ftc.go.kr/bizCommPop.do?wrkr_no="+ brno;
			window.open(url, "bizCommPop","width=750, height=700;");
		}
	</script>