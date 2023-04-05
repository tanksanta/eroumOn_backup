<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


 	<!-- container -->
    <main id="container" class="relative">
        <section class="main-notice <c:if test="${_mbrSession.uniqueId eq null}"> is-nologin</c:if>">
            <div class="container">
	            <h2 class="main-title">notice</h2>
	            <ul class="main-items">
	            	<c:forEach var="ntceList" items="${listVO.listObject}" varStatus="status">
		                <li>
		                    <a href="${_marketPath}/etc/ntce/view?nttNo=${ntceList.nttNo}" class="main-item">
		                        <span>${ntceList.ttl}</span>
		                        <small><fmt:formatDate value="${ntceList.regDt}" pattern="yyyy-MM-dd" /></small>
		                    </a>
		                </li>
	                </c:forEach>
	            </ul>
			</div>
        </section>

        <c:if test="${_mbrSession.uniqueId ne null}">
	        <section class="main-myinfo">
	            <h1 class="main-user">
	                <span class="name">hello <strong>${_mbrSession.mbrNm}</strong> 님</span>
	                	<span class="thumb"><c:if test="${!empty _mbrSession.proflImg}"><img src="/comm/proflImg?fileName=${_mbrSession.proflImg}" alt=""></c:if></span>
	            </h1>
	            <div class="main-number">
	                <a href="${_marketPath}/mypage/wish/list">
	                	<dl class="recent">
	                    	<dt>관심상품</dt>
	                    	<dd>${_mbrEtcInfoMap.totalWish}</dd>
	                	</dl>
	                </a>
	                <a href="${_marketPath}/mypage/cart/list">
		                <dl class="cart">
		                    <dt>장바구니</dt>
		                    <dd>${_mbrEtcInfoMap.totalCart}</dd>
		                </dl>
	                </a>
	                <a href="${_marketPath}/mypage/mlg/list">
		                <dl class="mileage">
		                    <dt>마일리지</dt>
		                    <dd><fmt:formatNumber value="${_mbrEtcInfoMap.totalMlg}" pattern="###,###" /></dd>
		                </dl>
	                </a>
	                <a href="${_marketPath}/mypage/point/list">
		                <dl class="point">
		                    <dt>포인트</dt>
		                    <dd><fmt:formatNumber value="${_mbrEtcInfoMap.totalPoint}" pattern="###,###" /></dd>
		                </dl>
	                </a>
	                <a href="${_marketPath}/mypage/coupon/list">
		                <dl class="coupon">
		                    <dt>보유쿠폰</dt>
		                    <dd><fmt:formatNumber value="${_mbrEtcInfoMap.totalCoupon}" pattern="###,###" /></dd>
		                </dl>
	                </a>
	            </div>
	        </section>
        </c:if>

        <section class="main-visual <c:if test="${_mbrSession.uniqueId eq null}"> is-nologin</c:if>">
            <div class="swiper swiper-main">
                <div class="swiper-wrapper">
                    <div class="swiper-slide slide-item1">
                        <div class="slide-wrapper">
                            <div class="slide-img"><div class="photo"></div></div>
                            <div class="slide-content">
                                <div class="content">
                                    <div class="slogan">
                                        <strong>Senior Life Style</strong> by Eroum <i></i> <strong>BATHROOM</strong>
                                    </div>
                                    <div class="title">
                                        <p>안전한 <em>욕실생활</em></p>
                                        <small>미끄러운 사고 위험이 높은 공간으로 안전을 예방하는 복지용구를 소개해드립니다.</small>
                                    </div>
                                    <a href="${_marketPath}/cntnts/style-guide-bathroom" class="btn">욕실에 필요한 복지용구 보기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide slide-item2">
                        <div class="slide-wrapper">
                            <div class="slide-img"><div class="photo"></div></div>
                            <div class="slide-content">
                                <div class="content">
                                    <div class="slogan">
                                        <strong>Senior Life Style</strong> by Eroum <i></i> <strong>LIVING ROOM</strong>
                                    </div>
                                    <div class="title">
                                        <p>편안한 <em>거실생활</em></p>
                                        <small>
                                            일상생활에서 가장 많이 활동하는 공간으로<br>
                                            이동에 편리함을 주는 복지용구를 소개해드립니다.
                                        </small>
                                    </div>
                                    <a href="${_marketPath}/cntnts/style-guide-livingroom" class="btn">거실에 필요한 복지용구 보기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide slide-item3">
                        <div class="slide-wrapper">
                            <div class="slide-img"><div class="photo"></div></div>
                            <div class="slide-content">
                                <div class="content">
                                    <div class="slogan">
                                        <strong>Senior Life Style</strong> by Eroum <i></i> <strong>BEDROOM</strong>
                                    </div>
                                    <div class="title">
                                        <p>행복한 <em>침실생활</em></p>
                                        <small>
                                            일상을 마치고 수면과 휴식을 취하는 침실에서 더욱 빛나는 복지용구를 소개해드립니다.
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide slide-item4">
                        <div class="slide-wrapper">
                            <div class="slide-img"><div class="photo"></div></div>
                            <div class="slide-content">
                                <div class="content">
                                    <div class="slogan">
                                        <strong>Senior Life Style</strong> by Eroum <i></i> <strong>OUTDOOR</strong>
                                    </div>
                                    <div class="title">
                                        <p>활기찬 <em>야외생활</em></p>
                                        <small>많은 사람들과 함께 불편할 수 있는 야외활동을 보조해주는 복지용구를 소개합니다. </small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="swiper swiper-paging">
                <div class="swiper-wrapper">
                    <div class="swiper-slide slide-item1">
                        <span class="front">
                            <strong>욕실</strong>
                            <small>Bathroom</small>
                        </span>
                        <span class="rear">
                            <strong>욕실</strong>
                            <small>Bathroom</small>
                        </span>
                    </div>
                    <div class="swiper-slide slide-item2">
                        <span class="front">
                            <strong>거실</strong>
                            <small>Living Room</small>
                        </span>
                        <span class="rear">
                            <strong>거실</strong>
                            <small>Living Room</small>
                        </span>
                    </div>
                    <div class="swiper-slide slide-item3">
                        <span class="front">
                            <strong>침실</strong>
                            <small>Bedroom</small>
                        </span>
                        <span class="rear">
                            <strong>준비중입니다.</strong>
                        </span>
                    </div>
                    <div class="swiper-slide slide-item4">
                        <span class="front">
                            <strong>야외</strong>
                            <small>Outdoor</small>
                        </span>
                        <span class="rear">
                            <strong>준비중입니다.</strong>
                        </span>
                    </div>
                </div>
            </div>
            
            <div class="swiper-arrow">
                스크롤을 내려보세요
            </div>

            <script>
                var paging = new Swiper(".main-visual .swiper-paging", {
                    spaceBetween: 6,
                    slidesPerView: 4,
                    freeMode: true,
                    watchSlidesProgress: true,
                });

                var visual = new Swiper(".main-visual .swiper-main", {
                    loop: true,
                    slidesPerView: 1,
                    spaceBetween: 20,
                    autoplay: {
                        delay: 6000,
                        disableOnInteraction: false,
                    },
                    thumbs: {
                        swiper: paging,
                    }
                });

                $('.swiper-paging button').on('click', function() {
                    $(this).addClass('is-active').siblings().removeClass('is-active');
                    if($('.swiper .slide-item' + ($(this).index() + 1)).length > 0) {
                        visual.slideTo($(this).index());
                    }
                });
                
                $(window).on('scroll load', function() {
                    if($(window).scrollTop() > $('#header').outerHeight()) {
                        $('.main-visual.is-nologin').addClass('is-scroll');
                    }
                });
                
                $(window).on('scroll', function() {
                    if($('.main-visual').get(0).getClientRects()[0].y + $('.main-visual').get(0).getClientRects()[0].height > 0) {
                        $('.main-visual .slide-img .photo').css({'transform': 'translateY(' + ($(window).scrollTop() * -0.125)+ 'px)'});
                    }
                });
            </script>
        </section>

        <section class="main-check">
        	<div class="container">
	            <h2 class="main-title">
	                <strong>나에게 맞는 </strong>복지용구 선택의 기준
	                <small>구매 전 <em>복지용구 품목별 체크사항</em>을 알아보세요</small>
	            </h2>
				<div class="checkpoint-navigation">
	                <div class="container">
	                    <ul class="nav nav-tabs">
	                        <li><a href="#check-content3" data-bs-toggle="pill" data-bs-target="#check-content3" role="tab" class="nav-item3 active">성인용 보행기</a></li>
	                        <li><a href="#check-content10" data-bs-toggle="pill" data-bs-target="#check-content10" role="tab" class="nav-item10">수동휠체어</a></li>
	                        <li><a href="#check-content7" data-bs-toggle="pill" data-bs-target="#check-content7" role="tab" class="nav-item7">지팡이</a></li>
	                        <li><a href="#check-content4" data-bs-toggle="pill" data-bs-target="#check-content4" role="tab" class="nav-item4">안전손잡이</a></li>
	                        <li><a href="#check-content5" data-bs-toggle="pill" data-bs-target="#check-content5" role="tab" class="nav-item5">미끄럼방지 매트</a></li>
	                        <li><a href="#check-content6" data-bs-toggle="pill" data-bs-target="#check-content6" role="tab" class="nav-item6">미끄럼방지 양말</a></li>
	                        <li><a href="#check-content11" data-bs-toggle="pill" data-bs-target="#check-content11" role="tab" class="nav-item11">욕창예방 매트리스</a></li>
	                        <li><a href="#check-content8" data-bs-toggle="pill" data-bs-target="#check-content8" role="tab" class="nav-item8">욕창예방 방석</a></li>
	                        <li><a href="#check-content12" data-bs-toggle="pill" data-bs-target="#check-content12" role="tab" class="nav-item12">자세변환용구</a></li>
	                        <li><a href="#check-content9" data-bs-toggle="pill" data-bs-target="#check-content9" role="tab" class="nav-item9">요실금 팬티</a></li>
	                        <li><a href="#check-content2" data-bs-toggle="pill" data-bs-target="#check-content2" role="tab" class="nav-item2">목욕의자</a></li>
	                        <li><a href="#check-content1" data-bs-toggle="pill" data-bs-target="#check-content1" role="tab" class="nav-item1">이동변기</a></li>
	                        <li><a href="#check-content13" data-bs-toggle="pill" data-bs-target="#check-content13" role="tab" class="nav-item13">간이변기</a></li>
	                        <li><a href="#check-content14" data-bs-toggle="pill" data-bs-target="#check-content14" role="tab" class="nav-item14">경사로</a></li>
	                    </ul>
	                </div>
	            </div>
	            <div class="main-content tab-content">
	                <div id="check-content1" class="tab-pane fade">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item1.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">이동변기</div>
                    			<div class="desc">실내 화장실 이동이 불편하신 고객에게 추천합니다.</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>5</strong>
	                                    <sub>년</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>1</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content1" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
	                <div id="check-content2" class="tab-pane fade">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item2.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">목욕의자</div>
                    			<div class="desc">서 있거나 앉아서 씻기 불편한 고객의 자세 유지 및 편안한 목욕이 필요한 고객에게 추천합니다.</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>5</strong>
	                                    <sub>년</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>1</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content2" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
	                <div id="check-content3" class="tab-pane fade show active">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item3.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">성인용 보행기</div>
	                            <div class="desc">보행이 불편한 경우 실내∙외에서 혼자서 이동할 수 있도록 보조하는 용품</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>5</strong>
	                                    <sub>년</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>2</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content3" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
	                <div id="check-content4" class="tab-pane fade">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item4.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">안전손잡이</div>
	                            <div class="desc">신체 기능저하로 실내에서 일어서거나 앉을 때 보조하는 용품으로 낙상(넘어지는)위험이 있는 고객에게 추천합니다.</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>&nbsp;</strong>
	                                    <sub>없음</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>10</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content4" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
	                <div id="check-content5" class="tab-pane fade">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item5.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">미끄럼방지 매트</div>
	                            <div class="desc">신체 기능 저하로 실내에서 낙상(넘어지는)위험이 있는 고객에게 추천합니다.</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>&nbsp;</strong>
	                                    <sub>없음</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>5</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content5" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
	                <div id="check-content6" class="tab-pane fade">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item6.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">미끄럼방지 양말</div>
	                            <div class="desc">신체 기능 저하로 실내에서 낙상(넘어지는)위험이 있는 고객에게 추천합니다.</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>&nbsp;</strong>
	                                    <sub>없음</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>6</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content6" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
	                <div id="check-content7" class="tab-pane fade">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item7.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">지팡이</div>
	                            <div class="desc">일반적인 보행이 불편하고 실내 ,야외에서 낙상(넘어지는)위험이 있는 고객에게 추천합니다.</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>2</strong>
	                                    <sub>년</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>1</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content7" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
	                <div id="check-content8" class="tab-pane fade">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item8.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">욕창예방 방석</div>
	                            <div class="desc">휠체어를 이용하시거나 실내, 야외에서 많은 시간 앉아 계시는 고객에게 추천합니다.</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>3</strong>
	                                    <sub>년</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>1</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content8" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
	                <div id="check-content9" class="tab-pane fade">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item9.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">요실금 팬티</div>
	                            <div class="desc">실내, 야외에 활동 시 요실금이 있거나, 기저귀 착용에 거부감이 있는 고객에게 추천합니다.</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>&nbsp;</strong>
	                                    <sub>없음</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>4</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content9" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
	                <div id="check-content10" class="tab-pane fade">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item10.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">수동휠체어</div>
	                            <div class="desc">실내, 야외에서 보행이 불가능하거나 장시간 걷지 못하는 고객에게 추천합니다.</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>5</strong>
	                                    <sub>년</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>1</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content10" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
	                <div id="check-content11" class="tab-pane fade">
	                    <div class="content">
	                        <div class="thumb">
	                            <p class="img"><img src="/html/page/market/assets/images/img-main-check-item11.png" alt=""></p>
	                        </div>
	                        <div class="detail">
	                            <div class="name">욕창예방 매트리스</div>
	                            <div class="desc">신체 기능 저하로 실내에서 많은 시간 누워 계시는 고객에게 추천합니다.</div>
	                            <div class="info">
	                                <p>
	                                    <sup>사용연한</sup>
	                                    <strong>3</strong>
	                                    <sub>년</sub>
	                                </p>
	                                <p>
	                                    <sup>급여한도</sup>
	                                    <strong>3</strong>
	                                    <sub>개</sub>
	                                </p>
	                            </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content11" class="btn btn-primary">자세히 알아보기</a>
	                        </div>
	                    </div>
	                </div>
                    <div id="check-content12" class="tab-pane fade">
                        <div class="content">
                            <div class="thumb">
                                <p class="img"><img src="/html/page/market/assets/images/img-main-check-item12.png" alt=""></p>
                            </div>
                            <div class="detail">
                                <div class="name">자세변환용구</div>
                                <div class="desc">신체 기능 저하로 실내에서 장시간 같은 자세로 있는 고객에게 추천합니다.</div>
                                <div class="info">
                                    <p>
                                        <sup>사용가능 햇수</sup>
                                        <strong>&nbsp;</strong>
                                        <sub>없음</sub>
                                    </p>
                                    <p>
                                        <sup>급여한도</sup>
                                        <strong>5</strong>
                                        <sub>개</sub>
                                    </p>
                                </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content12" class="btn btn-primary">자세히 알아보기</a>
                            </div>
                        </div>
                    </div>
                    <div id="check-content13" class="tab-pane fade">
                        <div class="content">
                            <div class="thumb">
                                <p class="img"><img src="/html/page/market/assets/images/img-main-check-item13.png" alt=""></p>
                            </div>
                            <div class="detail">
                                <div class="name">간이변기</div>
                                <div class="desc">실내 화장실 이용이 불편하신 고객에게 추천합니다.</div>
                                <div class="info">
                                    <p>
                                        <sup>사용연한</sup>
                                        <strong>&nbsp;</strong>
                                        <sub>없음</sub>
                                    </p>
                                    <p>
                                        <sup>급여한도</sup>
                                        <strong>2</strong>
                                        <sub>개</sub>
                                    </p>
                                </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content13" class="btn btn-primary">자세히 알아보기</a>
                            </div>
                        </div>
                    </div>
                    <div id="check-content14" class="tab-pane fade">
                        <div class="content">
                            <div class="thumb">
                                <p class="img"><img src="/html/page/market/assets/images/img-main-check-item14.png" alt=""></p>
                            </div>
                            <div class="detail">
                                <div class="name">경사로</div>
                                <div class="desc">실내, 야외에서 문턱이나 계단 이동 시 안전사고 예방하기 위한 고객에게 추천합니다.</div>
                                <div class="info">
                                    <p>
                                        <sup>사용가능 햇수</sup>
                                        <strong>2</strong>
                                        <sub>년</sub>
                                    </p>
                                    <p>
                                        <sup>급여한도</sup>
                                        <strong>6</strong>
                                        <sub>개</sub>
                                    </p>
                                </div>
	                            <a href="${_marketPath}/cntnts/checkpoint#checkpoint-content14" class="btn btn-primary">자세히 알아보기</a>
                            </div>
                        </div>
                    </div>
	            </div>
        	</div>
            <script>
                $(function() {
                    horizonScroll($('.checkpoint-navigation .container'));
                })
            </script>
        </section>


        <section class="main-movie">
            <div class="container">
                <div class="left-movie">
                    <h2 class="main-title">
                        <strong>복지용구 제품</strong> 정보
                        <a href="https://www.youtube.com/@e-roum9433/videos" target="_blank" class="main-link">전체 제품 바로가기</a>
                    </h2>
                    <div class="main-video">
                        <iframe width="560" height="315" src="https://www.youtube.com/embed/TtPCu-IhNo4" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                    </div>
                </div>
                <div class="right-movie">
                    <h2 class="main-title">
                        <strong>
                            알아두면 쓸모있는 <br>
                            시니어 잡학사전
                        </strong>
                        <img src="/html/page/market/assets/images/bg-main-video2.png" alt="">
                    </h2>
                    <div class="main-video">
                        <iframe width="560" height="315" src="https://www.youtube.com/embed/sGDPTjFFvs4" title="YouTube video player" frameborder="0" allow="accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
                    </div>
                </div>
            </div>
        </section>

        <section class="main-guide">
            <div class="container">
                <h2 class="main-title">
                    복지용구를<br class="xl:hidden"> <strong>장기요양 급여로 이용</strong>하려면 <br>
                    어떻게 해야 하나요?
                </h2>
                <div class="main-content">
                    <dl class="grade">
                        <dt>
                            장기요양<br>
                            예상등급 확인
                        </dt>
                        <dd>
                            간단한 테스트로<br>
                            이로움에서 플랜을 제공받으세요
                            <a href="https://silver.bokji24.com/find/step2-1" target="_blank">테스트 하기</a>
                        </dd>
                    </dl>
                    <dl class="payment">
                        <dt>복지용구 급여이용 안내</dt>
                        <dd>
                            구입/대여에서 본인부담금 계산까지
                            <a href="#modal-content" data-bs-toggle="modal" data-bs-target="#modal-content">자세히 보기</a>
                        </dd>
                    </dl>
                    <dl class="partner">
                        <dt>복지용구 멤버스 안내</dt>
                        <dd>
                        	전국 약 1,600개 <strong>이로움 멤버스</strong>가 여러분 곁에 있습니다.
                            <!-- 전국 <fmt:formatNumber value="${bplcCnt}" pattern="###,###" />개 <strong>이로움 멤버스</strong>가 여러분 곁에 있습니다. -->
                            <a href="${_partnersPath}"><i></i> 지도로 보기</a>
                        </dd>
                    </dl>
                </div>
            </div>
            <div class="modal fade" id="modal-content" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close">닫기</button>
                        </div>
                        <div class="modal-body">
                            <img src="/html/page/market/assets/images/img-index-guide-content.png" alt="">
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
    <!-- //container -->