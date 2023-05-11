<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="relative">
	<link rel="stylesheet" href="/html/core/vendor/simplebars/simplebar.css">
	<script src="/html/core/vendor/simplebars/simplebar.min.js"></script>

	<div class="style-guide-content2 is-white">
		<div class="content-title">
	        <small class="slogan"><strong>Senior Life Style</strong> by Eroum <i></i> <strong>BEDROOM</strong></small>
	        <h2 class="title">안락한 <em>침실생활</em></em></h2>
	        <p class="desc">수면과 휴식을 취하는 공간에서 필요한 복지용구를 소개해드립니다.</p>
            <div class="back">
                <a href="${_marketPath}" class="is-main">뒤로가기</a>
                <a href="${_marketPath}/cntnts/style-guide-bathroom">욕실</a>
                <a href="${_marketPath}/cntnts/style-guide-livingroom">거실</a>
                <a href="${_marketPath}/cntnts/style-guide-bedroom" class="is-active">침실</a>
                <a href="${_marketPath}/cntnts/style-guide-outdoor">야외</a>
            </div>
		</div>
		
        <div class="content-alert">
            <img src="/html/page/market/assets/images/ico-content-livingroom-drag.svg" alt="">
            터치하여 좌우로 움직여보세요
        </div>

		<div class="content-body">
			<div class="container">
				<img src="/html/page/market/assets/images/bg-content-bedroom.jpg" alt="" class="background">
	            <a href="contentModal1" class="object object-5" data-bs-toggle="modal" data-bs-target="#contentModal1">
	                <img src="/html/page/market/assets/images/img-content-bedroom1.png" alt="" class="photo">
	                <div class="name">
	                    <em>이동변기</em>
	                    <i>
	                        <span class="f"></span>
	                        <span class="r">view</span>
	                    </i>
	                </div>
	            </a>
	            <a href="contentModal2" class="object object-6" data-bs-toggle="modal" data-bs-target="#contentModal2">
	                <img src="/html/page/market/assets/images/img-content-bedroom2.png" alt="" class="photo">
	                <div class="name">
	                    <em>안전손잡이</em>
	                    <i>
	                        <span class="f"></span>
	                        <span class="r">view</span>
	                    </i>
	                </div>
	            </a>
	            <a href="contentModal3" class="object object-7" data-bs-toggle="modal" data-bs-target="#contentModal3">
	                <img src="/html/page/market/assets/images/img-content-bedroom3.png" alt="" class="photo">
	                <div class="name">
	                    <em>지팡이</em>
	                    <i>
	                        <span class="f"></span>
	                        <span class="r">view</span>
	                    </i>
	                </div>
	            </a>
	            <a href="contentModal4" class="object object-8" data-bs-toggle="modal" data-bs-target="#contentModal4">
                <img src="/html/page/market/assets/images/img-content-bedroom4.png" alt="" class="photo">
                <div class="name">
                    <em>자세변환용구</em>
                    <i>
                        <span class="f"></span>
                        <span class="r">view</span>
                    </i>
                </div>
	            <a href="contentModal5" class="object object-9" data-bs-toggle="modal" data-bs-target="#contentModal5">
                <img src="/html/page/market/assets/images/img-content-bedroom5.png" alt="" class="photo">
                <div class="name">
                    <em>욕창예방매트리스</em>
                    <i>
                        <span class="f"></span>
                        <span class="r">view</span>
                    </i>
                </div>
            </a>
			</div>		
		</div>
	
        <div class="content-item">
	        <div class="item item-5">
	            <a href="#contentModal1" data-bs-toggle="modal" data-bs-target="#contentModal1">이동변기</a>
	            <i></i>
	        </div>
	        <div class="item item-6">
	            <a href="#contentModal2" data-bs-toggle="modal" data-bs-target="#contentModal2">안전손잡이<br> (기둥형)</a>
	            <i></i>
	        </div>
	        <div class="item item-7">
	            <a href="#contentModal3" data-bs-toggle="modal" data-bs-target="#contentModal3">지팡이</a>
	            <i></i>
	        </div>
	        <div class="item item-8">
	            <a href="#contentModal4" data-bs-toggle="modal" data-bs-target="#contentModal4">자세변환용구</a>
	            <i></i>
	        </div>
	        <div class="item item-9">
	            <a href="#contentModal5" data-bs-toggle="modal" data-bs-target="#contentModal5">욕창예방매트리스</a>
	            <i></i>
	        </div>
        </div>

        <div class="modal fade" tabindex="-1" aria-hidden="true" id="contentModal1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
						<p class="text-title">이동변기</p>
                        <button data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="logo"><img src="/html/page/market/assets/images/img-content-bedroom2-1.svg" alt=""></div>
                        <div class="info">
	                        <p>
	                            <sup>사용연한</sup>
	                            <strong>&nbsp;</strong>
	                            <sub style="font-size: 1.2em; bottom: 0.75em; bottom: 0.0875em;">없음</sub>
	                        </p>
	                        <p>
	                            <sup>급여한도</sup>
	                            <strong>1</strong>
	                            <sub>개</sub>
	                        </p>
                        </div>
                        <p class="desc">
	                        벽이나 화장실 변기, 생활에 필요한 곳에 설치하여 <br>
	                        걷기가 어려운 어르신이 실내 이동시 <br>
	                        낙상을 예방하는 복지용구 급여대한 품목
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a href="${_marketPath}/gds/2/list#6" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" aria-hidden="true" id="contentModal2">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
						<p class="text-title">안전손잡이(기둥형)</p>
                        <button data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="logo"><img src="/html/page/market/assets/images/img-content-bedroom1-1.svg" alt=""></div>
                        <div class="info">
	                        <p>
	                            <sup>사용연한</sup>
	                            <strong>5</strong>
	                            <sub>년</sub>
	                        </p>
                            <p>
                                <sup>급여한도</sup>
                                <strong>10</strong>
                                <sub>개</sub>
                            </p>
                        </div>
                        <p class="desc">
	                        실내 화장실 이동이 불편하신 고객에게<br>
	                        추천드리며, 다양한 소재와 색상이 있어<br>
	                        실내 분위기와 어울리는 제품을 선택할 수 있습니다.
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a href="${_marketPath}/gds/2/list#25" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" aria-hidden="true" id="contentModal3">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
						<p class="text-title">지팡이</p>
                        <button data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="logo"><img src="/html/page/market/assets/images/img-content-bedroom3-1.svg" alt="" style="height: 80%;"></div>
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
                        <p class="desc">
	                        보행을 보조하는 품목으로<br> 
	                        무게는 가벼울수록 높낮이 조절은 쉬울수록 좋습니다.
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a href="${_marketPath}/gds/2/list#39" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" aria-hidden="true" id="contentModal4">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
						<p class="text-title">자세변환용구</p>
                        <button data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="logo"><img src="/html/page/market/assets/images/img-content-bedroom4-1.svg" alt=""></div>
                        <div class="info">
	                        <p>
	                            <sup>사용연한</sup>
	                            <strong>&nbsp;</strong>
	                            <sub style="font-size: 1.2em; bottom: 0.75em; bottom: 0.0875em;">없음</sub>
	                        </p>
	                        <p>
	                            <sup>급여한도</sup>
	                            <strong>5</strong>
	                            <sub>개</sub>
	                        </p>
                        </div>
                        <p class="desc">
	                        신체 기능 저하로 실내에서 장시간 같은 자세로<br>
	                        있는 고객에게 추천합니다. 
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a href="${_marketPath}/gds/2/list#21" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" aria-hidden="true" id="contentModal5">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
						<p class="text-title">욕창예방매트리스</p>
                        <button data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="logo"><img src="/html/page/market/assets/images/img-content-bedroom5-1.svg" alt=""></div>
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
                        <p class="desc">
	                        신체 기능 저하로 실내에서 많은 시간<br>
	                        누워 계시는 고객에게 추천합니다.
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a href="${_marketPath}/gds/2/list#22" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                    </div>
                </div>
            </div>
        </div>


        <script>
            var simpleBar    = null,
                simpleWrap   = null,
                simpleEl     = null,
                simpleImg    = null,
                simpleCl     = false,
                background   = null,
                screenHeight = null,
                aspectRatio  = null;

            //object visible check
            var observerCallback = (entries, observer, header) => {
                var indiName = entries[0].target.classList[1].replace('object','item');
                if(entries[0].isIntersecting === true) {
                    document.querySelector('.content-item .' + indiName + ' i').classList.add('is-active');
                } else {
                    document.querySelector('.content-item .' + indiName + ' i').classList.remove('is-active');
                }
            };

            window.addEventListener('load', (e) => {
                container                  = document.querySelector('.style-guide-content2');
                simpleWrap                 = document.querySelector('.content-body');
                simpleBar                  = new SimpleBar(simpleWrap,{autoHide: false, forceVisible: true});
                simpleEl                   = simpleBar.getScrollElement();
                simpleImg                  = simpleEl.querySelector('.container');
                container.style.maxWidth   = simpleEl.querySelector('.background').naturalWidth + 'px';
                simpleImg.style.width      = simpleEl.querySelector('.background').clientWidth + 'px';

                horizonScroll($(simpleEl));

                [].slice.call(document.querySelectorAll('.object')).forEach((e) => {
                    var observer = new IntersectionObserver((entries) => {
                        observerCallback(entries, observer);
                    }, {
                        rootMargin: '100% 0% 100% 0%',
                        threshold: 1
                    });

                    e.classList.add('is-visible');

                    observer.observe(e);
                }, this);

                $('.style-guide-content2').on('mousedown touchstart', function() {
                    $('.content-alert').hide();
                });

                $('.content-body .object').on('click', function() {
                    var id= $(this).attr('href');
                    simpleCl = true;
                    $('.content-item.item a[href="#' + id + '"]').addClass('is-active').parent().addClass('is-active').siblings().removeClass('is-active');
                });

                $('.content-item .item a').on('click', function() {
                    simpleCl = true;
                    $(this).parent().addClass('is-active');
                });

                $('.content-item .item').on('mouseenter', function() {
                    simpleCl = false;
                    $(this).addClass('is-active').siblings().removeClass('is-active');
                });

                $('.content-item .item').on('mouseleave', function() {
                    if(!simpleCl) {
                        $(this).removeClass('is-active').siblings().removeClass('is-active');
                    }
                });

                $('.modal button[data-bs-dismiss]').on('click', function() {
                    simpleCl = false;
                    var id = $(this).closest('.modal').attr('id');
                    $('.content-item.item a[href="#' + id + '"]').removeClass('is-active').parent().removeClass('is-active');
                });
            });

            window.addEventListener('resize', (e) => {
                container.style.maxWidth   = simpleEl.querySelector('.background').naturalWidth + 'px';
                simpleImg.style.width      = simpleEl.querySelector('.background').clientWidth + 'px';
            });
        </script>
        <style>
            .modal-backdrop.show {
                opacity: 0.1;
            }
        </style>
    </div>
</main>