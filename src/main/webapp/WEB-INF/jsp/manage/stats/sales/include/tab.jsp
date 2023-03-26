<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<ul class="nav tab-list tab-full">
                    <li><a href="./prfmnc" ${fn:indexOf(_curPath,'prfmnc')>-1?'class="active"':''}>판매실적</a></li>
                    <li><a href="./goods" ${fn:indexOf(_curPath,'goods')>-1?'class="active"':''}>판매상품</a></li>
                    <li><a href="./trpr" ${fn:indexOf(_curPath,'trpr')>-1?'class="active"':''}>성별/연령별</a></li>
                    <li><a href="./partner" ${fn:indexOf(_curPath,'partner')>-1?'class="active"':''}>멤버스별</a></li>
                    <li><a href="./mlg" ${fn:indexOf(_curPath,'mlg')>-1?'class="active"':''}>마일리지</a></li>
                    <li><a href="./point" ${fn:indexOf(_curPath,'point')>-1?'class="active"':''}>포인트</a></li>
<%--
                    <li><a href="./coupon" ${fn:indexOf(_curPath,'coupon')>-1?'class="active"':''}>쿠폰</a></li>
--%>
                    <li><a href="./stlmTy" ${fn:indexOf(_curPath,'stlmTy')>-1?'class="active"':''}>결제수단별</a></li>
                    <li><a href="./cardCo" ${fn:indexOf(_curPath,'cardCo')>-1?'class="active"':''}>카드사별</a></li>

                </ul>