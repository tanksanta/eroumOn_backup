<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <!-- container -->
    <main id="container">
        <div id="page-header">
            <ul class="page-header-breadcrumb">
                <li><a href="${_marketPath}">홈</a></li>
                <li>검색결과</li>
            </ul>
            <div class="page-header-title mt-3 md:mt-4.5 lg:mt-6">
                <a href="${_marketPath}" class="back lg-max:!flex">이전 페이지 가기</a>
                <h2 class="pl-10 text-left text-xl font-medium md:pl-13 md:pb-0.5 md:text-2xl lg:p-0">
                	<c:if test="${!empty param.srchKwd }">
                		<strong class="text-[#1D45D5]">‘${fn:split(param.srchKwd,'?')[0]}’</strong>
                	</c:if>
                	<c:if test="${!empty param.srchNonKwd }">
                		<strong class="text-[#1D45D5]">‘${fn:split(param.srchNonKwd,'?')[0]}’</strong>
                	</c:if>
                	 검색결과입니다
                </h2>
            </div>
        </div>

        <div class="mx-auto px-4 max-w-screen-xl lg:px-7 xl:px-10">
            <form action="#" class="mt-3 mb-6 border-t border-t-gray1 md:mt-4 md:mb-9.5 lg:mb-13">
            	<input type="hidden" name="srchKwd" value="${param.srchKwd}">
                <c:if test="${fn:length(resultCtgryGrpList) > 0}">
                <fieldset>
                    <legend class="sr-only">검색 조건</legend>
                    <dl class="flex items-start border-b border-b-gray3 font-bold text-[0.8125rem] md:text-sm">
                        <dt class="py-3 px-1.5 w-23 border border-transparent md:pt-3.5 md:px-2.5 md:w-43">카테고리</dt>
                        <dd class="flex-1 flex flex-wrap items-start gap-1.5 p-2">
                        	<c:forEach items="${resultCtgryGrpList}" var="result" varStatus="status" begin="0">
                            <label class="form-check">
                                <input type="radio" name="srchCtgryNo" id="srchCtgryNo${status.index}" value="${result.ctgryNo}" class="form-check-input peer absolute w-0 h-0 overflow-hidden opacity-0">
                                <span for="srchCtgryNo${status.index}" class="form-check-label
									ml-0 py-1 px-3 border border-transparent rounded text-gray6 font-normal transition-colors duration-500 md:py-1.5 md:px-4 hover:bg-black/10
									peer-checked:border-black2 peer-checked:bg-white peer-checked:font-bold peer-checked:text-black2">
                                	${result.ctgryNm}
                                </span>
                            </label>
                        	</c:forEach>
                        </dd>
                    </dl>
                    <dl class="flex items-start border-b border-b-gray3 font-bold text-[0.8125rem] md:text-sm">
                        <dt class="py-3 px-1.5 w-23 border border-transparent md:pt-3.5 md:px-2.5 md:w-43">상품구분</dt>
                        <dd class="flex-1 flex flex-wrap items-start gap-1.5 p-2">
                        	<c:forEach items="${resultGdsTyGrpList}" var="result" varStatus="status">
                            <label class="form-check">
                                <input type="radio" name="gdsTy" id="gdsTy${statys.index}" value="${result.gdsTy }" class="form-check-input peer absolute w-0 h-0 overflow-hidden opacity-0">
                                <span for="gdsTy${statys.index}" class="form-check-label
									ml-0 py-1 px-3 border border-transparent rounded text-gray6 font-normal transition-colors duration-500 md:py-1.5 md:px-4 hover:bg-black/10
									peer-checked:border-black2 peer-checked:bg-white peer-checked:font-bold peer-checked:text-black2">
                               		${gdsTyCode[result.gdsTy]}
								</span>
                            </label>
                            </c:forEach>
                        </dd>
                    </dl>
                    <!-- div class="text-center mt-5 md:mt-7">
                        <button type="button" class="btn btn-success f_srchBtn">검색</button>
                    </div -->
                </fieldset>
                </c:if>
            </form>

            <div id="search-list-wrap">
            	<div class="grid grid-cols-2 gap-x-3 gap-y-6 mt-2.5 md:grid-cols-3 md:gap-x-4 md:gap-y-13 md:mt-4 lg:grid-cols-4 lg:gap-x-5 lg:gap-y-20 lg:mt-5">
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
		var srchKwd = "${fn:split(param.srchKwd,'?')[0]}";
		if("${param.srchNonKwd}" != '' && "${param.srchNonKwd}" != null){
			srchKwd = "${fn:split(param.srchNonKwd,'?')[0]}";
		}
		var params = {
			curPage:page
			, srchGdsTys:srchGdsTys
			, srchCtgryNos:srchCtgryNos
			, sortBy:$("#srchOrdr").val() || 'SORT_NO'
			, srchKwd:srchKwd
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