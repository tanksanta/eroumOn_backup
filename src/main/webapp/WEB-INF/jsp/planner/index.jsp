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
                        <p>시니어를 위한</p>
                        <picture>
                            <source srcset="/html/page/planner/assets/images/txt-login-title-white.svg" media="(max-width: 1039px)">
                            <source srcset="/html/page/planner/assets/images/txt-login-title.svg">
                            <img src="/html/page/planner/assets/images/txt-login-title.svg" alt="" />
                        </picture>
                    </div>
                    <c:if test="${_mbrSession.loginCheck}">

                    <!-- 로그인시 -->
                    <div class="userinfo-count">
                        <div class="user">
                            <p class="name">${_mbrSession.mbrNm}&nbsp;<small>${_mbrAge}세, ${_mbrAddr}</small></p>
                            <p class="button">
                                <a href="${_membershipPath}/mypage/list" class="btn btn-outline-primary">설정</a>
                                <a href="${_membershipPath}/logout" class="btn btn-primary">로그아웃</a>
                            </p>
                        </div>
                        <div class="desc2">
                            <strong>내게 <em>딱</em> 맞는</strong><br>
                            <strong>복지서비스<span>를</span> 한 곳<span>에</span>…</strong>
                        </div>
                        <p class="count"><strong class="totalCnt">0</strong> 건</p>
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
                    </c:if>
					<c:if test="${!_mbrSession.loginCheck}">
                    <!-- 미로그인시 -->
                    <div class="userinfo-count">
                    	<!-- <p class="title">복지서비스</p> -->
                        <p class="desc">
                            <small>대한민국 모든 <strong>시니어를 위한 복지서비스</strong></small>
                            <strong>한 곳</strong>에 모아서…
                        </p>
                        <p class="count"><strong class="totalCnt">0</strong> 건</p>
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
                    </c:if>
                    <div class="userinfo-link">
                        <a href="${_plannerPath }/Senior-Long-Term-Care" class="link-grade">노인장기요양보험</a>
                        <a href="${_plannerPath }/Senior-Friendly-Foods" class="link-foods">고령친화 우수식품</a>
                    </div>
                    <div class="userinfo-member">
                        <div class="userinfo-member-market">
                            <a href="${_marketPath }/index">
                                <strong>이로움 마켓</strong>
                                복지용구부터 시니어 생활용품까지 한번에!
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
                    <span class="desc">
                    	노인복지가 궁금하세요?
                    	<a href="#"><span class="close">펼쳐보기</span> <span class="open">접기</span></a>
                   	</span>
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
                    <!-- <li class="option-item4">
                        <label for="opt-item4">
                            <input type="checkbox" name="category" value="고용" id="opt-item4">
                            <span>고용</span>
                        </label>
                    </li> -->
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

                <div class="option-desc">
                    <div class="content">
                        <img src="/html/page/planner/assets/images/img-welfare-content1.jpg" alt="">
                        <img src="/html/page/planner/assets/images/img-welfare-content2.jpg" alt="">
                        <img src="/html/page/planner/assets/images/img-welfare-content3.jpg" alt="">
                    </div>
                    <button type="button" class="close">닫기</button>
                </div>
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
                                <strong class="instListCnt">0</strong>
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
                <div class="tab-pane fade " id="tabs-cont2" role="tabpanel">
                    <div class="page-content-map">
                        <div id="map" class="map-area"></div>
                        <div class="map-select">
                            <button class="resizer">
                                <span class="sr-only">사이즈 조정</span>
                            </button>
                            <ul class="nav nav-tabs tabs-list" role="tablist">
                                <li class="nav-item" role="presentation"><a href="#marker-cont1" class="nav-link nav-link-item1 active" data-bs-toggle="pill" data-bs-target="#marker-cont1" role="tab" aria-selected="true">이로움 멤버스</a></li>
                                <li class="nav-item" role="presentation"><a href="#marker-cont2" class="nav-link nav-link-item2" data-bs-toggle="pill" data-bs-target="#marker-cont2" role="tab" aria-selected="false">재가시설</a></li>
                                <li class="nav-item" role="presentation"><button type="button" class="nav-link nav-link-item3 set_position" aria-selected="false">현재위치 검색</button></li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane fade show active" id="marker-cont1" role="tabpanel">
                                    <div class="map-select-items is-member">
                                    	<%-- 멤버스 --%>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="marker-cont2" role="tabpanel">
                                	<div class="map-select-items">
                                    	<%-- 재가시설 --%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //서비스 본문(복지시설) -->
            </div>
        </div>
        <!-- //본문 영역 -->

		<%--상세 --%>
		<div id="modalSrvcDtl"></div>

		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${_kakaoScriptKey}&libraries=services,clusterer,drawing"></script>
        <script>

		// 함수 이동
        var category = "";
        function srvcDtl(bokjiId){
    		if(bokjiId > 0){
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
	            			}
	            		);

    		}
    	}

        var PlannerSrvc = (function(){

			var curPage = 1;
			var cntPerPage = 8;
			<c:if test="${!_mbrSession.loginCheck}"><%--로그인 전--%>
			var sido = "서울특별시"; // 1100000000
        	var gugun = "금천구"; // 1154500000
        	</c:if>
			<c:if test="${_mbrSession.loginCheck}"><%--로그인 후--%>
			var sido = "${_mbrAddr1}";
        	var gugun = "${_mbrAddr2}";
			</c:if>


        	var srchMode = "LOCATION";
        	var dist = 0; // meter

        	var isAllow = false;
        	var lat = 0.00; //현재위치 위도
        	var lot = 0.00; //현재위치 경도
        	var objData = {};

        	var isMob = false;
        	var windowWidth;
        	var windowHeight = $(window).height();
        	window.addEventListener('resize', function() {
        		requestAnimationFrame(resizeHandler);
        	}, false);
        	resizeHandler();

        	function init(){

				if($(".select-sido button").first().text() == "-"){
					<c:if test="${!_mbrSession.loginCheck}"><%--로그인 전--%>
	        		$(".select-sido button").text(sido);
	        		$("[data-ctpv-nm='"+ sido +"']").click();
	        		</c:if>
	        		<c:if test="${_mbrSession.loginCheck}"><%--로그인 후--%>
	        		$(".select-sido ul a:contains('${_mbrAddr1}')").click();
	        		sido = $(".select-sido ul a:contains('${_mbrAddr1}')").text();
	        		</c:if>
					$(".select-gugun button").text(gugun);

        	        f_srchSrvcList(1);
        	        f_srchInstList();
	        	}

        		$('.search-tabs a[data-bs-toggle="pill"]').on("click", function(){
					var targetTab = $(this).data("bsTarget");
					if(targetTab == "#tabs-cont1"){ //서비스
						f_srchSrvcList(1);
					}else if(targetTab == "#tabs-cont2"){ //지도탭
						// animation > done까지 kakao지도가 호출되지 않음, display:block 상태로 변경시 호출 가능
						$("#tabs-cont2").css({"display":"block"});
						//isAllow = searchGps();
						f_srchInstList();
					}
				});


        		// 서비스 목록일 경우
            	let spLocation = window.location.href.split("#");
        		//console.log("spLocation: ", spLocation);
            	if(spLocation.length > 1){
            		let bokjiId = spLocation[1];
            		srvcDtl(bokjiId);
            	}
    		}

        	function cntSum(){
        		var sum = Number(uncomma($(".srvcListCnt").text()))
        				+ Number(uncomma($(".instListCnt").text()));
        		$(".totalCnt").text(comma(sum));
        	}


    		//지도 > 탭 이벤트
			$(document).on('click', '.map-select a[data-bs-toggle="pill"]', function(){
				var targetTab = $(this).data("bsTarget");
				if(targetTab == "#marker-cont1"){ //멤버스
					srchMode = "LOCATION";
				}else if(targetTab == "#marker-cont2"){ //복지24
					srchMode = "BOKJI";
				}
				f_srchInstList();
			});

			$(document).on("click", "button.srch-srvc", function(e){
				e.preventDefault();
				sido = $(".select-sido button").first().text();
				gugun = $(".select-gugun button").first().text();

				if(gugun == "시/군/구"){
					alert("시/군/구를 선택해 주세요.");
				}else{
					//console.log("search!!!", sido, gugun);
					f_srchSrvcList(1);
					f_srchInstList();
				}

			});

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
					console.log(params);
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

								cntSum();
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
        		e.preventDefault();
        		let bokjiId = $(this).attr("href").replace("#", "");
				$('body').append('<div class="box-loading" style="position: fixed; top:50%; left:50%; transform: translate(-50%,-50%); z-index: 6666;"><div class="icon"><span></span><span></span><span></span></div><p class="text">데이터를 불러오는 중입니다.</p></div>')
				srvcDtl(bokjiId);
        	});

        	// 카테고리 선택
        	$(document).on("click", ":checkbox[name='category']", function(e){
				var selCheckVal = "";
				$(":checkbox[name='category']:checked").each(function(){
					selCheckVal += (selCheckVal==""?$(this).val():"|"+$(this).val());
				});
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


			$(document).on("click", ".f_clip", function(e){
				e.preventDefault();
				let bokjiId = $(this).data("bokjiId");
				let nowUrl = window.location.href + "#" + bokjiId;
				const shareObject = {
					title: $(this).parents(".modal").find(".modal-project-title").text()
					, text: '이로움온'
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


        	function searchGps() {
        		if(navigator.geolocation) {
        			navigator.geolocation.getCurrentPosition((function (position) {
        				lat = position.coords.latitude;
        				lot = position.coords.longitude;
        				isAllow = true;
        				//srchMode = "LOCATION";
        				//f_srchInstList(($(window).width() < 768) ? false : true);
        			}), (function (e) {
        				switch (e.code) {
        					case e.PERMISSION_DENIED:
        						console.log("위치정보 검색을 거부했습니다.\n브라우저의 설정에서 위치(GPS) 서비스를 사용으로 변경해주세요.");
        						break;
        					case e.POSITION_UNAVAILABLE:
        						console.log("브라우저가 위치정보를 검색하지 못했습니다.");
        						break;
        					case e.TIMEOUT:
        						console.log("브라우저의 위치 정보 검색 시간이 초과됐습니다.");
        						break;
        					default:
        						console.log("위치 정보 검색에 문제가 있습니다.");
        				}
        				isAllow = false;
        				//$(".set_position").remove();
        				//srchMode = "LOCATION";
        				//f_srchInstList();
        			}), { timeout: 1000 });
        		} else {
        			console.log("사용 중이신 브라우저가 위치(GPS) 기능을 지원하지 않습니다.");
        			isAllow = false;
        			//$(".set_position").remove();
    				//f_srchInstList(($(window).width() < 768) ? false : true);
        		}
        	}


        	function f_srchInstList(){

        		if(sido != "" && sido != "-"){ //sido는 필수
        			gugun = gugun.replace("시/군/구", "");

	        		if(isAllow){	// GPS허용
	    				dist = 10000;
	        		}else{
	        			dist = 0;
	        		}

	    			var params = {
	    					srchMode:srchMode
	    					, sido:sido, gugun:gugun
	    					, isAllow:false, lot:lot, lat:lat, dist:dist };

	    			//console.log("params", params);

	    			$.ajax({
	    				type : "post",
	    				url  : "/planner/srchInstList.json",
	    				data : params,
	    				dataType : 'json'
	    			})
	    			.done(function(json) {
	    				//console.log(json);
	    				if(srchMode == "LOCATION"){
							objData = json.bplcList;
	    				}else{
	    					objData = json.instList;
	    				}
	    				//console.log(Number(json.bplcCnt) + Number(json.instCnt));
	    				var instCnt = Number(json.bplcCnt) + Number(json.instCnt);
	    				$(".instListCnt").text(comma(instCnt));

						addListItem();
						kakaoMapDraw();

						cntSum();
	    			})
	    			.fail(function(data, status, err) {
	    				console.log(data);
	    			});
        		}
    		}

        	function addListItem(){

    			if(objData.length > 0){
    				var html = '';
    				if(srchMode == "LOCATION"){
	        			$.each( objData, function( index, item ) {
							html += '<div class="map-select-item">';
	        				html += '    <a href="#" class="map-select-link is-members">';
	        				html += '        <p class="name">'+ item.bplcNm +'</p>';
	        				html += '    	 <p class="addr">'+ item.addr +' ' + item.daddr  +'</p>';
	        				html += '        <p class="call">'+ item.telno +'</p>';
	        				html += '    </a>';
	        				html += '</div>';
	        			});
    				}else if(srchMode == "BOKJI"){
	        			$.each( objData, function( index, item ) {
							html += '<div class="map-select-item">';
	        				html += '    <a href="#" class="map-select-link">';
	        				html += '        <p class="name">'+ item.institutionName +'</p>';
	        				html += '    	 <p class="addr">'+ item.address  +'</p>';
	        				html += '        <p class="call">'+ item.contactNumber +'</p>';
	        				html += '    </a>';
	        				html += '</div>';
	        			});
    				}
    			}else{
    				html = '<div class="map-select-item">검색 결과가 없습니다.</div>';
    			}

    			$(".map-select-items").empty() //list 초기화

    			var target = null;
    			if(srchMode === "LOCATION"){
    				target = $('#marker-cont1');
    			}else if(srchMode === "BOKJI"){
    				target = $('#marker-cont2');
				}

    			$('.tabs-list a[data-bs-target="#' + target.attr('id') + '"]').addClass("active");
    			target.addClass('show active').find('.map-select-items').append(html);
    			$(".map-select-item").css({"cursor":"pointer"});
    		}



        	function kakaoMapDraw(){

        		var datas = {};
        		var positions = [];
        		var markers = [];
        		var overlays = [];
        		var level = 3;
        		var latlng;
        		var centerLat = isMob ? -0.0002 : 0.0005;
        		var centerLng = isMob ? 0 : 0.0015;

        		if(objData.length > 0){

	        		$.each( objData, function( index, item ) {

	        			var kminfo = "";
	        			if(srchMode == "LOCATION"){
		        			datas = {
		        				latlng: new kakao.maps.LatLng(Number(item.lat), Number(item.lot)),
		        				center: new kakao.maps.LatLng(Number(item.lat) + centerLat, Number(item.lot) - centerLng),
		        				content: '<div class="map-select-overlay is-members">' +
				                         '		<div class="name">' +
				                         '			<strong>'+ item.bplcNm +'</strong>' +
				                         '			<div class="close overlayClose">닫기</div>' +
				                         '		</div>' +
				                         '		<p class="addr">'+ item.addr +' '+ item.daddr  +'</p>' +
				                         '		<a class="call" href="tel:'+ item.telno +'">'+ item.telno +'</a>' +
				                         '</div>',
		        				title: item.bplcNm
		        			}

	        			}else if(srchMode == "BOKJI"){
	        				datas = {
		        				latlng: new kakao.maps.LatLng(Number(item.lat), Number(item.lng)),
		        				center: new kakao.maps.LatLng(Number(item.lat) + centerLat, Number(item.lng) - centerLng),
		        				content: '<div class="map-select-overlay">' +
				                         '		<div class="name">' +
				                         '			<strong>'+ item.institutionName +'</strong>' +
				                         '			<div class="close overlayClose">닫기</div>' +
				                         '		</div>' +
				                         '		<p class="addr">'+ item.address  +'</p>' +
				                         '		<a class="call" href="tel:'+ item.contactNumber +'">'+ item.contactNumber +'</a>' +
				                         '</div>',
		        				title: item.institutionName
			        			}
	        			}
	        			positions.push(datas);
	        		});

	        		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	    			mapOption = {
	    				center: positions[0].center, // 지도의 중심좌표
	    				level: level // 지도의 확대 레벨
	    			};

					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

					// 마커 클러스터러를 생성합니다
					// 마커 클러스터러를 생성할 때 disableClickZoom 값을 true로 지정하지 않은 경우
					// 클러스터 마커를 클릭했을 때 클러스터 객체가 포함하는 마커들이 모두 잘 보이도록 지도의 레벨과 영역을 변경합니다
					// 이 예제에서는 disableClickZoom 값을 true로 설정하여 기본 클릭 동작을 막고
					// 클러스터 마커를 클릭했을 때 클릭된 클러스터 마커의 위치를 기준으로 지도를 1레벨씩 확대합니다
					var clusterer = new kakao.maps.MarkerClusterer({
						map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
						averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
						minLevel: 6, // 클러스터 할 최소 지도 레벨
						disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
					});


					//마커 생성
	                var imageSrc = '/html/page/planner/assets/images/img-marker-members.svg';
                	if(srchMode == "BOKJI"){
						imageSrc = '/html/page/planner/assets/images/img-marker.svg';
                	}
	                var imageSize = new kakao.maps.Size(34, 42);
	                var imageOption = {offset: new kakao.maps.Point(16, 46)};

        			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

	                for (var j = 0; j < positions.length; j ++) {

	        			// 마커를 생성합니다
	        			var marker = new kakao.maps.Marker({
	        				map: map, // 마커를 표시할 지도
	        				position: positions[j].latlng, // 마커를 표시할 위치
	        				title : positions[j].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        				image : markerImage, // 마커 이미지
	        				clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
	        			});

	        			overlay = new kakao.maps.CustomOverlay({
                            content: positions[j].content,
                            map: map,
                            yAnchor: 1.45,
                            position: marker.getPosition()
                        });
	        			overlay.setMap(null);
	        			overlays.push(overlay);
	        			var idx = overlays.length - 1; // 오버레이, 마커 인덱스

	        			marker.idx = idx; // 마커에 해당하는 오버레이를 index를 저장합니다.
	        			markers.push(marker); // 생성된 마커를 배열에 담아줍니다.

	        			clusterer.addMarkers(markers); // 생성된 마커를 클러스터에 담아줍니다.

	        			kakao.maps.event.addListener(marker, 'click', function() {
	        				allOverlayClose();

	        				var idx = this.idx;
	        				var overlay = overlays[idx]; // 마커에 해당되는 overlay를 열어줍니다.
	        				overlay.setMap(map, this);
	        				map.setCenter(positions[idx].center);
	        				map.setLevel(3)
	        			});

	        		}

	                // 지도를 내위치로
	                $(".set_position").on("click", function(){
	                	if(isAllow){
							map.setCenter(new kakao.maps.LatLng(lat, lot));
	        				map.setLevel(3)
	                	}
					})

	             	// 리스트 클릭시
	        		$("div.map-select-item").on('click', function(event, visible) {
	        			event.preventDefault();

	        			idx = $(this).index();
	        			allOverlayClose();

	        			var overlay = overlays[idx];
	        			overlay.setMap(map, markers[idx]);

	        			map.setCenter(positions[idx].center);
	        			map.setLevel(3);

	        			if($(window).width() < 768) {
		        			map.panBy(0, -75);
	        			}

	        			// is-active
	        			$(".map-select-link").removeClass("is-active");
	        			$(this).find("a.map-select-link").addClass("is-active");

	        			if(!visible && $(window).width() < 768) {
	        				$('.map-select').removeClass('is-active');
	        			}

	        		});

	        		$("a.map-select-link").eq(0).trigger('click', {visible: true});

	             	// 모든 Overlay를 닫아줍니다.
	        		function allOverlayClose() {
	        			for(var i = 0; i<overlays.length; i++) {
	        				var overlay = overlays[i];
	        				overlay.setMap(null);
	        			}
	        		}

	        		$(document).on("click",".overlayClose", function(){
	        			allOverlayClose();
	        		});

	        		// 마커 클러스터러에 클릭이벤트를 등록합니다
	        		// 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
	        		// 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
	        		kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
	        			var level = map.getLevel()-1; // 현재 지도 레벨에서 1레벨 확대한 레벨
	        			map.setLevel(level, {anchor: cluster.getCenter()}); // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다


	        		});

	        		// 지도가 이동, 확대, 축소로 인해 중심좌표가 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
	        		kakao.maps.event.addListener(map, 'center_changed', function() {
	        			var level = map.getLevel(); // 지도의  레벨을 얻어옵니다
	        			latlng = map.getCenter(); // 지도의 중심좌표를 얻어옵니다
						//console.log(level);
	        			if(level > 6){ // 지도 축소시 오버레이 닫음
		        			allOverlayClose();
	        			}
	        		});

        		} else { // result = 0
        			//console.log("result 0");
        			// 데이터가 없을 경우
        			var mapContainer = document.getElementById('map'),
	    			mapOption = {
	    				center: new kakao.maps.LatLng(37.6065432383919, 127.092820287004),
	    				level: 8 // 지도의 확대 레벨
	    			};

					var map = new kakao.maps.Map(mapContainer, mapOption);
        		}

        	}

        	function resizeHandler() {
        		windowWidth = $(window).width();
        		windowHeight = $(window).height();
        		isMob = windowWidth <= 1023;
        	}

        	$(function(){

        		if($(".is-nologin").length < 1){
        			var field = "${_mbrSession.itrstField}";

        			if(field != "null" && field != ''){
        				field = field.replaceAll(' ','').split(',');
    					for(var i=0; i<field.length; i++){
    						switch(field[i]){
    							case "1" : $("#opt-item7").prop("checked",true);break;
    							case "2" : $("#opt-item8").prop("checked",true);break;
    							case "3" : $("#opt-item6").prop("checked",true);break;
    							case "4" : $("#opt-item3").prop("checked",true);break;
    							case "5" : $("#opt-item2").prop("checked",true);break;
    							case "6" : break;
    							case "7" : $("#opt-item1").prop("checked",true);break;
    							case "8" : $("#opt-item5").prop("checked",true);break;
    						}
    					}
        			}else{
        				$("input[name='category']").prop("checked",true);
        			}

					$(".non_login").hide();
					$(".on_login").show();
        		}else{
        			$("input[name='category']").prop("checked",true);
        			$(".non_login").show();
					$(".on_login").hide();
        		}

        	});

        	init();
        })();
        </script>