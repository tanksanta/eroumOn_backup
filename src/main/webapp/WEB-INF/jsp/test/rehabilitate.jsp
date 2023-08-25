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
								<input type="radio" name="rehabilitate1" value="1"/>
								<span>운동장애 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate1" value="2"/>
								<span>불완전 운동장애</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate1" value="3"/>
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
								<input type="radio" name="rehabilitate2" value="1"/>
								<span>운동장애 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate2" value="2"/>
								<span>불완전 운동장애</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate2" value="3"/>
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
								<input type="radio" name="rehabilitate3" value="1"/>
								<span>운동장애 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate3" value="2"/>
								<span>불완전 운동장애</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate3" value="3"/>
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
								<input type="radio" name="rehabilitate4" value="1"/>
								<span>운동장애 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate4" value="2"/>
								<span>불완전 운동장애</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate4" value="3"/>
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
								<input type="radio" name="rehabilitate5" value="1"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate5" value="2"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate5" value="3"/>
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
								<input type="radio" name="rehabilitate6" value="1"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate6" value="2"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate6" value="3"/>
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
								<input type="radio" name="rehabilitate7" value="1"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate7" value="2"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate7" value="3"/>
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
								<input type="radio" name="rehabilitate8" value="1"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate8" value="2"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate8" value="3"/>
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
								<input type="radio" name="rehabilitate9" value="1"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate9" value="2"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate9" value="3"/>
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
								<input type="radio" name="rehabilitate10" value="1"/>
								<span>제한 없음</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate10" value="2"/>
								<span>한쪽관절 제한</span>
							</label>
							<label class="check-item">
								<input type="radio" name="rehabilitate10" value="3"/>
								<span>양쪽관절 제한</span>
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
		//테스트 전체 문항수(12 + 1 + 1 + 1 + 10 + 2)
		const testTotalCount = 27;
		//재활 테스트 문항수
		const rehabilitateCount = 10;
		//재활 평가점수 기준
		const scoreEvaluations = [
			{
		      "evaluation": 0,
		      "score": 10
		    },
		    {
		      "evaluation": 11.51,
		      "score": 11
		    },
		    {
		      "evaluation": 19.43,
		      "score": 12
		    },
		    {
		      "evaluation": 24.72,
		      "score": 13
		    },
		    {
		      "evaluation": 28.93,
		      "score": 14
		    },
		    {
		      "evaluation": 32.62,
		      "score": 15
		    },
		    {
		      "evaluation": 36.06,
		      "score": 16
		    },
		    {
		      "evaluation": 39.46,
		      "score": 17
		    },
		    {
		      "evaluation": 42.96,
		      "score": 18
		    },
		    {
		      "evaluation": 46.69,
		      "score": 19
		    },
		    {
		      "evaluation": 50.72,
		      "score": 20
		    },
		    {
		      "evaluation": 54.97,
		      "score": 21
		    },
		    {
		      "evaluation": 59.2,
		      "score": 22
		    },
		    {
		      "evaluation": 63.19,
		      "score": 23
		    },
		    {
		      "evaluation": 66.93,
		      "score": 24
		    },
		    {
		      "evaluation": 70.53,
		      "score": 25
		    },
		    {
		      "evaluation": 74.16,
		      "score": 26
		    },
		    {
		      "evaluation": 78.07,
		      "score": 27
		    },
		    {
		      "evaluation": 82.75,
		      "score": 28
		    },
		    {
		      "evaluation": 89.57,
		      "score": 29
		    },
		    {
		      "evaluation": 100,
		      "score": 30
		    }
		];
	
		$(function() {
			loadTestResult();
			
			//기존테스트 결과 있으면 불러오기
			function loadTestResult() {
				const testResult = getTestResultAjax();
				if (testResult && testResult.rehabilitateSelect && testResult.rehabilitateSelect.length > 0) {
					for (var i = 0; i < rehabilitateCount; i++) {
						const inputNumber = i + 1;
						const selectedIndex = testResult.rehabilitateSelect[i] - 1;
						const curInputs = $('input[name=rehabilitate' + inputNumber + ']');
						curInputs[selectedIndex].checked = true;
					}
				}
			}
			
			//문항 답변 클릭 이벤트
			$('.check-item input').click(function() {
				const inputName = $(this).attr('name');
				const inputNumber = Number(inputName.replace('rehabilitate', ''));
				
				//스크롤 내리기
				if (inputNumber && inputNumber < rehabilitateCount) {
					const curInput = $('input[name=rehabilitate' + inputNumber + ']')[1];
					curInput.scrollIntoView();
				}
				
				//진행도 표시
				const checkedCount = $('.check-item input:checked').length;
				const percent = Math.floor(((15 + checkedCount) / testTotalCount) * 100);
				setPrograssBar(percent, checkedCount);
			});
			
			//뒤로가기 이벤트
			$('#back-btn').click(function() {
				location.href = '/test/nurse';
			});
			
			//다음 단계 이벤트
			$('#next-btn').click(function() {
				const checkedInputs = $('.check-item input:checked');
				if (checkedInputs.length < rehabilitateCount) {
					alert('모든 항목을 작성하세요.');
					return;
				}
				
				let rehabilitateSelect = '';
				let selectSum = 0;
				for (var i = 0; i < rehabilitateCount; i++) {
					const selectValue = checkedInputs[i].value;
					
				 	if (i === 0) {
				 		rehabilitateSelect = selectValue;
				 	} else {
				 		rehabilitateSelect += "," + selectValue;
				 	}
				 	
				 	selectSum += Number(selectValue);
				}
				const rehabilitateScore = scoreEvaluations.find(f => f.score === selectSum).evaluation;
				
				const requestJson = JSON.stringify({
					mbrTestVO: {
						rehabilitateSelect,
						rehabilitateScore
					},
					testNm: 'rehabilitate',
				});
					
				//재활 정보 저장
				saveTestResultAjax(requestJson, '/test/disease');
			});
		});
	</script>