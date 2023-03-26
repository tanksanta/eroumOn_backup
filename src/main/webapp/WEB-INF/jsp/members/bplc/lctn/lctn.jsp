<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container">
	<h2 class="page-title">찾아오시는길</h2>

	<div class="aspect-video overflow-hidden relative bg-gray-200 maps-kakao" id="map"></div>
	<dl class="cont-location car">
		<dt>자차 이용 시</dt>
		<dd>
		${bplcSetupVO.carDrc}
		</dd>
	</dl>

	<dl class="cont-location bus">
		<dt>버스 이용 시</dt>
		<dd>
			${bplcSetupVO.busDrc}
		</dd>
	</dl>

	<dl class="cont-location metro">
		<dt>지하철 이용 시</dt>
		<dd>
			${bplcSetupVO.subwayDrc}
		</dd>
	</dl>
</main>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=84e3b82c817022c5d060e45c97dbb61f&libraries=services,clusterer,drawing"></script>
<script>
    //지도 생성
    var map = new kakao.maps.Map(document.getElementById('map'), {
        center: new kakao.maps.LatLng(${bplcSetupVO.lat}, ${bplcSetupVO.lot}),
        level: 3
    });

    //마커 생성
    var imageSrc    = '/html/page/office/assets/images/ico-map-marker.svg',
        imageSize   = new kakao.maps.Size(28, 35),
        imageOption = {offset: new kakao.maps.Point(14, 40)};

    var markerImage     = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
        markerPosition  = new kakao.maps.LatLng(${bplcSetupVO.lat}, ${bplcSetupVO.lot});

    var marker = new kakao.maps.Marker({
        position : markerPosition,
        image    : markerImage
    });

    marker.setMap(map);

</script>