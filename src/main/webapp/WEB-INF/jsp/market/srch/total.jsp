<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!-- container -->
    <main id="container">
        <div id="page-header" class="search-header">
            <ul class="page-header-breadcrumb">
                <li><a href="#">홈</a></li>
                <li><a href="#">복지용구</a></li>
                <li><a href="#">복지용구</a></li>
                <li><a href="#">복지용구</a></li>
            </ul>
            <div class="page-header-title">
                <a href="#" class="back">이전 페이지 가기</a>
                <h2 class="subject"><strong>‘실버카’</strong> 검색결과입니다</h2>
            </div>
        </div>

        <div class="search-container">
            <form action="#" class="search-option">
                <fieldset>
                    <legend class="sr-only">검색 조건</legend>
                    <dl class="form-group">
                        <dt>카테고리</dt>
                        <dd>
                            <label class="form-check">
                                <input type="checkbox" name="" id="search-item1-1" class="form-check-input" checked>
                                <span for="search-item1-1" class="form-check-label">야외</span>
                            </label>
                            <label class="form-check">
                                <input type="checkbox" name="" id="search-item1-2" class="form-check-input">
                                <span for="search-item1-2" class="form-check-label">거실</span>
                            </label>
                        </dd>
                    </dl>
                    <dl class="form-group">
                        <dt>상품구분</dt>
                        <dd>
                            <label class="form-check">
                                <input type="checkbox" name="" id="search-item2-1" class="form-check-input">
                                <span for="search-item2-1" class="form-check-label">급여</span>
                            </label>
                            <label class="form-check">
                                <input type="checkbox" name="" id="search-item2-2" class="form-check-input">
                                <span for="search-item2-2" class="form-check-label">비급여</span>
                            </label>
                            <label class="form-check">
                                <input type="checkbox" name="" id="search-item2-3" class="form-check-input">
                                <span for="search-item2-3" class="form-check-label">일반</span>
                            </label>
                        </dd>
                    </dl>
                    <div class="text-center mt-5 md:mt-7">
                        <button type="submit" class="btn btn-success">검색</button>
                    </div>
                </fieldset>
            </form>

            <div class="search-count">
                <p>총 <strong class="text-danger">6</strong>개의 상품이 있습니다.</p>
                <select class="form-control form-small">
                    <option value="">신상품 순</option>
                </select>
            </div>

            <div class="search-result is-large">
                <p>검색하신 <strong>‘실버카’</strong> 에 대한 상품검색 결과가 없습니다.</p>
            </div>

            <div class="search-grid">
                <!-- <div class="progress-loading">
                    <div class="icon"><span></span><span></span><span></span></div>
                    <p class="text">상품을 불러오는 중입니다.</p>
                </div> -->
                <a href="#" class="product-item">
                    <div class="item-thumb">
                    </div>
                    <div class="item-content">
                        <div class="label">
                            <span class="label-primary">
                                <span>급여가</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>직배송</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>설치</span>
                                <i></i>
                            </span>
                            <span class="label-outline-danger">
                                <span>일시품절</span>
                                <i></i>
                            </span>
                        </div>
                        <div class="name">
                            <small>성인용보행기</small>
                            <strong>살졸 카본 롤레이터</strong>
                        </div>
                        <div class="cost">
                            <dl>
                                <dt>판매가</dt>
                                <dd>66,300<small>원</small></dd>
                            </dl>
                        </div>
                    </div>
                    <div class="item-layer">
                        <div class="mx-auto mb-2.5">
                            <button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
                            <button type="button" class="btn btn-love is-active" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
                            <button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
                        </div>
                        <p class="soldout">전 색상 일시 품절 : 5/27 입고 예정</p>
                    </div>
                    <script>
                        $(function() {
                            $('.btn-compare, .btn-love, .btn-cart').on('click', function(e) {
                                e.stopPropagation();
                                e.preventDefault();
                            })
                        })
                    </script>
                </a>
                <a href="#" class="product-item">
                    <div class="item-thumb is-empty">
                    </div>
                    <div class="item-content">
                        <div class="label">
                            <span class="label-primary">
                                <span>급여가</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>직배송</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>설치</span>
                                <i></i>
                            </span>
                            <span class="label-outline-danger">
                                <span>일시품절</span>
                                <i></i>
                            </span>
                        </div>
                        <div class="name">
                            <small>성인용보행기</small>
                            <strong>살졸 카본 롤레이터</strong>
                        </div>
                        <div class="cost">
                            <dl>
                                <dt>판매가</dt>
                                <dd>66,300<small>원</small></dd>
                            </dl>
                        </div>
                    </div>
                    <div class="item-layer">
                        <div class="mx-auto mb-2.5">
                            <button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
                            <button type="button" class="btn btn-love is-active" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
                            <button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
                        </div>
                        <p class="soldout">전 색상 일시 품절 : 5/27 입고 예정</p>
                    </div>
                </a>
                <a href="#" class="product-item">
                    <div class="item-thumb">
                        <img src="../../assets/images/dummy/img-dummy-product.png" alt="">
                    </div>
                    <div class="item-content">
                        <div class="label">
                            <span class="label-primary">
                                <span>급여가</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>직배송</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>설치</span>
                                <i></i>
                            </span>
                            <span class="label-outline-danger">
                                <span>일시품절</span>
                                <i></i>
                            </span>
                        </div>
                        <div class="name">
                            <small>성인용보행기</small>
                            <strong>살졸 카본 롤레이터</strong>
                        </div>
                        <div class="cost">
                            <dl>
                                <dt>판매가</dt>
                                <dd>66,300<small>원</small></dd>
                            </dl>
                        </div>
                    </div>
                    <div class="item-layer">
                        <div class="mx-auto mb-2.5">
                            <button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
                            <button type="button" class="btn btn-love is-active" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
                            <button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
                        </div>
                        <p class="soldout">전 색상 일시 품절 : 5/27 입고 예정</p>
                    </div>
                </a>
                <a href="#" class="product-item">
                    <div class="item-thumb">
                        <img src="../../assets/images/dummy/img-dummy-product.png" alt="">
                    </div>
                    <div class="item-content">
                        <div class="label">
                            <span class="label-primary">
                                <span>급여가</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>직배송</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>설치</span>
                                <i></i>
                            </span>
                            <span class="label-outline-danger">
                                <span>일시품절</span>
                                <i></i>
                            </span>
                        </div>
                        <div class="name">
                            <small>성인용보행기</small>
                            <strong>살졸 카본 롤레이터</strong>
                        </div>
                        <div class="cost">
                            <dl>
                                <dt>판매가</dt>
                                <dd>66,300<small>원</small></dd>
                            </dl>
                        </div>
                    </div>
                    <div class="item-layer">
                        <div class="mx-auto mb-2.5">
                            <button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
                            <button type="button" class="btn btn-love is-active" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
                            <button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
                        </div>
                        <p class="soldout">전 색상 일시 품절 : 5/27 입고 예정</p>
                    </div>
                </a>
                <a href="#" class="product-item">
                    <div class="item-thumb">
                        <img src="../../assets/images/dummy/img-dummy-product.png" alt="">
                    </div>
                    <div class="item-content">
                        <div class="label">
                            <span class="label-primary">
                                <span>급여가</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>직배송</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>설치</span>
                                <i></i>
                            </span>
                            <span class="label-outline-danger">
                                <span>일시품절</span>
                                <i></i>
                            </span>
                        </div>
                        <div class="name">
                            <small>성인용보행기</small>
                            <strong>살졸 카본 롤레이터</strong>
                        </div>
                        <div class="cost">
                            <dl>
                                <dt>판매가</dt>
                                <dd>66,300<small>원</small></dd>
                            </dl>
                        </div>
                    </div>
                    <div class="item-layer">
                        <div class="mx-auto mb-2.5">
                            <button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
                            <button type="button" class="btn btn-love is-active" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
                            <button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
                        </div>
                        <p class="soldout">전 색상 일시 품절 : 5/27 입고 예정</p>
                    </div>
                </a>
                <a href="#" class="product-item">
                    <div class="item-thumb">
                        <img src="../../assets/images/dummy/img-dummy-product.png" alt="">
                    </div>
                    <div class="item-content">
                        <div class="label">
                            <span class="label-primary">
                                <span>급여가</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>직배송</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>설치</span>
                                <i></i>
                            </span>
                            <span class="label-outline-danger">
                                <span>일시품절</span>
                                <i></i>
                            </span>
                        </div>
                        <div class="name">
                            <small>성인용보행기</small>
                            <strong>살졸 카본 롤레이터</strong>
                        </div>
                        <div class="cost">
                            <dl>
                                <dt>판매가</dt>
                                <dd>66,300<small>원</small></dd>
                            </dl>
                        </div>
                    </div>
                    <div class="item-layer">
                        <div class="mx-auto mb-2.5">
                            <button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
                            <button type="button" class="btn btn-love is-active" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
                            <button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
                        </div>
                        <p class="soldout">전 색상 일시 품절 : 5/27 입고 예정</p>
                    </div>
                </a>
                <a href="#" class="product-item">
                    <div class="item-thumb">
                        <img src="../../assets/images/dummy/img-dummy-product.png" alt="">
                    </div>
                    <div class="item-content">
                        <div class="label">
                            <span class="label-primary">
                                <span>급여가</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>직배송</span>
                                <i></i>
                            </span>
                            <span class="label-outline-primary">
                                <span>설치</span>
                                <i></i>
                            </span>
                            <span class="label-outline-danger">
                                <span>일시품절</span>
                                <i></i>
                            </span>
                        </div>
                        <div class="name">
                            <small>성인용보행기</small>
                            <strong>살졸 카본 롤레이터</strong>
                        </div>
                        <div class="cost">
                            <dl>
                                <dt>판매가</dt>
                                <dd>66,300<small>원</small></dd>
                            </dl>
                        </div>
                    </div>
                    <div class="item-layer">
                        <div class="mx-auto mb-2.5">
                            <button type="button" class="btn btn-compare" data-bs-toggle="tooltip" title="상품 비교 추가">상품 비교 추가</button>
                            <button type="button" class="btn btn-love is-active" data-bs-toggle="tooltip" title="관심상품 등록">관심상품 등록</button>
                            <button type="button" class="btn btn-cart" data-bs-toggle="tooltip" title="장바구니 담기">장바구니 담기</button>
                        </div>
                        <p class="soldout">전 색상 일시 품절 : 5/27 입고 예정</p>
                    </div>
                </a>
            </div>
        </div>
    </main>
    <!-- //container -->


<script>
$(function(){

});
</script>