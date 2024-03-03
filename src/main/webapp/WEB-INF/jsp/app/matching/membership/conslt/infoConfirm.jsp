<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">
	
       	<!-- 상단 뒤로가기 버튼 추가 -->
		<jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp" />
        
        
        <main>
            <section class="intro">

                <h3 class="title">
                    <mark class="mk01">${recipientInfo.recipientsNm}님</mark> 상담을 위해<br />필요한 정보를 확인해주세요
                </h3>

                <div class="h40"></div>

                <table class="table_basic">
                    <colgroup>
                        <col style="width:120px;">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr>
                            <th class="font_sbmr">상담유형</th>
                            <td class="l_right padR20 color_tp_s font_sbms">${prevPathMap[prevPath]}</td>
                        </tr>
                        <tr>
                            <th class="font_sbmr">신청자 이름</th>
                            <td class="l_right padR20 color_tp_s font_sbms">${_matMbrSession.mbrNm}</td>
                        </tr>
                        <tr>
                            <th class="font_sbmr">어르신 기본정보</th>
                            <td class="l_right padR20 color_tp_s font_sbms">${recipientInfo.recipientsNm}</td>
                        </tr>
                        <tr>
                            <th class="font_sbsr">상담받을 연락처</th>
                            <td class="l_right">
                                <span class="waves-effect link_text">${recipientInfo.tel}</span>
                            </td>
                        </tr>
                    </tbody>
                </table>

            </section>
        </main>
        

        <footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p" onclick="location.href='/matching/membership/conslt/request'">다음</a>
            </div>

        </footer>
	    
	</div>
	<!-- wrapper -->
	
	
	<script>
		$(function() {
			saveInLocalStorage('consltPrevPath', '${prevPath}');
		});
	</script>