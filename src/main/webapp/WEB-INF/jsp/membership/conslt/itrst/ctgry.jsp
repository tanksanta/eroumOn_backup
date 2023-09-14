<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
20230815 현재는 사용하지 않음
 --%>
<main id="container" class="is-mypage">
		<jsp:include page="../../layout/page_header.jsp">
			<jsp:param value="관심 카테고리" name="pageTitle"/>
		</jsp:include>

	<div id="page-container">

		<jsp:include page="../../layout/page_sidenav.jsp" />

		<div id="page-content">
			<div class="global-user mb-9 ${_mbrSession.mberGrade eq 'E' ? 'is-grade1' : _mbrSession.mberGrade eq 'B' ? 'is-grade2' : _mbrSession.mberGrade eq 'S' ? 'is-grade3' : _mbrSession.mberGrade eq 'N' ? '' : ''} lg:hidden">
				<div class="user-name">
				    <strong>${_mbrSession.mbrNm} <small>님</small></strong>
					<span>${recipterYnCode[_mbrSession.recipterYn]}</span>
                       <button type="button" class="user-toggle">메뉴 열기</button>
				</div>
				<div class="user-info">
				    <div class="grade">
				        <strong>${gradeCode[_mbrSession.mberGrade]}</strong>
						<a href="${_marketPath}/etc/bnft/list">등급별혜택</a>
					</div>
					<div class="point">
					    <dl>
					        <dt>쿠폰</dt>
					        <dd>
					        	<a href="${_marketPath}/mypage/coupon/list">
                               		<strong>11</strong> 장
						   		</a>
						 	</dd>
						</dl>
						<dl>
						    <dt>포인트</dt>
						    <dd>
						   		<a href="${_marketPath}/mypage/point/list">
                               		<strong>11</strong>
									<img src="/html/core/images/txt-point-white.svg" alt="포인트">
								</a>
							</dd>
	                    </dl>
	                    <dl>
	                        <dt>마일리지</dt>
	                        <dd>
	                        	<a href="${_marketPath}/mypage/mlg/list">
                               		<strong>11</strong>
									<img src="/html/core/images/txt-mileage-white.svg" alt="마일리지">
								</a>
							</dd>
	                    </dl>
	                </div>
	            </div>
            </div>

           <div class="items-center justify-between md:flex">
               <div class="space-y-1.5">
                   <p class="text-alert">고객님의 관심 카테고리를 설정하실 수 있습니다.</p>
                   <p class="text-alert">설정하신 카테고리는 메인 페이지에서 바로 이동하실 수 있습니다.</p>
                   <p class="text-alert">관심 카테고리는 최대 5개까지 카테고리까지 설정 가능합니다.</p>
               </div>
           </div>

			<div class="text-title2 mt-8 mb-5 md:mt-10 md:mb-6.5">복지용구</div>
			<ul class="grid grid-cols-3 gap-3 md:grid-cols-4 md:gap-4 lg:gap-5 xl:grid-cols-5 xs-max:grid-cols-2">
			<c:forEach var="ctgry" items="${gdsCtgry}" varStatus="status">
                <li class="mypage-category-item ctgry${ctgry.ctgryNo}" data-color-nm="color" data-ctgry-no="${ctgry.ctgryNo}">
                    <input type="checkbox" name="cates" class="check">
                    <div class="image"><img src="/comm/CTGRY_IMG/getFile?fileName=${ctgry.ctgryImg}" alt="" ></div>
					<div class="text">${ctgry.ctgryNm}</div>
                </li>
			</c:forEach>
			</ul>
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

	const color = ['is-mint','is-orange','is-yellow','is-purple','is-pink'];
	var arrColor = ['is-mint','is-orange','is-yellow','is-purple','is-pink'];


	// 회원 관심 카테고리
	<c:forEach var="item" items="${itemList}" varStatus="status">
			$(".ctgry"+"${item.ctgryNo}").addClass(arrColor[0]);
			$(".ctgry"+"${item.ctgryNo}").data("colorNm", arrColor[0]);
			arrColor = arrColor.filter((element) => element !== arrColor[0]);
	</c:forEach>





	// 색 변환 이벤트
	$(document).on("click", ".mypage-category-item", function(e){
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