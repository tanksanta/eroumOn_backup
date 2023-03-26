<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="modal fade" id="modal-partner" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p class="text-title">멤버스 선택</p>
			</div>
			<div class="modal-close">
				<button data-bs-dismiss="modal">모달 닫기</button>
			</div>
			<div class="modal-body">
				<form class="product-partners-layer">
					<ul class="nav tabs is-small mb-4 md:mb-5">
						<li><a href="#itrst" data-bs-toggle="pill" data-bs-target="#itrst" role="tab" aria-selected="true" class="tabs-link ${pageType eq 'itrst' ? 'active' : ''}" data-tab-param="itrst">관심</a></li>
						<li><a href="#recommend" data-bs-toggle="pill" data-bs-target="#recommend" role="tab" class="tabs-link  ${pageType eq 'recommend' ? 'active' : ''}" data-tab-param="recommend">추천</a></li>
						<li><a href="#around" data-bs-toggle="pill" data-bs-target="#around" role="tab" class="tabs-link  ${pageType eq 'around' ? 'active' : ''}" data-tab-param="around" id="ard" data-srch-mode="around">내 주위</a></li>
						<li><a href="#recent" data-bs-toggle="pill" data-bs-target="#recent" role="tab" class="tabs-link  ${pageType eq 'recent' ? 'active' : ''}" data-tab-param="recent">최근 구매</a></li>
						<li><a href="#search" data-bs-toggle="pill" data-bs-target="#search" role="tab" class="tabs-link  ${pageType eq 'search' ? 'active' : ''}" data-tab-param="search" id="srch">멤버스 찾기</a></li>
					</ul>

					<div id="listView">


					</div>


				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary btn-submit" id="subPartners">확인</button>
				<button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

<script>

function searchGps() {
	if(navigator.geolocation) {
		navigator.geolocation.getCurrentPosition((function (position) {
			lat = position.coords.latitude;
			lot = position.coords.longitude;
			isAllow = true;
			srchMode = "around";
		}), (function (e) {
			switch (e.code) {
				case e.PERMISSION_DENIED:
					console.log("위치정보 검색을 거부했습니다.\n브라우저의 설정에서 위치(GPS) 서비스를 사용으로 변경해주세요.");
					break;
				case e.POSITION_UNAVAILABLE:
					console.log("브라우저가 위치정보를 검색하지 못했습니다.");
					break;
				case e.TIMEOUT:
					console.log("브라우저의 위치 정보 검색 시간이 초과됐습니다.");
					break;
				default:
					console.log("위치 정보 검색에 문제가 있습니다.");
			}
			isAllow = false;
			srchMode = "around";
			srchList();
		}), { timeout: 1000 });
	} else {
		console.log("사용 중이신 브라우저가 위치(GPS) 기능을 지원하지 않습니다.");
		isAllow = false;
		srchList();
	}
}


function srchList(pageType){

	// 공휴일
	const holiDayCode = {
		<c:forEach var="holiDay" items="${bplcRstdeCode}">
			${holiDay.key} : '${holiDay.value}',
		</c:forEach>
	}

	console.log("isAllow : " + isAllow);
	console.log("srchMode : " + srchMode);
	console.log("pageType :" + pageType);

	if(isAllow && srchMode == "around"){
		dist = 10000; // 범위 초기화 (아무검색 조건 없을때만)
	}else{
		dist = 0;
	}

	$.ajax({
		type : "post",
		url  : "/market/gds/choicePartnersList",
		data : {
			srchMode:srchMode
			, params : pageType
			, isAllow:isAllow
			, lot:lot
			, lat:lat
			, dist:dist
		},
		dataType : 'json'
	})
	.done(function(data) {
		$("#listView").html('');

		var html_part = "";
		html_part += '<div class="tab-pane" id="around">';
		html_part += '<p class="text-alert">고객님 주소 주위의 멤버스 정보를 제공합니다. 멤버스를 선택해 주세요.</p>';
		html_part += '</div>';
		$("#listView").append(html_part);

		console.log(data.resultList[0].proflImg);
		var list = data.resultList;

		for(var i=0; i<list.length; i++){
			var html = "";
			html += '<div class="product-partners" data-unique-id='+list[i].uniqueId+'>';
			if(list[i].proflImg != null){
				html += '<img src="/comm/PROFL/getFile?fileName='+list[i].proflImg+'" alt="">';
			}else{
				html += '<img src="/html/page/market/assets/images/partners_default.png">';
			}

			html += '<dl>';
			html += '<dt>'+list[i].bplcNm+'</dt>';
			html += '<dd class="info">';
			html += '<p class="addr">'+list[i].zip+'&nbsp;'+list[i].addr+'&nbsp;'+list[i].daddr+'</p>';
			html += '<p class="call">';
			html += '<a href="tel:'+list[i].telno+'">'+list[i].telno+'</a>';
			html += '		</p>';
			html += '	</dd>';
			html += '	<dd class="desc">';
			html += '		<div class="time">';
			html += '			<c:set var="hldys" value="${fn:split(around.hldy,',')}" />';
			html += '			<p><small>영업시간</small>';
			if(list[i].bsnHrBgng != null){
				html += list[i].bsnHrBgng + "~" + list[i].bsnHrEnd;
			}
			html += '</p>';
			html += '<p>';
			html += '<small>휴무</small>';
			html += '&nbsp;';
			if(list[i].hldy != null){
				var hldy = list[i].hldy;
				console.log(hldy);
				hldy = hldy.replace(" ","");
				hldy = hldy.split(",")
				console.log(hldy);
				for(var h=0; h < hldy.length; h++){
					if(hldy[h] == "E"){
						html += list[i].hldyEtc;
					}else{
						html += holiDayCode[hldy[h]];

					}
					html += '&nbsp';
				}
			}
			html += '</p>';
			html += '		</div>';
			html += '		<a href="/members/'+list[i].bplcId+'/gds/list" class="btn btn-primary btn-small flex-none" target="_blank">홈페이지 방문</a>';
			html += '</dd>';
			html += '</dl>';
			html += '<label class="partners-select">  <input type="radio" name="itrstClick"> <span>선택</span>';
			html += '</label>';
			html += '</div>';

			$("#around").append(html);
		}
	})
	.fail(function(data, status, err) {
		console.log(data);
	});
}

	//멤버스 모달 리스트
	function f_gdsBplcList(param, page) {
		console.log(param);
		$("#listView").load("${_marketPath}/gds/choicePartnersList", {
			params : param,
			curPage : page
		}, function() {
			$("#" + param).show();
		});
	}

	//멤버스 찾기용 모달 리스트
	function f_DtlList(param, page) {
		$("#detailList").load("${_marketPath}/gds/partnersDtlList"
				, {params : param
			, curPage : page});
	}

	$(function() {


		// 내 주위 멤버스
		var srchMode = "around";

	 	var dist = 0; // meter

		var isAllow = false;
		var lat = 0.00; //현재위치 위도
		var lot = 0.00; //현재위치 경도
		var objData = {};

		isAllow = searchGps();

		// 모달 탭
		$(".tabs-link").on("click", function() {
			if($(this).data("tabParam") == "around"){
				srchMode = $(this).data("srchMode");
				var pageType = $(this).data("tabParam");
				srchList(pageType);
			}else{
				var tab = $(this).data("tabParam");
				f_gdsBplcList(tab);
			}
		});


	});
</script>