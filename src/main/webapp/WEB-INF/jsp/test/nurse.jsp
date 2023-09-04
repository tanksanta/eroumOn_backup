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
							<div class="bubble" style="width: 51%;">
								<div class="text">
									<img src="/html/page/test/assets/images/ico-steps4.svg" alt="" />
									<span class="font-bold">0/1</span>
								</div>
							</div>
						</div>
						<div class="percent">51%</div>
					</div>
				</div>
			</div>
		
			<div id="container">
				<form class="check-page4">
					<div class="check-title">
						<small>Check List</small>
						<h2>간호처치</h2>
						<img src="/html/page/test/assets/images/ico-check-item4.png" alt="" />
						<p>
							증상이 심각하고 지속적인 관리가 필요한지
							<br />
							신청인의 상황에 맞게 요양 필요 여부와
							<br />
							필요한 간호처치를 판단합니다.
						</p>
					</div>
		
					<div class="check-desc">
						<u>최근 2주간의 상황을 종합</u>하여 <strong>필요하거나 제공 받고 있는 의료처리</strong>를 아래 항목 중 선택해 주세요.
					</div>
		
					<!-- 테스트 문항 -->
					<div class="check-items">
						<label class="check-item">
							<input type="checkbox" name="nurse1"/>
							<span>기관지 절개관 <small>기관지를 절개하여 인공기도를 확보하는 간호</small></span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="nurse2"/>
							<span>흡인 <small>카테터 등으로 인위적으로 분비물을 제거하여 기도유지</small></span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="nurse3"/>
							<span>산소요법 <small>저산소증이나 저산소혈증을 치료, 감소 시키기 위해 산소공급장치를 통해 추가적인 산소 공급</small></span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="nurse4"/>
							<span>욕창간호 <small>장기적인 고정체위로 인해 압박 부위의 피부와 하부조직 손상되어 지속적인 드레싱과 체위변경 처치</small></span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="nurse5"/>
							<span>경관 영양 <small>구강으로 음식섭취가 어려워 관을 통해서 위, 십이지장 등에 직접 영양을 공급해야 하는 경우</small></span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="nurse6"/>
							<span>암성통증 <small>암의 진행을 억제하지 못하여 극심한 통증에 발생</small></span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="nurse7"/>
							<span>도뇨관리 <small>배뇨가 자율적으로 관리가 불가능하여 인위적으로 방광을 비우거나 관리</small></span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="nurse8"/>
							<span>장루 <small>인공항문을 통해 체외로 대변을 배설 시킴으로 부착장치의 지속적인 관리</small></span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="nurse9"/>
							<span>투석 <small>장기적인 신부전증으로 인해 혈액 투석이 필요한 경우</small></span>
						</label>
						<label class="check-item is-disable">
							<input type="checkbox" name="nurse10" checked/>
							<span>해당하는 증상이 없다.</span>
						</label>
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
		//간호처치 평가점수 기준
		const scoreEvaluations = [
		  {
	        "evaluation": 0,
	        "score": 0
	      },
	      {
	        "evaluation": 19.84,
	        "score": 1
	      },
	      {
	        "evaluation": 36.9,
	        "score": 2
	      },
	      {
	        "evaluation": 47.84,
	        "score": 3
	      },
	      {
	        "evaluation": 55.81,
	        "score": 4
	      },
	      {
	        "evaluation": 62.53,
	        "score": 5
	      },
	      {
	        "evaluation": 68.98,
	        "score": 6
	      },
	      {
	        "evaluation": 76.11,
	        "score": 7
	      },
	      {
	        "evaluation": 85.86,
	        "score": 8
	      },
	      {
	        "evaluation": 100,
	        "score": 9
	      }
		];
	
		$(function() {
			//loadTestResult();
			
			//기존테스트 결과 있으면 불러오기
			function loadTestResult() {
				const testResult = getTestResultAjax();
				if (testResult && testResult.nurseSelect && testResult.nurseSelect.length > 0) {
					for (var i = 0; i < testResult.nurseSelect.length; i++) {
						const inputNumber = i + 1;
						const checked = testResult.nurseSelect[i];
						const curInputs = $('input[name=nurse' + inputNumber + ']');
						curInputs[0].checked = checked;
						
						//선택된것이 있다면 증상없음 해제
						if (curInputs[0].checked) {
							var input = $('input[name=nurse10]')[0];
							input.checked = false;
						}
					}
				}
			}
			
			//문항 답변 클릭 이벤트
			$('.check-item input').click(function() {
				const inputName = $(this).attr('name');
				const inputNumber = Number(inputName.replace('nurse', ''));
				
				if (inputNumber === 10) {
					//전부 체크 해제(증상 없음은 제외)
					$('.check-item input').each(function() {
						if (this.getAttribute('name') === 'nurse10') {
							this.checked = true;	
						} else {
							this.checked = false;							
						}
					});
				}
				else {
					var test = $('input[name=nurse10]')[0];
					test.checked = false;
				}
			});
			
			//뒤로가기 이벤트
			$('#back-btn').click(function() {
				location.href = '/test/behavior';
			});
			
			//다음 단계 이벤트
			$('#next-btn').click(function() {
				const Inputs = $('.check-item input');
				
				let nurseSelect = '';
				let selectSum = 0;
				//증상 없음은 제외
				for (var i = 0; i < 9; i++) {
					const inputScore = Inputs[i].checked ? '1' : '0';
					if (i === 0) {
						nurseSelect = inputScore;
					} else {
						nurseSelect += "," + inputScore;
					}
					
					selectSum += Number(inputScore);
				}
				const nurseScore = scoreEvaluations.find(f => f.score === selectSum).evaluation;
				
				const requestJson = JSON.stringify({
					mbrTestVO: {
						nurseSelect,
						nurseScore
					},
					testNm: 'nurse',
				});
				
				//간호처치 정보 저장
				saveTestResultAjax(requestJson, '/test/rehabilitate');
			});
		});
	</script>