<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 회원검색 -->
<div class="modal fade" id="mbrModal" tabindex="-1">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p>회원 검색</p>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
			</div>
			<div class="modal-body">
				<form action="#">
					<fieldset>
						<legend class="text-title2">회원 검색</legend>
						<table class="table-detail">:
							<colgroup>
								<col class="w-34">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label for="modalSrchMbrTarget">키워드 검색</label></th>
									<td>
										<div class="form-group w-full">
											<select name="modalSrchMbrTarget" id="modalSrchMbrTarget" class="form-control w-32">
												<c:forEach var="srchTarget" items="${keyWordCode}" >
													<option value="${srchTarget.key}">${srchTarget.value}</option>
												</c:forEach>
											</select>
											<input type="text" id="modalSrchMbrText" name="modalSrchMbrText" class="form-control flex-1">
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="modalSrchGrade">회원등급</label></th>
									<td>
										<select name="modalSrchGrade" id="modalSrchGrade" class="form-control w-84">
											<option value="">전체</option>
											<c:forEach var="grade" items="${gradeCode}">
												<option value="${grade.key}">${grade.value}</option>
											</c:forEach>
										</select></td>
								</tr>
								<tr>
									<th scope="row"><label for="modalSrchMbrTy">가입구분</label></th>
									<td>
										<select name="modalSrchMbrTy" id="modalSrchMbrTy" class="form-control w-84">
											<option value="">전체</option>
											<c:forEach var="mbrTy" items="${mbrTyCode}">
												<option value="${mbrTy.key}">${mbrTy.value}</option>
											</c:forEach>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
					</fieldset>

					<div class="btn-group mt-5">
						<button type="submit" class="btn-primary large shadow w-30" id="modalSrchMbrBtn">검색</button>
					</div>
				</form>

				<p class="text-title2 mt-10">회원 목록</p>
				<table class="table-list" id="mbrDataTable">
					<colgroup>
						<col class="w-15">
						<col class="w-28">
						<col>
						<col>
						<col class="w-20">
						<col class="w-25">
					</colgroup>
					<thead>
						<tr>
							<th scope="col">
								<div class="form-check">
									<input class="form-check-input" type="checkbox">
								</div>
							</th>
							<th scope="col">고객코드</th>
							<th scope="col">아이디</th>
							<th scope="col">회원이름</th>
							<th scope="col">성별</th>
							<th scope="col">회원등급</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn-primary large shadow w-26 f_modalSelMbr">선택</button>
				<button type="button" class="btn-secondary large shadow w-26" data-bs-dismiss="modal" aria-label="close">취소</button>
			</div>
		</div>
	</div>
</div>
<!-- //회원검색 -->

<script>

// 회원 성별
const genderCode = {
<c:forEach items="${genderCode}" var="gender">
${gender.key} : '${gender.value}',
</c:forEach>
};

//회원 등급
const gradeCode = {
<c:forEach items="${gradeCode}" var="grade">
${grade.key} : '${grade.value}',
</c:forEach>
};


const mbrMap = new Map();
const MbrDataTable = function() {
	var mbrSrchList;
	var dtCall = function(){
		mbrSrchList = $("#mbrDataTable").DataTable({
			bServerSide: true,
			sAjaxSource: "/_mng/promotion/coupon/mbrSearchList.json",
			bFilter: false,
			bInfo: false,
			bSort : false,
			bAutoWidth: false,
			bLengthChange: false,
			language: dt_lang,

			aoColumns: [
				{ mDataProp: "uniqueId",
					mRender: function(oObj, dp, aDt) {
						var str  = '<div class="form-check">';
							str += '<input class="form-check-input" type="checkbox" value="'+aDt.uniqueId+'">';
							str += '</div>';
				 		return str;
					}
				},
				{ mDataProp: "uniqueId"},
				{ mDataProp: "mbrId"},
				{ mDataProp: "mbrNm"},
				{ mDataProp: "gender",
					mRender : function(oObj){
						return genderCode[oObj];
					}},
				{ mDataProp: "mberGrade",
					mRender : function(oObj){
						return gradeCode[oObj];
					}},
			],
			fnServerData: function ( sSource, aoData, fnCallback ) {
				var paramMap = {};
				for ( var i = 0; i < aoData.length; i++) {
	          		paramMap[aoData[i].name] = aoData[i].value;
				}
				var pageSize = 10;
				var start = paramMap.iDisplayStart;
				var pageNum = (start == 0) ? 1 : (start / pageSize) + 1; // pageNum is 1 based

				var restParams = new Array();
				restParams.push({name : "sEcho", value : paramMap.sEcho});
				restParams.push({name : "curPage", value : pageNum });
				restParams.push({name : "cntPerPage", value : pageSize});
				restParams.push({name : "srchTarget", value :  $("#modalSrchMbrTarget").val()});
				restParams.push({name : "srchText", value :  $("#modalSrchMbrText").val()});
				restParams.push({name : "srchMbrGrade", value :  $("#modalSrchGrade").val()});
				restParams.push({name : "srchRecipter", value :  $("#modalSrchMbrTy").val()});

				$.ajax({
	          		dataType : 'json',
	          	    type : "POST",
	          	    url : sSource,
	          	    data : restParams,
	          	    success : function(data) {
	          	    	fnCallback(data);
					}
				});
			},
			fnDrawCallback: function(){

				/* NO > 넘버링 */
				var oSettings = this.fnSettings();
				var startNum = oSettings.fnRecordsDisplay() - oSettings._iDisplayStart;
				var endNum = startNum - oSettings._iDisplayLength + 1;
				if(endNum < 0){ endNum = 1;}

				//console.log("drawCallback");
				mbrMap.clear();
				//console.log(gdsMap);
				var api = this.api();
		       	rows = api.rows( {page:'current'} ).data();
		       	for(var i=0; i < rows.length; i++){
		       		mbrMap.set(rows[i].uniqueId, rows[i]);
		       	}
			}
		});
	}
	return {
		init: function(){
			dtCall();
			// 키워드 검색
			$("#modalSrchMbrTarget").on("change",function(e){
				$("#modalSrchMbrText").on("keyup",function(e){
					mbrSrchList.draw();
				});
			});
			$("#modalSrchMbrBtn").on("click", function(e){
				e.preventDefault();
				mbrSrchList.draw();
			});
			// 클릭 이벤트 추가
			$("#mbrDataTable th :checkbox").click(function(){
				let isChecked = $(this).is(":checked");
				$("#mbrDataTable td :checkbox").prop("checked",isChecked);
			});
			$(".f_modalSelMbr").on("click", function(){
				let mbrUniqueIds = $("#mbrDataTable td :checkbox:checked").map(function(){return $(this).val();}).get();
				if(mbrUniqueIds==null||mbrUniqueIds.length==0) {
					alert("선택된 회원이 없습니다.");
				}else{
					f_modalMbrSearch_callback(mbrUniqueIds);
				}
			});
		}
	};
}();

$(function(){
	//
});
</script>