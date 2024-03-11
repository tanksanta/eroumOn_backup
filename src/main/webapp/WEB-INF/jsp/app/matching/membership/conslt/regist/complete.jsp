<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<div class="wrapper">
	
		<header>
            <nav class="top">
                <div class="btn_back">
                    <span class="txt">상담 신청 완료</span>
                </div>
                <div class="icon_area waves-effect">
                    <div class="icon_btn i_share"></div>
                </div>

            </nav>
        </header>


        <main>
            <section class="intro">

                <h3 class="title">신청이 완료되었어요</h3>

                <div class="h20"></div>

                <div class="align_center" style="padding-left: 32px;">
                    <dotlottie-player src="https://lottie.host/29279b7c-3d9b-4543-8217-56a97dde8828/earXVHpFGI.json" background="transparent" speed="1" style="width: 170px; height: 148px;" loop autoplay></dotlottie-player>
                </div>

                <div class="h16"></div>

                <div class="center font_sbmr">
                    장기요양기관에 연결 중이에요<br>
                    48시간 내 연락 드릴게요
                </div>

                <div class="h32"></div> 

                <div class="card">

                    <div class="card-content">

                      <span class="font_sbms">상담 신청 정보</span>
                      
                      <div class="h14"></div>

                      <table class="table_basic small">
                        <colgroup>
                            <col style="width:50%;">
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="color_secondary font_sbmr">상담유형</th>
                                <td class="font_sbmr">${prevPathCtgryMap[mbrConsltVO.prevPath]}/${prevPathMap[mbrConsltVO.prevPath]}</td>
                            </tr>
                            <tr>
                                <th class="color_secondary font_sbmr">신청자 이름</th>
                                <td class="font_sbmr">${mbrConsltVO.rgtr}</td>
                            </tr>
                            <tr>
                                <th class="color_secondary font_sbmr">어르신 이름</th>
                                <td class="font_sbmr">${mbrConsltVO.mbrNm}</td>
                            </tr>
                            <tr>
                                <th class="color_secondary font_sbmr">상담받을 연락처</th>
                                <td class="font_sbmr">${mbrConsltVO.mbrTelno}</td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <div class="h16"></div>

                    <a class="waves-effect btn-large btn_default w100p" onclick="location.href='/matching/membership/conslt/list';">신청 상세보기</a>
          
                    </div>
                  </div>
                  <!-- card -->

            </section>
        </main>


        <footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p">더 알아보기</a>
            </div>

        </footer>
        
	</div>
	<!-- wrapper -->
	
	
	<script>
		$(function() {
			//상담 정보 입력 페이지부터 최근 이력 삭제
			removeHistoryStackFrom('/matching/membership/conslt/infoConfirm');
			
			//body에 css class 추가
			$('body').addClass('back_gray');
		});
	</script>