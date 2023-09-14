<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

        <div id="page-navigation">
            <div class="global-user ${_mbrSession.mberGrade eq 'E' ? 'is-grade1' : _mbrSession.mberGrade eq 'B' ? 'is-grade2' : _mbrSession.mberGrade eq 'S' ? 'is-grade3' : _mbrSession.mberGrade eq 'N' ? '' : ''}">
                <div class="user-name">
                    <strong>${_mbrSession.mbrNm} <small>님</small></strong>
                    <span>${recipterYnCode[_mbrSession.recipterYn]}</span>
                </div>
                <div class="user-info">
                    <div class="grade">
                        <strong>${gradeCode[_mbrSession.mberGrade]}</strong>
                        <a href="${_marketPath}/etc/bnft/list">등급별혜택</a>
                    </div>
                    <div class="point">
                        <dl>
                            <dt>쿠폰</dt>
                            <dd><a href="${_marketPath}/mypage/coupon/list"><strong>${_mbrEtcInfoMap.totalCoupon }</strong> 장</a></dd>
                        </dl>
                        <dl>
                            <dt>포인트</dt>
                            <dd><a href="${_marketPath}/mypage/point/list"><strong><fmt:formatNumber value="${_mbrEtcInfoMap.totalPoint}" pattern="###,###" /></strong> <img src="/html/core/images/txt-point-white.svg" alt="포인트"></a></dd>
                        </dl>
                        <dl>
                            <dt>마일리지</dt>
                            <dd><a href="${_marketPath}/mypage/mlg/list"><strong><fmt:formatNumber value="${_mbrEtcInfoMap.totalMlg}" pattern="###,###" /></strong> <img src="/html/core/images/txt-mileage-white.svg" alt="마일리지"></a></dd>
                        </dl>
                    </div>
                </div>
            </div>
            <nav class="menu">
                <ul class="menu-items">
                    <li class="menu-item">
                        <a href="${_membershipPath}/conslt/appl/list" class="menu-link">나의 상담 관리</a>
                        <ul class="smenu-items">
                            <li class="smenu-item"><a href="${_membershipPath}/conslt/appl/list" class="smenu-link ${fn:indexOf(_curPath, '/appl/') > -1?'is-active':'' }">인정등급 상담신청</a></li>
                            <li class="smenu-item"><a href="${_membershipPath}/conslt/itrst/bplc" class="smenu-link ${fn:indexOf(_curPath, '/itrst/') > -1?'is-active':'' }">관심 멤버스 설정</a></li>
                        </ul>
                    </li>
                    <li class="menu-item">
                        <a href="${_membershipPath}/info/myinfo/list" class="menu-link">나의 정보 관리</a>
                        <ul class="smenu-items">
                            <li class="smenu-item"><a href="${_membershipPath}/info/myinfo/confirm" class="smenu-link ${fn:indexOf(_curPath, '/myinfo/') > -1?'is-active':'' }">내 정보수정</a></li>
                            <li class="smenu-item"><a href="${_membershipPath}/info/dlvy/list" class="smenu-link ${fn:indexOf(_curPath, '/dlvy/') > -1?'is-active':'' }">배송지 관리</a></li>
                            <li class="smenu-item"><a href="${_membershipPath}/info/whdwl/form" class="smenu-link ${fn:indexOf(_curPath, '/whdwl/') > -1?'is-active':'' }">회원탈퇴</a></li>
                        </ul>
                    </li>
                    <li class="menu-item"><a href="${_marketPath}/mypage/index" class="menu-link" target="_blank">나의 쇼핑 관리</a></li>
                </ul>
            </nav>
        </div>

