<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form:form name="frmBplcNotice" id="frmBplcNotice" modelAttribute="bplcNoticeVO" method="post" action="./action" enctype="multipart/form-data">
	<!-- 검색조건 -->
	<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />
	<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
	<input type="hidden" name="srchUseYn" id="srchUseYn" value="${param.srchUseYn }" />
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
	<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
	<input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" />
	<input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" />
	<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
	<input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />

	<form:hidden path="crud" />
	<form:hidden path="noticeNo" />

	<fieldset>
		<legend class="text-title2 relative">
			공지사항 ${bplcNoticeVO.crud eq 'CREATE'?'등록':'수정' } <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
			</span>
		</legend>
		<table class="table-detail">
			<colgroup>
				<col class="w-43">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="ttl" class="require" maxlength="50">제목</label></th>
					<td><form:input path="ttl" class="form-control w-full" maxlength="50" value="${bplcNoticeVO.ttl}"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="cn" class="require">내용</label></th>
					<td><form:textarea path="cn" class="form-control w-full" cols="30" rows="10" value="${bplcNoticeVO.cn}" /></td>
				</tr>
				<tr>
					<th scope="row">첨부파일</th>
					<td><c:forEach var="fileList" items="${bplcNoticeVO.fileList }" varStatus="status">
							<div id="attachFileViewDiv${fileList.fileNo}">
								<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp; <a href="#delFile" class="btn-secondary" onclick="delFile('${fileList.fileNo}', 'ATTACH', '${status.index}'); return false;"> 삭제</a>
							</div>
						</c:forEach>

						<div id="attachFileDiv">
							<c:forEach begin="0" end="0" varStatus="status">
								<!-- 첨부파일 갯수 -->
								<div class="row" id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(bplcNoticeVO.fileList) }">style="display:none;"</c:if>>
									<div class="col-12">
										<div class="custom-file" id="uptAttach">
											<input type="file" class="form-control w-2/3" id="attachFile${status.index}" name="attachFile${status.index}" onchange="fileCheck(this);" />
										</div>
									</div>
								</div>
							</c:forEach>
						</div></td>
				</tr>
				<tr>
					<th scope="row"><label for="useYn">사용여부</label></th>
					<td>
						<div class="form-check-group">
							<c:forEach items="${useYnCode}" var="useYn" varStatus="status">
								<div class="form-check">
									<form:radiobutton class="form-check-input" path="useYn" id="useYn${status.index}" value="${useYn.key}" />
									<label class="form-check-label" for="useYn${status.index}">${useYn.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</fieldset>

	<div class="btn-group right mt-8">
		<button type="submit" class="btn-primary large shadow">저장</button>

		<c:set var="pageParam" value="curPage=${listVO.curPage}&srchText=${param.srchText}&srchYn=${param.srchYn}&srchTarget=${param.srchTarget}&cntPerPage=${param.cntPerPage}&sortBy=${param.sortBy}&srchBgngDt=${param.srchBgngDt}&srchEndDt=${param.srchEndDt}" />
		<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	</div>
</form:form>

<script>
function delFile(fileNo, type, spanNo){
	if(confirm("삭제하시겠습니까?")){
		if(type == "ATTACH"){
			if($("#delAttachFileNo").val()==""){
				$("#delAttachFileNo").val(fileNo);
			}else{
				$("#delAttachFileNo").val($("#delAttachFileNo").val()+","+fileNo);
			}
			$("#attachFileViewDiv"+fileNo).remove();
			$("#attachFileInputDiv"+spanNo).show();
		}
	}
}

	$(function() {

   		<c:if test="${bplcNoticeVO.useYn eq 'Y'}">
   		//tinymce editor
		tinymce.overrideDefaults(baseConfig);
		tinymce.init({selector:"#cn"});
		</c:if>

		$("form#frmBplcNotice").validate({
		    ignore: "input[type='text']:hidden",
		    rules : {
		    	ttl : { required : true},
		    	cn : {required : true, maxlength : "20000"}
		    },
		    messages : {
		    	ttl : { required : "제목은 필수 입력 항목입니다."},
		    	cn : {required : "내용은 필수 입력 항목입니다.", maxlength : "최대 글자를 초과하였습니다."}
		    },
		    submitHandler: function (frm) {
		    	if(confirm("저장 하시겠습니까?")){
			    	frm.submit();
		    	} else{
		    		return false;
		    	}
		    }
		});

	});
</script>