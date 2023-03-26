<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<header id="header">
            <div class="container">
                <h1>
                    <a href="/<spring:eval expression="@props['Globals.Members.path']"/>/introduce">
                        <img src="/html/page/office/assets/images/ico-partner-logo.svg" alt="E-ROUM MEMBERS">
                        <span>
                            당신이 어디에 있든<br>
                            멤버스가 항상 옆에 있습니다.
                        </span>
                    </a>
                </h1>
                <a href="/<spring:eval expression="@props['Globals.Members.path']"/>/regist" class="request">멤버스 등록신청</a>
            </div>
        </header>