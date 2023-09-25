<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
                <div class="member-info">
                    <div class="info">
                        <span class="thum"><c:if test="${mbrVO.proflImg ne null}"><img src="/comm/PROFL/getFile?fileName=${mbrVO.proflImg}"></c:if></span>
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

				<ul class="tab-list page-kind tab-full -mt-6.5 mx-2.5 px-1 rounded-md bg-white">
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/view" uniqueId="${mbrVO.uniqueId}" page-kind="view" class="btn ${fn:indexOf(_curPath, '/view') > -1?' active':'' }"   >회원정보</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/ordr" uniqueId="${mbrVO.uniqueId}" page-kind="ordr" class="btn ${fn:indexOf(_curPath, '/ordr') > -1?' active':'' }" >주문내역</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/mlg" uniqueId="${mbrVO.uniqueId}" page-kind="mlg" class="btn ${fn:indexOf(_curPath, '/mlg') > -1?' active':'' }" >마일리지</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/coupon" uniqueId="${mbrVO.uniqueId}" page-kind="coupon" class="btn ${fn:indexOf(_curPath, '/coupon') > -1?' active':'' }" >쿠폰</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/point" uniqueId="${mbrVO.uniqueId}" page-kind="point" class="btn ${fn:indexOf(_curPath, '/point') > -1?' active':'' }" >포인트</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/event" uniqueId="${mbrVO.uniqueId}" page-kind="event" class="btn ${fn:indexOf(_curPath, '/event') > -1?' active':'' }" >이벤트</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/review" uniqueId="${mbrVO.uniqueId}" page-kind="review" class="btn ${fn:indexOf(_curPath, '/review') > -1?' active':'' }" >상품후기</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/qna" uniqueId="${mbrVO.uniqueId}" page-kind="qna" class="btn ${fn:indexOf(_curPath, '/qna') > -1?' active':'' }" >상품Q&A</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/question" uniqueId="${mbrVO.uniqueId}" page-kind="question" class="btn ${fn:indexOf(_curPath, '/question') > -1?' active':'' }" >1:1문의</a></li>
                    <li><a href="/_mng/mbr/${mbrVO.uniqueId}/favorite?modalType=cart" uniqueId="${mbrVO.uniqueId}" page-kind="favorite?modalType=cart" class="btn ${fn:indexOf(_curPath, '/favorite') > -1?' active':'' }">관심상품</a></li>
                </ul>