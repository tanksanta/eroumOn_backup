<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        <!-- container -->
        <div id="maps-container">
            <div class="maps-content">
                <div class="maps-layer">
                    <ul class="nav tabs-list">
                        <li><a href="#tabs1" data-bs-toggle="pill" data-bs-target="#tabs1">지역검색</a></li>
                        <li><a href="#tabs2" data-bs-toggle="pill" data-bs-target="#tabs2">직접검색</a></li>
                        <li><a href="#tabs2" data-bs-toggle="pill" data-bs-target="#tabs3">추천 멤버스</a></li>
                    </ul>
                    <div class="tab-content">
                    	<%-- tab1 --%>
                        <div class="tab-pane fade " id="tabs1" role="tabpanel">
                            <div class="maps-layer-search">
                               <select name="sido" id="sido" class="form-control">
                                    <option value="">시/도</option>
                                    <c:forEach items="${stdgCdList}" var="stdg">
                                    <option value="${stdg.stdgCd}">${stdg.ctpvNm }</option>
                                    </c:forEach>

                                </select>
                                <select name="gugun" id="gugun" class="form-control">
                                    <option value="">시/군/구</option>
                                </select>
                                <button type="button" class="btn-primary shadow f_srch_location" data-srch-mode="LOCATION">검색</button>
                            </div>
                            <div class="maps-layer-results collapse show" id="result-list1">
								<%--item list--%>
                            </div>
                            <button type="button" class="maps-layer-toggle" data-bs-toggle="collapse" data-bs-target="#result-list1" aria-expanded="true">검색 목록 펼치기/접기</button>
                        </div>
                        <%-- tab2 --%>
                        <div class="tab-pane fade" id="tabs2" role="tabpanel">
                            <div class="maps-layer-search">
                                <input type="text" id="srchText" name="srchText" class="form-control" placeholder="멤버스명/주소 입력(예: 용산 또는 한강대로)">
                                <button type="button" class="btn-primary shadow f_srch_text" data-srch-mode="TEXT">검색</button>
                                <button type="button" class="btn-cancel shadow set_position">내 위치로 찾기</button>
                            </div>
                            <div class="maps-layer-results collapse show" id="result-list2">
							<%--item list--%>
                            </div>
                            <button type="button" class="maps-layer-toggle" data-bs-toggle="collapse" data-bs-target="#result-list2" aria-expanded="true">검색 목록 펼치기/접기</button>
                        </div>
                        <%-- tab3 --%>
                        <div class="tab-pane fade" id="tabs3" role="tabpanel">
                            <div class="maps-layer-results collapse show" id="result-list3">
                            	<%--item list--%>
                            </div>
                            <button type="button" class="maps-layer-toggle" data-bs-toggle="collapse" data-bs-target="#result-list3" aria-expanded="true">검색 목록 펼치기/접기</button>
                        </div>
                    </div>
                </div>
                <div id="map" class="maps-kakao"></div>
            </div>
            <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${_kakaoScriptKey}&libraries=services,clusterer,drawing"></script>

            <script>
	        var FindBusinessPlace = (function(){

	        	var srchMode = "LOCATION";
	        	var sido = "서울특별시";
	        	var gugun = "금천구";
	        	var srchText = "";
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

	        	var gpsMsg = "";

        		function init(){

					isAllow = searchGps();

					// 시/군/구 검색
					$("#sido").on("change", function(){
        				$("#gugun").empty();
        				$("#gugun").append("<option value=''>시/군/구</option>");
		            	if($("#sido").val() != ""){
		            		$.ajax({
		        				type : "post",
		        				url  : "/members/stdgCd/stdgCdList.json",
		        				data : {stdgCd:$("#sido").val()},
		        				dataType : 'json'
		        			})
		        			.done(function(data) {
		        				if(data.result){
			       					$.each(data.result, function(index, item){
			       						if(gugun == item.sggNm){
			       							$("#gugun").append("<option value='"+ item.sggNm +"' selected='selected'>"+ item.sggNm +"</option>");
			       						}else{
			       							$("#gugun").append("<option value='"+ item.sggNm +"'>"+ item.sggNm +"</option>");
			       						}

			       	                });
		        				}
		        			})
		        			.fail(function(data, status, err) {
		        				console.log('지역호출 error forward : ' + data);
		        			});
		            	}
        			});
					$("select[name='sido'] option").each(function(){
						//console.log($(this).text());
						if($(this).text() == sido){
							$(this).attr("selected", "selected");
							$("#sido").trigger("change");
						}
					});

					//검색버튼 이벤트
					$(".f_srch_location").on("click", function(){
						srchMode = $(this).data("srchMode");
						sido = $("#sido option:selected").text().substring(0,2);
						gugun = $("#gugun").val();
						srchList(true);
					});
					$(".f_srch_text").on("click", function(){
						srchMode = $(this).data("srchMode");
						srchText = $("#srchText").val();
						srchList(true);
					});

					$("#srchText").on("keyup", function(e){
						if (e.keyCode == 13) {
							srchText = $("#srchText").val();
							srchList(true);
						}
					});

					//탭 이벤트
					$('a[data-bs-toggle="pill"]').on("click", function(){
						var targetTab = $(this).data("bsTarget");
						if(targetTab == "#tabs1"){ //지역검색탭
							srchMode = "LOCATION";
						}else if(targetTab == "#tabs2"){ //직접검색탭
							srchMode = "TEXT";
						}else if(targetTab == "#tabs3"){ //추천멤버스
							srchMode = "RECOMMEND";
						}

						srchList();
					});
        		}

        		function f_ariaShow(){
	        		// 아리아케어만 사업소 보기
		        	// 사업소 보기 전체 출력 -> 아리아케어만 보이기
		        	$(".show_members").each(function(){
		        		console.log($(this).attr("href"));
		        		if($(this).attr("href") != '/members/ariamart'){
		        			$(this).hide();
		        		}
		        	});
	        	}

	        	function searchGps() {
	        		if(navigator.geolocation) {
	        			navigator.geolocation.getCurrentPosition((function (position) {
	        				lat = position.coords.latitude;
	        				lot = position.coords.longitude;
	        				isAllow = true;
	        				srchMode = "TEXT";
	        				srchList(($(window).width() < 768) ? false : true);
	        			}), (function (e) {
	        				switch (e.code) {
	        					case e.PERMISSION_DENIED:
	        						console.log("위치정보 검색을 거부했습니다.\n브라우저의 설정에서 위치(GPS) 서비스를 사용으로 변경해주세요.");
	        						gpsMsg = "위치정보 검색을 거부했습니다.\n브라우저의 설정에서 위치(GPS) 서비스를 사용으로 변경해주세요.";
	        						break;
	        					case e.POSITION_UNAVAILABLE:
	        						console.log("브라우저가 위치정보를 검색하지 못했습니다.");
	        						gpsMsg = "브라우저가 위치정보를 검색하지 못했습니다.";
	        						break;
	        					case e.TIMEOUT:
	        						console.log("브라우저의 위치 정보 검색 시간이 초과됐습니다.");
	        						gpsMsg = "브라우저의 위치 정보 검색 시간이 초과됐습니다.";
	        						break;
	        					default:
	        						console.log("위치 정보 검색에 문제가 있습니다.");
	        						gpsMsg = "위치 정보 검색에 문제가 있습니다.";
	        				}
	        				isAllow = false;
	        				//$(".set_position").remove();
	        				srchMode = "LOCATION";
	        				srchList();
	        			}), { timeout: 1000 });
	        		} else {
	        			console.log("사용 중이신 브라우저가 위치(GPS) 기능을 지원하지 않습니다.");
	        			gpsMsg = "사용 중이신 브라우저가 위치(GPS) 기능을 지원하지 않습니다.";
	        			isAllow = false;
	        			//$(".set_position").remove();
        				srchList(($(window).width() < 768) ? false : true);
	        		}
	        	}

        		function srchList(expanded){

        			if(isAllow && srchMode == "TEXT" && srchText == ""){ //직접검색에 검색어가 없고 GPS가 허용된 경우만 10km내 검색
        				//console.log(isAllow, srchText);
        				dist = 10000; // 범위 초기화 (아무검색 조건 없을때만)
        			}else{
        				dist = 0;
        			}

        			var params = {
        					srchMode:srchMode
        					, sido:sido, gugun:gugun
        					, srchText:srchText
        					, isAllow:isAllow, lot:lot, lat:lat, dist:dist };

        			//console.log(params);

        			$.ajax({
        				type : "post",
        				url  : "/members/bplcList.json",
        				data : params,
        				dataType : 'json'
        			})
        			.done(function(json) {
    					objData = json.resultList;
    					//console.log(Object.keys(objData).length);
    					addListItem(expanded); // 목록 추가
    					kakaoMapDraw(); // 지도 추가
    					 f_ariaShow();
        			})
        			.fail(function(data, status, err) {
        				console.log(data);
        			});
        		}

        		function addListItem(expanded){

        			if(objData.length > 0){
        				var html = '';
        				var noImgCount = 0;

	        			$.each( objData, function( index, item ) {
	        				var kminfo = Math.round((item.dist/1000) * 100) / 100 + 'km';

							if(srchMode == "RECOMMEND"){
								html += '<div class="maps-layer-recommend">';
								if(item.proflImg != null){
									html += '	<img src="/comm/proflImg?fileName='+ item.proflImg +'" alt="">';
								}else{
									html += '	<div class="noimg color' + noImgCount + '"></div>';
									noImgCount = (noImgCount === 4) ? 0 : noImgCount + 1;
								}

								html += '	<div class="partner">';
								html += '		<div class="name"><strong>'+ item.bplcNm +'</strong></div>';
								html += '		<p class="addr">'+ item.addr +' '+ item.daddr  +'</p>';
								html += '	</div>';
								html += '</div>';
							}else{
								html += '<div class="maps-layer-result">';
		        				html += '    <div class="name">';
		        				html += '        <strong>'+ item.bplcNm +'</strong>';
		        				if(isAllow && item.dist > 0){
		        					html += '        <span>'+ kminfo +'</span>';
		        				}
		        				html += '    </div>';
		        				html += '    <p class="addr">'+ item.addr +' ' + item.daddr  +'</p>';
		        				html += '    <a class="call" href="tel:'+ item.telno +'">'+ item.telno +'</a>';
		        				html += '</div>';
							}
	        			});
        			}else{
        				html = '<div>검색 결과가 없습니다.</div>';
        			}

        			$(".maps-layer-results").empty() //list 초기화

        			var target = null;

        			if(srchMode === "LOCATION"){
        				target = $('#tabs1');
        			}else if(srchMode === "TEXT"){
        				target = $('#tabs2');
        			}else if(srchMode === "RECOMMEND"){
        				target = $('#tabs3');
					}

        			$('.tabs-list a[data-bs-target="#' + target.attr('id') + '"]').addClass("active");
        			target.addClass('show active').find('.maps-layer-results').append(html);

        			if(expanded === true) {
        				target.find('.maps-layer-results').addClass('show');
        				target.find('.maps-layer-toggle').removeClass('collapsed').attr('aria-expanded', 'true');
        			}else if(expanded === false) {
        				target.find('.maps-layer-results').removeClass('show');
        				target.find('.maps-layer-toggle').addClass('collapsed').attr('aria-expanded', 'false');
        			}

        			$(".maps-layer-result").css({"cursor":"pointer"});
        		}

	        	function kakaoMapDraw(){

	        		var datas = {};
	        		var positions = [];
	        		var markers = [];
	        		var overlays = [];
	        		var level = 5;
	        		var latlng;
	        		var centerLat = 0.0005;
	        		var centerLng = isMob ? 0 : 0.005; // 검색 레이어보다 오른쪽으로 이동

	        		if(objData.length > 0){

		        		$.each( objData, function( index, item ) {

		        			var kminfo = "";
		        			if(isAllow && item.dist > 0){
		        				kminfo = Math.round((item.dist/1000) * 100) / 100 + 'km';
		        			}
		        			datas = {
		        				latlng: new kakao.maps.LatLng(Number(item.lat), Number(item.lot)),
		        				center: new kakao.maps.LatLng(Number(item.lat) + centerLat, Number(item.lot) - centerLng),
		        				content: '<div class="maps-kakao-overlay">' +
				                            '	<div class="content">' +
				                            '		<div class="name">' +
				                            '			<strong>'+ item.bplcNm +'</strong>' +
				                            '			<span>' + kminfo + '</span>' +
				                            '		<div class="close overlayClose">닫기</div>' +
				                            '		</div>' +
				                            '		<p class="addr">'+ item.addr +' '+ item.daddr  +'</p>' +
				                            '		<a class="call" href="tel:'+ item.telno +'">'+ item.telno +'</a>' +
			                            	'<a href="/members/'+ item.bplcUrl +'" target="_blank" class="btn-secondary flex mt-4 w-28 h-7 rounded-full mx-auto text-sm show_members">멤버스보기</a>' +
				                            '	</div>' +
				                            '</div>',
		        				title: item.bplcNm
		        			}
		        			positions.push(datas);
		        		});
		        		//console.log(positions);

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
		                var imageSrc = '/html/page/office/assets/images/ico-map-marker.svg',
		                    imageSize = new kakao.maps.Size(28, 35),
		                    imageOption = {offset: new kakao.maps.Point(14, 40)};

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
	                            yAnchor: 1.2,
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
		        				map.setLevel(5)
		        			});

		        		}

		                // 지도를 내위치로
		                $(".set_position").one("click", function(){
							if(isAllow){
								map.setCenter(new kakao.maps.LatLng(lat, lot));
		        				map.setLevel(5)
							}
						})

		             	// 리스트 클릭시
		        		$("div.maps-layer-result, div.maps-layer-recommend").on('click', function(event, visible) {
		        			idx = $(this).index();
		        			allOverlayClose();

		        			var overlay = overlays[idx];
		        			overlay.setMap(map, markers[idx]);

		        			map.setCenter(positions[idx].center);
		        			map.setLevel(5);

		        			if($(window).width() < 768) {
			        			map.panBy(0, -75);
		        			}

		        			if(!visible && $(window).width() < 768) {
		        				$('.maps-layer-results:visible').removeClass('show');
		        				$('.maps-layer-toggle:visible').addClass('collapsed').attr('aria-expanded', 'false');
		        			}
		        			f_ariaShow();
		        		});

		        		$("div.maps-layer-result").eq(0).trigger('click', {visible: true});

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

	        			// 데이터가 없을 경우
	        			var mapContainer = document.getElementById('map'),
		    			mapOption = {
		    				center: new kakao.maps.LatLng(37.6065432383919, 127.092820287004),
		    				level: 8 // 지도의 확대 레벨
		    			};

						var map = new kakao.maps.Map(mapContainer, mapOption);
	        		}
	        	}

	        	function resizeHandler() {
	        		windowWidth = $(window).width();
	        		windowHeight = $(window).height();
	        		isMob = windowWidth <= 1023;
	        	}
				init();
	        })();
            </script>
        </div>
        <!-- //container -->
