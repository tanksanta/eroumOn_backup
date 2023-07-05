<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
<div class="main-visual">
	<div class="swiper">
		<div class="swiper-wrapper">
			<c:forEach var="resultList" items="${mainBannerList}" varStatus="status">
				<div class="swiper-slide">
					<a href="${resultList.linkUrl}">
						<picture>
							<c:forEach var="fileList" items="${resultList.mobilefileList}" varStatus="stts">
								<source srcset="/comm/getFile?srvcId=BANNER&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" media="(max-width: 768px)">
							</c:forEach>
							 
							<c:forEach var="fileList" items="${resultList.pcfileList}" varStatus="stts">
								<source srcset="/comm/getFile?srvcId=BANNER&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">
								<img src="/comm/getFile?srvcId=BANNER&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" alt="">
							</c:forEach>
						</picture>
					</a>
				</div>
			</c:forEach>

		</div>
	</div>
	<div class="swiper-control">
		<div class="swiper-control-container">
			<div class="swiper-button">
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-toggle"></div>
				<div class="swiper-button-next"></div>
			</div>
			<div class="swiper-pagination"></div>
		</div>
	</div>
</div>

<div class="main-product">
	<h2 class="title">
		<img src="/html/page/market/assets/images/ico-main-product1.png" alt=""> 오늘의 쇼핑 제안
	</h2>
	<div class="swiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl>
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl class="hypen">
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
							<dl class="discount">
								<dt>오늘의 특가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl>
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl>
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-button-next"></div>
</div>

<div class="main-banner1">
	<c:forEach var="resultList" items="${mainMngList }" varStatus="status">
		<c:if test="${resultList.themaTy eq 'H' }">
		<div <c:if test="${resultList.sortNo eq 1}">class="left"</c:if><c:if test="${resultList.sortNo eq 2}">class="right"</c:if>>
			<a href="${resultList.linkUrl}"> <picture>
				<source srcset="/comm/getFile?srvcId=MAIN&amp;upNo=${fileList.upNo }&amp;fileTy=HALF&amp;fileNo=${fileList.fileNo }">
				<img src="/comm/getFile?srvcId=MAIN&amp;upNo=${fileList.upNo }&amp;fileTy=HALF&amp;fileNo=${fileList.fileNo }" alt=""> <!-- pc url --> </picture>
			</a>
		</div>
		</c:if>
	</c:forEach>
	
	
	<!-- <div class="right">
		<a href="#"> <picture>
			<source srcset="/html/page/market/assets/images/dummy/img-dummy-main-banner2.png" media="(max-width: 768px)">
			<!-- mobile url -->
			<!-- <source srcset="/html/page/market/assets/images/dummy/img-dummy-main-banner2.png">
			<!-- pc url  <img src="/html/page/market/assets/images/dummy/img-dummy-main-banner2.png" alt=""> <!-- pc url  </picture>
		</a>
	</div> -->
</div>

<div class="main-product">
	<h2 class="title">
		<img src="/html/page/market/assets/images/ico-main-product2.png" alt=""> 좋아할만한 카테고리 상품
	</h2>
	<div class="swiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl>
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl class="hypen">
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
							<dl class="discount">
								<dt>오늘의 특가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl>
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl>
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-button-next"></div>
</div>

<div class="main-banner2">
	<a href="#"> <picture>
		<source srcset="/html/page/market/assets/images/dummy/img-dummy-main-banner3.png" media="(max-width: 768px)">
		<!-- mobile url -->
		<source srcset="/html/page/market/assets/images/dummy/img-dummy-main-banner3.png">
		<!-- pc url --> <img src="/html/page/market/assets/images/dummy/img-dummy-main-banner3.png" alt=""> <!-- pc url --> </picture>
	</a>
</div>

<div class="main-product">
	<h2 class="title">
		<img src="/html/page/market/assets/images/ico-main-product3.png" alt=""> 오늘의 판매 특가
	</h2>
	<div class="swiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl>
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl class="hypen">
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
							<dl class="discount">
								<dt>오늘의 특가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl>
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
			<div class="swiper-slide">
				<div class="product-item">
					<div class="item-thumb">
						<img src="/html/page/market/assets/images/dummy/img-dummy-product.png" alt="">
					</div>
					<a href="#" class="item-content">
						<div class="name">
							<small>성인용보행기</small> <strong>살졸 카본 롤레이터</strong>
						</div>
						<div class="cost">
							<dl>
								<dt>판매가</dt>
								<dd>
									66,300<small>원</small>
								</dd>
							</dl>
						</div>
					</a>
					<div class="item-layer">
						<div class="mx-auto mb-2.5">
							<button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
							<button type="button" class="btn btn-love" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
							<button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-button-next"></div>
</div>

<script>
            window.addEventListener('DOMContentLoaded', (e) => {
                var visual = new Swiper('.main-visual .swiper', {
                    loop: true,
                    slidesPerView: 1,
                    spaceBetween: 0,
                    speed: 1000,
                    autoplay: {
                        delay: 6000,
                        disableOnInteraction: false,
                    },
                    pagination: {
                        el: '.main-visual .swiper-pagination',
                        type: 'fraction',
                    },
                    navigation: {
                        nextEl: '.main-visual .swiper-button-next',
                        prevEl: '.main-visual .swiper-button-prev',
                    },
                });

                $(".swiper-button-toggle").click(function() {
                    if($(this).hasClass('is-pause')) {
                        $(this).removeClass('is-pause');
                        visual.autoplay.start();
                    } else {
                        $(this).addClass('is-pause');
                        visual.autoplay.stop();
                    }
                });

                [].slice.call(document.querySelectorAll('.main-product')).forEach((el) => {
                    new Swiper(el.querySelector('.swiper'), {
                        loop: true,
                        slidesPerView: 'auto',
                        spaceBetween: 10,
                        navigation: {
                            nextEl: el.querySelector('.swiper-button-next'),
                            prevEl: el.querySelector('.swiper-button-prev')
                        },
                        breakpoints: {
                            768: {
                                slidesPerView: 'auto',
                                spaceBetween: 15,
                            },
                            1280: {
                                slidesPerView: 4,
                                spaceBetween: 20,
                            }
                        }
                    });
                });
            });
        </script>
</main>