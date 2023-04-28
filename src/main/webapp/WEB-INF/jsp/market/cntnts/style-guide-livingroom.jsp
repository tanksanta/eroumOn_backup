<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container" class="relative" style="padding-bottom: 0;">
	<link rel="stylesheet" href="/html/core/vendor/simplebars/simplebar.css">
	<script src="/html/core/vendor/simplebars/simplebar.min.js"></script>

    <div class="style-guide-livingroom">
        <div class="livingroom-title">
            <small class="slogan"><strong>Senior Life Style</strong> by Eroum <i></i> <strong>LIVING ROOM</strong></small>
            <h2 class="title">편안한 <em>거실생활</em></h2>
            <p class="desc">일상생활에서 가장 많이 활동하는 공간으로 이동에 편리함을 주는 복지용구를 소개해드립니다.</p>
        </div>
        <div class="livingroom-alert">
            <img src="/html/page/market/assets/images/ico-content-livingroom-drag.svg" alt="">
            터치하여 좌우로 움직여보세요
        </div>
        <div class="livingroom-visual">
            <div class="container">
                <img src="/html/page/market/assets/images/bg-content-livingroom.jpg" alt="" class="background">
                <a href="contentModal1" class="object object-1" data-bs-toggle="modal" data-bs-target="#contentModal1">
                    <img src="/html/page/market/assets/images/img-content-livingroom1.png" alt="" class="photo">
                    <div class="name">
                        <em>안전손잡이</em>
                        <i>
                            <span class="f"></span>
                            <span class="r">view</span>
                        </i>
                    </div>
                </a>
                <a href="contentModal2" class="object object-2" data-bs-toggle="modal" data-bs-target="#contentModal2">
                    <img src="/html/page/market/assets/images/img-content-livingroom2.png" alt="" class="photo">
                    <div class="name">
                        <em>성인용보행기</em>
                        <i>
                            <span class="f"></span>
                            <span class="r">view</span>
                        </i>
                    </div>
                </a>
                <a href="contentModal3" class="object object-3" data-bs-toggle="modal" data-bs-target="#contentModal3">
                    <img src="/html/page/market/assets/images/img-content-livingroom3.png" alt="" class="photo">
                    <div class="name">
                        <em>미끄럼방지양말</em>
                        <i>
                            <span class="f"></span>
                            <span class="r">view</span>
                        </i>
                    </div>
                </a>
                <a href="contentModal4" class="object object-4" data-bs-toggle="modal" data-bs-target="#contentModal4">
                    <img src="/html/page/market/assets/images/img-content-livingroom4.png" alt="" class="photo">
                    <div class="name">
                        <em>지팡이</em>
                        <i>
                            <span class="f"></span>
                            <span class="r">view</span>
                        </i>
                    </div>
                </a>
            </div>
        </div>
        <div class="livingroom-steps">
            <div class="steps">
                <a href="#contentModal1" data-bs-toggle="modal" data-bs-target="#contentModal1">안전손잡이</a>
                <i></i>
            </div>
            <div class="steps">
                <a href="#contentModal2" data-bs-toggle="modal" data-bs-target="#contentModal2">성인용 보행기 <br class="hidden xs:inline"> 워커</a>
                <i></i>
            </div>
            <div class="steps">
                <a href="#contentModal3" data-bs-toggle="modal" data-bs-target="#contentModal3">미끄럼방지<br> 양말</a>
                <i></i>
            </div>
            <div class="steps">
                <a href="#contentModal4" data-bs-toggle="modal" data-bs-target="#contentModal4">지팡이<br></a>
                <i></i>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" aria-hidden="true" id="contentModal1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">
                        	안전손잡이_벽걸이형
							<small class="block text-left">(변기형, 벽걸이형, 기둥형)</small>
						</p>
                        <button data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="logo"><img src="/html/page/market/assets/images/img-content-livingroom1-1.svg" alt=""></div>
                        <div class="info">
	                        <p>
	                            <sup>사용연한</sup>
	                            <strong>&nbsp;</strong>
	                            <sub style="font-size: 1.2em; bottom: 0.75em; bottom: 0.0875em;">없음</sub>
	                        </p>
	                        <p>
	                            <sup>급여한도</sup>
	                            <strong>10</strong>
	                            <sub>개</sub>
	                        </p>
                        </div>
                        <p class="desc">
                            신체가 불편하거나, 일어서거나 앉을 때<br>
                            혈압이 떨어지는 상황에 도움되는 복지용구
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
                        <p class="text-title">
                        	성인용 보행기_워커
							<small class="block text-left">(실버카, 롤레이터, 워커)</small>
						</p>
                        <button data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="logo"><img src="/html/page/market/assets/images/img-content-livingroom2-1.svg" alt=""></div>
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
                        <p class="desc">
                            실내용으로 재활 목적을 가진 제품으로<br>
                            수술 전, 후 도움되는 복지용구
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a href="${_marketPath}/gds/2/list#37" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" aria-hidden="true" id="contentModal3">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">미끄럼방지 양말</p>
                        <button data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="logo"><img src="/html/page/market/assets/images/img-content-livingroom3-1.svg" alt="" style="height: 80%;"></div>
                        <div class="info">
	                        <p>
	                            <sup>사용연한</sup>
	                            <strong>&nbsp;</strong>
	                            <sub style="font-size: 1.2em; bottom: 0.75em; bottom: 0.0875em;">없음</sub>
	                        </p>
	                        <p>
	                            <sup>급여한도</sup>
	                            <strong>6</strong>
	                            <sub>개</sub>
	                        </p>
                        </div>
                        <p class="desc">
                        	신체 기능 저하로 실내에서<br>
                        	낙상(넘어지는)을 예방하는 복지용구
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a href="${_marketPath}/gds/2/list#5" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" tabindex="-1" aria-hidden="true" id="contentModal4">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">지팡이</p>
                        <button data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="logo"><img src="/html/page/market/assets/images/img-content-livingroom4-1.svg" alt=""></div>
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
							일반적인 보행이 불편하고<br>
							실내에서 낙상(넘어지는)을 예방하는 복지용구
                        </p>
                    </div>
                    <div class="modal-footer">
                        <a href="${_marketPath}/gds/2/list#39" class="btn btn-large btn-primary">복지용구 상품 바로보기</a>
                    </div>
                </div>
            </div>
        </div>

        <script>
            $(function() {
                var simpleBar = new SimpleBar($('.livingroom-visual')[0],{
                    autoHide: false,
                    forceVisible: true
                    // classNames: {contentWrapper: 'dragscroll'}
                });

                var simpleEl  = simpleBar.getScrollElement();
                var simpleCl  = false;

                simpleEl.scrollLeft = (simpleEl.querySelector('.container').getClientRects()[0].width - simpleEl.getClientRects()[0].width) / 2;

                //dragscroll.reset();

                simpleBar.getScrollElement().addEventListener('scroll', function() {
                    var cont     = $(this).find('.container').get(0).getClientRects()[0];
                    var contview = cont.width + cont.x;
                    var screen   = this.getClientRects()[0].width;

                    $('.livingroom-visual .object').each(function(index) {
                        var temp   = $(this).get(0).getClientRects()[0].x + ($(this).get(0).getClientRects()[0].width);
                        if(temp > 0 && temp < screen) {
                            $('.livingroom-steps .steps').eq(index).find('i').addClass('is-active');
                        } else {
                            $('.livingroom-steps .steps').eq(index).find('i').removeClass('is-active');
                        }
                    });
                });

                $(window).on('load resize', function() {
                    var cont     = $(simpleBar.getScrollElement()).find('.container').get(0).getClientRects()[0];
                    var contview = cont.width + cont.x;
                    var screen   = simpleBar.getScrollElement().getClientRects()[0].width;


                    if($(window).width() > 1280) {
                        $('.livingroom-visual').height($(window).outerWidth() * 0.625);
                    } else {
                        $('.livingroom-visual').height($(window).outerWidth() * 0.6875);
                    }

                    $('.livingroom-visual .container').width($('.livingroom-visual').height() * 2.133333333333333);

                    $('.livingroom-visual .object').each(function(index) {
                        var temp   = $(this).get(0).getClientRects()[0].x + $(this).get(0).getClientRects()[0].width + 10;
                        if(temp > 0 && temp < screen) {
                            $('.livingroom-steps .steps').eq(index).find('i').addClass('is-active');
                        } else {
                            $('.livingroom-steps .steps').eq(index).find('i').removeClass('is-active');
                        }
                    });
                })

                $('.style-guide-livingroom .dragscroll').on('mousedown touchstart', function() {
                    $('.livingroom-alert').hide();
                });

                $('.livingroom-visual .object').on('click', function() {
                    var id= $(this).attr('href');
                    simpleCl = true;
                    $('.livingroom-steps .steps a[href="#' + id + '"]').addClass('is-active').parent().addClass('is-active').siblings().removeClass('is-active');
                });

                $('.livingroom-steps .steps a').on('click', function() {
                    simpleCl = true;
                    $(this).parent().addClass('is-active');
                });

                $('.livingroom-steps .steps').on('mouseenter', function() {
                    simpleCl = false;
                    $(this).addClass('is-active').siblings().removeClass('is-active');
                });

                $('.livingroom-steps .steps').on('mouseleave', function() {
                    if(!simpleCl) {
                        $(this).removeClass('is-active').siblings().removeClass('is-active');
                    }
                });

                $('.modal button[data-bs-dismiss]').on('click', function() {
                    simpleCl = false;
                    var id = $(this).closest('.modal').attr('id');
                    $('.livingroom-steps .steps a[href="#' + id + '"]').removeClass('is-active').parent().removeClass('is-active');
                });
            })
        </script>
        <style>
            .modal-backdrop.show {
                opacity: 0.1;
            }
        </style>
    </div>
</main>