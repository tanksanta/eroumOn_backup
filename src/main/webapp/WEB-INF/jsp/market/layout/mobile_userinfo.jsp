<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%--
휴대기기용 > 회원정보
 --%>

			<div class="global-user mb-9 ${_mbrSession.mberGrade eq 'E' ? 'is-grade1' : _mbrSession.mberGrade eq 'B' ? 'is-grade2' : _mbrSession.mberGrade eq 'S' ? 'is-grade3' : _mbrSession.mberGrade eq 'N' ? '' : ''} lg:hidden">
				<div class="user-name">
				    <strong>${_mbrSession.mbrNm} <small>님</small></strong>
					<span>${recipterYnCode[_mbrSession.recipterYn]}</span>
                       <button type="button" class="user-toggle">메뉴 열기</button>
				</div>
				<div class="user-info">
				    <div class="grade">
				        <strong>${gradeCode[_mbrSession.mberGrade]}</strong>
						<a href="${_marketPath}/etc/bnft/list">등급별혜택</a>
					</div>
					<div class="point">
					    <dl>
					        <dt>쿠폰</dt>
					        <dd>
					        	<a href="${_marketPath}/mypage/coupon/list">
                               		<strong>${_mbrEtcInfoMap.totalCoupon }</strong> 장
						   		</a>
						 	</dd>
						</dl>
						<dl>
						    <dt>포인트</dt>
						    <dd>
						   		<a href="${_marketPath}/mypage/point/list">
                               		<strong><fmt:formatNumber value="${_mbrEtcInfoMap.totalPoint}" pattern="###,###" /></strong>
									<img src="/html/core/images/txt-point-white.svg" alt="포인트">
								</a>
							</dd>
	                    </dl>
	                    <dl>
	                        <dt>마일리지</dt>
	                        <dd>
	                        	<a href="${_marketPath}/mypage/mlg/list">
                               		<strong><fmt:formatNumber value="${_mbrEtcInfoMap.totalMlg}" pattern="###,###" /></strong>
									<img src="/html/core/images/txt-mileage-white.svg" alt="마일리지">
								</a>
							</dd>
	                    </dl>
	                </div>
	            </div>
            </div>