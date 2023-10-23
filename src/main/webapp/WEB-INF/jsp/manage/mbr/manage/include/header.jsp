<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
                <div class="member-info">
                    <div class="info">
                        <%-- <span class="thum"><c:if test="${mbrVO.proflImg ne null}"><img src="/comm/PROFL/getFile?fileName=${mbrVO.proflImg}"></c:if></span> --%> 
                        <span class="name">
                            <strong>${mbrVO.mbrNm}</strong>
                            <small>${mbrVO.mbrId }</small>
                        </span>
                    </div>
                    <p class="grade">${mberGradeCode[mbrVO.mberGrade]}</p>
                    <p class="member">
                        <span id="recipter">온라인 회원</span>
                        <strong><fmt:formatDate value="${mbrVO.joinDt}" pattern="yyyy-MM-dd" /></strong>
                    </p>
                    <i class="ico-member-pc type" id="coursPattern"></i>


                </div>

				<c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchId=${param.srchId}&amp;srchNm=${param.srchNm}&amp;srchTel=${param.srchTel}&amp;srchBirth=${param.srchBirth}" />
                <ul class="tab-list tab-full -mt-6.5 mx-2.5 px-1 rounded-md bg-white">
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/view"  ${fn:indexOf(_curPath, '/view') > -1?'class="active"':'' } >회원정보</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/recipient"  ${fn:indexOf(_curPath, '/recipient') > -1?'class="active"':'' } >수급자정보</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/ordr" ${fn:indexOf(_curPath, '/ordr') > -1?'class="active"':'' }>주문내역</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/mlg" ${fn:indexOf(_curPath, '/mlg') > -1?'class="active"':'' }>마일리지</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/coupon" ${fn:indexOf(_curPath, '/coupon') > -1?'class="active"':'' }>쿠폰</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/point" ${fn:indexOf(_curPath, '/point') > -1?'class="active"':'' }>포인트</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/event" ${fn:indexOf(_curPath, '/event') > -1?'class="active"':'' }>이벤트</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/review" ${fn:indexOf(_curPath, '/review') > -1?'class="active"':'' }>상품후기</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/qna" ${fn:indexOf(_curPath, '/qna') > -1?'class="active"':'' }>상품Q&A</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/question" ${fn:indexOf(_curPath, '/question') > -1?'class="active"':'' }>1:1문의</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/favorite?modalType=cart " ${fn:indexOf(_curPath, '/favorite') > -1?'class="active"':'' }>관심상품</a></li>
                </ul>