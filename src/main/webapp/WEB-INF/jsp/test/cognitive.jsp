<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="simulation" class="mt-0">
		<section class="h-100vh max-h-screen xl:h-screen flex flex-col">
			<div id="header">
				<div class="container">
					<div class="header-title">
						<h1>
							<strong>장기요양 예상등급</strong>
							<small>
								장기요양인정등급 판정 전에
								<br /> 미리 등급을 알아보세요!
							</small>
						</h1>
						<p>TEST</p>
					</div>
					<div class="header-steps">
						<div class="indictor">
							<div class="bubble" style="width: 48%;">
								<div class="text">
									<img src="/html/page/test/assets/images/ico-steps2.svg" alt="" />
									<span class="font-bold">0/1</span>
								</div>
							</div>
						</div>
						<div class="percent">48%</div>
					</div>
				</div>
			</div>
		
			<div id="container">
				<form class="check-page2">
					<div class="check-title">
						<small>Check List</small>
						<h2>인지기능</h2>
						<img src="/html/page/test/assets/images/ico-check-item2.png" alt="" />
						<p>
							초기 치매, 알츠하이머의 진행 여부와도 관련이 있으며
							<br />
							치매로 인한 상황 판단능력을 측정합니다.
						</p>
					</div>
		
					<div class="check-desc">
						<u>최근 한 달간의 상황을 종합</u>하여 아래 항목 중<br />
						<strong>해당하는 모든 증상을 선택</strong>해 주세요.
					</div>
		
					<!-- 테스트 문항 -->
					<div class="check-items">
						<label class="check-item">
							<input type="checkbox" name="cognitive1"/>
							<span>방금 전에 들었던 이야기나 일을 잊는다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="cognitive2"/>
							<span>오늘이 몇 년, 몇 월, 몇 일인지 모른다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="cognitive3"/>
							<span>자신이 있는 장소를 알지 못한다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="cognitive4"/>
							<span>자신의 나이와 생일을 모른다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="cognitive5"/>
							<span>지시를 이해하지 못한다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="cognitive6"/>
							<span>주어진 상황에 대한 판단력이 떨어져 있다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="cognitive7"/>
							<span>의사소통이나 전달에 장애가 있다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="cognitive8" checked/>
							<span>해당하는 증상이 없다.</span>
						</label>
					</div>
					<!-- 테스트 문항 끝 -->
		
					<div class="check-button">
						<div class="btn">뒤로가기</div>
						<div class="btn btn-primary">다음 단계로</div>
					</div>
				</form>
			</div>
		</section>
	</main>