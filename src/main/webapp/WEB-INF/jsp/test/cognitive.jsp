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
							<div class="bubble" style="width: 44%;">
								<div class="text">
									<img src="/html/page/test/assets/images/ico-steps2.svg" alt="" />
									<span class="font-bold">0/1</span>
								</div>
							</div>
						</div>
						<div class="percent">44%</div>
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
						<label class="check-item is-disable">
							<input type="checkbox" name="cognitive8" checked/>
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
		//인지기능 평가점수 기준
		const scoreEvaluations = [
		  {
	        "evaluation": 0,
	        "score": 0
	      },
	      {
	        "evaluation": 19.71,
	        "score": 1
	      },
	      {
	        "evaluation": 33.81,
	        "score": 2
	      },
	      {
	        "evaluation": 44.61,
	        "score": 3
	      },
	      {
	        "evaluation": 54.78,
	        "score": 4
	      },
	      {
	        "evaluation": 65.71,
	        "score": 5
	      },
	      {
	        "evaluation": 80.06,
	        "score": 6
	      },
	      {
	        "evaluation": 100,
	        "score": 7
	      }
		];
	
		$(function() {
			//loadTestResult();
			
			//기존테스트 결과 있으면 불러오기
			// function loadTestResult() {
			// 	const testResult = getTestResultAjax();
			// 	if (testResult && testResult.cognitiveSelect && testResult.cognitiveSelect.length > 0) {
			// 		for (var i = 0; i < testResult.cognitiveSelect.length; i++) {
			// 			const inputNumber = i + 1;
			// 			const checked = testResult.cognitiveSelect[i];
			// 			const curInputs = $('input[name=cognitive' + inputNumber + ']');
			// 			curInputs[0].checked = checked;
						
			// 			//선택된것이 있다면 증상없음 해제
			// 			if (curInputs[0].checked) {
			// 				var input = $('input[name=cognitive8]')[0];
			// 				input.checked = false;
			// 			}
			// 		}
			// 	}
			// }
			
			//문항 답변 클릭 이벤트
			$('.check-item input').click(function() {
				const inputName = $(this).attr('name');
				const inputNumber = Number(inputName.replace('cognitive', ''));
				
				if (inputNumber === 8) {
					//전부 체크 해제(증상 없음은 제외)
					$('.check-item input').each(function() {
						if (this.getAttribute('name') === 'cognitive8') {
							this.checked = true;	
						} else {
							this.checked = false;							
						}
					});
				}
				else {
					var input = $('input[name=cognitive8]')[0];
					input.checked = false;
				}
			});
			
			//뒤로가기 이벤트
			$('#back-btn').click(function() {
				location.href = '/test/physical';
			});
			
			//다음 단계 이벤트
			$('#next-btn').click(function() {
				const Inputs = $('.check-item input');
				
				let cognitiveSelect = '';
				let selectSum = 0;
				//증상 없음은 제외
				for (var i = 0; i < 7; i++) {
					const inputScore = Inputs[i].checked ? '1' : '0';
					if (i === 0) {
						cognitiveSelect = inputScore;
					} else {
						cognitiveSelect += "," + inputScore;
					}
					
					selectSum += Number(inputScore);
				}
				const cognitiveScore = scoreEvaluations.find(f => f.score === selectSum).evaluation;
				
				var testData = JSON.parse(sessionStorage.getItem('testData'));
				const requestJson = JSON.stringify({
					mbrTestVO: {
						recipientsNo : testData.recipientsNo,
						cognitiveSelect,
						cognitiveScore
					},
					testNm: 'cognitive',
				});
				
				
				if (testData.isLogin) {
					//인지기능 정보 저장(api 방식)
					saveTestResultAjax(requestJson, '/test/behavior');
				} else {
					//세션방식 저장
					testData.cognitive = {
						cognitiveSelect,
						cognitiveScore
					};
					sessionStorage.setItem('testData', JSON.stringify(testData));
					
					location.href = '/test/behavior';
				}
			});
		});
	</script>