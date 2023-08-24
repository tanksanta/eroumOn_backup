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
									<img src="/html/page/test/assets/images/ico-steps3.svg" alt="" />
									<span class="font-bold">0/1</span>
								</div>
							</div>
						</div>
						<div class="percent">48%</div>
					</div>
				</div>
			</div>
			
			<div id="container">
				<form class="check-page3">
					<div class="check-title">
						<small>Check List</small>
						<h2>행동변화</h2>
						<img src="/html/page/test/assets/images/ico-check-item3.png" alt="" />
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
							<input type="checkbox" name="behavior1"/>
							<span>사람들이 무엇을 훔쳤다고 믿거나, 자기를 해하려 한다고 잘못 믿고 있다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior2"/>
							<span>헛것을 보거나 환청을 듣는다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior3"/>
							<span>슬퍼 보이거나 기분이 처져 있으며 때로 울기도 한다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior4"/>
							<span>밤에 자다가 일어나 주위 사람을 깨우거나 아침에 너무 일찍 일어난다. 또는 낮에는 지나치게 잠을 자고 밤에는 잠을 이루지 못한다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior5"/>
							<span>주위사람이 도와주려 할 때 도와주는 것에 저항한다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior6"/>
							<span>한군데 가만히 있지 못하고 서성거리거나 왔다 갔다 하며 안절부절 못한다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior7"/>
							<span>길을 잃거나 헤맨 적이 있다. 외출하면 집이나 병원, 시설로 혼자 들어올 수 없다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior8"/>
							<span>화를 내며 폭언이나 폭행을 하는 등 위협적인 행동을 보인다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior9"/>
							<span>혼자서 밖으로 나가려고 해서 눈을 뗄 수가 없다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior10"/>
							<span>물건을 망가뜨리거나 부순다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior11"/>
							<span>의미 없거나 부적절한 행동을 자주 보인다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior12"/>
							<span>돈이나 물건을 장롱같이 찾기 어려운 곳에 감춘다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior13"/>
							<span>옷을 부적절하게 입는다.</span>
						</label>
						<label class="check-item">
							<input type="checkbox" name="behavior14"/>
							<span>대소변을 벽이나 옷에 바르는 등의 행위를 한다.</span>
						</label>
						<label class="check-item is-disable">
							<input type="checkbox" name="behavior15" checked/>
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
		$(function() {
			//문항 답변 클릭 이벤트
			$('.check-item input').click(function() {
				const inputName = $(this).attr('name');
				const inputNumber = Number(inputName.replace('behavior', ''));
				
				if (inputNumber === 15) {
					//전부 체크 해제(증상 없음은 제외)
					$('.check-item input').each(function() {
						if (this.getAttribute('name') === 'behavior15') {
							this.checked = true;	
						} else {
							this.checked = false;							
						}
					});
				}
				else {
					var test = $('input[name=behavior15]')[0];
					test.checked = false;
				}
			});
			
			//뒤로가기 이벤트
			$('#back-btn').click(function() {
				location.href = '/test/cognitive';
			});
			
			//다음 단계 이벤트
			$('#next-btn').click(function() {
				location.href = '/test/nurse';
			});
		});
	</script>