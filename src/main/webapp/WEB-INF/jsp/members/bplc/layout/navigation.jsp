<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

        <!-- navigation -->
        <nav id="navigation">
            <ul>
                <li ${fn:indexOf(_curPath, 'gds') > -1?'class="active"':''}><a href="${_bplcPath}/gds/list">복지용구</a></li>
                <li class="separate" aria-hidden="true" role="separator"></li>
                <li ${fn:indexOf(_curPath, 'notice') > -1?'class="active"':''}><a href="${_bplcPath}/bbs/notice/list">공지사항</a></li>
                <li ${fn:indexOf(_curPath, 'lctn') > -1?'class="active"':''}><a href="${_bplcPath}/lctn">찾아오시는길</a></li>
            </ul>
        </nav>
        <!-- //navigation -->