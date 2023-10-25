<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<main id="container" class="is-mypage-style">
	<header id="page-title">
		<h2>
			<span>수급자상세</span>
		</h2>
	</header>

	<jsp:include page="../../layout/page_nav.jsp" />
	
	<div id="page-content">               
		<h3 class="mypage-title2 with-icon">
			<i class="icon-back"></i>
			수급자상세
		</h3>
		<div class="mypage-consult-desc text-with-icon">
			<i class="icon-alert"></i>
			<p>장기요양보험 수급자와 예비수급자의 정보를 관리할 수 있는 페이지입니다.</p>
		</div>

		<div class="mypage-client-details mt-3.5 md:mt-5">
			<div class="mypage-client-detail-item">
				<h4 class="mypage-client-detail-item-title">
					<strong class="text-xl">기본정보</strong>
					<a href="#" class="text-blue3 text-sm" onclick="clickStartConsltBtn();">수정하기<i class="icon-plus icon-blue3"></i></a>
				</h4>
				<div class="mypage-client-detail-inner">
					<table class="table-view bg-title">
					<caption class="hidden">수급자 상세 기본정보표 입니다</caption>
					<colgroup>
						<col class="w-40">
						<col>
					</colgroup>
						<tbody>
							<tr>
								<th scope="row">수급자와의 관계</th>
								<td>${mbrRelationCode[recipientVO.relationCd]}</td>
							</tr>
							<tr>
								<th scope="row">수급자 성명</th>
								<td>${recipientVO.recipientsNm}</td>
							</tr>
							<tr>
								<th scope="row">요양인정번호</th>
								<td>L${recipientVO.rcperRcognNo}</td>
							</tr>
							<tr>
								<th scope="row">상담받을 연락처</th>
								<td>${recipientVO.tel}</td>
							</tr>
							<tr>
								<th scope="row">실거주지 주소</th>
								<td>${recipientVO.sido}&nbsp;${recipientVO.sigugun}&nbsp;${recipientVO.dong}</td>
							</tr>
							<tr>
								<th scope="row">생년월일</th>
								<td>
									<c:if test="${ recipientVO.brdt != null }">
										${recipientVO.brdt.substring(0,4)}/${recipientVO.brdt.substring(4,6)}/${recipientVO.brdt.substring(6,8)}
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row">성별</th>
								<td>${genderCode[recipientVO.gender]}</td>
							</tr>
							<tr>
								<th scope="row">최근등록(수정)일시</th>
								<td>
									<c:choose>
										<c:when test="${!empty recipientVO.mdfcnDt}">
											<fmt:formatDate value="${recipientVO.mdfcnDt}" pattern="yyyy-MM-dd HH:mm:ss" />
										</c:when>
										<c:otherwise>
											<fmt:formatDate value="${recipientVO.regDt}" pattern="yyyy-MM-dd HH:mm:ss" />
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="mypage-client-detail-item">
				<h4 class="mypage-client-detail-item-title">
					<strong class="text-xl">상담 내역</strong>
					<a href="/membership/conslt/appl/list" class="text-sm">지난 상담 내역 보기<i class="icon-arrow-right"></i></a>
				</h4>
				<div class="mypage-client-detail-inner">
					<table class="table-view bg-title">
					<caption class="hidden">수급자 상담내역 정보입니다</caption>
					<colgroup>
						<col class="w-30">
						<col>
					</colgroup>
						<tbody>
							<tr>
								<th scope="row">수급자 성명</th>
								<td>${consltVO.mbrNm}</td>
							</tr>
							<tr>
								<th scope="row">상담 유형</th>
								<td>${prevPathCode[consltVO.prevPath]}</td>
							</tr>
							<tr>
								<th scope="row">진행 현황</th>
								<td>${consltSttusCode[consltVO.consltSttus]}</td>
							</tr>
							<tr>
								<th scope="row">장기요양기관</th>
								<td>
									<c:if test="${consltResultVO != null}">
										<strong>${consltResultVO.bplcNm}</strong>
										<a href="tel:010-0000-0000"><i class="icon-tel"></i></a>
										<div class="item-request justify-end">
											<div class="flex items-center">
												<label class="check1">
													<input type="checkbox" name="" value="">
													<span>추천하기</span>
												</label>
												<label class="check2">
													<input type="checkbox" name="" value="">
													<span>관심설정</span>
												</label>
											</div>
										</div>
									</c:if>
								</td>
							</tr>
							<tr>
								<th scope="row">상담 신청일</th>
								<td><fmt:formatDate value="${consltVO.regDt}" pattern="yyyy.MM.dd" /></td>
							</tr>
							<tr>
								<th scope="row">상담 완료일</th>
								<td>
									<c:if test="${completeChgHistVO != null}">
										<fmt:formatDate value="${completeChgHistVO.regDt}" pattern="yyyy.MM.dd" />
									</c:if>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="flex justify-between mt-8">
			<h3 class="careinfo-title mb-2">요양정보</h3>
			<a class="btn-success btn-small" onclick="requestConslt('simpleSearch');">상담하기</a>
		</div>

		<div class="careinfo-myinfo mypage" style="display:none;">
			<div class="myinfo-wrapper">
				<div class="myinfo-box1">
                       <p class="name" ><span class="blurring2"><span class="mask"></span><span class="searchNm">이로미</span></span>&nbsp; 님
                           <c:if test="${_mbrSession.loginCheck}">
                               <a href="/membership/mypage/list">정보수정</a>
                           </c:if>
                       </p>
                       <dl class="numb">
                           <dt class="desc">요양인정번호</dt>
                           <dd class="searchNo"><span class="blurring2"><span class="mask"></span>L123456789</span></dd>
                       </dl>
                       <dl class="date">
                           <dt class="desc">인정 유효기간</dt>
                           <dd id="searchRcgt">
                               <span class="blurring2"><span class="mask"></span>2023년 1월 1일 ~2023년 12월 31일</span>
                           </dd>
                       </dl>
                       <dl class="date">
                           <dt class="desc">적용기간</dt>
                           <dd id="searchBgngApdt">
                               <span class="blurring2"><span class="mask"></span>2023년 1월 1일 ~2023년 12월 31일</span>
                           </dd>
                       </dl>
                   </div>
                   <div class="myinfo-box2">
                       <p class="desc">잔여급여</p>
                       <p class="cost"><span class="blurring2"><span class="mask"></span><strong id="searchRemn">1,250,000</strong>원</span></p>
                       <dl class="used1">
                           <dt class="desc">사용</dt>
                           <dd class="percent">
                               <div class="track">
                                   <div class="bar" id="useAmtBar"></div>
                           </div>
                           <div class="won" id="searchUseAmt"><span class="blurring2"><span class="mask"></span>350,000원</span></div>
                       </dd>
                    </dl>
                    <dl class="used2">
                        <dt class="desc">총 급여</dt>
                        <dd class="percent">
                            <div class="track">
                                <div class="bar" id="setAmtBar"></div>
                            </div>
                            <div class="won" id="searchLimit"><span class="blurring2"><span class="mask"></span>1,600,000원</span></div>
                        </dd>
                    </dl>
                </div>
                <div class="myinfo-box3">
                    <p class="desc">인정등급</p>
                    <p class="cost"><span class="blurring"><span class="mask"></span><strong id="searchGrade">15</strong></span>등급</p>
                    <p class="desc">제품가 최소 85% 지원</p>
                </div>
                <div class="myinfo-box4">
                    <p class="name">본인부담율</p>
                    <p class="cost"><span class="blurring"><span class="mask"></span><strong id="searchQlf">15</strong></span>%</p>
                    <p class="desc">월 141만원내에서<br> 요양보호사 신청 가능</p>
                </div>
        	</div>
		</div>

		<div class="careinfo-status recipter_view" style="display:none;">
            <h3 class="careinfo-title">나의 복지용구 현황</h3>
            <div class="status-swiper">
                <div class="swiper">
                    <div class="swiper-wrapper own_view">
                        <div class="swiper-slide swiper-item1">
                            <strong>성인용 보행기</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finwalkerForAdults"><span class="blurring"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buywalkerForAdults" ><span class="blurring2"><span class="mask"></span>${apiVO.walkerForAdults}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item2">
                            <strong>수동휠체어</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finwheelchair"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buywheelchair"><span class="blurring2"><span class="mask"></span>${apiVO.wheelchair}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item3">
                            <strong>지팡이</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="fincane"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buycane"><span class="blurring2"><span class="mask"></span>${apiVO.cane}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item4">
                            <strong>안전손잡이</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finsafetyHandle"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buysafetyHandle"><span class="blurring2"><span class="mask"></span>${apiVO.safetyHandle}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item5">
                            <strong>미끄럼방지 용품</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finantiSlipProduct"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buyantiSlipProduct"><span class="blurring2"><span class="mask"></span>${apiVO.antiSlipProduct}</span></dd>
                            </dl>
                        </div>
                        <!-- <div class="swiper-slide swiper-item6">
                            <strong>미끄럼방지 양말</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd>1</dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd>0</dd>
                            </dl>
                        </div> -->
                        <div class="swiper-slide swiper-item7">
                            <strong>욕창예방 매트리스</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finmattress"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buymattress"><span class="blurring2"><span class="mask"></span>${apiVO.mattress}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item8">
                            <strong>욕창예방 방석</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="fincushion"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buycushion"><span class="blurring2"><span class="mask"></span>${apiVO.cushion}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item9">
                            <strong>자세변환용구</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finchangeTool"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buychangeTool"><span class="blurring2"><span class="mask"></span>${apiVO.changeTool}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item10">
                            <strong>요실금 팬티</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finpanties"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buypanties"><span class="blurring2"><span class="mask"></span>${apiVO.panties}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item11">
                            <strong>목욕의자</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finbathChair"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buybathChair"><span class="blurring2"><span class="mask"></span>${apiVO.bathChair}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item12">
                            <strong>이동변기</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finmobileToilet"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buymobileToilet"><span class="blurring2"><span class="mask"></span>${apiVO.mobileToilet}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item13">
                            <strong>간이변기</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finportableToilet"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buyportableToilet"><span class="blurring2"><span class="mask"></span>${apiVO.portableToilet}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item15">
                            <strong>경사로(실외용)</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finoutRunway"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buyoutRunway"><span class="blurring2"><span class="mask"></span>${apiVO.outRunway}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item14">
                            <strong>경사로(실내용)</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="fininRunway"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buyinRunway"><span class="blurring2"><span class="mask"></span>${apiVO.inRunway}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item16">
                            <strong>전동침대</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finelectricBed"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buyelectricBed"><span class="blurring2"><span class="mask"></span>${apiVO.electricBed}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item17">
                            <strong>수동침대</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finmanualBed"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buymanualBed"><span class="blurring2"><span class="mask"></span>${apiVO.manualBed}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item18">
                            <strong>이동욕조</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finbathtub"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buybathtub"><span class="blurring2"><span class="mask"></span>${apiVO.bathtub}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item19">
                            <strong>목욕리프트</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="finbathLift"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buybathLift"><span class="blurring2"><span class="mask"></span>${apiVO.bathLift}</span></dd>
                            </dl>
                        </div>
                        <div class="swiper-slide swiper-item20">
                            <strong>배회감지기</strong>
                            <i></i>
                            <dl>
                                <dt>계약완료</dt>
                                <dd class="findetector"><span class="blurring2"><span class="mask"></span>0</span></dd>
                            </dl>
                            <dl>
                                <dt>구매예상</dt>
                                <dd class="buydetector"><span class="blurring2"><span class="mask"></span>${apiVO.detector}</span></dd>
                            </dl>
                        </div>
                    </div>
                </div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>

            <div class="collapse" id="collapse-agree1">
                <h4 class="status-title">복지용구 상세 현황</h4>
                <table class="status-table">
                    <caption class="hidden">복지용구 품목명, 계약완료상태, 구매예상 표입니다</caption>
                    <colgroup>
                        <col class="min-w-10 w-[15%]">
                        <col>
                        <col class="min-w-16 w-1/5">
                        <col class="min-w-16 w-1/5">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">No</th>
                            <th scope="col">품목명</th>
                            <th scope="col">계약완료</th>
                            <th scope="col">구매예상</th>
                        </tr>
                    </thead>
                    <tbody class="sale_return">
                    </tbody>
                </table>

                <h4 class="status-title">대여 복지용구 상세 현황</h4>
                <table class="status-table">
                    <caption class="hidden">대여 복지용구 품목명, 계약완료상태, 구매예상 표입니다</caption>
                    <colgroup>
                        <col class="min-w-10 w-[15%]">
                        <col>
                        <col class="min-w-16 w-1/5">
                        <col class="min-w-16 w-1/5">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col">No</th>
                            <th scope="col">품목명</th>
                            <th scope="col">계약완료</th>
                            <th scope="col">구매예상</th>
                        </tr>
                    </thead>
                    <tbody  class="lend_return">
                    </tbody>
                </table>
                <div style="text-align: center; margin-top: 5px;">※ 위 내용은 데이터 조회 시점에 따라 <strong style="text-decoration: underline;">실제와 다를 수 있으니 참고용</strong>으로만 사용해주세요.</div>
            </div>

            <button type="button" class="btn status-toggle" data-bs-target="#collapse-agree1" data-bs-toggle="collapse" aria-expanded="false">상세열기</button>
        </div>
		
		
		<c:choose>
			<c:when test="${recipientVO.recipientsYn != null && recipientVO.recipientsYn == 'Y'}">
				<div class="card-bg-gray searchRecipterInfo">
		            <img src="/html/page/members/assets/images/img-medical-care.svg" class="w-12" alt="요양정보 표현이미지"/>
		            <p class="text-gray6">올해 사용한 장기요양금액과 남은 장기요양금액을 확인하세요</p>
		            <p class="text-gray5 text-xs">최근 조회 일시: <span id="refleshDate"><fmt:formatDate value="${refleshDate}" pattern="yyyy년 MM월 dd일 HH:mm:ss" /></span></p>
		            <a class="btn-outline-secondary btn-arrow mt-8" onclick="getRecipterInfo();">
		                요양정보 상세보기
		                <i class="icon-next ml-3"></i>
		            </a>
		        </div>
			</c:when>
			<c:otherwise>
				<div class="card-bg-gray searchRecipterInfo">
					<i class="icon-alert size-md opacity-60"></i>
					<p class="text-gray6">요양인정번호를 등록하면 확인할 수 있어요</p>
					<a href="#" class="btn btn-white mt-8">
						<strong class="text-blue3 underline">기본 정보 > 수정하기</strong>에서 등록할 수 있어요
						<i class="icon-next ml-3"></i>
					</a>
				</div>
			</c:otherwise>
		</c:choose>
		
		
		<div class="flex justify-between mt-8">
			<h3 class="careinfo-title mb-2">인정등급 예상 테스트</h3>
			<a class="btn-success btn-small" onclick="requestConslt('test');">상담하기</a>
		</div>
		
		<c:choose>
			<c:when test="${testVO != null}">
				<div class="card-bg-gray">
					<img src="/html/page/members/assets/images/img-expected-test.png" class="w-80" alt="인정등급예상테스트결과 표현이미지"/>
					<p class="text-gray6">진행하신 인정등급 예상 테스트 결과를 확인하세요</p>
					<p class="text-gray5 text-xs">최근 테스트 일시 :<span><fmt:formatDate value="${testVO.mdfcnDt != null ? testVO.mdfcnDt : testVO.regDt}" pattern="yyyy년 MM월 dd일 HH:mm:ss" /></span></p>
					<a href="#" class="btn-outline-secondary mt-8"  data-bs-toggle="modal" data-bs-target="#grade-test-result">
						결과 상세보기
						<i class="icon-next ml-3"></i>
					</a>
				</div>
			</c:when>
			<c:otherwise>
				<div class="card-bg-gray">
					<i class="icon-alert size-md opacity-60"></i>
					<p class="text-gray6">인정등급 예상 테스트를 하면 확인할 수 있어요</p>
					<a href="/main/cntnts/test" class="btn-outline-secondary mt-8">
						인정등급 예상 테스트 바로가기
						<i class="icon-next ml-3"></i>
					</a>
				</div>				
			</c:otherwise>
		</c:choose>
		
		<div class="text-center my-20">
			<a href="수급자관리.html"  class="btn-primary btn-large w-1/3">목록</a>
		</div>
	</div>


	<jsp:include page="./recipient_info_modal.jsp" />
	

	<!--모달: 인정등급 예상 테스트 결과보기 -->
	<div class="modal modal-scrolled  fade" id="grade-test-result" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered  modal-dialog-scrollable modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="text-title">결과 상세보기</h2>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
				</div>
				<div class="modal-body">
					<iframe  src="/test/result.html?recipientsNo=${recipientsNo}" onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
				</div>
			</div>
		</div>
	</div>
</main>



    <script>
    
	    //숫자형 날짜 하이폰 삽입
	    function f_hiponFormat(value){
	    	var yyyy = value.substring(0,4);
	    	var mm = value.substring(4,6);
	    	var dd = value.substring(6,8);
	
	    	return yyyy+'-'+mm+'-'+dd;
	    }
	
	    //콤마 찍기 : ###,###
	    function comma(num){
	        var len, point, str;
	        str = "0";
	    	if(num != ''){
	    	    num = num + "";
	    	    point = num.length % 3 ;
	    	    len = num.length;
	
	    	    str = num.substring(0, point);
	    	    while (point < len) {
	    	        if (str != "") str += ",";
	    	        str += num.substring(point, point + 3);
	    	        point += 3;
	    	    }
	        }
	        return str;
	    }
	
	    //숫자형 날짜 -> yyyy-MM-dd
	    function f_dateFormat(value){
	    	var date = new Date(value);
	
	    	var yyyy = date.getFullYear();
	    	var mm = date.getMonth() + 1;
	    	mm = mm >= 10 ? mm : '0' + mm;
	    	var dd = date.getDate();
	    	dd = dd >= 10? dd: '0' + dd;
	    	return yyyy+'-'+mm+'-'+dd;
	    }
	
	    function f_replaceLink (str){
	    	let link = 0;
	
	    	switch(str){
	    	case "walkerForAdults":
	    		link = 1;
	    		break;
	    	case "wheelchair":
	    		link = 2;
	    		break;
	    	case "cane":
	    		link = 3;
	    		break;
	    	case "safetyHandle":
	    		link = 4;
	    		break;
	    	case "antiSlipProduct":
	    		link = 5;
	    		break;
	    	case "antiSlipProduct":
	    		link = 6;
	    		break;
	    	case "mattress":
	    		link = 7;
	    		break;
	    	case "cushion":
	    		link = 8;
	    		break;
	    	case "changeTool":
	    		link = 9;
	    		break;
	    	case "panties":
	    		link = 10;
	    		break;
	    	case "bathChair":
	    		link = 11;
	    		break;
	    	case "mobileToilet":
	    		link = 12;
	    		break;
	    	case "portableToilet":
	    		link = 13;
	    		break;
	    	case "outRunway":
	    		link = 14;
	    		break;
	    	case "inRunway":
	    		link = 14;
	    		break;
	    	default:
	    		link = 0;
	    		break;
	    	}
	
	
	    	return link;
	    }
	
	    function f_onlyNumber (str){
	    	let regExp = /[^0-9]/g;
	    	let regExp2 = /[a-zA-z]/g;
	    	str = str.replace(regExp, "").replace(regExp2,"");
	    	return str;
	    }
    
	  	//수급자 정보 조회
	    function getRecipterInfo(){
	    	$(".careinfo-mask").removeClass("is-active");
	    	$("#collapse-agree1").removeClass("show");
	    	const name = '${recipientsNm}';
	    	const no = '${rcperRcognNo}';
	
	    	if (name == '') {
	    		alert("로그인 이후 조회가 가능합니다.");
	    		return;
	    	}
	    	
	    	if(no == '' ){
	    		alert("요양인정번호는 필수 입력 항목입니다.");
	    		return;
	    	}
	    	
	    	$.ajax({
	    		type : "post",
	    		url  : "/common/recipter/getRecipterInfo.json",
	    		data : {
	    			mbrNm : name
	    			, rcperRcognNo : no
	    		},
	    		dataType : 'json'
	    	})
	    	.done(function(json) {
	    		if(!json.isSearch) {
	    			alert(json.msg);
	    			return;
	    		}
	    		
	    		if(json.result){
	    			//갱신일 입력
	    			//$(refleshDate).text(json.refleshDate);
	    			
	    			let usePercent = 0;
	    			let setPercent = 100;
	    			if(Number(json.infoMap.USE_AMT) != 0){
	    				let total = Number(json.infoMap.LMT_AMT);
	    				let use = Number(json.infoMap.USE_AMT);
	    				usePercent = ((use / total) * 100);
	    				setPercent = (((total-use) / total) * 100);
	    			}
	
	    			let penPayRate = json.infoMap.REDUCE_NM == '일반' ? '15': json.infoMap.REDUCE_NM == '기초' ? '0' : json.infoMap.REDUCE_NM == '의료급여' ? '6': (json.infoMap.SBA_CD.split('(')[1].substr(0, json.infoMap.SBA_CD.split('(')[1].length-1).replaceAll("%",""));
	    			$("#searchQlf").text(penPayRate);
	
	    			$(".searchNm").text(name);
	    			$(".searchNo").text("L"+no);
	    			$("#searchGrade").text(json.infoMap.LTC_RCGT_GRADE_CD);
	    			$("#searchRcgt").html(json.infoMap.RCGT_EDA_DT);
	    			$("#searchBgngApdt").html(f_hiponFormat((json.infoMap.APDT_FR_DT)) + " ~ " + f_hiponFormat((json.infoMap.APDT_TO_DT)));
	    			//$("#searchEndApdt").html("~ " + f_hiponFormat((json.infoMap.APDT_TO_DT)));
	    			$("#searchRemn").text(comma(json.infoMap.LMT_AMT - json.infoMap.USE_AMT));
	    			$("#searchUseAmt").html(comma(json.infoMap.USE_AMT) + ' <span class="won">원</span>');
	    			$("#searchLimit").text(comma(json.infoMap.LMT_AMT)+"원");
	
	
	
	    			$("#useAmtBar").attr("style", 'width: '+usePercent+'%');
	    			$("#setAmtBar").attr("style", 'width: '+setPercent+'%');
	
	    			let allList = new Array();
	
	    			let saleList = new Array();
	    			let saleNonList = new Array();
	    			let lendList = new Array();
	    			let lendNonList = new Array();
	
	    			let ownSaleList = new Array();
	    			let ownLendList = new Array();
	
	    			if(json.infoMap.saleList != '' && json.infoMap.saleList != null){
	    				saleList = json.infoMap.saleList
	    			}
	    			if(json.infoMap.saleNonList != '' && json.infoMap.saleNonList != null){
	    				saleNonList = json.infoMap.saleNonList
	    			}
	    			if(json.infoMap.lendList != '' && json.infoMap.lendList != null){
	    				lendList = json.infoMap.lendList
	    			}
	    			if(json.infoMap.lendNonList != '' && json.infoMap.lendNonList != null){
	    				lendNonList = json.infoMap.lendNonList
	    			}
	    			if(json.infoMap.ownSaleList != '' && json.infoMap.ownSaleList != null){
	    				ownSaleList = json.infoMap.ownSaleList
	    			}
	    			if(json.infoMap.ownLendList != '' && json.infoMap.ownLendList != null){
	    				ownLendList = json.infoMap.ownLendList
	    			}
	    			if(json.infoMap.allList != '' && json.infoMap.allList != null){
	    				allList = json.infoMap.allList;
	    			}
	
	    			// 고유 보유 개수
	    			let apiMap = new Map();
	
	    			let vo = "${apiVO}";
	    			vo = vo.replaceAll("TilkoApiVO(","").replaceAll(")","").replaceAll(" ","").split(",");
	
	    			for(let v=0; v<vo.length; v++){
	    				let obj = vo[v].split("=");
	    				apiMap.set(obj[0],obj[1]);
	    			}
	
	    			// 전체 고유 개수
	    			if(allList.length > 0){
	    				for(let i=0; i<allList.length; i++){
	    					$(".fin"+allList[i]).text(0);
	    					$(".buy"+allList[i]).text(apiMap.get(allList[i]));
	    				}
	    			}
	
	    			let CodeMap = new Map();
	    			let code = "${apiCode}";
	    			code = code.replaceAll("{","").replaceAll("}","").replaceAll(" ","").split(",");
	
	    			for(let v=0; v<code.length; v++){
	    				let str = code[v];
	    				str = str.split("=");
	    				CodeMap.set(str[1], str[0]);
	    			}
	
	    			// 판매 급여 품목
	    			$(".sale_return").empty();
	    			if(saleList.length > 0){
	    				for(let i=0; i<saleList.length; i++){
	    					let uniqueCnt = Number($(".own_view .buy"+saleList[i]).text());
	    					let html = "";
	    					html +='   <tr>';
	    					html +='    <td class="sale_index">'+(i+1)+'</td>';
	    					html +=' <td class="subject"><a href="${_mainPath}/cntnts/page3-checkpoint#check-cont'+f_replaceLink(saleList[i])+'" target=_blank>'+CodeMap.get(saleList[i])+'</a></td>';
	    					html +=' <td class="fin'+saleList[i]+'">0</td>';
	    					html +='<td class="buy'+saleList[i]+'">'+uniqueCnt+'</td>';
	    					html +='</tr>';
	    					$(".sale_return").append(html);
	    				}
	
	    				for(let i=0; i<saleNonList.length; i++){
	    					let html = "";
	    					html +='   <tr>';
	    					html +='    <td class="sale_index">'+($(".sale_index").length+1)+'</td>';
	    					html +=' <td class="subject"><a href="${_mainPath}/cntnts/page3-checkpoint#check-cont'+f_replaceLink(saleNonList[i])+'" target=_blank>'+CodeMap.get(saleNonList[i])+'(판매 불가)</a></td>';
	    					html +=' <td class="fin'+saleNonList[i]+'">해당없음</td>';
	    					html +='<td class="buy'+saleNonList[i]+'">해당없음</td>';
	    					html +='</tr>';
	    					$(".sale_return").append(html);
	    					$("dd.buy"+saleNonList[i]).text(0);
	    					$("dd.fin"+saleNonList[i]).text(0);
	    				}
	    			}else{
	    				let html = "";
	    				html +='   <tr>';
	    				html +='    <td colspan="4">검색된 데이터가 없습니다.</td>';
	    				html +='</tr>';
	    				$(".sale_return").append(html);
	    			}
	
	
	
	    			// 대여 급여 품목
	    			$(".lend_return").empty();
	    			if(lendList.length > 0){
	    				for(let i=0; i<lendList.length; i++){
	    					let uniqueCnt = Number($(".own_view .buy"+lendList[i]).text());
	    					let html = "";
	    					html +='   <tr>';
	    					html +='    <td class="lend_index">'+($(".lend_index").length+1)+'</td>';
	    					if(f_replaceLink(lendList[i]) == 0){
	    						html +=' <td class="subject">'+CodeMap.get(lendList[i])+'</td>';
	    					}else{
	    						html +=' <td class="subject"><a href="${_mainPath}/cntnts/page3-checkpoint#check-cont'+f_replaceLink(lendList[i])+'" target=_blank>'+CodeMap.get(lendList[i])+'</a></td>';
	    					}
	
	
	    					html +=' <td class="fin'+lendList[i]+'">0</td>';
	    					html +='<td class="buy'+lendList[i]+'">'+uniqueCnt+'</td>';
	    					html +='</tr>';
	    					$(".lend_return").append(html);
	    				}
	    				for(let i=0; i<lendNonList.length; i++){
	    					let html = "";
	    					html +='   <tr>';
	    					html +='    <td class="lend_index">'+(i+1)+'</td>';
	    					if(f_replaceLink(lendNonList[i]) == 0){
	    						html +=' <td class="subject">'+CodeMap.get(lendNonList[i])+'(대여 불가)</td>';
	    					}else{
	    						html +=' <td class="subject"><a href="${_mainPath}/cntnts/page3-checkpoint#check-cont'+f_replaceLink(lendNonList[i])+'" target=_blank>'+CodeMap.get(lendNonList[i])+'(대여 불가)</a></td>';
	    					}
	
	    					html +=' <td class="fin'+lendNonList[i]+'">해당없음</td>';
	    					html +='<td class="buy'+lendNonList[i]+'">해당없음</td>';
	    					html +='</tr>';
	    					$(".lend_return").append(html);
	    					$("dd.buy"+lendNonList[i]).text(0);
	    					$("dd.fin"+lendNonList[i]).text(0);
	    				}
	    			}else{
	    				let html = "";
	    				html +='   <tr>';
	    				html +='    <td colspan="4">검색된 데이터가 없습니다.</td>';
	    				html +='   </tr>';
	    				$(".lend_return").append(html);
	    			}
	
	
	    			// 보유 현황 카운트 - 판매
	    			if(ownSaleList.length > 0){
	    				for(let i=0; i<ownSaleList.length; i++){
	    					let finCnt = 0;
	    					let buyCnt = 0;
	
	    					if($(".sale_return .fin"+ownSaleList[i]).text() != '해당없음'){
	    						finCnt = Number($(".sale_return .fin"+ownSaleList[i]).text());
	    						buyCnt = Number($(".own_view .buy"+ownSaleList[i]).text());
	    						$(".fin"+ownSaleList[i]).text(finCnt+1);
	    					}else{
	    						$(".fin"+ownSaleList[i]).text(1);
	    					}
	
	    					if(buyCnt > 0){
	    						$(".buy"+ownSaleList[i]).text(buyCnt-1);
	    					}else{
	    						$(".buy"+ownSaleList[i]).text(0);
	    					}
	    				}
	    			}
	
	    			// 보유 현황 카운트 - 대여
	    			if(ownLendList.length > 0){
	    				for(let i=0; i<ownLendList.length; i++){
	    					let finCnt = 0;
	    					let buyCnt = 0;
	
	    					if($(".lend_return .fin"+ownLendList[i]).text() != '해당없음'){
	    						finCnt = Number($(".lend_return .fin"+ownLendList[i]).text());
	    						buyCnt = Number($("own_view .buy"+ownLendList[i]).text());
	    						$(".fin"+ownLendList[i]).text(finCnt + 1);
	    					}else{
	    						$(".fin"+ownLendList[i]).text(1);
	    					}
	
	    					if(buyCnt > 0){
	    						$(".buy"+ownLendList[i]).text(buyCnt -1);
	    					}else{
	    						$(".buy"+ownLendList[i]).text(0);
	    					}
	    				}
	    			}
	                $('.careinfo-mask').addClass('is-active');
	                
	                
	                //결과창 보여주기
	                $('.careinfo-myinfo').css('display', 'block');
	                $('.careinfo-status').css('display', 'block');
	                
	                //조회버튼 숨기기
	                $('.searchRecipterInfo').css('display', 'none');
	    		}else{
	    			alert("조회된 데이터가 없습니다.");
	    		}
	    	})
	    	.fail(function(data, status, err) {
	    		console.log('error forward : ' + data);
	    	});
	    }
    
	  	
	  	//수급자 정보 수정 클릭
	    function clickStartConsltBtn() {
			var recipientsNo = '${recipientsNo}'
			openModal('updateRecipient', Number(recipientsNo));
	    }
	  	
	  	//상담하기 버튼 클릭
	  	function requestConslt(prevPath) {
	  		var recipientsNo = '${recipientsNo}'
			openModal('requestConslt', Number(recipientsNo), prevPath);
	  	}
	  	
	  	
	    $(function() {
	    	
			var swiper = new Swiper(".swiper", {
				slidesPerView : 'auto',
				spaceBetween : 10,
				navigation: {
					nextEl: ".swiper-button-next",
					prevEl: ".swiper-button-prev",
				},
				breakpoints: {
					spaceBetween : 12,
				},
			});
			
			$('.status-toggle').on('click', function() {
				$(this).toggleClass('is-active').prev('.status-list').toggleClass('hidden');
			})
		})
    </script>
