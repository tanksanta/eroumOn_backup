<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main id="simulation" class="mt-0">
		<section class="h-200vh xl:h-screen flex flex-col">
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
								<div class="text">Ready</div>
							</div>
						</div>
						<div class="percent">0%</div>
					</div>
				</div>
			</div>
			<div id="container">
				<div class="check-intro">
					<div class="total">
						<h2>구성</h2>
						<div>
							<p>
								<strong class="numb1">5</strong>
								<small>영역</small>
							</p>
							<p class="split">/</p>
							<p>
								<strong class="numb2">52</strong>
								<small>항목</small>
							</p>
						</div>
					</div>
					<dl class="section1">
						<dt>
							신체<em>기능</em>
						</dt>
						<dd>12</dd>
					</dl>
					<dl class="section2">
						<dt>
							인지<em>기능</em>
						</dt>
						<dd>7</dd>
					</dl>
					<dl class="section3">
						<dt>행동변화</dt>
						<dd>14</dd>
					</dl>
					<dl class="section4">
						<dt>간호처치</dt>
						<dd>9</dd>
					</dl>
					<dl class="section5">
						<dt>재활</dt>
						<dd>10</dd>
					</dl>
				</div>
		
				<div class="check-intro-rule">
					<h2>
						<small>점수별 등급</small>
						산정 기준
					</h2>
					<ul>
						<li>
							<p class="grade">
								<strong>1</strong>등급
							</p>
						</li>
						<li>
							<p class="point">
								<strong>95</strong>점
							</p>
							<p class="grade">
								<strong>2</strong>등급
							</p>
						</li>
						<li>
							<p class="point">
								<strong>75</strong>점
							</p>
							<p class="grade">
								<strong>3</strong>등급
							</p>
						</li>
						<li>
							<p class="point">
								<strong>60</strong>점
							</p>
							<p class="grade">
								<strong>4</strong>등급
							</p>
						</li>
						<li>
							<p class="point">
								<strong>51</strong>점
							</p>
							<p class="grade">
								<strong>5</strong>등급
							</p>
						</li>
						<li>
							<p class="point">
								<strong>45</strong>점
							</p>
							<p class="grade">
								<strong>인지지원</strong>등급
							</p>
						</li>
					</ul>
				</div>
		
				<div class="check-intro-desc">
					<p>※</p>
					<p>
						본 테스트는 보건복지부에서 고시한 장기요양등급판정기준에 관한 고시 자료를 근거로 만들어 졌으며 실제 장기요양인정등급 심의 및 판정과는 다를 수
						있으므로 <strong>참고용으로만 확인</strong>해 주시기 바랍니다.
					</p>
				</div>
		
				<div class="check-button is-sticky">
					<button id="next-btn" class="btn btn-primary">테스트 시작</button>
				</div>
			</div>
		</section>
	</main>
	
	<script>
		$(function() {
			$('#next-btn').click(function() {
				location.href = '/test/physical';
			});
		});
	</script>