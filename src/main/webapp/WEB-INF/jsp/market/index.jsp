<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
<div class="main-visual">
	<div class="swiper">
		<div class="swiper-wrapper">
			<c:forEach var="resultList" items="${mainBannerList}" varStatus="status">
				<div class="swiper-slide">
					<c:if test="${resultList.linkTy ne 'N' }"><a href="${resultList.linkUrl}?rdcntBanner=${resultList.bannerNo}" <c:if test="${resultList.linkTy eq 'S'}">target="_blank"</c:if>></c:if>
						<picture>
							<c:forEach var="fileList" items="${resultList.mobileFileList}" varStatus="stts">
								<source srcset="/comm/getFile?srvcId=BANNER&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" media="(max-width: 768px)">
							</c:forEach>

							<c:forEach var="fileList" items="${resultList.pcFileList}" varStatus="stts">
								<source srcset="/comm/getFile?srvcId=BANNER&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">
								<img src="/comm/getFile?srvcId=BANNER&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" alt="">
							</c:forEach>
						</picture>
					<c:if test="${resultList.linkTy ne 'N' }"></a></c:if>
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

<c:forEach var="gdsMainList" items="${mainMngList}" >
<c:if test="${gdsMainList.themaTy eq 'G' && gdsMainList.sortNo eq 1}">
<div class="main-product">
	<h2 class="title">
		<c:forEach var="fileList" items="${gdsMainList.fileList}">
			<img src="/comm/getFile?srvcId=MAIN&amp;upNo=${fileList.upNo }&amp;fileTy=ATTACH&amp;fileNo=${fileList.fileNo }" alt="">
		 </c:forEach>
		${gdsMainList.sj}
	</h2>
	<div class="swiper">
		<div class="swiper-wrapper">

			<c:forEach var="resultList" items="${gdsMainList.gdsList}">
				<div class="swiper-slide">
					<div class="product-item">
						<div class="item-thumb">
							<c:set var="fileList" value="${resultList.gdsInfo.thumbnailFile}" />

								<img src="/comm/getFile?srvcId=GDS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy}&amp;fileNo=${fileList.fileNo }" alt="">
							</a>
						</div>
						<a href="${_marketPath}/gds/${resultList.gdsInfo.ctgryNo}/${resultList.gdsInfo.gdsCd}?rdcntMain=${resultList.mainNo}" class="item-content">
							<div class="name">
								<small>${resultList.gdsCtgry.ctgryNm}</small>
								<strong>${resultList.gdsInfo.gdsNm}</strong>
							</div>
							<div class="cost">
								<dl>
									<dt>판매가</dt>
									<dd>
										<fmt:formatNumber value="${resultList.gdsInfo.pc}" pattern="###,###" />
										<small>원</small>
									</dd>
								</dl>
							</div>
						</a>
						<div class="item-layer">
							<div class="mx-auto mb-2.5">
								<c:if test="${_mbrSession.loginCheck}">
                                	<button type="button" class="btn btn-love f_wish ${resultList.gdsInfo.wishYn>0?'is-active':'' }" data-gds-no="${resultList.gdsInfo.gdsNo}" data-wish-yn="${resultList.gdsInfo.wishYn>0?'Y':'N'}" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
                                </c:if>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-button-next"></div>
</div>
</c:if>
</c:forEach>

<div class="main-banner1">
	<c:forEach var="resultList" items="${mainMngList}" varStatus="status">
		<c:if test="${resultList.themaTy eq 'H' }">
			<div <c:if test="${resultList.sortNo eq 1}">class="left"</c:if><c:if test="${resultList.sortNo eq 2}">class="right"</c:if>>
				<a href="${resultList.linkUrl}?rdcntMain=${resultList.mainNo}"> <picture>
					<c:forEach var="fileList" items="${resultList.halfFileList}">
						<source srcset="/comm/getFile?srvcId=MAIN&amp;upNo=${fileList.upNo }&amp;fileTy=HALF&amp;fileNo=${fileList.fileNo }">
						<img src="/comm/getFile?srvcId=MAIN&amp;upNo=${fileList.upNo }&amp;fileTy=HALF&amp;fileNo=${fileList.fileNo }" alt=""> <!-- pc url --> </picture>
					</c:forEach>
				</a>
			</div>
		</c:if>
	</c:forEach>

</div>

<c:forEach var="gdsMainList" items="${mainMngList}" >
<c:if test="${gdsMainList.themaTy eq 'G' && gdsMainList.sortNo eq 2}">
<div class="main-product">
	<h2 class="title">
		<c:forEach var="fileList" items="${gdsMainList.fileList}">
			<img src="/comm/getFile?srvcId=MAIN&amp;upNo=${fileList.upNo }&amp;fileTy=ATTACH&amp;fileNo=${fileList.fileNo }" alt="">
		 </c:forEach>
		${gdsMainList.sj}
	</h2>
	<div class="swiper">
		<div class="swiper-wrapper">

			<c:forEach var="resultList" items="${gdsMainList.gdsList}">
				<div class="swiper-slide">
					<div class="product-item">
						<div class="item-thumb">
							<c:set var="fileList" value="${resultList.gdsInfo.thumbnailFile}" />
							<img src="/comm/getFile?srvcId=GDS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy}&amp;fileNo=${fileList.fileNo }" alt="">
						</div>
						<a href="${_marketPath}/gds/${resultList.gdsInfo.ctgryNo}/${resultList.gdsInfo.gdsCd}?rdcntMain=${resultList.mainNo}" class="item-content">
							<div class="name">
								<small>${resultList.gdsCtgry.ctgryNm}</small>
								<strong>${resultList.gdsInfo.gdsNm}</strong>
							</div>
							<div class="cost">
								<dl>
									<dt>판매가</dt>
									<dd>
										<fmt:formatNumber value="${resultList.gdsInfo.pc}" pattern="###,###" />
										<small>원</small>
									</dd>
								</dl>
							</div>
						</a>
						<div class="item-layer">
							<div class="mx-auto mb-2.5">
								<c:if test="${_mbrSession.loginCheck}">
                                	<button type="button" class="btn btn-love f_wish ${resultList.gdsInfo.wishYn>0?'is-active':'' }" data-gds-no="${resultList.gdsInfo.gdsNo}" data-wish-yn="${resultList.gdsInfo.wishYn>0?'Y':'N'}" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
                                </c:if>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-button-next"></div>
</div>
</c:if>
</c:forEach>

<div class="main-banner2">
	<c:forEach var="resultList" items="${mainMngList}" varStatus="status">
		<c:if test="${resultList.themaTy eq 'B'}">
			<a href="${resultList.linkUrl}?rdcntMain=${resultList.mainNo}">
				<picture>
					<c:forEach var="mobileFileList" items="${resultList.mobileImgFileList}">
						<source srcset="/comm/getFile?srvcId=MAIN&amp;upNo=${mobileFileList.upNo }&amp;fileTy=MOBILE&amp;fileNo=${mobileFileList.fileNo }" media="(max-width: 768px)">
					</c:forEach>

					<c:forEach var="pcFileList" items="${resultList.pcImgFileList}">
						<source srcset="/comm/getFile?srvcId=MAIN&amp;upNo=${pcFileList.upNo }&amp;fileTy=PC&amp;fileNo=${pcFileList.fileNo }">
						<img src="/comm/getFile?srvcId=MAIN&amp;upNo=${pcFileList.upNo }&amp;fileTy=PC&amp;fileNo=${pcFileList.fileNo }" alt=""> <!-- pc url -->
					</c:forEach>
				</picture>
			</a>
		</c:if>
	</c:forEach>
</div>

<c:forEach var="gdsMainList" items="${mainMngList}" >
<c:if test="${gdsMainList.themaTy eq 'G' && gdsMainList.sortNo eq 3}">
<div class="main-product">
	<h2 class="title">
		<c:forEach var="fileList" items="${gdsMainList.fileList}">
			<img src="/comm/getFile?srvcId=MAIN&amp;upNo=${fileList.upNo }&amp;fileTy=ATTACH&amp;fileNo=${fileList.fileNo }" alt="">
		 </c:forEach>
		${gdsMainList.sj}
	</h2>
	<div class="swiper">
		<div class="swiper-wrapper">

			<c:forEach var="resultList" items="${gdsMainList.gdsList}">
				<div class="swiper-slide">
					<div class="product-item">
						<div class="item-thumb">
							<c:set var="fileList" value="${resultList.gdsInfo.thumbnailFile}" />
							<img src="/comm/getFile?srvcId=GDS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy}&amp;fileNo=${fileList.fileNo }" alt="">
						</div>
						<a href="${_marketPath}/gds/${resultList.gdsInfo.ctgryNo}/${resultList.gdsInfo.gdsCd}?rdcntMain=${resultList.mainNo}" class="item-content">
							<div class="name">
								<small>${resultList.gdsCtgry.ctgryNm}</small>
								<strong>${resultList.gdsInfo.gdsNm}</strong>
							</div>
							<div class="cost">
								<dl>
									<dt>판매가</dt>
									<dd>
										<fmt:formatNumber value="${resultList.gdsInfo.pc}" pattern="###,###" />
										<small>원</small>
									</dd>
								</dl>
							</div>
						</a>
						<div class="item-layer">
							<div class="mx-auto mb-2.5">
								<c:if test="${_mbrSession.loginCheck}">
                                	<button type="button" class="btn btn-love f_wish ${resultList.gdsInfo.wishYn>0?'is-active':'' }" data-gds-no="${resultList.gdsInfo.gdsNo}" data-wish-yn="${resultList.gdsInfo.wishYn>0?'Y':'N'}" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
                                </c:if>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>

		</div>
	</div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-button-next"></div>
</div>
</c:if>
</c:forEach>

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