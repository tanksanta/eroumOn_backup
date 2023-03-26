<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../layout/page_header.jsp">
	<jsp:param value="찾아오시는 길" name="pageTitle" />
</jsp:include>
<div id="page-content">
	<form:form action="./placeAction" id="placeFrm" name="placeFrm" method="post" modelAttribute="bplcVO">
	<form:hidden path="uniqueId"/>
	<!-- 수정을 막기 위함 -->
	<form:hidden path="telno"/>
	<form:hidden path="rcmdtnYn"/>
	<form:hidden path="useYn"/>
	<form:hidden path="hldyEtc"/>

		<fieldset>
			<legend class="text-title2">오시는 길 정보</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="carDrc">자동차 이용 시</label></th>
						<td><form:textarea path="carDrc" rows="3" class="form-control w-full" placeholder="100자 이내로 입력해주세요." maxlength="100" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="busDrc">버스 이용 시</label></th>
						<td><form:textarea path="busDrc" rows="3" cols="30" class="form-control w-full" placeholder="100자 이내로 입력해주세요." maxlength="100" /></td>
					</tr>
					<tr>
						<th scope="row"><label for="subwayDrc">지하철 이용 시</label></th>
						<td><form:textarea path="subwayDrc" rows="3" class="form-control w-full" placeholder="100자 이내로 입력해주세요." maxlength="100" /></td>
					</tr>
				</tbody>
			</table>
		</fieldset>

		<div class="btn-group right mt-8">
			<button type="submit" class="btn-save large shadow">저장</button>
		</div>
	</form:form>
</div>

<script>
$(function(){

	//유효성
	$("form#placeFrm").validate({
	    submitHandler: function (frm) {
	   		if(confirm("저장하시겠습니까?")){
	   			frm.submit();
	   		}else{
	   			return false;
	   		}
	    }
	});

});
</script>