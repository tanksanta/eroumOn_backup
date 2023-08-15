<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container" class="is-mypage-style">
		<header id="page-title">
			<h2>
				<span>장기요양 상담신청</span>
			</h2>
		</header>

		<jsp:include page="../../layout/page_nav.jsp" />

        <div id="page-content">

            <h3 class="mypage-title">
                장기요양 상담신청
                <button type="button" class="mypage-consult-toggle">상세검색</button>
            </h3>

            <form action="" class="mypage-consult-search">
                <fieldset>
                    <legend>상세 검색</legend>
                    <button type="button" class="search-close">닫기</button>
                    <dl class="search-date">
                        <dt><label for="search-item1">상담 신청일</label></dt>
                        <dd>
                            <div class="form-group">
                                <input type="date" class="form-control" id="search-item1">
                                <span>-</span>
                                <input type="date" class="form-control">
                            </div>
                            <div class="form-group-check">
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input">
                                    <span class="form-check-label">오늘</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input">
                                    <span class="form-check-label">일주일</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input">
                                    <span class="form-check-label">15일</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input">
                                    <span class="form-check-label">한달</span>
                                </label>
                            </div>
                        </dd>
                    </dl>
                    <dl class="search-partner">
                        <dt><label for="search-item2">상담 사업소</label></dt>
                        <dd><input type="text"id="search-item2" class="form-control w-full md:w-83"></dd>
                    </dl>
                    <dl class="search-current">
                        <dt><label for="search-item3">상담 접수 현황</label></dt>
                        <dd>
                            <select name="" id="search-item3" class="form-control w-full md:w-40">
                                <option value="">옵션</option>
                            </select>
                        </dd>
                    </dl>
                    <button type="submit" class="search-submit">검색</button>
                </fieldset>
            </form>

            <div class="mypage-consult-desc">
                <p class="text-alert">장기요양테스트 후 1:1상담 신청한 내역을 확인하는 페이지입니다.</p>
            </div>

            <p><strong>총 9건</strong>의 상담신청 내역이 있습니다.</p>

            <div class="mypage-consult-items mt-3.5 md:mt-5">
                <div class="mypage-consult-item-gutter"></div>
                <div class="mypage-consult-item">
                    <dl class="item-current">
                        <dt>상담진행 현황</dt>
                        <dd>상담 신청 완료</dd>
                    </dl>
                    <dl class="item-partner">
                        <dt>상담 사업소</dt>
                        <dd><strong>장기요양기관 배정 중</strong> 입니다.</dd>
                    </dl>
                    <dl class="item-date">
                        <dt>상담 신청일</dt>
                        <dd>2023.07.28</dd>
                    </dl>
                    <div class="item-request">
                        <button type="button" class="button" data-bs-toggle="modal" data-bs-target="#reqModal">재 상담 신청</button>
                        <label class="check1">
                            <input type="checkbox" name="" value="">
                            <span>추천하기</span>
                        </label>
                        <label class="check2">
                            <input type="checkbox" name="" value="">
                            <span>관심설정</span>
                        </label>
                    </div>
                </div>
                <div class="mypage-consult-item">
                    <dl class="item-current">
                        <dt>상담진행 현황</dt>
                        <dd>상담 신청 완료</dd>
                    </dl>
                    <dl class="item-partner">
                        <dt>상담 사업소</dt>
                        <dd><strong>장기요양기관 배정 중</strong> 입니다.</dd>
                    </dl>
                    <dl class="item-date">
                        <dt>상담 신청일</dt>
                        <dd>2023.07.28</dd>
                    </dl>
                </div>
                <div class="mypage-consult-item">
                    <dl class="item-current">
                        <dt>상담진행 현황</dt>
                        <dd>상담 신청 완료</dd>
                    </dl>
                    <dl class="item-partner">
                        <dt>상담 사업소</dt>
                        <dd><strong>장기요양기관 배정 중</strong> 입니다.</dd>
                    </dl>
                    <dl class="item-date">
                        <dt>상담 신청일</dt>
                        <dd>2023.07.28</dd>
                    </dl>
                </div>
                <div class="mypage-consult-item">
                    <dl class="item-current">
                        <dt>상담진행 현황</dt>
                        <dd>상담 신청 완료</dd>
                    </dl>
                    <dl class="item-partner">
                        <dt>상담 사업소</dt>
                        <dd><strong>장기요양기관 배정 중</strong> 입니다.</dd>
                    </dl>
                    <dl class="item-date">
                        <dt>상담 신청일</dt>
                        <dd>2023.07.28</dd>
                    </dl>
                </div>
                <div class="mypage-consult-item">
                    <dl class="item-current">
                        <dt>상담진행 현황</dt>
                        <dd>상담 신청 완료</dd>
                    </dl>
                    <dl class="item-partner">
                        <dt>상담 사업소</dt>
                        <dd><strong>장기요양기관 배정 중</strong> 입니다.</dd>
                    </dl>
                    <dl class="item-date">
                        <dt>상담 신청일</dt>
                        <dd>2023.07.28</dd>
                    </dl>
                </div>
                <div class="mypage-consult-item">
                    <dl class="item-current">
                        <dt>상담진행 현황</dt>
                        <dd>상담 신청 완료</dd>
                    </dl>
                    <dl class="item-partner">
                        <dt>상담 사업소</dt>
                        <dd>
                            <strong>장기요양기관 배정 중</strong> 입니다.
                            <ul class="history">
                                <li>
                                    <small>1차 상담</small>
                                    <span>상담소명</span>
                                </li>
                            </ul>
                        </dd>
                    </dl>
                    <dl class="item-date">
                        <dt>상담 신청일</dt>
                        <dd>2023.07.28</dd>
                    </dl>
                    <div class="item-request">
                        <button type="button" class="button" data-bs-toggle="modal" data-bs-target="#reqModal">재 상담 신청</button>
                        <label class="check1">
                            <input type="checkbox" name="" value="">
                            <span>추천하기</span>
                        </label>
                        <label class="check2">
                            <input type="checkbox" name="" value="">
                            <span>관심설정</span>
                        </label>
                    </div>
                </div>
            </div>

            <div class="pagination">
                <div class="paging">
                    <a href="#" class="prev">이전</a>
                    <a href="#" class="page active">1</a>
                    <a href="#" class="page">2</a>
                    <a href="#" class="page">3</a>
                    <a href="#" class="page">4</a>
                    <a href="#" class="page">5</a>
                    <a href="#" class="next">다음</a>
                </div>
            </div>

            <script>
                $(function() {
                    $('.mypage-consult-items').masonry({
                        itemSelector   : '.mypage-consult-item',
                        gutter         : '.mypage-consult-item-gutter',
                        percentPosition: true
                    });

                    $('.consult-toggle, .consult-search-close').on('click', function() {
                        $('body').toggleClass('overflow-hidden').find('.consult-search').toggle();
                    });

                    $(window).on('resize', function() {
                        if(resize) $('body').removeClass('overflow-hidden').find('.consult-search').removeAttr('style');
                    })
                })
            </script>

            <div class="modal fade" id="reqModal" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog  modal-dialog-centered">
                    <form class="modal-content">
                        <div class="modal-header">
                            <p class="text-title">재 상담 신청 사유 입력</p>
                        </div>
                        <div class="modal-close">
                            <button type="button" data-bs-dismiss="modal">모달 닫기</button>
                        </div>
                        <div class="modal-body">
                            <p class="text-alert">재 상담 신청 사유를 입력해 주세요.</p>
                            <textarea name="" cols="30" rows="10" class="form-control mt-3.5 w-full h-58"></textarea>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary btn-submit">저장하기</button>
                            <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

    </main>
	<script src="/html/core/vendor/masonry/masonry.pkgd.min.js"></script>
    <script>
    $(function(){
    });
    </script>
