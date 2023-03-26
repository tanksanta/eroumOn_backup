<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 포토 상품후기 -->
<div class="modal fade" id="modal-photo" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p class="text-title">${reviewVO.ttl}</p>
			</div>
			<div class="modal-close">
				<button data-bs-dismiss="modal">모달 닫기</button>
			</div>
			<div class="modal-body">
				<div class="product-itemphoto-layer">
					<div class="layer-user">
						<img src="/html/page/market/assets/images/dummy/img-dummy-partners.png" alt="" class="thumb">
						<div class="name">
							<strong>${reviewVO.regId}</strong> <span><fmt:formatDate value="${reviewVO.regDt}" pattern="yyyy-MM-dd" /></span>
						</div>
					</div>
					<div class="layer-content">${reviewVO.cn}</div>

					<div class="swiper layer-swiper-thumb">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<c:set var="imgFile" value="${reviewVO.imgFile}" />
								<img src="/comm/getImage?srvcId=REVIEW&amp;upNo=${reviewVO.gdsReivewNo}&amp;fileNo=${imgFile.fileNo}" alt="" >
							</div>
						</div>

				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<!-- //포토 상품후기 -->