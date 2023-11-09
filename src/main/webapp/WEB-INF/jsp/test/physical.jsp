<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="simulation">
		<!-- <section class="h-100vh max-h-screen xl:h-screen flex flex-col"> -->
		<section class="simulation-inner">
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
								<input type="radio" name="physical1" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical1" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical1" value="3"/>
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
								<input type="radio" name="physical2" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical2" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical2" value="3"/>
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
								<input type="radio" name="physical3" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical3" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical3" value="3"/>
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
								<input type="radio" name="physical4" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical4" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical4" value="3"/>
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
								<input type="radio" name="physical5" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical5" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical5" value="3"/>
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
								<input type="radio" name="physical6" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical6" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical6" value="3"/>
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
								<input type="radio" name="physical7" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical7" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical7" value="3"/>
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
								<input type="radio" name="physical8" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical8" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical8" value="3"/>
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
								<input type="radio" name="physical9" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical9" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical9" value="3"/>
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
								<input type="radio" name="physical10" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical10" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical10" value="3"/>
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
								<input type="radio" name="physical11" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical11" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical11" value="3"/>
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
								<input type="radio" name="physical12" value="1"/>
								<span>혼자서 가능</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical12" value="2"/>
								<span>일부 도움 필요</span>
							</label>
							<label class="check-item">
								<input type="radio" name="physical12" value="3"/>
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
		//테스트 전체 문항수(12 + 1 + 1 + 1 + 10 + 2)
		const testTotalCount = 27;
		//신체 테스트 문항수
		const physicalCount = 12;
		//신체 평가점수 기준
		const scoreEvaluations = [
		  {
	        "evaluation": 0,
	        "score": 12
	      },
	      {
	        "evaluation": 15.58,
	        "score": 13
	      },
	      {
	        "evaluation": 22.24,
	        "score": 14
	      },
	      {
	        "evaluation": 28.04,
	        "score": 15
	      },
	      {
	        "evaluation": 32.38,
	        "score": 16
	      },
	      {
	        "evaluation": 35.92,
	        "score": 17
	      },
	      {
	        "evaluation": 38.96,
	        "score": 18
	      },
	      {
	        "evaluation": 41.68,
	        "score": 19
	      },
	      {
	        "evaluation": 44.18,
	        "score": 20
	      },
	      {
	        "evaluation": 46.52,
	        "score": 21
	      },
	      {
	        "evaluation": 48.76,
	        "score": 22
	      },
	      {
	        "evaluation": 50.93,
	        "score": 23
	      },
	      {
	        "evaluation": 53.06,
	        "score": 24
	      },
	      {
	        "evaluation": 55.17,
	        "score": 25
	      },
	      {
	        "evaluation": 57.3,
	        "score": 26
	      },
	      {
	        "evaluation": 59.46,
	        "score": 27
	      },
	      {
	        "evaluation": 61.71,
	        "score": 28
	      },
	      {
	        "evaluation": 64.06,
	        "score": 29
	      },
	      {
	        "evaluation": 66.59,
	        "score": 30
	      },
	      {
	        "evaluation": 69.36,
	        "score": 31
	      },
	      {
	        "evaluation": 72.5,
	        "score": 32
	      },
	      {
	        "evaluation": 76.22,
	        "score": 33
	      },
	      {
	        "evaluation": 81.02,
	        "score": 34
	      },
	      {
	        "evaluation": 88.4,
	        "score": 35
	      },
	      {
	        "evaluation": 100,
	        "score": 36
	      }
	    ];
	
		$(function() {
			//loadTestResult();
			
			//기존테스트 결과 있으면 불러오기
			// function loadTestResult() {
			// 	const testResult = getTestResultAjax();
			// 	if (testResult && testResult.physicalSelect && testResult.physicalSelect.length > 0) {
			// 		for (var i = 0; i < physicalCount; i++) {
			// 			const inputNumber = i + 1;
			// 			const selectedIndex = testResult.physicalSelect[i] - 1;
			// 			const curInputs = $('input[name=physical' + inputNumber + ']');
			// 			curInputs[selectedIndex].checked = true;
			// 		}
			// 	}
			// }
			
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
				location.href = '/main/cntnts/test';
			});
			
			//다음 단계 이벤트
			$('#next-btn').click(function() {
				const checkedInputs = $('.check-item input:checked');
				if (checkedInputs.length < physicalCount) {
					alert('모든 항목을 작성하세요.');
					return;
				}
				
				let physicalSelect = '';
				let selectSum = 0;
				for (var i = 0; i < physicalCount; i++) {
					const selectValue = checkedInputs[i].value;
					
				 	if (i === 0) {
				 		physicalSelect = selectValue;
				 	} else {
				 		physicalSelect += "," + selectValue;
				 	}
				 	
				 	selectSum += Number(selectValue);
				}
				const physicalScore = scoreEvaluations.find(f => f.score === selectSum).evaluation;
				
				const recipientsNo = ${recipientsNo};
				const requestJson = JSON.stringify({
					mbrTestVO: {
						recipientsNo,
						physicalSelect,
						physicalScore
					},
					testNm: 'physical',
				});
				
				
				var result = getMbrInfo();
				sessionStorage.setItem('testData', JSON.stringify({
					isLogin: result.isLogin,
					recipientsNo,
				}));
				
				if (result.isLogin) {
					//신체기능 정보 저장(api 방식)
					saveTestResultAjax(requestJson, '/test/cognitive');	
				} else {
					//세션방식 저장
					var testData = JSON.parse(sessionStorage.getItem('testData'));
					testData.physical = {
						physicalSelect,
						physicalScore
					};
					sessionStorage.setItem('testData', JSON.stringify(testData));
					
					location.href = '/test/cognitive';
				}
			});
			
			//로그인 여부 확인용 사용자 조회하기
			function getMbrInfo() {
				var result = {};
				$.ajax({
	        		type : "post",
					url  : "/membership/info/myinfo/getMbrInfo.json",
					dataType : 'json',
					async: false
	        	})
	        	.done(function(data) {
	        		//로그인 한 경우
	        		if (data.isLogin) {
	        			result.isLogin = true;	        			
	        		}
	        		//로그인 안한 경우
	        		else {
	        			result.isLogin = false;
	        		}
	        	})
	        	.fail(function(data, status, err) {
	        		alert('서버와 연결이 좋지 않습니다.');
				});
				
				return result;
			}
		});
	</script>