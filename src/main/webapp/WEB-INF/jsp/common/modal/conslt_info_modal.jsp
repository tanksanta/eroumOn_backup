<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<!--모달: 수급자 정보 -->
	<div class="modal modal-default fade" id="check-counseling-info" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="text-title">상담 정보 확인</h2>
                    <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                </div>

                <div class="modal-body">
                    <div>
                        <div class="text-subtitle">
                            <i class="icon-alert"></i>
                            <p>신청하신 수급자의 정보와 상담받을 연락처를 확인하세요</p>
                        </div>
                        <table class="table-view">
                            <caption class="hidden">상담정보확인 위한 수급자와의 관계, 수급자성명, 요양인정번호, 상담받을연락처, 실거주지 주소, 생년월일,성별, 상담유형 내용입니다 </caption>
                            <colgroup>
                                <col class="w-22 xs:w-32">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr class="top-border">
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <th scope="row" class="text-gray1 font-medium">수급자와의 관계</th>
                                    <td id="relationText">본인</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="text-gray1 font-medium">수급자 성명</th>
                                    <td id="mbrNm">이로움</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="text-gray1 font-medium">요양인정번호</th>
                                    <td id="rcperRcognNo">L123456789</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="text-gray1 font-medium">상담받을 연락처</th>
                                    <td id="mbrTelno">010-1234-5678</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="text-gray1 font-medium">실거주지 주소</th>
                                    <td id="address">서울특별시 금천구 가산디지털로 104</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="text-gray1 font-medium">생년월일</th>
                                    <td id="brdt">1900/01/01</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="text-gray1 font-medium">성별</th>
                                    <td id="gender">남성</td>
                                </tr>
                                <tr>
                                    <th scope="row" class="text-gray1 font-medium">상담 유형</th>
                                    <td id="prevPath">인정등급 상담</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary w-2/6" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>


    <script>
	  	//상담정보보기 클릭
	    function viewConsltInfoModal(consltNo) {
	    	$.ajax({
	    		type : "post",
	    		url  : "/membership/conslt/appl/getConsltInfo.json",
	    		data : {
	    			consltNo
	    		},
	    		dataType : 'json'
	    	})
	    	.done(function(data) {
	    		if(data.success) {
	    			$('#relationText').text(data.mbrConsltInfo.relationText);
	    			$('#mbrNm').text(data.mbrConsltInfo.mbrNm);
	    			if (data.mbrConsltInfo.rcperRcognNo) {
	    				$('#rcperRcognNo').text(data.mbrConsltInfo.rcperRcognNo);	    				
	    			} else {
	    				$('#rcperRcognNo').text('');
	    			}
	    			$('#mbrTelno').text(data.mbrConsltInfo.mbrTelno);
	    			$('#address').text(data.mbrConsltInfo.address);
	    			$('#brdt').text(data.mbrConsltInfo.brdt);
	    			$('#gender').text(data.mbrConsltInfo.gender);
	    			$('#prevPath').text(data.mbrConsltInfo.prevPath);
	    			
	    			$('#check-counseling-info').modal('show');
	    		}else{
	    			alert(data.msg);
	    		}
	    	})
	    	.fail(function(data, status, err) {
	    		alert('서버와 연결이 좋지 않습니다.');
	    	});
	    }
    </script>
