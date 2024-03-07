<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- swiper -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

    <style>
        .swiper-slide {
            padding: 20px;
        }

        .om_guide_Swiper .swiper-pagination {
            width: auto;
            top: 36px;
            right: 36px;
            left: initial;
            font-size: 0;
            line-height: 0;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="" name="addButton" />
        <jsp:param value="어르신 길잡이" name="addTitle" />
    </jsp:include>

    <main>
        <section class="default">

            <!-- Swiper -->
            <div class="swiper om_guide_Swiper marT-20W-20">
                <div class="swiper-wrapper">

                    <c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
                        <c:if test="${resultList.addValueChk01 == 'Y'}">
                            <c:set var="pageParam" value="nttNo=${resultList.nttNo}&amp;curPage=${listVO.curPage}" />
                        
                            <div class="swiper-slide">
                                <a href="./view?${pageParam}" class="block">
                                    <div class="card waves-effect om_guide_card ${swiperBackcolor.get(status.index % 3)}" style="background-image:url(${resultList.addValueText02})">
            
                                        <div class="card-content">
            
                                            <div class="padR80">
                                                <div class="color_tp_p font_sbsr">${resultList.ctgryNm}</div>
            
                                                <h4 class="title marT2">${resultList.ttl}</h4>
            
                                                <p class="color_t_s font_sbsr marT4">
                                                    ${resultList.addValueText01}
                                                </p>
                                            </div>
            
                                            <div class="h46"></div>
            
                                        </div>
                                    </div>
                                    <!-- card -->
                                </a>
                            </div>
                        </c:if>
                        
                    </c:forEach>
                    
                </div>

                <div class="swiper-pagination"></div>
            </div>

            <div class="box_normal marW-20 pad020">

                <c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
                    <c:set var="pageParam" value="nttNo=${resultList.nttNo}&amp;curPage=${listVO.curPage}" />
                    
                    <a href="./view?${pageParam}" class="block">

                        <div class="waves-effect list_link exp01 bder_bottom">
                            <div>
                                <div class="color_t_s font_sbsr">${resultList.ctgryNm}</div>
                                <div class="font_sbms">${resultList.ttl}</div>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
            <!-- box -->

        </section>
    </main>
    
	<!-- 하단 네이비게이션 -->
	<jsp:include page="/WEB-INF/jsp/app/matching/common/bottomNavigation.jsp">
		<jsp:param value="guide" name="menuName" />
	</jsp:include>
</div>

<script>
    $(function () {
        $("body").addClass("back_gray");
        
        var swiper = new Swiper(".om_guide_Swiper", {
            autoHeight: true,
            spaceBetween: 0,
            pagination: {
                el: ".swiper-pagination",

            },
        });

    });
</script>