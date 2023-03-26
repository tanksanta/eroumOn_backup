<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<!-- main content -->
        <main id="container">
        	<form id="listFrm" name="listFrm" method="get" action="${_curPath}">
			<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
            <!-- <p class="product-count">총 ${listVO.totalCount}개</p> -->

			<!-- 상품 카테고리 -->
			<div id="page-content">
                <dl class="product-category">
                    <dt>상품분류</dt>
                    <dd>
                        <a href="#" ${ctgryNo>0?'':'class="is-active"' } data-ctgry-no="">전체 </a>
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


            <!--  상품 시작 -->
            <!-- <div class="product-items">
				<c:forEach items="${listVO.listObject}" var="resultList" varStatus="status">
				<a href="${_marketPath}/gds/${resultList.upCtgryNo}/${resultList.ctgryNo}/${resultList.gdsCd}" target="_blank" class="product-item">
                    <div class="thumb">
						<img src="/comm/getImage?srvcId=GDS&amp;upNo=${resultList.thumbnailFile.upNo }&amp;fileTy=${resultList.thumbnailFile.fileTy }&amp;fileNo=${resultList.thumbnailFile.fileNo }&amp;thumbYn=Y" alt=""> -->
                        <!-- <button type="button" class="cart" onclick="alert('basket'); return false;">장바구니 담기</button> -->
                    <!-- </div>
                    <div class="content">
                        <div class="name">
                            <small>${resultList.ctgryNm}</small>
                            <strong>${resultList.gdsNm}</strong>
                        </div>
                        <div class="cost">
                            <dl>
                                <dt>판매가</dt>
                                <dd><fmt:formatNumber value="${resultList.pc}" pattern="###,###" /><small>원</small></dd>
                            </dl>
                        </div>
                    </div>
                </a>
                </c:forEach>
                <c:if test="${empty listVO.listObject}">
                <p class="box-result is-large" style="grid-column: 1/-1;">등록된 상품이 없습니다.</p>
                </c:if>
            </div> -->
            </form>

<!--             <div class="pagination mt-7"> -->
				<%-- TO-DO 페이징 체크 --%>
<!-- 				<front:paging listVO="${listVO}" /> -->

				<!--
				<div class="sorting2">
					<label for="countPerPage">출력</label>
					<select name="countPerPage" id="countPerPage" class="form-control">
						<option value="12" ${listVO.cntPerPage eq '12' ? 'selected' : '' }>12개</option>
						<option value="24" ${listVO.cntPerPage eq '24' ? 'selected' : '' }>24개</option>
						<option value="36" ${listVO.cntPerPage eq '36' ? 'selected' : '' }>36개</option>
					</select>
				</div>

				<div class="counter">
					총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지
				</div>
			 	-->
<!-- 			</div> -->

        </main>
        <!-- //main content -->


        <script>
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
    				"/members/${bplcUrl}/gds/${upCtgryNo}/srchList"
    				, params
    				, function(obj){
    					$("#gds-list-wrap").fadeIn(200);
    			});
    	}

		$(function(){
			f_srchGdsList(1); // search

			// 출력 갯수
		    $("#countPerPage").on("change", function(){
				var cntperpage = $("#countPerPage option:selected").val();
				$("#cntPerPage").val(cntperpage);
				$("#listFrm").submit();
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

		    $(window).on('load resize', function() {
		        var cateItem = $('.product-category a');
		        var cateMore = $('.category-moreview');

		        if($(this).width() < 576) {
		            if(cateItem.length < 9) {
		                cateItem.addClass('is-visible');
		            } else {
		                cateItem.each(function(i) {
		                    if(i < 7) $(this).addClass('is-visible');
		                })
		                cateMore.addClass('is-visible');
		            }
		        } else {
		            cateItem.removeClass('is-visible');
		            cateMore.removeClass('is-visible');
		        }

		        cateMore.off('click').on('click', function() {
		            var cateWrap = $(this).closest('dd');
		            if(cateWrap.hasClass('is-expand')) {
		                cateWrap.removeClass('is-expand').find('a').each(function(i) {
		                    if(i > 6) {
		                        $(this).removeClass('is-visible');
		                    }
		                });
		            } else {
		                cateWrap.addClass('is-expand').find('a').addClass('is-visible');
		            }
		        });
			});
		});
		</script>