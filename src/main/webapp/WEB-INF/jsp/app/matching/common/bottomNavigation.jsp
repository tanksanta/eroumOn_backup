<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <footer class="page-footer bottomNav">

      <ul class="bottomNav_menu">

        <li class="btn_om<c:if test="${ param != null && param.menuName == 'recipients' }"> active</c:if>">
          <a class="waves-effect">
            <span class="txt">어르신</span>
          </a>
        </li>
        <li class="btn_wel<c:if test="${ param != null && param.menuName == 'welfare' }"> active</c:if>">
          <a class="waves-effect">
            <span class="txt">복지용구</span>
          </a>
        </li>
        <li class="btn_service<c:if test="${ param != null && param.menuName == 'service' }"> active</c:if>" onclick="location.href='/matching/main/service';">
          <a class="waves-effect">
            <span class="txt">서비스</span>
          </a>
        </li>
        <li class="btn_guide<c:if test="${ param != null && param.menuName == 'guide' }"> active</c:if>">
          <a class="waves-effect">
            <span class="txt">길잡이</span>
          </a>
        </li>
        <li class="btn_entier<c:if test="${ param != null && param.menuName == 'entire' }"> active</c:if>">
          <a class="waves-effect">
            <span class="txt">전체</span>
          </a>
        </li>

      </ul>

    </footer>