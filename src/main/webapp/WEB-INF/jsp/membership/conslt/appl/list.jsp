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

            <form action="./list" method="get" id="searchFrm" name="searchFrm" class="mypage-consult-search">
                <fieldset>
                    <legend>상세 검색</legend>
                    <button type="button" class="search-close">닫기</button>
                    <dl class="search-date">
                        <dt><label for="srchRegBgng">상담 신청일</label></dt>
                        <dd>
                            <div class="form-group">
                                <input type="date" class="form-control" id="srchRegBgng" name="srchRegBgng" value="${param.srchRegBgng}">
                                <span>-</span>
                                <input type="date" class="form-control" id="srchRegEnd" name="srchRegEnd" value="${param.srchRegEnd}">
                            </div>
                            <div class="form-group-check">
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('1'); return false;">
                                    <span class="form-check-label">오늘</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('2'); return false;">
                                    <span class="form-check-label">일주일</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('3'); return false;">
                                    <span class="form-check-label">15일</span>
                                </label>
                                <label class="form-check">
                                    <input type="radio" name="" value="" class="form-check-input" onclick="f_srchJoinSet('4'); return false;">
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
                        <dt><label for="srchConsltSttus">상담 접수 현황</label></dt>
                        <dd>
                            <select name="srchConsltSttus" id="srchConsltSttus" class="form-control w-full md:w-40">
                                <option value="">선택</option>
                                <option value="CS01" ${param.srchConsltSttus eq 'CS01'?'selected="selected"':''}>상담 신청 완료</option>
                                <option value="CS02" ${param.srchConsltSttus eq 'CS02'?'selected="selected"':''}>장기요양기관 배정 완료</option>
                                <option value="CS03" ${param.srchConsltSttus eq 'CS03'?'selected="selected"':''}>상담 취소 (신청자 상담 거부)</option>
                                <option value="CS04" ${param.srchConsltSttus eq 'CS04'?'selected="selected"':''}>상담 취소 (장기요양기관 상담 거부)</option>
                                <option value="CS05" ${param.srchConsltSttus eq 'CS05'?'selected="selected"':''}>상담 진행 중</option>
                                <option value="CS06" ${param.srchConsltSttus eq 'CS06'?'selected="selected"':''}>상담 완료</option>
                                <option value="CS07" ${param.srchConsltSttus eq 'CS07'?'selected="selected"':''}>재상담 신청 접수</option>
                                <option value="CS08" ${param.srchConsltSttus eq 'CS08'?'selected="selected"':''}>장기요양기관 재배정 완료</option>
                            </select>
                        </dd>
                    </dl>
                    <button type="submit" class="search-submit">검색</button>
                </fieldset>
            </form>

            <div class="mypage-consult-desc">
                <p class="text-alert">장기요양테스트 후 1:1상담 신청한 내역을 확인하는 페이지입니다.</p>
            </div>

            <p><strong>총 ${listVO.totalCount}건</strong>의 상담신청 내역이 있습니다.</p>

            <div class="mypage-consult-items mt-3.5 md:mt-5">
                <div class="mypage-consult-item-gutter"></div>

                <c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
                <div class="mypage-consult-item">
                    <dl class="item-current">
                        <dt>상담진행 현황</dt>
                        <dd>
                        	<%-- 사용자/관리자 txt가 일부 달라서 코드만 동일하게 사용함 --%>
                        	<c:choose>
								<c:when test="${resultList.consltSttus eq 'CS01'}">상담 신청 완료</c:when>
								<c:when test="${resultList.consltSttus eq 'CS02'}">장기요양기관 배정 완료</c:when>
								<c:when test="${resultList.consltSttus eq 'CS03'}">상담 취소<br>(신청자 상담거부)</c:when>
								<c:when test="${resultList.consltSttus eq 'CS04'}">상담 취소<br>(장기요양기관 상담거부)</c:when>
								<c:when test="${resultList.consltSttus eq 'CS05'}">상담 진행 중</c:when>
								<c:when test="${resultList.consltSttus eq 'CS06'}">상담 완료</c:when>
								<c:when test="${resultList.consltSttus eq 'CS07'}">재상담 신청 접수</c:when>
								<c:when test="${resultList.consltSttus eq 'CS08'}">장기요양기관 재배정 완료</c:when>
							</c:choose>
                        </dd>
                    </dl>
                    <dl class="item-partner">
                        <dt>상담 사업소</dt>
                        <dd>
							<c:choose>
								<c:when test="${resultList.consltSttus eq 'CS01' || resultList.consltSttus eq 'CS07'}"><strong>장기요양기관 배정 중</strong> 입니다.</c:when>
								<c:when test="${resultList.consltSttus eq 'CS03' || resultList.consltSttus eq 'CS04'}">상담이 취소되었습니다.</c:when>
								<c:otherwise>
									<c:set var="consltSize" value="${fn:length(resultList.consltResultList)}" />
									<strong>${resultList.consltResultList[consltSize-1].bplcNm}</strong>
									<c:if test="${consltSize > 1 }">
									<ul class="history">
									<c:forEach items="${resultList.consltResultList}" var="consltResult" varStatus="status2">
		                                <li>
		                                    <small>${status2.index+1}차 상담</small>
		                                    <span>${consltResult.bplcNm}</span>
		                                </li>
									</c:forEach>
		                            </ul>
		                            </c:if>
								</c:otherwise>
							</c:choose>
                        </dd>
                    </dl>
                    <dl class="item-date">
                        <dt>상담 신청일</dt>
                        <dd><fmt:formatDate value="${resultList.regDt }" pattern="yyyy.MM.dd" /></dd>
                    </dl>
                    <%--상담 완료시 --%>
                    <c:if test="${resultList.consltSttus eq 'CS06'}">
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
                    </c:if>
                </div>
                </c:forEach>
                <%--
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
                 --%>
            </div>

			<div class="pagination">
				<front:paging listVO="${listVO}" />
			</div>

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
    function f_srchJoinSet(ty){
    	$("#srchRegEnd").val(f_getToday());
    	if(ty == "1"){//오늘
       		$("#srchRegBgng").val(f_getToday());
    	}else if(ty == "2"){//일주일
    		$("#srchRegBgng").val(f_getDate(-7));
    	}else if(ty == "3"){//15일
    		$("#srchRegBgng").val(f_getDate(-15));
    	}else if(ty == "4"){//한달
    		$("#srchRegBgng").val(f_getDate(-30));
    	}
    }

    $(function(){
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

    });
    </script>
