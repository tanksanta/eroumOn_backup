<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>Template</title>

    <!-- plugin -->
    <link rel="stylesheet" href="../../../core/vendor/jstree/dist/themes/default/style.min.css">
    <link rel="stylesheet" href="../../../core/vendor/jquery/jquery-ui.min.css">

    <script src="../../../core/vendor/jquery/jquery-3.6.0.min.js"></script>
    <script src="../../../core/vendor/jquery/jquery-ui.min.js"></script>
    <script src="../../../core/vendor/jstree/dist/jstree.min.js"></script>

    <!-- admin -->
    <link rel="stylesheet" href="../assets/style/style.min.css">
    <script src="../assets/script/common.js"></script>
</head>
<body>
    <!-- header -->
    <header id="header">
        <!-- header title -->
        <h1 class="system-title small white">Management<br> System</h1>
        <!-- //header title -->

        <!-- main navigation -->
        <nav id="navigation">
            <ul class="menu-items">
                <li><a href="dashboard.html" class="menu-item1">대시보드</a></li>
                <li><a href="#list-items2" class="menu-item2 active">회원관리</a></li>
                <li><a href="#list-items3" class="menu-item3">상품관리</a></li>
                <li><a href="#list-items4" class="menu-item4">주문관리</a></li>
                <li><a href="#list-items5" class="menu-item5">전시관리</a></li>
                <li><a href="#list-items11" class="menu-item11">프로모션관리</a></li>
                <li><a href="#list-items7" class="menu-item7">고객상담관리</a></li>
                <li><a href="#list-items8" class="menu-item8">시스템관리</a></li>
                <li><a href="#list-items9" class="menu-item9">정산관리</a></li>
                <li><a href="#list-items10" class="menu-item10">통계관리</a></li>
            </ul>
            <div class="list-items active" id="list-items2">
                <p>
                    회원관리
                    <small> management</small>
                </p>
                <ul>
                    <li><a href="/_mng/mbr/list">일반회원관리</a></li>
                    <li><a href="#">블랙리스트회원관리</a></li>
                    <li><a href="#">휴면회원관리</a></li>
                    <li><a href="#">탈퇴회원관리</a></li>
                    <li><a href="#">SMS 전송 이력</a></li>
                </ul>
            </div>
            <div class="list-items" id="list-items3">
                <p>
                    상품관리
                    <small> management</small>
                </p>
                <ul>
                    <li><a href="#">카테고리관리</a></li>
                    <li><a href="#">상품관리</a></li>
                    <li><a href="#">상품일괄업로드</a></li>
                    <li><a href="#">상품재고관리</a></li>
                </ul>
            </div>
            <div class="list-items" id="list-items4">
                <p>
                    주문관리
                    <small> management</small>
                </p>
                <ul>
                    <li><a href="#">전체주문</a></li>
                    <li><a href="#">입금대기</a></li>
                    <li><a href="#">결제완료</a></li>
                    <li><a href="#">배송관리</a></li>
                    <li><a href="#">구매확정</a></li>
                    <li><a href="#">취소관리</a></li>
                    <li><a href="#">멤버스취소요청</a></li>
                    <li><a href="#">교환관리</a></li>
                    <li><a href="#">반품관리</a></li>
                    <li><a href="#">환불관리</a></li>
                </ul>
            </div>
            <div class="list-items" id="list-items5">
                <p>
                    전시관리
                    <small> management</small>
                </p>
                <ul>
                    <li><a href="#">추천상품관리</a></li>
                    <li><a href="#">테마전시관리</a></li>
                    <li><a href="#">팝업관리</a></li>
                    <li><a href="#">광고관리</a></li>
                </ul>
            </div>
            <div class="list-items" id="list-items11">
                <p>
                    프로모션관리
                    <small> management</small>
                </p>
                <ul>
                    <li><a href="#">기획전</a></li>
                    <li><a href="#">이벤트</a></li>
                    <li><a href="#">쿠폰</a></li>
                    <li><a href="#">포인트</a></li>
                    <li><a href="#">마일리지</a></li>
                </ul>
            </div>
            <div class="list-items" id="list-items7">
                <p>
                    고객상담관리
                    <small> management</small>
                </p>
                <ul>
                    <li><a href="#">상품후기</a></li>
                    <li><a href="#">상품Q&amp;A</a></li>
                </ul>
            </div>
            <div class="list-items" id="list-items8">
                <p>
                    시스템관리
                    <small> management</small>
                </p>
                <ul>
                    <li><a href="#">관리자관리</a></li>
                    <li><a href="#">권한관리</a></li>
                    <li><a href="#">메뉴관리</a></li>
                    <li><a href="#">게시판관리</a></li>
                    <li><a href="#">금지어관리</a></li>
                    <li><a href="#">업체(멤버스)관리</a></li>
                    <li><a href="#">제조사관리</a></li>
                    <li><a href="#">배송업체관리</a></li>
                    <li><a href="#">공통코드관리</a></li>
                </ul>
            </div>
            <div class="list-items" id="list-items9">
                <p>
                    정산관리
                    <small> management</small>
                </p>
                <ul>
                    <li><a href="#">정산목록</a></li>
                </ul>
            </div>
            <div class="list-items" id="list-items10">
                <p>
                    통계관리
                    <small> management</small>
                </p>
                <ul>
                    <li><a href="#">매출통계</a></li>
                    <li><a href="#">회원통계</a></li>
                </ul>
            </div>
        </nav>
        <!-- //main navigation -->

        <!-- admin exit -->
        <a href="dashboard.html" class="back">뒤로가기</a>
        <!-- //admin exit -->
    </header>
    <!-- //header -->

    <!-- main content -->
    <main id="container">
        <div id="content">
            <!-- page header -->
            <header id="page-header">
                <h1 class="text-title1">일반회원 관리</h1>
                <nav class="breadcrumb">
                    <ul>
                        <li><a href="#">회원관리</a></li>
                        <li><strong>일반회원 관리</strong></li>
                    </ul>
                </nav>
                <a href="#" class="user-info">
                    <span class="name">
                        <strong>Login-ID-abcd</strong>
                        <small>접속중 <span>19:20:31</span></small>
                    </span>
                    <span class="thum"></span>
                </a>
                <a href="login.html" class="btn-logout">Logout</a>
            </header>
            <!-- //page header -->

            <!-- page content -->
            <div id="page-content">

            </div>
            <!-- //page content -->
        </div>
    </main>
    <!-- //main content -->

    <script src="../../../core/vendor/twelements/index.min.js"></script>
</body>
</html>


<%--
<!doctype html>
<html lang="ko" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none">

<head>

    <meta charset="utf-8" />
    <title>PMS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- App favicon
    <link rel="shortcut icon" href="/assets/images/favicon.ico">
    -->

    <!-- jsvectormap css -->
    <link href="/assets/libs/jsvectormap/css/jsvectormap.min.css" rel="stylesheet" type="text/css" />

    <!--Swiper slider css-->
    <link href="/assets/libs/swiper/swiper-bundle.min.css" rel="stylesheet" type="text/css" />

    <!-- Layout config Js -->
    <script src="/assets/js/layout.js"></script>
    <!-- Bootstrap Css -->
    <link href="/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="/assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <!-- custom Css-->
    <link href="/assets/css/custom.min.css" rel="stylesheet" type="text/css" />

    <script src="/assets/js/jquery-3.5.0.min.js"></script>

</head>

<body>

    <!-- Begin page -->
    <div id="layout-wrapper">

		<tiles:insertAttribute name="header"/>

		<tiles:insertAttribute name="aside" />

        <!-- Vertical Overlay-->
        <div class="vertical-overlay"></div>

        <div class="main-content">

            <div class="page-content">
                <div class="container-fluid">

					<tiles:insertAttribute name="breadcrumb"/>

					<tiles:insertAttribute name="content"/>

                </div>
            </div>

            <tiles:insertAttribute name="footer"/>

        </div>
        <!-- end main content-->

    </div>
    <!-- END layout-wrapper -->



    <!--start back-to-top-->
    <button onclick="topFunction()" class="btn btn-danger btn-icon" id="back-to-top">
        <i class="ri-arrow-up-line"></i>
    </button>
    <!--end back-to-top-->


    <!-- JAVASCRIPT -->
    <script src="/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/assets/libs/simplebar/simplebar.min.js"></script>
    <script src="/assets/libs/node-waves/waves.min.js"></script>
    <script src="/assets/libs/feather-icons/feather.min.js"></script>
    <script src="/assets/js/pages/plugins/lord-icon-2.1.0.js"></script>

	<!-- script add -->


    <!-- App js -->
    <script src="/assets/js/app.js"></script>
</body>

</html>
--%>