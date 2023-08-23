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
							<div class="bubble" style="width: 96%;">
								<div class="text">
									<img src="/html/page/test/assets/images/ico-steps6.svg" alt="" />
									<span class="font-bold">0/2</span>
								</div>
							</div>
						</div>
						<div class="percent">96%</div>
					</div>
				</div>
			</div>

			<div id="container">
				<form class="check-page6">
					<div class="check-title">
						<small>Check List</small>
						<h2>질병</h2>
						<img src="/html/page/test/assets/images/ico-check-item6.png" alt="" />
						<p>
							어르신이 앓고 있으신 질병이나 증상에 대해 묻는 항목 입니다.
							<br />
							<strong>등급을 산정하는데 직접적인 영향을 주지는 않지만</strong>, 의사의 진단서와 함께 현재 어르신의 기능상태 저하를 뒷받침 하는 근거가 됩니다.
							<br />
							특히 치매의 경우에는 높은 등급을 받는데 참고가 될 수 있습니다.
						</p>
					</div>

					<div class="check-desc">
						<u>현재</u> 앓고 있는 <strong>질병 또는 증상을 모두 선택</strong>해 주세요.
					</div>

					<!-- 테스트 문항 -->
					<div class="check-items">
						<label class="check-item">
							<input type="checkbox" name="disease1-1"/>
							<span>치매</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-2"/>
							<span>중풍(뇌졸증)</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-3"/>
							<span>고혈압</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-4"/>
							<span>당뇨병</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-5"/>
							<span>관절염(퇴행성, 류마티스)</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-6"/>
							<span>요통, 좌골통(디스크)</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-7"/>
							<span>심부전, 폐질환, 천식 등</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-8"/>
							<span>난청</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-9"/>
							<span>백내장, 녹내장</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-10"/>
							<span>골절, 탈골, 사고 후유증</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-11"/>
							<span>암</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-12"/>
							<span>신부전</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease1-13"/>
							<span>욕창</span>
						</label>
					</div>
					<!-- 테스트 문항 끝 -->

					<div class="check-desc">
						<u>위에 선택한 질병 중</u>,<br />
						어르신의 현재 기능저하에 <strong>가장 직접적이고 중요한 원인이 되고 비중이 높은 항목</strong> 하나를 선택 하세요.
					</div>
					
					<!-- 테스트 문항 -->
					<div class="check-items">
						<label class="check-item">
							<input type="checkbox" name="disease2-1"/>
							<span>치매</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-2"/>
							<span>중풍(뇌졸증)</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-3"/>
							<span>고혈압</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-4"/>
							<span>당뇨병</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-5"/>
							<span>관절염(퇴행성, 류마티스)</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-6"/>
							<span>요통, 좌골통(디스크)</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-7"/>
							<span>심부전, 폐질환, 천식 등</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-8"/>
							<span>난청</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-9"/>
							<span>백내장, 녹내장</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-10"/>
							<span>골절, 탈골, 사고 후유증</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-11"/>
							<span>암</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-12"/>
							<span>신부전</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="disease2-13"/>
							<span>욕창</span>
						</label>
					</div>
					<!-- 테스트 문항 끝 -->

					<div class="check-button">
						<div class="btn">뒤로가기</div>
						<div class="btn btn-primary">결과 보기</div>
					</div>
				</form>
			</div>
		</section>
	</main>