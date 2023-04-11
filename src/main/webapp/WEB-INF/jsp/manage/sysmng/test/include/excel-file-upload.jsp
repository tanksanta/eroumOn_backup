<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
									<td><input type="file" id="excelAttach" name="excelAttach" class="form-control w-full" onchange="readExcel();" onchange="fileCheck(this);" accept=".xls,.xlsx"></td>
								</tr>
							</tbody>
						</table>
						<div class="btn-group mt-5">
							<button type="button" class="btn-primary large shadow w-26" id="excelBtn">등록</button>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</div>
<!-- //파일업로드 -->

<script>
	$(function() {
		$('#excelBtn').on('click', function() {
			const excelInput = $('#excelAttach')[0];
			
			if(excelInput.files.length > 0) {
				const file = excelInput.files[0];
				if (file.type !== 'application/vnd.ms-excel' && file.type !== 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet') {
					alert('엑셀 파일만 업로드가 가능합니다.');
					return;
				}
				
				const formData = new FormData();
				formData.append("excel", file);
				
				$.ajax({
					type: "post",
					url: "/_mng/sysmng/test/excelUpload.json",
					processData: false,
				    contentType: false,
				    data: formData,
				})
				.done(function(data) {
					alert(data.msg);
					
					$(".btn-close").click();
				})
				.fail(function(data, status, error) {
					console.log('엑셀 업로드 : error forward : ' + data);
				});
			} else {
				alert('파일을 선택 해주세요.');
			}
		});
	})
</script>