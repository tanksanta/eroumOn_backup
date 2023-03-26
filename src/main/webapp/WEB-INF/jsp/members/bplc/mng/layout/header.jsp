<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<%--
		멤버스 메뉴는 고정처리
	--%>

	<!-- header -->
    <header id="header">
        <!-- header title -->
        <h1 class="system-title"><a href="${_bplcPath}/mng/index"><img src="/html/page/office/assets/images/img-admin-logo.svg" alt=""></a></h1>
        <!-- //header title -->

        <!-- main navigation -->
        <nav id="navigation">
            <ul class="menu-items">
                <li><a href="#list-items1" class="menu-item1 ${fn:indexOf(_curPath, '/info/') > -1 || fn:indexOf(_curPath, '/mng/') < 0 || fn:indexOf(_curPath, '/index') > -1 ?'active':''}">정보수정</a></li>
                <li><a href="#list-items2" class="menu-item2 ${fn:indexOf(_curPath, '/gds/') > -1?'active':''}">상품</a></li>
                <li><a href="#list-items3" class="menu-item3 ${fn:indexOf(_curPath, '/ordr/') > -1?'active':''}">주문</a></li>
                <li><a href="#list-items4" class="menu-item4 ${fn:indexOf(_curPath, '/clcln/') > -1?'active':''}">정산</a></li>
                <li><a href="#list-items5" class="menu-item5 ${fn:indexOf(_curPath, '/set/') > -1?'active':''}">멤버스</a></li>
                <li><a href="#list-items6" class="menu-item6 ${fn:indexOf(_curPath, '/mNotice/') > -1?'active':''}">공지사항</a></li>
            </ul>
            <div class="list-items ${fn:indexOf(_curPath, 'info') > -1 || fn:indexOf(_curPath, '/index') > -1 ?'active':''}" id="list-items1">
                <p>
                    정보수정
                    <small> management</small>
                </p>
                <ul>
                    <li ${fn:indexOf(_curPath, 'info/view') > -1 ?'class="active"':''}><a href="${_bplcPath}/mng/info/view" >정보 변경</a></li>
                    <li ${fn:indexOf(_curPath, 'info/newPswd') > -1 ?'class="active"':''}><a href="${_bplcPath}/mng/info/newPswd">비밀번호 변경</a></li>
                </ul>
            </div>
            <div class="list-items ${fn:indexOf(_curPath, 'gds') > -1?'active':''}" id="list-items2">
                <p>
                    상품관리
                    <small> management</small>
                </p>
                <ul>
                    <li ${fn:indexOf(_curPath, 'gds') > -1?'class="active"':''}><a href="${_bplcPath}/mng/gds/list">상품관리</a></li>
                </ul>
            </div>
            <div class="list-items ${fn:indexOf(_curPath, '/ordr/') > -1?'active':''}" id="list-items3">
                <p>
                    주문관리
                    <small> management</small>
                </p>
                <ul>
                    <li ${fn:indexOf(_curPath, 'ordr/all') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/all">전체주문</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/or01') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/or01">주문 승인대기</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/or02') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/or02">주문 승인완료</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/or03') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/or03">주문 승인반려</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/or04') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/or04">입금대기</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/or05') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/or05">결제완료</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/or06') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/or06">배송관리</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/or09') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/or09">구매확정</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/ca01') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/ca01">취소관리</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/ex01') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/ex01">교환관리</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/re01') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/re01">반품관리</a></li>
                    <li ${fn:indexOf(_curPath, 'ordr/rf01') > -1?'class="active"':''}><a href="${_bplcPath}/mng/ordr/rf01">환불관리</a></li>
                </ul>
            </div>
            <div class="list-items ${fn:indexOf(_curPath, '/clcln/') > -1?'active':''}" id="list-items4">
                <p>
                    정산
                    <small> management</small>
                </p>
                <ul>
                    <li ${fn:indexOf(_curPath, '/clcln/') > -1?'class="active"':''}><a href="${_bplcPath}/mng/clcln/list">정산</a></li>
                </ul>
            </div>
            <div class="list-items ${fn:indexOf(_curPath, '/set/') > -1?'active':''}" id="list-items5">
                <p>
                    멤버스 관리
                    <small> management</small>
                </p>
                <ul>
                    <li ${fn:indexOf(_curPath, 'guide') > -1?'class="active"':''}><a href="${_bplcPath}/mng/set/guide">멤버스 안내</a></li>
                    <li ${fn:indexOf(_curPath, 'ntce') > -1?'class="active"':''}><a href="${_bplcPath}/mng/set/ntceList">공지사항</a></li>
                    <li ${fn:indexOf(_curPath, 'place') > -1?'class="active"':''}><a href="${_bplcPath}/mng/set/place">오시는길</a></li>
                    <li><a href="${_bplcPath}" target="_blank" class="external">멤버스 바로가기</a></li>
                </ul>
            </div>
            <div class="list-items ${fn:indexOf(_curPath, 'mNotice') > -1?'active':''}" id="list-items6">
                <p>
                    이로움마켓 공지사항
                    <small> management</small>
                </p>
                <ul>
                    <li ${fn:indexOf(_curPath, 'mNotice') > -1?'class="active"':''}><a href="${_bplcPath}/mng/mNotice/list">이로움마켓 공지사항</a></li>
                </ul>
            </div>
        </nav>
        <!-- //main navigation -->

        <!-- admin exit -->
        <a href="#" class="system-back">뒤로가기</a>
        <!-- //admin exit -->
    </header>
    <!-- //header -->