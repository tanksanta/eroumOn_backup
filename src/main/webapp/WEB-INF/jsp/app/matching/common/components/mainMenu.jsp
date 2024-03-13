<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<div class="card waves-effect w100p<c:if test="${ param != null && param.active == '1' }"> active</c:if>" onclick="location.href='/matching/welfareinfo/interest/intro';">

          <div class="card-content d-flex justify-content-between align-items-center">

            <div>
              <span class="color_t_s font_sbsr">관심 복지용구</span>
              <h5 class="title">
                장기요양금액으로<br />관심있는 복지용구 지원받기
              </h5>
            </div> 
            <img src="/html/page/app/matching/assets/src/images/08etc/tool_40.svg" class="w80" alt="관심 복지용구">

          </div>
        </div>
        <!-- card -->

        <div class="h16"></div>

        <div class="card waves-effect w100p<c:if test="${ param != null && param.active == '2' }"> active</c:if>" onclick="location.href='/matching/simpletest/simple/intro';">

          <div class="card-content d-flex justify-content-between align-items-center">

            <div>
              <span class="color_t_s font_sbsr">간편 테스트</span>
              <h5 class="title">
                장기요양보험 혜택 받을 수<br />있는 지 빠르게 확인하기
              </h5>
            </div> 
            <img src="/html/page/app/matching/assets/src/images/08etc/test_80.svg" class="w80" alt="간편 테스트">

          </div>
        </div>
        <!-- card -->
        
        <div class="h16"></div>

        <div class="card waves-effect w100p<c:if test="${ param != null && param.active == '3' }"> active</c:if>" onclick="location.href='/matching/simpletest/care/intro';">

          <div class="card-content d-flex justify-content-between align-items-center">

            <div>
              <span class="color_t_s font_sbsr">어르신 돌봄</span>
              <h5 class="title">
                필요한 시간에<br />돌봄 서비스 지원받기
              </h5>
            </div> 
            <img src="/html/page/app/matching/assets/src/images/08etc/time03_80.svg" class="w80" alt="어르신 돌봄">

          </div>
        </div>
        <!-- card -->
   
   