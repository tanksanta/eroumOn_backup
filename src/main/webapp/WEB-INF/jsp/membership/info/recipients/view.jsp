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
					<a href="#" class="text-blue3 text-sm" data-bs-toggle="modal" data-bs-target="#pop-client-edit">수정하기<i class="icon-plus icon-blue3"></i></a>
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
								<td>부모</td>
							</tr>
							<tr>
								<th scope="row">수급자 성명</th>
								<td>김영자</td>
							</tr>
							<tr>
								<th scope="row">요양인정번호</th>
								<td>L1234567890</td>
							</tr>
							<tr>
								<th scope="row">상담받을 연락처</th>
								<td>010-1234-5678</td>
							</tr>
							<tr>
								<th scope="row">실거주지 주소</th>
								<td>서울특별시 금천구 가산동</td>
							</tr>
							<tr>
								<th scope="row">생년월일</th>
								<td>2023.07.28</td>
							</tr>
							<tr>
								<th scope="row">성별</th>
								<td>여성</td>
							</tr>
							<tr>
								<th scope="row">최근등록(수정)일시</th>
								<td>20230926 11:12:33</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="mypage-client-detail-item">
				<h4 class="mypage-client-detail-item-title">
					<strong class="text-xl">상담 내역</strong>
					<a href="#" class="text-sm">지난 상담 내역 보기<i class="icon-arrow-right"></i></a>
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
								<td>김영자</td>
							</tr>
							<tr>
								<th scope="row">상담 유형</th>
								<td>인정등급상담</td>
							</tr>
							<tr>
								<th scope="row">진행 현황</th>
								<td>상담 완료</td>
							</tr>
							<tr>
								<th scope="row">장기요양기관</th>
								<td>
									<strong>이로움 사업소</strong>
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
								</td>
							</tr>
							<tr>
								<th scope="row">상담 신청일</th>
								<td>2023.09.22</td>
							</tr>
							<tr>
								<th scope="row">상담 완료일</th>
								<td>2023.09-25</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>

		<div class="careinfo-myinfo mypage">
			<div class="flex-none mb-2 md:flex md:justify-between gap-2">
				<h3 class="careinfo-title mb-0"><span class="blurring"><span class="mask"></span>이로미(L123456789)</span> 님의 요양정보</h3>
				
				<!-- 다시 조회하기 버튼 숨김처리 -->
				<!-- 
				<div class="flex gap-2 justify-end items-center">
					<span class="text-sm text-black2/50">2023년 10월 04일 11:11:11</span>
					<a class="btn btn-secondary btn-small">다시 조회하기 <i class="icon-refresh ml-1"></i></a>
					<a href="#" class="btn-success btn-small" data-bs-toggle="modal" data-bs-target="#pop-consulting-test">상담하기</a>
				</div>
				 -->
			</div>
			<div class="myinfo-wrapper">
				<div class="myinfo-box1">
					<p class="name"><span class="blurring">이로미님</span> <a href="#">정보수정</a></p>
					<dl class="numb">
						<dt class="desc">요양인정번호</dt>
						<dd><span class="blurring">L123456789</span></dd>
					</dl>
					<dl class="date">
						<dt class="desc">인정 유효기간</dt>
						<dd><span class="blurring">2023년 1월 1일<br> ~ 2023년 12월 31일</span></dd>
					</dl>
				</div>
				<div class="myinfo-box2">
					<p class="desc">잔여급여</p>
					<p class="cost"><span class="blurring"><strong>1,250,000</strong>원</span></p>
					<dl class="used1">
						<dt class="desc">사용</dt>
						<dd class="percent">
							<div class="track">
								<div class="bar" style="width: 25%;"></div>
							</div>
							<div class="won"><span class="blurring">350,000원</span></div>
						</dd>
					</dl>
					<dl class="used2">
						<dt class="desc">총 급여</dt>
						<dd class="percent">
							<div class="track">
								<div class="bar" style="width: 75%;"></div>
							</div>
							<div class="won"><span class="blurring">1,600,000원</span></div>
						</dd>
					</dl>
				</div>
				<div class="myinfo-box3">
					<p class="desc">인정등급</p>
					<p class="cost"><span class="blurring"><strong>15</strong>등급</span></p>
					<p class="desc">제품가 최소 85% 지원</p>
				</div>
				<div class="myinfo-box4">
					<p class="name">본인부담율</p>
					<p class="cost"><span class="blurring"><strong>15</strong>%</span></p>
					<p class="desc">월 141만원내에서<br> 요양보호사 신청 가능</p>
				</div>
			</div>
		</div>

		<div class="careinfo-status mypage">
			<h3 class="careinfo-title">나의 복지용구 현황</h3>
			<div class="status-swiper">
				<div class="swiper">
					<div class="swiper-wrapper">
						<div class="swiper-slide swiper-item1">
							<strong>성인용 보행기</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item2">
							<strong>수동휠체어</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item3">
							<strong>지팡이</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item4">
							<strong>안전손잡이</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item5">
							<strong>미끄럼방지 매트</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item6">
							<strong>미끄럼방지 양말</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item7">
							<strong>욕창예방 매트리스</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item8">
							<strong>욕창예방 방석</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item9">
							<strong>자세변환용구</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item10">
							<strong>요실금 팬티</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item11">
							<strong>목욕의자</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item12">
							<strong>이동변기</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item13">
							<strong>간이변기</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item14">
							<strong>경사로(실내)</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item15">
							<strong>경사로(실외)</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item16">
							<strong>전동침대</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item17">
							<strong>수동침대</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item18">
							<strong>이동욕조</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item19">
							<strong>목욕리프트</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
							</dl>
						</div>
						<div class="swiper-slide swiper-item20">
							<strong>배회감지기</strong>
							<i></i>
							<dl>
								<dt>계약완료</dt>
								<dd><span class="blurring">1</span></dd>
							</dl>
							<dl>
								<dt>구매예상</dt>
								<dd><span class="blurring">0</span></dd>
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
					<tbody>
						<tr>
							<td>1</td>
							<td class="subject">수동휠체어</td>
							<td>1개</td>
							<td>1개</td>
						</tr>
						<tr>
							<td>1</td>
							<td class="subject">수동휠체어</td>
							<td>1개</td>
							<td>1개</td>
						</tr>
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
					<tbody>
						<tr>
							<td><span class="blurring">1</span></td>
							<td class="subject">수동휠체어</td>
							<td><span class="blurring">1개</span></td>
							<td><span class="blurring">1개</span></td>
						</tr>
						<tr>
							<td><span class="blurring">1</span></td>
							<td class="subject">수동휠체어</td>
							<td><span class="blurring">1개</span></td>
							<td><span class="blurring">1개</span></td>
						</tr>
					</tbody>
				</table>
				<p class="text-center mt-3 text-sm">※ 위 내용은 데이터 조회 시점에 따라 <span class="underline font-bold">실제와 다를 수 있으니 참고용</span>으로만 사용해주세요. </p>
			</div>
			<button type="button" class="btn status-toggle" data-bs-target="#collapse-agree1" data-bs-toggle="collapse" aria-expanded="false">상세열기</button>
		</div>
		
		<!--데이터 없을때-->
		<div class="card-bg-gray">
			<i class="icon-alert size-md opacity-60"></i>
			<p class="text-gray6">요양인정번호를 등록하면 확인할 수 있어요</p>
			<a href="#" class="btn btn-white mt-8">
				<strong class="text-blue3 underline">기본 정보 > 수정하기</strong>에서 등록할 수 있어요
				<i class="icon-next ml-3"></i>
			</a>
		</div>
		
	 	<!--요양정보 조회전 -->
        <div class="card-bg-gray">
            <img src="/html/page/members/assets/images/img-medical-care.svg" class="w-12" alt="요양정보 표현이미지"/>
            <p class="text-gray6">올해 사용한 장기요양금액과 남은 장기요양금액을 확인하세요</p>
            <p class="text-gray5 text-xs">최근 조회 일시: <span>2023년 10월 04일 11:11:11</span></p>
            <a href="#" class="btn-outline-secondary btn-arrow mt-8">
                요양정보 상세보기
                <i class="icon-next ml-3"></i>
            </a>
        </div>

		
		<div class="flex justify-between">
			<h3 class="careinfo-title mb-2">인정등급 예상 테스트</h3>
			<a href="#" class="btn-success btn-small" data-bs-toggle="modal" data-bs-target="#pop-consulting-test">상담하기</a>
		</div>
		
		<div class="card-bg-gray">
			<img src="/html/page/members/assets/images/img-expected-test.png" class="w-80" alt="인정등급예상테스트결과 표현이미지"/>
			<p class="text-gray6">진행하신 인정등급 예상 테스트 결과를 확인하세요</p>
			<p class="text-gray5 text-xs">최근 테스트 일시 :<span>2023년 10월 04일 11:11:11</span></p>
			<a href="#" class="btn-outline-secondary mt-8"  data-bs-toggle="modal" data-bs-target="#grade-test-result">
				결과 상세보기
				<i class="icon-next ml-3"></i>
			</a>
		</div>
		
		<!--데이터 없을때-->
		<div class="card-bg-gray">
			<i class="icon-alert size-md opacity-60"></i>
			<p class="text-gray6">인정등급 예상 테스트를 하면 확인할 수 있어요</p>
			<a href="#" class="btn-outline-secondary mt-8">
				인정등급 예상 테스트 바로가기
				<i class="icon-next ml-3"></i>
			</a>
		</div>

		<div class="text-center my-20">
			<a href="수급자관리.html"  class="btn-primary btn-large w-1/3">목록</a>
		</div>

	</div>


	<!--모달: 수급자 정보 수정 -->
	<div class="modal modal-default fade" id="pop-client-edit" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-lg">
			<div class="modal-content">
			<div class="modal-header">
				<h2 class="text-title">수급자 정보 수정</h2>
				<button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
			</div>
			<div class="modal-body">
				<div class="text-subtitle -mb-2">
					<i class="icon-alert"></i>
					<p>회원이 이용약관에 따라 수급자 등록과 관리하는 것에 동의합니다</p>
				</div>
				<table class="table-detail">
					<caption class="hidden">상담정보확인 위한 수급자와의 관계(필수), 수급자성명(필수), 요양인정번호, 상담받을연락처(필수), 실거주지 주소(필수), 생년월일(필수),성별(필수), 상담유형 입력폼입니다 </caption>
					<colgroup>
						<col class="w-22 xs:w-32">
						<col>
					</colgroup>
					<tbody>
						<tr class="top-border wrapRelation">
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th scope="row">
								<p>
									<label for="recipter">수급자와의 관계<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td>
								<select name="relationSelect" id="relationSelect" class="form-control w-full lg:w-8/12">
									<option value="">선택</option>
									<option value="001" selected>본인</option>
									<option value="002">아버지</option>
									<option value="003">어머니</option>
									<option value="004">시아버지</option>
									<option value="005">시어머니</option>
									<option value="006">배우자</option>
									<option value="007">형제자매</option>
									<option value="100">기타</option>
								</select>
							</td>
						</tr>
						<tr class="wrapNm">
							<th scope="row">
								<p>
									<label for="recipter">수급자 성명<sup class="text-danger text-base md:text-lg">*</sup></label>
								</p>
							</th>
							<td>
								<input type="text" class="form-control w-full  lg:w-8/12" id="recipter" name="testName" maxlength="50" value="홍길동" readonly>
							</td>
						</tr>
						<tr class="wrapNo">
							<th scope="row">
								<p>
									<label for="rcperRcognNo">요양인정번호</label>
								</p>
							</th>
							<td>
								<div class="flex flex-row gap-2.5 mb-1.5">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="yn" id="yes" checked>
										<label class="form-check-label" for="yes">있음</label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="yn" id="no">
										<label class="form-check-label" for="no">없음</label>
									</div>
								</div>
								<div class="form-group w-full flex lg:w-8/12">
									<p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
									<input  type="text" class="form-control " id="rcperRcognNo" name="rcperRcognNo" maxlength="13" value="1234567890" readonly>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">
								<p><label for="search-item6">상담받을 연락처</label></p>
							</th>
							<td><input type="text" class="form-control w-full lg:w-8/12" id="info-tel"></td>
						</tr> 
						<tr>
							<th scope="row">
								<p><label for="search-item6">실거주지 주소<sup class="text-danger text-base md:text-lg">*</sup></label></p>
							</th>
							<td>
								<fieldset class="addr-select">
									<select name="" id="" class="form-control">
										<option value="">시/도</option>
									</select>
									<select name="" id="" class="form-control">
										<option value="">시/군/구</option>
									</select>
									<select name="" id="" class="form-control md:col-span-2 lg:col-span-1">
										<option value="">동/읍/면</option>
									</select>
								</fieldset>
							</td>
						</tr>
						<tr>
							<th scope="row"><p><label for="search-item4">생년월일<sup class="text-danger text-base md:text-lg">*</sup></label></p></th>
							<td><input type="text" class="form-control w-full  lg:w-8/12" id="search-item4"></td>
						</tr>
						<tr>
							<th scope="row"><p><label for="search-item4">성별<sup class="text-danger text-base md:text-lg">*</sup></label></p></th>
							<td>
								<div class="flex flex-row gap-2.5 mb-1.5">
									<div class="form-check">
										<input class="form-check-input" type="radio" name="info-gender" id="info-gender-m" value="M" checked>
										<label class="form-check-label" for="info-gender-m">남성</label>
									</div>
									<div class="form-check">
										<input class="form-check-input" type="radio" name="info-gender" id="info-gender-w" value="W">
										<label class="form-check-label" for="info-gender-w">여성</label>
									</div>
								</div>
							</td>
						</tr>
						<tr class="top-border">
							<td></td>
							<td></td>
						</tr>
					</tbody>
				</table>
				<div class="flex justify-end">
					<button class="btn-text-primary">삭제하기</button>
				</div>
			</div>
			<div class="modal-footer md:w-3/4 mx-auto mt-4">
				<button type="button" class="btn btn-primary large w-3/5" data-bs-toggle="modal" data-bs-target="#pop-consulting-complated">등록하기</button>
				<button type="button" class="btn btn-outline-primary large w-2/5">취소하기</button>
			</div>
			</div>
		</div>
	</div>

	<!--모달: 인정등급 예상 테스트-->
	<div class="modal modal-scrolled  fade" id="grade-test-result" tabindex="-1">
		<div class="modal-dialog modal-dialog-centered  modal-dialog-scrollable modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="text-title">결과 상세보기</h2>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
				</div>
				<div class="modal-body">
					<iframe  src="../../mail/장기용양등급테스트결과_mailFrom_2023908.html" onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
				</div>
			</div>
		</div>
	</div>

	<!--모달: 인정등급 예상 테스트 상담-->
	<div class="modal modal-default fade" id="pop-consulting-test" tabindex="-1" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="text-title">알림</h2>
					<button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
				</div>
				<div class="modal-body">
					<div class="modal-bg-wrap">
					<div class="flex flex-col justify-center items-center">
						<div class="text-center text-xl">
							진행중인 인정등급 상담이 있습니다.<br>
							상담 내역을 확인하시겠습니까?
						</div>
					</div>
					</div>
				</div>
				<div class="modal-footer gap-2">
					<button type="button" class="btn btn-primary large flex-initial w-55">상담내역 확인하기</button>
					<button type="button" class="btn btn-outline-primary large flex-initial w-45" data-bs-dismiss="modal" class="btn-close">새롭게 진행하기</button>
				</div>
			</div>
		</div>
	</div>

</main>



    <script>
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
