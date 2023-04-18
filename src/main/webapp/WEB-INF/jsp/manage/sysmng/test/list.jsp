<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
	
	<p class="text-right">
		<button type="button" class="btn-primary btn-excel" data-bs-toggle="modal" data-bs-target="#fileModal">엑셀 업로드</button>
		<button type="button" class="btn-primary btn-excel" id="excelDownload">엑셀 다운로드</button>
	</p>

	<ul class="nav tab-list tab-full mt-12" id="scollspy">
        <li><a role="button" class="nav-link" onclick="navButtonClick(this, '점수')">점수</a></li>
        <li><a role="button" class="nav-link" onclick="navButtonClick(this, '신체기능')">신체기능</a></li>
        <li><a role="button" class="nav-link" onclick="navButtonClick(this, '인지기능')">인지기능</a></li>
        <li><a role="button" class="nav-link" onclick="navButtonClick(this, '행동변화')">행동변화</a></li>
        <li><a role="button" class="nav-link" onclick="navButtonClick(this, '간호처치')">간호처치</a></li>
        <li><a role="button" class="nav-link" onclick="navButtonClick(this, '재활')">재활</a></li>
        <li><a role="button" class="nav-link" onclick="navButtonClick(this, '질병')">질병</a></li>
    </ul>
    <textarea id="dataText" class="w-full border border-black rounded-md" style="height:400px;" readonly></textarea>
	
	<!-- 엑셀 업로드 모달 추가 -->
	<c:import url="/_mng/sysmng/test/modalFileUpload" />
</div>

<script>
	function navButtonClick(navBtn, testNm) {
		//선택 처리
		$('.nav-link').removeClass('active');
		$(navBtn).addClass('active');
		
		//데이터 조회
		$.ajax({
			type: 'GET',
			url: '/_mng/sysmng/test/testData.json',
			data: { testNm }
		})
		.done(function(res) {
			if (res.result === 'Y') {
				$('#dataText').val(res.data);
			}
		})
		.fail(function(data, status, error) {
		});
	}

	$(function() {
		$('#excelDownload').on('click', function() {
			window.open('/_mng/sysmng/test/excelDownloadAction');
		});		
	})
</script>