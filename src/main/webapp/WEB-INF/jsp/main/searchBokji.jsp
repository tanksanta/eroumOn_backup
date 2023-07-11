<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
	<nav class="breadcrumb">
		<ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>이로움 서비스</li>
			<li>복지정보 서비스</li>
		</ul>
	</nav>
	<h2 class="subject">
		어르신 맞춤 복지서비스 <img src="/html/page/index/assets/images/ico-subject1.png" alt="">
		<small>노인복지가 궁금하세요? <a href="#" class="welfare-service-toggle">펼쳐보기</a></small>
	</h2>
</header>

<div id="content">
	<div class="welfare-service-desc">
		<div class="content">
			<img src="/html/page/index/assets/images/img-welfare-content1.jpg" alt="">
			<img src="/html/page/index/assets/images/img-welfare-content2.jpg" alt="">
			<img src="/html/page/index/assets/images/img-welfare-content3.jpg" alt="">
		</div>
		<button type="button" class="close">닫기</button>
	</div>

	<form action="#" class="welfare-service-search">
		<fieldset>
			<legend class="sr-only">복지서비스 검색</legend>
			<select name="select-sido" class="form-control">
				<c:set var="addr" value="" />
				<c:if test="${_mbrAddr1 eq '충남'}"><c:set var="addr" value="충청남도" /></c:if>
				<c:if test="${_mbrAddr1 eq '충북'}"><c:set var="addr" value="충청북도" /></c:if>
				<c:if test="${_mbrAddr1 eq '경남'}"><c:set var="addr" value="경상남도" /></c:if>
				<c:if test="${_mbrAddr1 eq '경북'}"><c:set var="addr" value="경상북도" /></c:if>
				<c:if test="${_mbrAddr1 eq '전남'}"><c:set var="addr" value="전라남도" /></c:if>
				<c:if test="${_mbrAddr1 eq '전북'}"><c:set var="addr" value="전라북도" /></c:if>
				<c:if test="${_mbrAddr1 eq '서울'}"><c:set var="addr" value="서울특별시" /></c:if>
				<c:if test="${_mbrAddr1 eq '강원' || _mbrAddr1 eq '경기' }"><c:set var="addr" value="${_mbrAddr1}도" /></c:if>
				<c:if test="${_mbrAddr1 eq '광주'}"><c:set var="addr" value="광주광역시" /></c:if>
				<c:if test="${_mbrAddr1 eq '대구' || _mbrAddr1 eq '대전' || _mbrAddr1 eq '부산' || _mbrAddr1 eq '울산' || _mbrAddr1 eq '인천'}"><c:set var="addr" value="${_mbrAddr1}광역시" /></c:if>

				<c:forEach var="stdg" items="${stdgCdList}">
					<option value="${stdg.stdgCd}" <c:if test="${!_mbrSession.loginCheck && stdg.ctpvNm eq '서울특별시'}">selected="selected"</c:if><c:if test="${_mbrSession.loginCheck && stdg.ctpvNm eq addr }">selected="selected"</c:if>>${stdg.ctpvNm}</option>
				</c:forEach>
			</select>
			<select name="select-gugun" class="form-control">
				<option value="">선택</option>
			</select>
			<button type="button" class="btn btn-primary2 srch-srvc">서비스 검색</button>
		</fieldset>
	</form>

	<nav class="welfare-service-menu">
		<p class="count">
			<strong class="totalCnt"><fmt:formatNumber value="${total}" pattern="###,###" /></strong>건
		</p>
		<ul class="nav" id="category_view">
			<li class="option-item7">
				<label for="opt-item7">
					<input type="checkbox" name="category" value="지원" id="opt-item7">
					<span>지원</span>
				</label>
			</li>
			<li class="option-item8">
				<label for="opt-item8">
					<input type="checkbox" name="category" value="보호" id="opt-item8">
					<span>보호</span>
				</label>
			</li>
			<li class="option-item6">
				<label for="opt-item6">
					<input type="checkbox" name="category" value="상담" id="opt-item6">
					<span>상담</span>
				</label>
			</li>
			<li class="option-item3">
				<label for="opt-item3">
					<input type="checkbox" name="category" value="보건" id="opt-item3">
					<span>보건</span>
				</label>
			</li>
			<li class="option-item2">
				<label for="opt-item2">
					<input type="checkbox" name="category" value="문화" id="opt-item2">
					<span>문화</span>
				</label>
			</li>
			<li class="option-item1">
				<label for="opt-item1">
					<input type="checkbox" name="category" value="주거" id="opt-item1">
					<span>주거</span>
				</label>
			</li>
			<li class="option-item5">
				<label for="opt-item5">
					<input type="checkbox" name="category" value="교육" id="opt-item5">
					<span>교육</span>
				</label>
			</li>
		</ul>
		<a href="#" class="btn btn-small btn-outline-primary"><span class="instListCnt">복지시설  0</span>곳</a>
	</nav>

	<!-- 서비스 본문(복지제도) -->
	<div class="welfare-service-item is-active">
		<div class="cont-target">
			<div class="progress-loading is-dark">
				<div class="icon">
					<span></span><span></span><span></span>
				</div>
				<p class="text">데이터를 불러오는 중입니다.</p>
			</div>
		</div>
		<div class="service-paging">
			<div class="paging-flow"></div>
		</div>
	</div>
	<!-- //서비스 본문(복지제도) -->

	<!-- 서비스 본문(복지시설) -->
	<div class="welfare-service-map">
		<div id="map" class="service-area"></div>
		<div class="service-select">
			<button class="toggle">
				<span class="sr-only">사이즈 조정</span>
			</button>
			<ul class="nav" role="tablist">
				<li class="nav-item" role="presentation"><a href="#marker-cont1" class="nav-link nav-link-item1 active" data-bs-toggle="pill" data-bs-target="#marker-cont1" role="tab" aria-selected="true">이로움 멤버스</a></li>
				<li class="nav-item" role="presentation"><a href="#marker-cont2" class="nav-link nav-link-item2" data-bs-toggle="pill" data-bs-target="#marker-cont2" role="tab" aria-selected="false">재가시설</a></li>
				<!-- <li class="nav-item" role="presentation"><button type="button" class="nav-link nav-link-item3" aria-selected="false">현재위치 검색</button></li> -->
			</ul>
			<div class="tab">
				<div class="tab-pane fade show active" id="marker-cont1" role="tabpanel">
					<div class="map-select-items is-member">
					<!-- 멤버스 -->
					</div>

				</div>
				<div class="tab-pane fade" id="marker-cont2" role="tabpanel">
					<div class="map-select-items">
					<!-- 재가시설 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- //서비스 본문(복지시설) -->

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${_kakaoScriptKey}&libraries=services,clusterer,drawing"></script>
	<script>
      $(function() {
          var page = 1;
          var pageT = 15;
      //아이템 선택
      $('.service-select .select-item').on('click', function() {
          $(this).toggleClass('is-active');
          return false;
      });

      $('.service-select .nav-link').on('click', function() {
          $(this).closest('.service-select').addClass('is-active');
      });

      $('.service-select .toggle').on('click', function() {
          $(this).closest('.service-select').toggleClass('is-active');
      });

      //지도 생성
      var map = new kakao.maps.Map(document.getElementById('map'), {
          center: new kakao.maps.LatLng(33.450701, 126.570667),
          level: 3
      });

      //마커 생성
      var imageSrc    = '/html/page/index/assets/images/img-welfare-marker-members.svg', //파트너스 img-welfare-marker-members.svg
          imageSize   = new kakao.maps.Size(34, 42),
          imageOption = {offset: new kakao.maps.Point(16, 46)};

      var markerImage     = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
          markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667);

      var marker = new kakao.maps.Marker({
          position : markerPosition,
          image    : markerImage
      });

      marker.setMap(map);

      //맵 오버레이 파트너스일경우 is-members 추가
      var ovContent = '<div class="service-overlay is-members">' +
                      '<div class="name">' +
                      '<strong>트윈시티점트윈시티점트윈시티점트윈시티점트윈시티점트윈시티점트윈시티점트윈시티점트윈시티점</strong>' +
                      '<div class="close" onclick="closeOverlay()">닫기</div>' +
                      '</div>' +
                      '<p class="addr">서울특별시 용산구 한강대로366 용산구 한강대로366 용산구 한강대로366 용산구 한강대로366 용산구 한강대로366 용산구 한강대로366</p>' +
                      '<a class="call" href="tel:02-2423-6331">02-2423-6331</a>' +
                      '</div>';

      overlay = new kakao.maps.CustomOverlay({
          content: ovContent,
          map: map,
          yAnchor: 1.25,
          position: marker.getPosition()
      });

      overlay.setMap(null);

      //오버레이 이벤트
      kakao.maps.event.addListener(marker, 'click', function() {
          overlay.setMap(map);
      });

      function closeOverlay() {
          overlay.setMap(null);
      }
      });
  </script>
</div>


<script>
function resizeHandler() {
	windowWidth = $(window).width();
	windowHeight = $(window).height();
	isMob = windowWidth <= 1023;
}

$(function(){

	var curPage = 1;
	var cntPerPage = 8;
	var category = "";

	var srchMode = "LOCATION";
	var dist = 0; // meter

	var isAllow = false;
	var lat = 0.00; //현재위치 위도
	var lot = 0.00; //현재위치 경도
	var objData = {};

	var isMob = false;
	var windowWidth;
	var windowHeight = $(window).height();
	window.addEventListener('resize', function() {
		requestAnimationFrame(resizeHandler);
	}, false);
	resizeHandler();


    $('.welfare-service-menu .btn').on('click', function() {
        if($('.welfare-service-item').hasClass('is-active')) {
            $('.welfare-service-item').removeClass('is-active');
            $('.welfare-service-map').addClass('is-active');
            $('.welfare-service-menu .nav').addClass('!hidden');
            $('.welfare-service-menu .totalCnt').text($(".instListCnt").text().replaceAll("복지시설 : ",""));
            $(".instListCnt").text("복지제도 : " + comma($("#srvcListCnt").val()));

            //$('.welfare-service-menu .count').html('<strong>42</strong>곳'); //카운트
            //$('.welfare-service-menu .btn').text('서비스 1272건'); //카운트
        } else {
            $('.welfare-service-item').addClass('is-active');
            $('.welfare-service-map').removeClass('is-active');
            $('.welfare-service-menu .nav').removeClass('!hidden');
            $('.welfare-service-menu .totalCnt').text(comma($("#srvcListCnt").val()));
            f_srchInstList();
            //$('.welfare-service-menu .count').html('<strong>1272</strong>건'); //카운트
            //$('.welfare-service-menu .btn').text('복지시설 42곳'); //카운트
        }
    })

    $('.welfare-service-toggle').on('click', function() {
        $('.welfare-service-toggle, .welfare-service-desc').addClass('is-active');
        return false;
    });

    $('.welfare-service-desc .close').on('click', function() {
        $('.welfare-service-toggle, .welfare-service-desc').removeClass('is-active');
    });

	var sido = $("select[name='select-sido'] option:selected").text();
	var gugun = $("select[name='select-gugun'] option:selected").text();

	// 회원 관심
	<c:if test="${_mbrSession.loginCheck}">
	$("checkbox input[name='category']").prop("checked",false);
		var field = "${_mbrSession.itrstField}";
		if(field != "null" && field != ''){
			field = field.replaceAll(' ','').split(',');
			for(var i=0; i<field.length; i++){
				switch(field[i]){
					case "1" : $("#opt-item7").prop("checked",true);break;
					case "2" : $("#opt-item8").prop("checked",true);break;
					case "3" : $("#opt-item6").prop("checked",true);break;
					case "4" : $("#opt-item3").prop("checked",true);break;
					case "5" : break;
					case "6" : $("#opt-item2").prop("checked",true);break;
					case "7" : $("#opt-item1").prop("checked",true);break;
					case "8" : $("#opt-item5").prop("checked",true);break;
				}
			}
		}
	</c:if>

	<c:if test="${!_mbrSession.loginCheck}">
	$("input[name='category']").prop("checked",true);
	</c:if>

	var selCheckVal = "";
	$(":checkbox[name='category']:checked").each(function(){
		selCheckVal += (selCheckVal==""?$(this).val():"|"+$(this).val());
	});
	category = selCheckVal;
	//$(".select-gugun button").text(gugun);

    f_srchInstList();
    f_srchSrvcList(1);

  	// 시/군/구 검색
	$(document).on("change", "select[name='select-sido']", function(e){
		e.preventDefault();
		var stdgCd = $(this).val();
		var stdgNm = $(this).text();

	   	if(stdgCd != ""){
    		$.ajax({
				type : "post",
				url  : "${_membersPath}/stdgCd/stdgCdList.json",
				data : {stdgCd:stdgCd},
				dataType : 'json'
			})
			.done(function(data) {
				if(data.result){
					$("select[name='select-gugun']").empty();
   					$.each(data.result, function(index, item){
							$("select[name='select-gugun']").append('<option value='+item.stdgCd+'>'+item.sggNm+'</option>');
   	                });

   					/*let uniqueId = "${_mbrSession.uniqueId}";
   			        console.log(uniqueId == '');
   			        if(uniqueId ==''){
   			        	$("select[name='select-gugun'] option[value='1154500000']").prop("selected",true);

   			        	$("button.srch-srvc").click();
   			        }*/
   					<c:if test="${empty _mbrSession.uniqueId}">
			     		$("select[name='select-gugun'] option[value='1154500000']").prop("selected",true);
			     	</c:if>
			     	<c:if test="${!empty _mbrSession.uniqueId}">
			     		$("select[name='select-gugun'] option").each(function(){
			     			if($(this).text() == "${_mbrAddr2}"){
			     				$(this).prop("selected",true);
			     			}

			     		});
			     	</c:if>
			     	if("${param.selectGugun}" != '' && "${param.selectGugun}"){
			     		$("select[name='select-gugun'] option").each(function(){
			     			if($(this).val() == "${param.selectGugun}"){
			     				$(this).prop("selected",true);
			     			}
			     		});
			     	}
			     	$("button.srch-srvc").click();
				}
			})
			.fail(function(data, status, err) {
				console.log('지역호출 error forward : ' + data);
			});
    	}

	});

	$(document).on("change", "select[name='select-gugun']", function(e){
		e.preventDefault();
		$("button.srch-srvc").click();
  	});

	//지도 > 탭 이벤트
	$(document).on('click', '.service-select a[data-bs-toggle="pill"]', function(){
		var targetTab = $(this).data("bsTarget");
		if(targetTab == "#marker-cont1"){ //멤버스
			srchMode = "LOCATION";
		}else if(targetTab == "#marker-cont2"){ //복지24
			srchMode = "BOKJI";
		}
		f_srchInstList();
	});

	$(document).on("click", "button.srch-srvc", function(e){
		e.preventDefault();

		sido = $("select[name='select-sido'] option:selected").text();
		gugun = $("select[name='select-gugun'] option:selected").text();


		f_srchInstList();
		f_srchSrvcList(1);

	});

	// 카테고리 선택
	$(document).on("click", ":checkbox[name='category']", function(e){
		var selCheckVal = "";
		if($(":checkbox[name='category']:checked").length < 1){
			$(":checkbox[name='category']").prop("checked",true);
		}
		$(":checkbox[name='category']:checked").each(function(){
			selCheckVal += (selCheckVal==""?$(this).val():"|"+$(this).val());
		});
		category = selCheckVal;
		f_srchSrvcList(1);

		$(".service-paging .paging-flow i").removeClass("is-active");
		$(".service-paging .paging-flow i:first-child").addClass("is-active");
	});


	$(document).on("click", ".content-item", function(e){
		e.preventDefault();
		let bokjiId = $(this).attr("href").replace("#", "");
		$('body').append('<div class="progress-loading is-dark"><div class="icon"><span></span><span></span><span></span></div><p class="text">데이터를 불러오는 중입니다.</p></div>')
		srvcDtl(bokjiId);
	});

	$(document).on("click", ".f_clip", function(e){
		e.preventDefault();
		let bokjiId = $(this).data("bokjiId");
		let nowUrl = window.location.href.split("#")[0]+ "#" + bokjiId;
		const shareObject = {
			title: $(this).parents(".modal").find(".modal-project-title").text()
			, text: '이로움ON'
			, url: nowUrl
		};

		//console.log(navigator.userAgent.indexOf("Mozilla"));
		if (navigator.share) { // Navigator를 지원하는 경우만 실행
			navigator.share(shareObject).then(() => {
				// 정상 동작할 경우 실행
			}).catch((error) => {
				//alert('에러가 발생했습니다.')
			})
		} else { // navigator를 지원하지 않는 경우
		  	//alert('페이지 공유를 지원하지 않습니다.')

		  	// 사파리 구분
		  	const agent = navigator.userAgent.toLowerCase();
			if(agent.indexOf("safari") > -1){
				shareDialog.classList.add('is-open');
			}else{
				navigator.clipboard.writeText(nowUrl).then(res=>{
					alert("주소가 복사되었습니다!");
				});
			}
		}
	});

    function srvcDtl(bokjiId){
		if(bokjiId > 0){
			$("#modalSrvcDtl").load(
        			"${_mainPath}/srvcDtl"
        			, {bokjiId:bokjiId}
        			, function(){
        				if(category.length > 0){ //designer 요청사항
							var colorNum = 0;
							var firstSelCheckVal = $(".cate").first().val();
							switch (firstSelCheckVal){
							  case "주거" :  colorNum = 1;break;
							  case "문화" :  colorNum = 2;break;
							  case "보건" :  colorNum = 3;break;
							  case "고용" :  colorNum = 4;break;
							  case "교육" :  colorNum = 5;break;
							  case "상담" :  colorNum = 6;break;
							  case "보호" :  colorNum = 8;break;
							  case "지원" :  colorNum = 7;break;
							}
							/*$("#modal-detail[class*='is-color']").removeClass(function(index, className){
							    return (className.match(/(^|\s)is-color\S+/g) || []).join(' ');
							})*/
							$("#modal-detail").addClass("is-color" + colorNum);
						}
						$('.progress-loading').remove();
        			}
        		);
		}
	}


function f_srchSrvcList(page, pageRefresh = true){
	if(sido != "" && sido != null){ //sido는 필수
		//gugun = gugun.replace("시/군/구", "");
		var params = {
				curPage:page
				, cntPerPage:cntPerPage
				, sido:sido
				, gugun:gugun
				, category:category
		};
		//console.log(params);
		$(".cont-target").load(
				"${_mainPath}/include/srchSrvcList"
				, params
				, function(obj){

					$(".totalCnt").text(comma($("#srvcListCnt").val()));

					$('.page-content-items .content-items').masonry({
				        itemSelector: '.content-item',
				        columnWidth: '.content-sizer',
				        gutter: '.content-gutter',
				        percentPosition: true
				    });

					// 선택된 카테고리가 있을경우
					if(category.length > 0){ // designer 요청사항
						var colorNum = 0;
						var firstSelCheckVal = $("#category_view a").first().val();
						switch (firstSelCheckVal){
						  case "주거" :  colorNum = 1;break;
						  case "문화" :  colorNum = 2;break;
						  case "보건" :  colorNum = 3;break;
						  case "고용" :  colorNum = 4;break;
						  case "교육" :  colorNum = 5;break;
						  case "상담" :  colorNum = 6;break;
						  case "보호" :  colorNum = 8;break;
						  case "지원" :  colorNum = 7;break;
						}
						$(".content-item > a[class*='is-color']").removeClass(function(index, className){
						    return (className.match(/(^|\s)is-color\S+/g) || []).join(' ');
						})
						$(".content-item > .content-body").addClass("is-color" + colorNum);
					}else {
						//console.log($("input[name='category']:checked").length);
						//$("input[name='category']").prop("checked",true);
					}
					//console.log(pageRefresh)
					if(pageRefresh) {
						var html = '';
						for(i=1; i<= $('.service-content').data("pageTotal"); i++) {
							if(i === params.curPage) {
								html += '<i class="is-active" data-num="' + i + '"></i>'
							}else {
								html += '<i data-num="' + i + '"></i>'
							}
						}
						$('.service-paging .paging-flow').removeAttr('style').empty().append(html)
					}
					//cntSum();
				});
	}
}

//콤마 찍기 : ###,###
function comma(num){
    var len, point, str;
    str = "0";
	if(num != ''){
	    num = num + "";
	    point = num.length % 3 ;
	    len = num.length;

	    str = num.substring(0, point);
	    while (point < len) {
	        if (str != "") str += ",";
	        str += num.substring(point, point + 3);
	        point += 3;
	    }
    }
    return str;
}

function f_srchInstList(){

	if(sido != "" && sido != "선택"){ //sido는 필수

		if(isAllow){	// GPS허용
			dist = 10000;
		}else{
			dist = 0;
		}
		var params = {
				srchMode:srchMode
				, sido:sido, gugun:gugun
				, isAllow:false, lot:lot, lat:lat, dist:dist };

		//console.log("params", params);

		$.ajax({
			type : "post",
			url  : "${_mainPath}/srchInstList.json",
			data : params,
			dataType : 'json'
		})
		.done(function(json) {
			var instCnt = Number(json.bplcCnt);
			var bplcCnt = Number(json.instCnt);
			if(srchMode == "LOCATION"){
				objData = json.bplcList;
			}else{
				objData = json.instList;
			}
			$(".instListCnt").text("복지시설 : " + comma(instCnt + bplcCnt));
			//$(".totalCnt").text(comma(instCnt + bplcCnt));
			//$(".totalCnt").text(comma(instCnt + bplcCnt));

			addListItem();
			kakaoMapDraw();

			//cntSum();
		})
		.fail(function(data, status, err) {
			console.log(data);
		});
	}
}

function addListItem(){

	if(objData != null){
		if(objData.length > 0){
			var html = '';
			if(srchMode == "LOCATION"){
    			$.each( objData, function( index, item ) {
    				html += '    <a href="#" class="service-item is-members">';
    				html += '        <p class="name">'+ item.bplcNm +'</p>';
    				html += '    	 <p class="addr">'+ item.addr +' ' + item.daddr  +'</p>';
    				html += '        <p class="call">'+ item.telno +'</p>';
    				html += '    </a>';
    			});
			}else if(srchMode == "BOKJI"){
    			$.each( objData, function( index, item ) {
    				html += '    <a href="#" class="service-item">';
    				html += '        <p class="name">'+ item.institutionName +'</p>';
    				html += '    	 <p class="addr">'+ item.address  +'</p>';
    				html += '        <p class="call">'+ item.contactNumber +'</p>';
    				html += '    </a>';
    			});
			}
		}else{
			html = '<div class="service-item">검색 결과가 없습니다.</div>';
		}
	}else{
		$(".instListCnt").text(0);
	}

	$(".map-select-items").empty() //list 초기화

	var target = null;
	if(srchMode === "LOCATION"){
		target = $('#marker-cont1');
	}else if(srchMode === "BOKJI"){
		target = $('#marker-cont2');
	}

	$('.tabs-list a[data-bs-target="#' + target.attr('id') + '"]').addClass("active");
	target.addClass('show active').find('.map-select-items').append(html);
	$(".map-select-item").css({"cursor":"pointer"});
}

function kakaoMapDraw(){

	var datas = {};
	var positions = [];
	var markers = [];
	var overlays = [];
	var level = 3;
	var latlng;
	var centerLat = isMob ? -0.0002 : 0.0005;
	var centerLng = isMob ? 0 : 0.0015;

	if(objData != null){

		if(objData.length > 0){

    		$.each( objData, function( index, item ) {

    			var kminfo = "";
    			if(srchMode == "LOCATION"){
        			datas = {
        				latlng: new kakao.maps.LatLng(Number(item.lat), Number(item.lot)),
        				center: new kakao.maps.LatLng(Number(item.lat) + centerLat, Number(item.lot) - centerLng),
        				content: ' <a class="service-item is-members" href="#">' +
		                         '		<p class="name">'+ item.bplcNm +'</strong>' +
		                         '		<p class="addr">'+ item.addr +' '+ item.daddr  +'</p>' +
		                         '		<a class="call" href="tel:'+ item.telno +'">'+ item.telno +'</a>' +
		                         '</a>',
        				title: item.bplcNm
        			}

    			}else if(srchMode == "BOKJI"){
    				datas = {
        				latlng: new kakao.maps.LatLng(Number(item.lat), Number(item.lng)),
        				center: new kakao.maps.LatLng(Number(item.lat) + centerLat, Number(item.lng) - centerLng),
        				content: '<a class="service-item" href="#">' +
		                         '		<p class="name">'+ item.institutionName +'</strong>' +
		                         '		<p class="addr">'+ item.address  +'</p>' +
		                         '		<a class="call" href="tel:'+ item.contactNumber +'">'+ item.contactNumber +'</a>' +
		                         '</a>',
        				title: item.institutionName
	        			}
    			}
    			positions.push(datas);
    		});

    		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			mapOption = {
				center: positions[0].center, // 지도의 중심좌표
				level: level // 지도의 확대 레벨
			};

			var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

			// 마커 클러스터러를 생성합니다
			// 마커 클러스터러를 생성할 때 disableClickZoom 값을 true로 지정하지 않은 경우
			// 클러스터 마커를 클릭했을 때 클러스터 객체가 포함하는 마커들이 모두 잘 보이도록 지도의 레벨과 영역을 변경합니다
			// 이 예제에서는 disableClickZoom 값을 true로 설정하여 기본 클릭 동작을 막고
			// 클러스터 마커를 클릭했을 때 클릭된 클러스터 마커의 위치를 기준으로 지도를 1레벨씩 확대합니다
			var clusterer = new kakao.maps.MarkerClusterer({
				map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
				averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
				minLevel: 6, // 클러스터 할 최소 지도 레벨
				disableClickZoom: true // 클러스터 마커를 클릭했을 때 지도가 확대되지 않도록 설정한다
			});


			//마커 생성
            var imageSrc = '/html/page/planner/assets/images/img-marker-members.svg';
        	if(srchMode == "BOKJI"){
				imageSrc = '/html/page/planner/assets/images/img-marker.svg';
        	}
            var imageSize = new kakao.maps.Size(34, 42);
            var imageOption = {offset: new kakao.maps.Point(16, 46)};

			var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption);

            for (var j = 0; j < positions.length; j ++) {

    			// 마커를 생성합니다
    			var marker = new kakao.maps.Marker({
    				map: map, // 마커를 표시할 지도
    				position: positions[j].latlng, // 마커를 표시할 위치
    				title : positions[j].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
    				image : markerImage, // 마커 이미지
    				clickable: true // 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
    			});

    			overlay = new kakao.maps.CustomOverlay({
                    content: positions[j].content,
                    map: map,
                    yAnchor: 1.45,
                    position: marker.getPosition()
                });
    			overlay.setMap(null);
    			overlays.push(overlay);
    			var idx = overlays.length - 1; // 오버레이, 마커 인덱스

    			marker.idx = idx; // 마커에 해당하는 오버레이를 index를 저장합니다.
    			markers.push(marker); // 생성된 마커를 배열에 담아줍니다.

    			clusterer.addMarkers(markers); // 생성된 마커를 클러스터에 담아줍니다.

    			kakao.maps.event.addListener(marker, 'click', function() {
    				allOverlayClose();

    				var idx = this.idx;
    				var overlay = overlays[idx]; // 마커에 해당되는 overlay를 열어줍니다.
    				overlay.setMap(map, this);
    				map.setCenter(positions[idx].center);
    				map.setLevel(3)
    			});

    		}

            // 지도를 내위치로
            $(".set_position").on("click", function(){
            	if(isAllow){
					map.setCenter(new kakao.maps.LatLng(lat, lot));
    				map.setLevel(3)
            	}
			})

         	// 리스트 클릭시
    		$(".map-select-items .service-item").on('click', function(event, visible) {
    			event.preventDefault();

    			idx = $(this).index();
    			allOverlayClose();

    			var overlay = overlays[idx];
    			overlay.setMap(map, markers[idx]);

    			map.setCenter(positions[idx].center);
    			map.setLevel(3);

    			if($(window).width() < 768) {
        			map.panBy(0, -75);
    			}

    			// is-active
    			$(".service-item").removeClass("is-active");
    			$(this).addClass("is-active");


    			if(!visible && $(window).width() < 768) {
    				$('.service-select').removeClass('is-active');
    			}

    		});

    		$("a.service-item").eq(0).trigger('click', {visible: true});

         	// 모든 Overlay를 닫아줍니다.
    		function allOverlayClose() {
    			for(var i = 0; i<overlays.length; i++) {
    				var overlay = overlays[i];
    				overlay.setMap(null);
    			}
    		}

    		$(document).on("click",".overlayClose", function(){
    			allOverlayClose();
    		});

    		// 마커 클러스터러에 클릭이벤트를 등록합니다
    		// 마커 클러스터러를 생성할 때 disableClickZoom을 true로 설정하지 않은 경우
    		// 이벤트 헨들러로 cluster 객체가 넘어오지 않을 수도 있습니다
    		kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
    			var level = map.getLevel()-1; // 현재 지도 레벨에서 1레벨 확대한 레벨
    			map.setLevel(level, {anchor: cluster.getCenter()}); // 지도를 클릭된 클러스터의 마커의 위치를 기준으로 확대합니다


    		});

    		// 지도가 이동, 확대, 축소로 인해 중심좌표가 변경되면 마지막 파라미터로 넘어온 함수를 호출하도록 이벤트를 등록합니다
    		kakao.maps.event.addListener(map, 'center_changed', function() {
    			var level = map.getLevel(); // 지도의  레벨을 얻어옵니다
    			latlng = map.getCenter(); // 지도의 중심좌표를 얻어옵니다
				//console.log(level);
    			if(level > 6){ // 지도 축소시 오버레이 닫음
        			allOverlayClose();
    			}
    		});

		} else { // result = 0
			//console.log("result 0");
			// 데이터가 없을 경우
			var mapContainer = document.getElementById('map'),
			mapOption = {
				center: new kakao.maps.LatLng(37.6065432383919, 127.092820287004),
				level: 8 // 지도의 확대 레벨
			};

			var map = new kakao.maps.Map(mapContainer, mapOption);
		}
	}
}
if("${param.selectSido}" != '' && "${param.selectSido}"){
	$("select[name='select-sido'] option").each(function(){
		if($(this).val() == "${param.selectSido}"){
			$(this).prop("selected",true);
		}
	});
}

$("select[name='select-sido']").trigger("change");

//paging 생성
$(document).on("click", "button.srvc-pager", function(e){
	e.preventDefault();
	let pageNo = $(this).data("pageNo");
	let pageTotal = $(this).data("pageTotal");

	if(pageNo > 0){
		f_srchSrvcList(pageNo, false);
	}

    $('.service-paging i').removeClass('is-active').filter('[data-num="' + pageNo + '"]').addClass('is-active');

	//이전
	if($(this).hasClass('button-prev')) {
        if(pageNo > 2 && pageNo <= pageTotal-2) {
            $('.service-paging .paging-flow').css('margin-left', -((pageNo - 3) * 20));
        }
	}

	//다음
	if($(this).hasClass('button-next')) {
        if(pageNo > 3 && pageNo <= pageTotal-2) {
            $('.service-paging .paging-flow').css('margin-left', -((pageNo - 3) * 20));
        }
	}
});

});
</script>