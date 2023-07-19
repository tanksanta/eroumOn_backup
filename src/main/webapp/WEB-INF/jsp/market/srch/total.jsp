<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!-- container -->
    <main id="container">
        <div id="page-header" class="search-header">
            <ul class="page-header-breadcrumb">
                <li><a href="${_marketPath}">홈</a></li>
                <li>검색결과</li>
            </ul>
            <div class="page-header-title">
                <a href="${_marketPath}" class="back">이전 페이지 가기</a>
                <h2 class="subject">
                	<c:if test="${!empty param.srchKwd }">
                		<strong>‘${param.srchKwd}’</strong>
                	</c:if>
                	<c:if test="${!empty param.srchNonKwd }">
                		<strong>‘${param.srchNonKwd}’</strong>
                	</c:if>
                	 검색결과입니다
                </h2>
            </div>
        </div>

        <div class="search-container">
            <form action="#" class="search-option">
            	<input type="hidden" name="srchKwd" value="${param.srchKwd}">
                <fieldset>
                    <legend class="sr-only">검색 조건</legend>
                    <dl class="form-group">
                        <dt>카테고리</dt>
                        <dd>
                        	<c:forEach items="${resultCtgryGrpList}" var="result" varStatus="status">
                            <label class="form-check">
                                <input type="radio" name="srchCtgryNo" id="srchCtgryNo${status.index}" value="${result.ctgryNo}" class="form-check-input">
                                <span for="srchCtgryNo${status.index}" class="form-check-label">${result.ctgryNm}</span>
                            </label>
                        	</c:forEach>
                        </dd>
                    </dl>
                    <dl class="form-group">
                        <dt>상품구분</dt>
                        <dd>
                        	<c:forEach items="${resultGdsTyGrpList}" var="result" varStatus="status">
                            <label class="form-check">
                                <input type="radio" name="gdsTy" id="gdsTy${statys.index}" value="${result.gdsTy }" class="form-check-input">
                                <span for="gdsTy${statys.index}" class="form-check-label">${gdsTyCode[result.gdsTy]}</span>
                            </label>
                            </c:forEach>
                        </dd>
                    </dl>
                    <!-- div class="text-center mt-5 md:mt-7">
                        <button type="button" class="btn btn-success f_srchBtn">검색</button>
                    </div -->
                </fieldset>
            </form>

            <div id="search-list-wrap">
            	<div class="search-grid">
	                <div class="progress-loading">
	                    <div class="icon"><span></span><span></span><span></span></div>
	                    <p class="text">상품을 불러오는 중입니다.</p>
	                </div>
                </div>
            </div>
        </div>
    </main>
    <!-- //container -->


<script>
$(function(){

	var curPage = 1;
	var cntPerPage = 12;

	function f_srchGdsList(page){

		var srchCtgryNos = $("input[name='srchCtgryNo']:checked").val();
		var srchGdsTys = $("input[name='gdsTy']:checked").val();
		var params = {
			curPage:page
			, srchGdsTys:srchGdsTys
			, srchCtgryNos:srchCtgryNos
			, sortBy:$("#srchOrdr").val() || 'SORT_NO'
			, srchKwd:"${param.srchKwd}"
		};

		$("#search-list-wrap").load(
			"${_marketPath}/search/srchList"
			, params
			, function(obj){
				$("#search-list-wrap").fadeIn(200);
				//$("html").scrollTop(0);
		});
	}

	f_srchGdsList(1);

	$(".f_srchBtn").on("click", function(){
		f_srchGdsList(1);
	});
	
	$('.search-option .form-check input').on('change', function() {
		f_srchGdsList(1);
	})

	$(document).on("change", "#srchOrdr", function(){
		console.log($(this).val());
		f_srchGdsList(1);
	});

	$(":checkbox[id*='gdsTy']").on("click", function(){
		var selCheckVal = "";
		$(":checkbox[id*='gdsTy']:checked").each(function(){
			selCheckVal += (selCheckVal==""?$(this).val():"|"+$(this).val());
		});
		$("#srchGdsTys").val(selCheckVal);
	});

	//gds-pager
	$(document).on("click", ".gds-pager a", function(e){
		e.preventDefault();
		let pageNo = $(this).data("pageNo");
		if(pageNo > 0){
			f_srchGdsList(pageNo);
		}
	});
});
</script>