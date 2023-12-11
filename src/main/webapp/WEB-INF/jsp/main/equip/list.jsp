<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header id="subject">
    <nav class="breadcrumb">
        <ul>
			<li class="home"><a href="${_mainPath}">홈</a></li>
			<li>이로움 서비스</li>
            <li>관심 복지용구 상담</li>
        </ul>
    </nav>

</header>

<div id="content">
    관심 복지용구 메인
	<br><br>
	<button class="btn btn-primary3" onclick="clickStartConsltBtn()">상담하기</button>


	<!-- 상담 신청하기 지원 모달 -->
	<jsp:include page="/WEB-INF/jsp/common/modal/recipient_and_conslt_modal.jsp" />
	

	<script>
		//상담하기 버튼 클릭
	    function clickStartConsltBtn() {
	    	var recipientsNo = '46';
	    	openModal('requestConslt', Number(recipientsNo), 'equip_ctgry');
	    }
	</script>
</div>
