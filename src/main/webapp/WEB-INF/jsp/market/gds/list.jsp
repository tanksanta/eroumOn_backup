<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="container" class="is-product">

		<jsp:include page="../layout/page_header.jsp" />

		<div id="page-container">

			<jsp:include page="../layout/page_sidenav.jsp" />

            <div id="page-content">
                <dl class="product-category">
                    <dt>상품분류</dt>
                    <dd>
                        <a href="#" ${ctgryNo>0?'':'class="is-active"' } data-ctgry-no="">전체</a>
						<c:forEach items="${_gdsCtgryList}" var="ctgry" varStatus="status">
							<c:if test="${ctgry.upCtgryNo eq upCtgryNo}">
								<a href="#${ctgry.ctgryNo}" data-ctgry-no="${ctgry.ctgryNo}" ${ctgryNo>0 && ctgry.ctgryNo eq ctgryNo?'class="is-active"':'' }>${ctgry.ctgryNm}</a>
							</c:if>
                        </c:forEach>
                        <button type="button" class="category-moreview">더보기</button>
                    </dd>
                </dl>

				<%-- 상품 목록 wrap --%>
                <div id="gds-list-wrap">
					<div class="grid gap-x-5 grid-cols-2 gap-y-8 mt-5 mb-13 md:grid-cols-3 md:gap-y-10 xl:gap-y-12 xl:grid-cols-4">
	                    <div class="col-span-2 md:col-span-3 xl:col-span-4">
	                        <div class="box-loading mx-auto">
	                            <div class="icon"><div></div></div>
	                            <p class="text">상품을 불러오는 중입니다.</p>
	                        </div>
	                    </div>
	                </div>
                </div>
            </div>
        </div>

	</main>

<script>
var Goods = (function(){

	var curPage = 1;
	var cntPerPage = 12;
	var srchGdsTys;
	var srchGdsTag;
	var srchMinPc;
	var srchMaxPc;
	var srchCtgryNos = "${ctgryNo>0?ctgryNo:''}";

	// 목록
	function f_srchGdsList(page){
		var params = {
				curPage:page
				, cntPerPage:cntPerPage
				, srchMinPc:$("#srchMinPc").val()
				, srchMaxPc:$("#srchMaxPc").val()
				, srchGdsTys:$("#srchGdsTys").val()
				, srchGdsTag:$("#srchGdsTag").val()
				, srchGdsTagNI:$("#srchGdsTagNI").val() //NOT IN
				, srchCtgryNos:srchCtgryNos
		};

		//console.log("params: ", params);

		$("#gds-list-wrap")
			.load(
				"${_marketPath}/gds/${upCtgryNo}/srchList"
				, params
				, function(obj){
					$("#gds-list-wrap").fadeIn(200);
			});
	}

	// 검색버튼
	$(".f_srchBtn").on("click", function(){
		f_srchGdsList(1);
	});

	// 2depth category (상품분류) 선택
	$(".product-category dd a").on("click", function(){
		srchCtgryNos = "";

		let ctgryNo = $(this).data("ctgryNo")
		if(ctgryNo == ""){//전체선택
			$(".product-category dd a").removeClass("is-active");
			$(this).addClass("is-active");
		}else{
			$(".product-category dd a[data-ctgry-no='']").removeClass("is-active");
			if($(this).hasClass("is-active")){
				$(this).removeClass("is-active");
			}else{
				$(this).addClass("is-active");
			}
			if($(".product-category dd a.is-active").length < 1){
				$(".product-category dd a[data-ctgry-no='']").addClass("is-active");
			}

			$(".product-category dd a.is-active").each(function(){
				srchCtgryNos += (srchCtgryNos==""?$(this).data("ctgryNo"):"|"+$(this).data("ctgryNo"));
			});
		}
		f_srchGdsList(1); // search
	});

	//init search
	if(typeof location.href.split("#")[1] != "undefined"){
		//링크로 카테고로 넘어온 경우 최초에만 실행
		const initCtgryNo = location.href.split("#")[1];
		if($(".product-category dd a[data-ctgry-no='"+ initCtgryNo +"']").length > 0){
			$(".product-category dd a[data-ctgry-no='']").removeClass("is-active");
			$(".product-category dd a[data-ctgry-no='"+ initCtgryNo +"']").addClass("is-active");
			srchCtgryNos = initCtgryNo;
		}
	}
	f_srchGdsList(1);

	//상품 목록 마우스 오버
    $(document).on('mouseenter', '.product-item .item-layer', function() {
        $(this).closest('.product-item').addClass('is-hover');
    }).on('mouseleave', '.product-item .item-layer', function() {
        $(this).closest('.product-item').removeClass('is-hover');
    });

	// checkbox event add
	$(":checkbox[id*='gdsTag']").on("click", function(){
		var selCheckVal1 = "";
		var selCheckVal2 = "";
		$(":checkbox[id*='gdsTag']:checked").each(function(){
			if($(this).data("inc") == "IN"){
				selCheckVal1 += (selCheckVal1==""?$(this).val():"|"+$(this).val());
			}else{
				selCheckVal2 += (selCheckVal2==""?$(this).val():"|"+$(this).val());
			}
		});
		$("#srchGdsTag").val(selCheckVal1);
		$("#srchGdsTagNI").val(selCheckVal2);
	});

	$(":checkbox[id*='gdsTy']").on("click", function(){
		var selCheckVal = "";
		$(":checkbox[id*='gdsTy']:checked").each(function(){
			selCheckVal += (selCheckVal==""?$(this).val():"|"+$(this).val());
		});
		$("#srchGdsTys").val(selCheckVal);
	});

	// reset
	$(".f_srchGdsFrmReset").on("click", function(){
		$("#srchMinPc, #srchMaxPc, #srchGdsTags, #srchGdsTys").val("");
		$(":checkbox[id*='gdsTag']").prop("checked", false);
		$(":checkbox[id*='gdsTy']").prop("checked", false);
		f_srchGdsList(1);
	});

	//gds-pager
	$(document).on("click", ".gds-pager a", function(){
		let pageNo = $(this).data("pageNo");
		if(pageNo > 0){
			f_srchGdsList(pageNo);
		}
	});



})();

</script>