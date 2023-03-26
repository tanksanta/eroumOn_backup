<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
		<jsp:include page="../../layout/page_header.jsp">
			<jsp:param value="관심 카테고리" name="pageTitle"/>
		</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<link rel="stylesheet" href="/html/page/market/assets/style/mypage-jh.css">
			<div class="mypage-content">
				<div class="interest-category">
					<div class="alert-wrap">
						<p class="text-alert">고객님의 관심 카테고리를 설정하실 수 있습니다.</p>
						<p class="text-alert">설정하신 카테고리는 메인 페이지에서 바로 이동하실 수 있습니다.</p>
						<p class="text-alert">관심 카테고리는 최대 5개까지 카테고리까지 설정 가능합니다.</p>
					</div>
					<div class="title-wrap">
						<div class="title-head flex">
							<span>복지용구</span>
						</div>
					</div>
					<div class="category-list">
						<!-- <ul class="flex">
                                <li class="list">
                                    <input id="list1" type="checkbox">
                                    <label for="list1">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category1.png" alt="" >
                                        </div>
                                        <div class="text">수동휠체어</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list2" type="checkbox" checked>
                                    <label for="list2" class="mint">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category2.png" alt="" >
                                        </div>
                                        <div class="text">성인용보행기</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list3" type="checkbox" checked>
                                    <label for="list3" class="orange">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category3.png" alt="" >
                                        </div>
                                        <div class="text">지팡이</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list4" type="checkbox">
                                    <label for="list4">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category4.png" alt="" >
                                        </div>
                                        <div class="text">안전손잡이</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list5" type="checkbox">
                                    <label for="list5">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category5.png" alt="" >
                                        </div>
                                        <div class="text">경사로</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list6" type="checkbox" checked>
                                    <label for="list6" class="yellow">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category6.png" alt="" >
                                        </div>
                                        <div class="text">미끄럼방지매트</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list7" type="checkbox">
                                    <label for="list7">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category7.png" alt="" >
                                        </div>
                                        <div class="text">미끄럼방지양말</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list8" type="checkbox">
                                    <label for="list8">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category8.png" alt="" >
                                        </div>
                                        <div class="text">이동욕조</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list9" type="checkbox" checked>
                                    <label for="list9" class="purple">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category9.png" alt="" >
                                        </div>
                                        <div class="text">목욕의자</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list10" type="checkbox">
                                    <label for="list10">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category10.png" alt="" >
                                        </div>
                                        <div class="text">간이변기</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list11" type="checkbox">
                                    <label for="list11">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category11.png" alt="" >
                                        </div>
                                        <div class="text">이동변기</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list12" type="checkbox">
                                    <label for="list12">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category12.png" alt="" >
                                        </div>
                                        <div class="text">요실금팬티</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list13" type="checkbox" checked>
                                    <label for="list13" class="pink">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category13.png" alt="" >
                                        </div>
                                        <div class="text">전동침대</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list14" type="checkbox">
                                    <label for="list14">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category14.png" alt="" >
                                        </div>
                                        <div class="text">자세변환용구</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list15" type="checkbox">
                                    <label for="list15">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category15.png" alt="" >
                                        </div>
                                        <div class="text">욕창예방매트리스</div>
                                    </label>
                                </li>
                                <li class="list">
                                    <input id="list16" type="checkbox">
                                    <label for="list16">
                                        <div class="img-wrap">
                                            <img src="/html/page/market/assets/images/content2/category16.png" alt="" >
                                        </div>
                                        <div class="text">욕창예방방석</div>
                                    </label>
                                </li>
                            </ul> -->
						<ul class="flex">
							<c:forEach var="ctgry" items="${gdsCtgry}" varStatus="status">
								<li class="list ctgryList ctgry${ctgry.ctgryNo}" data-color-nm="color" data-ctgry-no="${ctgry.ctgryNo}">
									<div class="img-wrap">
										<img src="/comm/CTGRY_IMG/getFile?fileName=${ctgry.ctgryImg}" alt="" >
									</div>
									<div class="text">${ctgry.ctgryNm}</div>
								</li>
							</c:forEach>

						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</main>

<script>
function f_itrstCategory(ctgryNo, type){
	/*관심 카테고리 등록, 삭제*/
	var no = ctgryNo;
	var crud = type;

	$.ajax({
	type : "post",
	url  : "/market/mypage/itrst/itrstCategory.json",
	data : {
		ctgryNo : no
		,type : crud
	},
	dataType : 'json'
	})
	.done(function(data) {
		if(data.result == true){
		}else{
			alert("관심 카테고리 등록중 오류가 발생했습니다. \n 관리자에게 문의 바랍니다.");
		}
	})
	.fail(function(data, status, err) {
		alert("단계 검사 중 오류가 발생했습니다.");
		console.log('error forward : ' + data);
	});
}

$(function(){

	const color = ['mint','orange','yellow','purple','pink'];
	var arrColor = ['mint','orange','yellow','purple','pink'];


	// 회원 관심 카테고리
	<c:forEach var="item" items="${itemList}" varStatus="status">
			$(".ctgry"+"${item.ctgryNo}").addClass(arrColor[0]);
			$(".ctgry"+"${item.ctgryNo}").data("colorNm", arrColor[0]);
			arrColor = arrColor.filter((element) => element !== arrColor[0]);
	</c:forEach>





	// 색 변환 이벤트
	$(document).on("click", ".ctgryList", function(e){
		console.log(arrColor);

			if(!color.includes($(this).data("colorNm"))){
				if(arrColor.length < 1){
					alert("관심 카테고리는 최대 5개까지 입니다.");
					return false;
				}else{

					$(this).addClass(arrColor[0]);
					$(this).data("colorNm", arrColor[0]);

					arrColor = arrColor.filter((element) => element !== arrColor[0]);
					//arrColor = arrColor.splice(1, arrColor.length );
					console.log("asd : " + arrColor);

					f_itrstCategory($(this).data("ctgryNo"),"INSERT");
				}
			}else{
				$(this).removeClass($(this).data("colorNm"));
				arrColor.push($(this).data("colorNm"));
				$(this).data("colorNm","");

				f_itrstCategory($(this).data("ctgryNo"),"DELETE");
			}
	});
});
</script>