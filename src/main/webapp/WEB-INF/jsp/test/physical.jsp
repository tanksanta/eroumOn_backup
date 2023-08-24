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
							<div class="bubble" style="width: 0%;">
								<div class="text">
									<img src="/html/page/test/assets/images/ico-steps1.svg" alt="" />
									<span class="font-bold">0/12</span>
								</div>
							</div>
						</div>
						<div class="percent">0%</div>
					</div>
				</div>
			</div>
		
			<div id="container">
				<form class="check-page1">
					<div class="check-title">
						<small>Check List</small>
						<h2>신체기능</h2>
						<img src="/html/page/test/assets/images/ico-check-item1.png" alt="" />
						<p>
							일상적인 생활의 유지가 얼마나 가능한지,
							<br />
							타인의 도움이 필요한 수준이 어느 정도인지를
							<br />
							종합적으로 판단하게 됩니다.
						</p>
					</div>
		
					<div class="check-desc">
						<u>최근 한 달간의 상황을 종합</u>하여 일상생활에서 다음과 같은 동작을 할 때 <strong>다른 사람의 도움을 받는 정도를 평가</strong>하여 문항을 선택해
						주세요.
					</div>
		
					<!-- 테스트 문항 -->
					<div>
						<h3 class="check-title2">
							<strong>옷 벗고 입기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical1"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical1"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>세수하기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical2"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical2"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>양치질하기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical3"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical3"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical3"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>목욕하기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical4"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical4"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical4"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>식사하기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical5"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical5"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical5"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>체위 변경하기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical6"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical6"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical6"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>일어나 앉기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical7"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical7"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical7"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>옮겨앉기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical8"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical8"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical8"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>방 밖으로 나오기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical9"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical9"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical9"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>화장실 사용하기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical10"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical10"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical10"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>대변 조절하기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical11"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical11"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical11"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<div>
						<h3 class="check-title2">
							<strong>소변 조절하기</strong>가 가능하십니까?
						</h3>
						<div class="check-items is-radio is-steps">
							<label class="check-item">
								<input type="radio" name="physical12"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical12"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical12"/>
								<span>완전히 도움 필요</span>
							</label>
						</div>
					</div>
					<!-- 테스트 문항 끝 -->
		
					<div class="check-button">
						<div id="back-btn" class="btn">뒤로가기</div>
						<div id="next-btn" class="btn btn-primary">다음 단계로</div>
					</div>
				</form>
			</div>
		</section>
	</main>
	
	<script>
		$(function() {
			//테스트 전체 문항수(12 + 1 + 1 + 1 + 10 + 2)
			const testTotalCount = 27;
			//신체 테스트 문항수
			const physicalCount = 12;
			
			//문항 답변 클릭 이벤트
			$('.check-item input').click(function() {
				const inputName = $(this).attr('name');
				const inputNumber = Number(inputName.replace('physical', ''));
				
				//스크롤 내리기
				if (inputNumber && inputNumber < physicalCount) {
					const curInput = $('input[name=physical' + inputNumber + ']')[1];
					curInput.scrollIntoView();
				}
				
				//진행도 표시
				const checkedCount = $('.check-item input:checked').length;
				const percent = Math.floor((checkedCount / testTotalCount) * 100);
				setPrograssBar(percent, checkedCount);
			});
			
			//뒤로가기 이벤트
			$('#back-btn').click(function() {
				location.href = '/test/index';
			});
			
			//다음 단계 이벤트
			$('#next-btn').click(function() {
				location.href = '/test/cognitive';
			});
		});
	</script>