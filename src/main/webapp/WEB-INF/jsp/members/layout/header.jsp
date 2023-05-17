<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

		<header id="header">
            <div class="container">
                <h1 id="logo" class="global-logo is-style2 is-white">
                    <a href="/<spring:eval expression="@props['Globals.Members.path']"/>/introduce">
                        <span>
                            멤버스
                            <small>
                                당신이 어디에 있든<br>
                                사업소가 항상 옆에 있습니다.
                            </small>
                        </span>
                    </a>
                </h1>
                <a href="/<spring:eval expression="@props['Globals.Members.path']"/>/regist" class="request">멤버스 등록신청</a>
            </div>
        </header>