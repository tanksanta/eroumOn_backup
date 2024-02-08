<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

	<main class="mainContainer">
		<br>
		<br>
		<div id="residentNumDiv" style="display: none;">
			주민등록번호<br>
			<input class="form-control" type="text" />
		</div>
		<div id="nameDiv">
			이름<br>
			<input id="nameInput" class="form-control" type="text" onblur="nameInputBlurEvent();" onkeypress="return nameInputKeypressEvent(event);" />
		</div>
		
	</main>
	
	
	<script>
		function nameInputKeypressEvent(e) {
			if (e.keyCode == 13) {
				$('#residentNumDiv').css('display', 'block');
				return false;
			} else {
				return true;
			}
		}
	
		function nameInputBlurEvent() {
			$('#residentNumDiv').css('display', 'block');
		}
	</script>