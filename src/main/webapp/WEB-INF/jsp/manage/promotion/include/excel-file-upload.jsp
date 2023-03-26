<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.15.5/xlsx.full.min.js"></script>
<!-- 후에 다운받아서 처리, 확장자 3개 테스트 -->
<!-- 파일업로드 -->
<div class="modal fade" id="fileModal" tabindex="-1">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<p>파일업로드</p>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
			</div>
			<div class="modal-body">
				<form action="#">
					<fieldset>
						<legend>업로드할 파일을 등록해주세요</legend>
						<table class="table-detail mt-3">
							<colgroup>
								<col class="w-34">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th scope="row"><label for="excelAttach">파일선택</label></th>
									<td><input type="file" id="excelAttach" name="excelAttach" class="form-control w-full" onchange="readExcel();" onchange="fileCheck(this);"></td>
								</tr>
							</tbody>
						</table>
						<div class="btn-group mt-5">
							<button type="button" class="btn-primary large shadow w-26" id="excelBtn">등록</button>
							<a href="/comm/SAMPLE/getFile?fileName=sample.xlsx" class="btn-secondary large shadow">샘플다운로드</a>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- //파일업로드 -->

<script>
var xlsxData = "";

//첨부파일 이미지 제한
function fileCheck(obj) {

	if(obj.value != ""){

		/* 첨부파일 확장자 체크*/
		var atchLmttArr = new Array();
		atchLmttArr.push("xlsx");

		var file = obj.value;
		var fileExt = file.substring(file.lastIndexOf('.') + 1, file.length).toLowerCase();
		var isFileExt = false;

		for (var i = 0; i < atchLmttArr.length; i++) {
			if (atchLmttArr[i] == fileExt) {
				isFileExt = true;
				break;
			}
		}

		if (!isFileExt) {
			alert("<spring:message code='errors.ext.limit' arguments='" + atchLmttArr + "' />");
			obj.value = "";
			return false;
		}
	}
};


//엑셀 파싱
function readExcel() {
    let input = event.target;
    let reader = new FileReader();
    reader.onload = function () {
        let data = reader.result;
        let workBook = XLSX.read(data, { type: 'binary' });
        workBook.SheetNames.forEach(function (sheetName) {
            //console.log('SheetName: ' + sheetName);
            let rows = XLSX.utils.sheet_to_json(workBook.Sheets[sheetName]);
            xlsxData = rows;
            //console.log(JSON.stringify(rows));
        })
    };
    reader.readAsBinaryString(input.files[0]);
}

$(function(){
	//var srchCnt = $(".trCnt").length;
	//목록에 추가
	$("#excelBtn").on("click",function(){

		if($("#excelAttach").val() != ''){
			console.log(xlsxData);
			$(".btn-close").click();
			$(".noresult").remove();

			for(var i=0; i<xlsxData.length;i++){
				//중복 추가 x
				if($("."+xlsxData[i].고객코드).length < 1){
					var html = "";
					html += '<tr class="trCnt '+xlsxData[i].고객코드+'">';
					html += '<td>';
					html += '<div class="form-check">';
					html += '<input class="form-check-input chkBox" type="checkbox" name="mbrChkBox" value="'+xlsxData[i].고객코드+'" id="idx'+cnt+'">';
					html += '<input type="hidden" name="uniqueId" value="'+xlsxData[i].고객코드+'">';
					html += '</div>';
					html += '</td>';
					html += '<td>'+(cnt)+'</td>';
					html += '<td>'+xlsxData[i].고객코드+'</td>';
					html += '<td>'+xlsxData[i].이름+'</td>';
					html += '<td>'+xlsxData[i].아이디+'</td>';
					html += '</tr>';

					$("#relMbrList tbody").append(html);

					cnt += 1;
				}
			}
		}else{
			alert("파일을 선택 해주세요.");
		}
	});
});
</script>