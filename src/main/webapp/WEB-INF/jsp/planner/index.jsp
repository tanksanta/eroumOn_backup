<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


        <!-- 회원정보 비쥬얼 -->
        <div id="userinfo">
            <div class="container">
                <div class="userinfo-slogan">
                    <p>편하고 행복한 삶</p>
                    <img src="/html/page/planner/assets/images/txt-slogan.svg" alt="이로움과 함께 설계하세요">
                </div>
                <div class="userinfo-box">
                    <div class="userinfo-title">
                        <p>꿈꾸는 시니어를 위한</p>
                        <picture>
                            <source srcset="/html/page/planner/assets/images/txt-login-title-white.svg" media="(max-width: 1039px)">
                            <source srcset="/html/page/planner/assets/images/txt-login-title.svg">
                            <img src="/html/page/planner/assets/images/txt-login-title.svg" alt="" />
                        </picture>
                    </div>
                    <%--
                    <!-- 로그인시 -->
                    <div class="userinfo-count">
                        <div class="user">
                            <p class="name">정경석 <small>64세, 서울 용산구</small></p>
                            <p class="button">
                                <a href="#" class="btn btn-outline-primary">설정</a>
                                <a href="#" class="btn btn-primary">로그아웃</a>
                            </p>
                        </div>
                        <div class="desc2">
                            <strong>내게 <em>딱</em> 맞는</strong><br>
                            <strong>복지서비스<span>를</span> 한 곳<span>에</span>…</strong>
                        </div>
                        <p class="count"><strong>12,345</strong> 건</p>
                        <div class="scroll">
                            <a href="#page" class="close-button">바로 확인하세요</a>
                            <div>
                                <img src="/html/page/planner/assets/images/ico-project1-white.svg" alt="">
                                <img src="/html/page/planner/assets/images/ico-project6-white.svg" alt="">
                                <img src="/html/page/planner/assets/images/ico-project7-white.svg" alt="">
                                <img src="/html/page/planner/assets/images/ico-project8-white.svg" alt="">
                            </div>
                        </div>
                    </div>
                    <!-- //로그인시 -->
 					--%>

                    <!-- 미로그인시 -->
                    <div class="userinfo-count">
                        <p class="title">복지서비스</p>
                        <p class="desc">
                            <small>대한민국 모든 <strong>시니어를 위한 복지서비스</strong></small>
                            <strong>한 곳</strong>에 모아서…
                        </p>
                        <p class="count"><strong class="srvcListCnt">0</strong> 건</p>
                        <div class="dropbox">
                            <div class="dropdown select-sido">
                                <button class="dropdown-toggle" type="button" id="area-toggle1" data-bs-toggle="dropdown" aria-expanded="false">-</button>
                                <ul class="dropdown-menu" aria-labelledby="area-toggle1">
                                	<c:forEach items="${stdgCdList}" var="stdg">
		                            <li><a class="dropdown-item" href="#" data-stdg-cd="${stdg.stdgCd}" data-ctpv-nm="${stdg.ctpvNm}">${stdg.ctpvNm}</a></li>
		                            </c:forEach>
                                </ul>
                            </div>
                            <div class="dropdown select-gugun">
                                <button class="dropdown-toggle" type="button" id="area-toggle2" data-bs-toggle="dropdown" aria-expanded="false">-</button>
                                <ul class="dropdown-menu" aria-labelledby="area-toggle2">
                                </ul>
                            </div>
                        </div>
                        <div class="scroll">
                            <a href="#page" class="close-button">바로 확인하세요</a>
                            <div>
                                <img src="/html/page/planner/assets/images/ico-project1-white.svg" alt="">
                                <img src="/html/page/planner/assets/images/ico-project6-white.svg" alt="">
                                <img src="/html/page/planner/assets/images/ico-project7-white.svg" alt="">
                                <img src="/html/page/planner/assets/images/ico-project8-white.svg" alt="">
                            </div>
                        </div>
                    </div>
                    <!-- //미로그인시 -->
                    <div class="userinfo-link">
                        <a href="${_plannerPath }/Senior-Long-Term-Care" class="link-grade">장기요양보험</a>
                        <a href="${_plannerPath }/Senior-Friendly-Foods" class="link-foods">고령친화 식품</a>
                    </div>
                    <div class="userinfo-member">
                        <div class="userinfo-member-market">
                            <a href="${_marketPath }/index">
                                <strong>이로움 마켓</strong>
                                복지용구 사업소와 수급자 매칭부터<br>
                                주문, 계약 및 결제까지 한번에!
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- //회원정보 비쥬얼 -->

        <!-- 본문 영역 -->
        <div id="content">
            <!-- 서비스 셀렉트 -->
            <div class="page-option">
                <h2>
                    <small>나를 위한</small>
                    복지서비스
                </h2>
                <ul>
                    <li class="option-item7">
                        <label for="opt-item7">
                            <input type="checkbox" name="category" value="지원" id="opt-item7">
                            <span>지원</span>
                        </label>
                    </li>
                    <li class="option-item8">
                        <label for="opt-item8">
                            <input type="checkbox" name="category" value="보호" id="opt-item8">
                            <span>보호</span>
                        </label>
                    </li>
                    <li class="option-item6">
                        <label for="opt-item6">
                            <input type="checkbox" name="category" value="상담" id="opt-item6">
                            <span>상담</span>
                        </label>
                    </li>
                    <li class="option-item3">
                        <label for="opt-item3">
                            <input type="checkbox" name="category" value="보건" id="opt-item3">
                            <span>보건</span>
                        </label>
                    </li>
                    <li class="option-item4">
                        <label for="opt-item4">
                            <input type="checkbox" name="category" value="고용" id="opt-item4">
                            <span>고용</span>
                        </label>
                    </li>
                    <li class="option-item2">
                        <label for="opt-item2">
                            <input type="checkbox" name="category" value="문화" id="opt-item2">
                            <span>문화</span>
                        </label>
                    </li>
                    <li class="option-item1">
                        <label for="opt-item1">
                            <input type="checkbox" name="category" value="주거" id="opt-item1">
                            <span>주거</span>
                        </label>
                    </li>
                    <li class="option-item5">
                        <label for="opt-item5">
                            <input type="checkbox" name="category" value="교육" id="opt-item5">
                            <span>교육</span>
                        </label>
                    </li>
                </ul>
            </div>
            <!-- //서비스 셀렉트 -->

            <!-- 서비스 검색 -->
            <div class="page-search">
                <div class="search-dropdown">
                    <div class="dropdown dropdown-menu1 select-sido">
                        <button class="dropdown-toggle" type="button" id="area-toggle3" data-bs-toggle="dropdown" aria-expanded="false">-</button>
                        <ul class="dropdown-menu" aria-labelledby="area-toggle3">
                        	<c:forEach items="${stdgCdList}" var="stdg">
                            <li><a class="dropdown-item" href="#" data-stdg-cd="${stdg.stdgCd}" data-ctpv-nm="${stdg.ctpvNm}">${stdg.ctpvNm}</a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="dropdown dropdown-menu2 select-gugun">
                        <button class="dropdown-toggle" type="button" id="area-toggle4" data-bs-toggle="dropdown" aria-expanded="false">-</button>
                        <ul class="dropdown-menu" aria-labelledby="area-toggle4">
                        </ul>
                    </div>
                    <button type="button" class="btn btn-primary srch-srvc">서비스 검색</button>
                </div>
                <div class="search-tabs">
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a href="#tabs-cont1" class="nav-link active" data-bs-toggle="pill" data-bs-target="#tabs-cont1" role="tab" aria-selected="true">
                                <span>복지제도</span>
                                <strong class="srvcListCnt">0</strong>
                                <small>건</small>
                                <i></i>
                            </a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a href="#tabs-cont2" class="nav-link" data-bs-toggle="pill" data-bs-target="#tabs-cont2" role="tab" aria-selected="false">
                                <span>복지시설</span>
                                <strong>0</strong>
                                <small>곳</small>
                                <i></i>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            
            <!-- //서비스 검색 -->
            <div class="page-content tab-content">
                <!-- 서비스 본문(복지제도) -->
                <div class="tab-pane fade show active" id="tabs-cont1" role="tabpanel">
                	<div class="cont-target">
	                	<div style="margin:5vh 0;">
						    <div class="box-loading">
						        <div class="icon">
						            <span></span><span></span><span></span>
						        </div>
						        <p class="text">데이터를 불러오는 중입니다.</p>
						    </div>
						</div>
                	</div>
                    <div class="page-content-paging">
                        <div class="flow"></div>
					</div>
				</div>
                <!-- //서비스 본문(복지제도) -->

                <!-- 서비스 본문(복지시설) -->
                <div class="tab-pane fade" id="tabs-cont2" role="tabpanel">
                    <div class="page-content-map">
                        <div id="map" class="map-area"></div>
                        <div class="map-select">
                            <button class="resizer">
                                <span class="sr-only">사이즈 조정</span>
                            </button>
                            <ul class="nav nav-tabs" role="tablist">
                                <li class="nav-item" role="presentation"><a href="#marker-cont1" class="nav-link nav-link-item1 active" data-bs-toggle="pill" data-bs-target="#marker-cont1" role="tab" aria-selected="true">이로움 멤버스</a></li>
                                <li class="nav-item" role="presentation"><a href="#marker-cont2" class="nav-link nav-link-item2" data-bs-toggle="pill" data-bs-target="#marker-cont2" role="tab" aria-selected="false">재가시설</a></li>
                                <li class="nav-item" role="presentation"><button type="button" class="nav-link nav-link-item3" aria-selected="false">현재위치 검색</button></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade show active" id="marker-cont1" role="tabpanel">
                                    <!-- 멤버스 -->
                                    <div class="map-select-items">
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link is-members">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="marker-cont2" role="tabpanel">
                                    <!-- 재가시설 -->
                                    <div class="map-select-items">
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                        <div class="map-select-item">
                                            <a href="#" class="map-select-link" data-number="C">
                                                <p class="name">새마음 복지용품</p>
                                                <p class="addr">서울시 송파구 잠실3동 20-2, 1층</p>
                                                <p class="call">02-1234-5677</p>
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=84e3b82c817022c5d060e45c97dbb61f&libraries=services,clusterer,drawing"></script>
                    <script>
                        //지도 생성
                        var map = new kakao.maps.Map(document.getElementById('map'), {
                            center: new kakao.maps.LatLng(33.450701, 126.570667),
                            level: 3
                        });

                        //마커 생성
                        var imageSrc    = '/html/page/planner/assets/images/img-marker.svg', //파트너스 img-marker-members.svg
                            imageSize   = new kakao.maps.Size(34, 42),
                            imageOption = {offset: new kakao.maps.Point(16, 46)};

                        var markerImage     = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
                            markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667);

                        var marker = new kakao.maps.Marker({
                            position : markerPosition,
                            image    : markerImage
                        });

                        marker.setMap(map);

                        //맵 오버레이 파트너스일경우 is-members 추가
                        var ovContent = '<div class="map-select-overlay is-members">' +
                                        '<div class="name">' +
                                        '<strong>트윈시티점트윈시티점트윈시티점트윈시티점트윈시티점트윈시티점트윈시티점트윈시티점트윈시티점</strong>' +
                                        '<div class="close" onclick="closeOverlay()">닫기</div>' +
                                        '</div>' +
                                        '<p class="addr">서울특별시 용산구 한강대로366 용산구 한강대로366 용산구 한강대로366 용산구 한강대로366 용산구 한강대로366 용산구 한강대로366</p>' +
                                        '<a class="call" href="tel:02-2423-6331">02-2423-6331</a>' +
                                        '</div>';

                        overlay = new kakao.maps.CustomOverlay({
                            content: ovContent,
                            map: map,
                            yAnchor: 1.25,
                            position: marker.getPosition()
                        });

                        overlay.setMap(null);

                        //오버레이 이벤트
                        kakao.maps.event.addListener(marker, 'click', function() {
                            overlay.setMap(map);
                        });

                        function closeOverlay() {
                            overlay.setMap(null);
                        }
                    </script>
                </div>
                <!-- //서비스 본문(복지시설) -->
            </div>
        </div>
        <!-- //본문 영역 -->


		<%--상세 --%>
		<div id="modalSrvcDtl"></div>


        <script>
        $(function(){

			var curPage = 1;
			var cntPerPage = 8;
			var sido = "서울특별시"; // 1100000000
        	var gugun = "금천구"; // 1154500000
        	var category = "";

        	function f_srchSrvcList(page){
        		if(sido != "" && sido != "-"){ //sido는 필수
        			gugun = gugun.replace("시/군/구", "");
					var params = {
							curPage:page
							, cntPerPage:cntPerPage
							, sido:sido
							, gugun:gugun
							, category:category
					};

					// console.log("params: ", params);

        			$(".cont-target").load(
							"/planner/srchSrvcList"
							, params
							, function(obj){

								$(".srvcListCnt").text(comma($("#srvcListCnt").val()));

								$('.page-content-items .content-items').masonry({
							        itemSelector: '.content-item',
							        columnWidth: '.content-sizer',
							        gutter: '.content-gutter',
							        percentPosition: true
							    });
								//$("#tabs-cont1").fadeIn(200);

								// 선택된 카테고리가 있을경우
								if(category.length > 0){ // designer 요청사항
									var colorNum = 0;
									var firstSelCheckVal = $(":checkbox[name='category']:checked").first().val();
									switch (firstSelCheckVal){
									  case "주거" :  colorNum = 1;break;
									  case "문화" :  colorNum = 2;break;
									  case "보건" :  colorNum = 3;break;
									  case "고용" :  colorNum = 4;break;
									  case "교육" :  colorNum = 5;break;
									  case "상담" :  colorNum = 6;break;
									  case "보호" :  colorNum = 8;break;
									  case "지원" :  colorNum = 7;break;
									}
									$(".content-item > a[class*='is-color']").removeClass(function(index, className){
									    return (className.match(/(^|\s)is-color\S+/g) || []).join(' ');
									})
									$(".content-item > .content-body").addClass("is-color" + colorNum);
								}

								if($('.page-content-paging .flow').is(':empty')) {
									var html = '';
									for(i=1; i<= $('.page-content-items').data("pageTotal"); i++) {
										if(i === params.curPage) {
											html += '<i class="is-active" data-num="' + i + '"></i>'
										}else {
											html += '<i data-num="' + i + '"></i>'
										}
									}
									$('.page-content-paging .flow').append(html)
								}
							});
        		}
			}

        	
        	//paging 생성
        	$(document).on("click", "button.srvc-pager", function(e){
        		e.preventDefault();
        		let pageNo = $(this).data("pageNo");
        		let pageTotal = $(this).data("pageTotal");
        		
        		if(pageNo > 0){
        			f_srchSrvcList(pageNo);
        		}

                $('.page-content-paging i').removeClass('is-active').filter('[data-num="' + pageNo + '"]').addClass('is-active');
                
        		//이전
        		if($(this).hasClass('content-prev')) {
                    if(pageNo > 2) {
                        $('.page-content-paging .flow').css('margin-left', -((pageNo - 3) * 20));
                    }
        		}
        		
        		//다음
        		if($(this).hasClass('content-next')) {
                    if(pageNo > 3 && pageNo <= pageTotal-2) {
                        $('.page-content-paging .flow').css('margin-left', -((pageNo - 3) * 20));
                    }
        		}
        	});


        	$(document).on("click", ".content-item a", function(e){
        		let bokjiId = $(this).attr("href").replace("#", "");
        		console.log($(this).attr("href"));
				$('body').append('<div class="box-loading" style="position: fixed; top:50%; left:50%; transform: translate(-50%,-50%); z-index: 6666;"><div class="icon"><span></span><span></span><span></span></div><p class="text">데이터를 불러오는 중입니다.</p></div>')
        		$("#modalSrvcDtl").load(
        			"/planner/srvcDtl"
        			, {bokjiId:bokjiId}
        			, function(){

        				if(category.length > 0){ //designer 요청사항
							var colorNum = 0;
							var firstSelCheckVal = $(":checkbox[name='category']:checked").first().val();
							switch (firstSelCheckVal){
							  case "주거" :  colorNum = 1;break;
							  case "문화" :  colorNum = 2;break;
							  case "보건" :  colorNum = 3;break;
							  case "고용" :  colorNum = 4;break;
							  case "교육" :  colorNum = 5;break;
							  case "상담" :  colorNum = 6;break;
							  case "보호" :  colorNum = 8;break;
							  case "지원" :  colorNum = 7;break;
							}
							$("#modal-detail[class*='is-color']").removeClass(function(index, className){
							    return (className.match(/(^|\s)is-color\S+/g) || []).join(' ');
							})
							$("#modal-detail").addClass("is-color" + colorNum);
						}
        				
						$('.box-loading').remove();
						
						$("#modal-detail").modal("show");
        			}
        		);
        	});


        	// 카테고리 선택
        	$(document).on("click", ":checkbox[name='category']", function(e){
				//console.log($(this).val());
				var selCheckVal = "";

				$(":checkbox[name='category']:checked").each(function(){
					selCheckVal += (selCheckVal==""?$(this).val():"|"+$(this).val());
				});
				//console.log(selCheckVal);
				category = selCheckVal;

				f_srchSrvcList(1);
        	});


        	// 시/군/구 검색
			$(document).on("click", ".select-sido ul a", function(e){
				e.preventDefault();
				var stdgCd = $(this).data("stdgCd");
				var stdgNm = $(this).text();

				$(".select-sido button").text(stdgNm);
				$(".select-gugun button").text("시/군/구");
				$(".select-gugun ul li").remove();
            	if(stdgCd != ""){
            		$.ajax({
        				type : "post",
        				url  : "${_membersPath}/stdgCd/stdgCdList.json",
        				data : {stdgCd:stdgCd},
        				dataType : 'json'
        			})
        			.done(function(data) {
        				if(data.result){
	       					$.each(data.result, function(index, item){
       							$(".select-gugun ul").append("<li><a class=\"dropdown-item\" href=\"#\" data-stdg-cd=\""+ stdgCd +"\" data-sgg-nm=\""+ item.sggNm +"\">"+ item.sggNm +"</a></li>");
	       	                });
        				}
        			})
        			.fail(function(data, status, err) {
        				console.log('지역호출 error forward : ' + data);
        			});
            	}
			});

			$(document).on("click", ".select-gugun ul a", function(e){
				e.preventDefault();
				var stdgCd = $(this).data("stdgCd");
				var stdgNm = $(this).text();
				$(".select-gugun button").text(stdgNm);
			});


			$(document).on("click", "button.srch-srvc", function(e){
				e.preventDefault();
				sido = $(".select-sido button").first().text();
				gugun = $(".select-gugun button").first().text();
				//console.log("search!!!", sido, gugun);
				f_srchSrvcList(1);
			});

			$(document).on("click", ".f_clip", function(e){
				e.preventDefault();
				let nowUrl = window.location.href;
				const shareObject = {
					title: $(this).parents(".modal").find(".modal-project-title").text()
					, text: '이로움on'
					, url: nowUrl
				};

				if (navigator.share) { // Navigator를 지원하는 경우만 실행
					navigator.share(shareObject).then(() => {
						// 정상 동작할 경우 실행
					}).catch((error) => {
						alert('에러가 발생했습니다.')
					})
				} else { // navigator를 지원하지 않는 경우
				  	//alert('페이지 공유를 지원하지 않습니다.')
					navigator.clipboard.writeText(nowUrl).then(res=>{
						alert("주소가 복사되었습니다!");
					});
				}
			});

			// init
        	if($(".select-sido button").first().text() == "-"){
        		//console.log(sido);
        		$(".select-sido button").text(sido);
        		$("[data-ctpv-nm='"+ sido +"']").click();
        		$(".select-gugun button").text(gugun);

        		f_srchSrvcList(1);
        	}

        });
        </script>