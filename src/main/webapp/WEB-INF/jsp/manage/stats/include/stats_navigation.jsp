<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ul class="nav tab-list tab-full">
	<li><a href="./join" ${fn:indexOf(_curPath,'/join') > -1 ? 'class="active"' : ''}>가입/탈퇴현황</a></li>
	<li><a href="./drmc" ${fn:indexOf(_curPath,'/drmc') > -1 ? 'class="active"' : ''}>휴면회원 현황</a></li>
	<li><a href="./gender" ${fn:indexOf(_curPath,'/gender') > -1 ? 'class="active"' : ''}>성별/연령별</a></li>
	<li><a href="./cours" ${fn:indexOf(_curPath,'/cours') > -1 ? 'class="active"' : ''}>가입경로</a></li>
	<li><a href="./grade" ${fn:indexOf(_curPath,'/grade') > -1 ? 'class="active"' : ''}>등급별</a></li>
</ul>
