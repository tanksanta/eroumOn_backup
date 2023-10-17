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
							<div class="bubble" style="width: 92%;">
								<div class="text">
									<img src="/html/page/test/assets/images/ico-steps6.svg" alt="" />
									<span class="font-bold">0/2</span>
								</div>
							</div>
						</div>
						<div class="percent">92%</div>
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
					<div id="disease1-items" class="check-items">
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
					<div id="disease2-items" class="check-items">
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
						<div id="back-btn" class="btn">뒤로가기</div>
						<div id="next-btn" class="btn btn-primary">결과 보기</div>
					</div>
				</form>
			</div>
		</section>
	</main>
	
	<script>
		//질병 평가점수 기준
		const scoreEvaluations = [
			{
		      "evaluation": 0,
		      "score": 0
		    },
		    {
		      "evaluation": 7.69,
		      "score": 1
		    },
		    {
		      "evaluation": 15.38,
		      "score": 2
		    },
		    {
		      "evaluation": 23.07,
		      "score": 3
		    },
		    {
		      "evaluation": 30.76,
		      "score": 4
		    },
		    {
		      "evaluation": 38.45,
		      "score": 5
		    },
		    {
		      "evaluation": 46.14,
		      "score": 6
		    },
		    {
		      "evaluation": 53.83,
		      "score": 7
		    },
		    {
		      "evaluation": 61.52,
		      "score": 8
		    },
		    {
		      "evaluation": 69.21,
		      "score": 9
		    },
		    {
		      "evaluation": 76.9,
		      "score": 10
		    },
		    {
		      "evaluation": 84.59,
		      "score": 11
		    },
		    {
		      "evaluation": 92.28,
		      "score": 12
		    },
		    {
		      "evaluation": 100,
		      "score": 13
		    }
		];
	
		$(function() {
			//loadTestResult();
			
			//기존테스트 결과 있으면 불러오기
			// function loadTestResult() {
			// 	const testResult = getTestResultAjax();
			// 	if (testResult && testResult.diseaseSelect1 && testResult.diseaseSelect1.length > 0) {
			// 		for (var i = 0; i < testResult.diseaseSelect1.length; i++) {
			// 			const inputNumber = i + 1;
			// 			const checked = testResult.diseaseSelect1[i];
			// 			const curInputs = $('input[name=disease1-' + inputNumber + ']');
			// 			curInputs[0].checked = checked;
			// 		}
			// 	}
				
			// 	if (testResult && testResult.diseaseSelect2 && testResult.diseaseSelect2.length > 0) {
			// 		for (var i = 0; i < testResult.diseaseSelect2.length; i++) {
			// 			const inputNumber = i + 1;
			// 			const checked = testResult.diseaseSelect2[i];
			// 			const curInputs = $('input[name=disease2-' + inputNumber + ']');
			// 			curInputs[0].checked = checked;
			// 		}
			// 	}
			// }
			
			//뒤로가기 이벤트
			$('#back-btn').click(function() {
				location.href = '/test/rehabilitate';
			});
			
			//다음 단계 이벤트
			$('#next-btn').click(function() {
				//질병1 영역 정보
				const disease1Inputs = $('#disease1-items .check-item input');
				
				let diseaseSelect1 = '';
				let selectSum = 0;
				for (var i = 0; i < 13; i++) {
					const inputScore = disease1Inputs[i].checked ? '1' : '0';
					if (i === 0) {
						diseaseSelect1 = inputScore;
					} else {
						diseaseSelect1 += "," + inputScore;
					}
					
					selectSum += Number(inputScore);
				}
				const diseaseScore1 = scoreEvaluations.find(f => f.score === selectSum).evaluation;
				
				//질병2 영역 정보
				const disease2Inputs = $('#disease2-items .check-item input');
				
				let diseaseSelect2 = '';
				selectSum = 0;
				for (var i = 0; i < 13; i++) {
					const inputScore = disease2Inputs[i].checked ? '1' : '0';
					if (i === 0) {
						diseaseSelect2 = inputScore;
					} else {
						diseaseSelect2 += "," + inputScore;
					}
					
					selectSum += Number(inputScore);
				}
				const diseaseScore2 = scoreEvaluations.find(f => f.score === selectSum).evaluation;
				
				
				var testData = JSON.parse(sessionStorage.getItem('testData'));
				var testResult = {};
				if (testData.isLogin) {
					//다이어그램 로직을 위해 기존 테스트 데이터 가져오기(api 방식)
					testResult = getTestResultAjax(testData.recipientsNo);	
				} else {
					//테스트 데이터 가져오기(세션 방식)
					testResult = {
						isLogin: testData.isLogin,
						physicalScore: testData.physical.physicalScore,
						physicalSelect: convertStringToNumberArray(testData.physical.physicalSelect),
						cognitiveScore: testData.cognitive.cognitiveScore,
						cognitiveSelect: convertStringToNumberArray(testData.cognitive.cognitiveSelect),
						behaviorScore: testData.behavior.behaviorScore,
						behaviorSelect: convertStringToNumberArray(testData.behavior.behaviorSelect),
						nurseScore: testData.nurse.nurseScore,
						nurseSelect: convertStringToNumberArray(testData.nurse.nurseSelect),
						rehabilitateScore: testData.rehabilitate.rehabilitateScore,
						rehabilitateSelect: convertStringToNumberArray(testData.rehabilitate.rehabilitateSelect),
						diseaseScore1,
						diseaseSelect1: convertStringToNumberArray(diseaseSelect1),
						diseaseScore2,
						diseaseSelect2: convertStringToNumberArray(diseaseSelect2),
					}
					sessionStorage.setItem('testData', JSON.stringify(testResult));
				}
				
				
				//최종 결과 객체 만들기
				const finalTestResult = getFinalTestResultData(testResult);
				
				const requestJson = JSON.stringify({
					mbrTestVO: {
						...finalTestResult,
						recipientsNo : testData.recipientsNo,
						diseaseScore1,
						diseaseSelect1,
						diseaseScore2,
						diseaseSelect2,
					},
					testNm: 'disease',
				});
				
				
				//질병 및 최종결과 정보 저장
				if (testData.isLogin) {
					//api 방식
					saveTestResultAjax(requestJson, '/main/cntnts/test-result');
				} else {
					//session 방식
					sessionStorage.setItem('finalTestResult', JSON.stringify(finalTestResult));
					location.href = '/main/cntnts/test-result';
				}
			});
			
			function getFinalTestResultData(testResult) {
				if (!testResult
					|| testResult.physicalSelect.length === 0
					|| testResult.cognitiveSelect.length === 0
					|| testResult.behaviorSelect.length === 0
					|| testResult.nurseSelect.length === 0
					|| testResult.rehabilitateSelect.length === 0) {
					alert('테스트가 정상적으로 수행되지 않았습니다. 다시 진행하세요.');
					return;
				}
				
				//다이어그램 판정하기
				const diagramBehaviorScore = InspectBehaviorResult(
					testResult.physicalScore,
					testResult.physicalSelect,
					testResult.cognitiveScore,
					testResult.behaviorScore,
					testResult.behaviorSelect,
				);
				const diagramCleanScore = InspectCleanResult(
					testResult.physicalScore,
					testResult.physicalSelect,
					testResult.cognitiveScore,
					testResult.cognitiveSelect,
					testResult.rehabilitateScore,
					testResult.behaviorScore,
				);
				const diagramExcretionScore = InspectExcretionResult(
					testResult.physicalScore,
					testResult.physicalSelect,
					testResult.cognitiveSelect,
					testResult.behaviorScore,
					testResult.behaviorSelect,
					testResult.nurseSelect,
					testResult.rehabilitateSelect,
				);
				const diagramFunctionalScore = InspectFunctionalAidResult(
					testResult.physicalScore,
					testResult.physicalSelect,
					testResult.behaviorScore,
					testResult.behaviorSelect,
					testResult.nurseSelect,
					testResult.rehabilitateSelect,
				);
				const diagramIndirectScore = InspectIndirectSupportResult(
					testResult.physicalScore,
					testResult.physicalSelect,
					testResult.behaviorScore,
					testResult.behaviorSelect,
				);
				const diagramMealScore = InspectMealResult(
					testResult.physicalScore,
					testResult.physicalSelect,
					testResult.behaviorSelect,
					testResult.rehabilitateScore,
				);
				const diagramNurseScore = InspectNurseResult(
					testResult.physicalSelect,
					testResult.behaviorSelect,
					testResult.nurseScore,
					testResult.nurseSelect,
					testResult.rehabilitateSelect,
				);
				const diagramRehabilitateScore = InspectRehabilitateResult(
					testResult.physicalSelect,
					testResult.cognitiveSelect,
					testResult.behaviorSelect,
					testResult.rehabilitateScore,
				);
				
				//최종점수 및 등급 판정
				const score = diagramBehaviorScore + 
					diagramCleanScore +
					diagramExcretionScore +
					diagramFunctionalScore +
					diagramIndirectScore +
					diagramMealScore +
					diagramNurseScore +
					diagramRehabilitateScore;
				
				let grade = 0;
				if (score >= 95) {
					grade = 1;
				} else if (score >= 75 && score <= 94) {
					grade = 2;
				} else if (score >= 60 && score <= 74) {
					grade = 3;
				} else if (score >= 51 && score <= 59) {
					grade = 4;
				} else if (score >= 45 && score <= 50) {
					grade = 5;
				}
				
				return {
					grade,
					score,
					diagramBehaviorScore,
					diagramCleanScore,
					diagramExcretionScore,
					diagramFunctionalScore,
					diagramIndirectScore,
					diagramMealScore,
					diagramNurseScore,
					diagramRehabilitateScore,
				}
			}
			
			function convertStringToNumberArray(str) {
				var strArray = str.split(',');
				if (strArray.length === 0) {
					return [];
				}
				
				return strArray.map(m => Number(m));
			}
		});
	</script>