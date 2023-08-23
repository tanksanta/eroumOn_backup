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
							<div class="bubble" style="width: 59%;">
								<div class="text">
									<img src="/html/page/test/assets/images/ico-steps5.svg" alt="" />
									<span class="font-bold">0/10</span>
								</div>
							</div>
						</div>
						<div class="percent">59%</div>
					</div>
				</div>
			</div>

			<div id="container">
				<form class="check-page5">
					<div class="check-title">
						<small>Check List</small>
						<h2>재활</h2>
						<img src="/html/page/test/assets/images/ico-check-item5.png" alt="" />
						<p>
							각 관절의 움직임과, 전체적인 팔, 다리의
							<br />
							운동 능력을 확인하는 단계 입니다.
						</p>
					</div>

					<div class="check-desc">
						<u>현재</u> 신청인의 각 부분의 움직임의 제한 여부를 보시고 <strong>하나씩 질문에 답해 보세요.</strong>
					</div>


					<!-- 테스트 문항 -->
					<h3 class="check-title3 mt-5 xs:mt-6.5">운동장애 정도</h3>
					<div>
						<h4 class="check-title2 is-icon">
							<img src="/images/img-check-treat1.svg" alt="" />
							<p><strong>오른쪽 상지(손, 팔, 어깨)</strong>가 의지대로 움직이시나요?</p>
						</h4>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="rehablilitate1"/>
								<span>운동장애 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate1"/>
								<span>불완전 운동장애</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate1"/>
								<span>완전 운동장애</span>
							</label>
						</div>
					</div>
					<div>
						<h4 class="check-title2 is-icon">
							<img src="/images/img-check-treat2.svg" alt="" />
							<p><strong>오른쪽 하지(발, 다리)</strong>가 의지대로 움직이시나요?</p>
						</h4>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="rehablilitate2"/>
								<span>운동장애 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate2"/>
								<span>불완전 운동장애</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate2"/>
								<span>완전 운동장애</span>
							</label>
						</div>
					</div>
					<div>
						<h4 class="check-title2 is-icon">
							<img src="/images/img-check-treat3.svg" alt="" />
							<p><strong>왼쪽 상지(손, 팔, 어깨)</strong>가 의지대로 움직이시나요?</p>
						</h4>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="rehablilitate3"/>
								<span>운동장애 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate3"/>
								<span>불완전 운동장애</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate3"/>
								<span>완전 운동장애</span>
							</label>
						</div>
					</div>
					<div>
						<h4 class="check-title2 is-icon">
							<img src="/images/img-check-treat4.svg" alt="" />
							<p><strong>왼쪽 하지(발, 다리)</strong>가 의지대로 움직이시나요?</p>
						</h4>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="rehablilitate4"/>
								<span>운동장애 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate4"/>
								<span>불완전 운동장애</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate4"/>
								<span>완전 운동장애</span>
							</label>
						</div>
					</div>
					
					<h3 class="check-title3 mt-21 xs:mt-26">운동제한 정도</h3>
					<div>
						<h4 class="check-title2">
							<strong>어깨관절</strong>이 자유롭게 움직이시나요?
						</h4>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="rehablilitate5"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate5"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate5"/>
								<span>양쪽관절 제한</span>
							</label>
						</div>
					</div>
					<div>
						<h4 class="check-title2">
							<strong>팔꿈치관절</strong>이 자유롭게 움직이시나요?
						</h4>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="rehablilitate6"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate6"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate6"/>
								<span>양쪽관절 제한</span>
							</label>
						</div>
					</div>
					<div>
						<h4 class="check-title2">
							<strong>손목 및 손관절</strong>이 자유롭게 움직이시나요?
						</h4>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="rehablilitate7"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate7"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate7"/>
								<span>양쪽관절 제한</span>
							</label>
						</div>
					</div>
					<div>
						<h4 class="check-title2">
							<strong>고관절(엉덩이관절)</strong>이 자유롭게 움직이시나요?
						</h4>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="rehablilitate8"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate8"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate8"/>
								<span>양쪽관절 제한</span>
							</label>
						</div>
					</div>
					<div>
						<h4 class="check-title2">
							<strong>무릎관절</strong>이 자유롭게 움직이시나요?
						</h4>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="rehablilitate9"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate9"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate9"/>
								<span>양쪽관절 제한</span>
							</label>
						</div>
					</div>
					<div>
						<h4 class="check-title2">
							<strong>발목관절</strong>이 자유롭게 움직이시나요?
						</h4>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="rehablilitate10"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate10"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehablilitate10"/>
								<span>양쪽관절 제한</span>
							</label>
						</div>
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