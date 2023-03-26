<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page-content">
                <form:form name="frmBrand" id="frmBrand" modelAttribute="brandVO" method="post" action="./action" enctype="multipart/form-data">
                <form:hidden path="crud" />
                <form:hidden path="brandNo" />
                <input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />

				<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
				<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn}" />
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
				<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
				<input type="hidden" name="sortBy" id="sortBy" value="${param.sortBy}" />
				<fieldset>
                        <legend class="text-title2 relative">
                            ${brandVO.crud eq 'CREATE'?'등록':'수정' }
                            <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                                (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                            </span>
                        </legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">브랜드코드</th>
                                    <td>${brandVO.brandNo}</td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="mkrNm" class="require">브랜드명</label></th>
                                    <td>
                                        <div class="form-group w-120">
                                            <form:input type="text" class="form-control w-90" path="brandNm" value="${brandVO.brandNm }" maxlength="40"/>
                                            <button type="button" class="btn-primary w-20" id="searchNm" data-chkbtn="unchecked">검색</button>
                                        </div>


                                    </td>
                                </tr>
                                <tr>
                                	<th><label for="qlityGrnte">품질보증기준</label></th>
                                	<td>
                                		<form:input path="qlityGrnte" class="form-control w-90" value="${brandVO.qlityGrnte}" maxlength="50" />
                                		</br>ex) 공정거래위원회 고시 소비자 분쟁해결 기준에 준함
                                	</td>
                                </tr>
                                <tr>
                                	<th><label for="telno">서비스센터</label></th>
                                	<td>
                                		<div class="form-group w-90">
                                			<form:input class="form-control flex-1" path="telno" value="${brandVO.telno}" maxlength="15" />
                                		</div>
                                	</td>
                                </tr>
                                <tr>
                                	<th><label for="intrcn">브랜드 소개</br>(500자 이내)</label></th>
                                	<td><form:textarea path="intrcn"  cols="30" rows="10" class="form-control w-full" maxlength="500"/></td>
                                </tr>
                             	<tr>
									<th scope="row"><label for="" class="require">브랜드 이미지</label></th>
									<td><c:forEach var="fileList" items="${brandVO.fileList }" varStatus="status">
											<div id="attachFileViewDiv${fileList.fileNo}">
												<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp;
												 <a href="#delFile" class="btn-secondary" onclick="delFile('${fileList.fileNo}', 'ATTACH', '${status.index}'); return false;"> 삭제</a>
											</div>
										</c:forEach>

										<div id="attachFileDiv">
											<c:forEach begin="0" end="0" varStatus="status">
												<!-- 첨부파일 갯수 -->
												<div class="row" id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(brandVO.fileList) }">style="display:none;"</c:if>>
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
                                    <th scope="row"><label for="form-item2">상태</label></th>
                                    <td>
									<div class="form-group">
										<div class="form-check-group">
											<c:forEach var="sttus" items="${useYn}">
												<div class="form-check">
													<form:radiobutton path="useYn" class="form-check-input" id="${sttus.value}" value="${sttus.key}" />
													<label class="form-check-label" for="${sttus.value}">${sttus.value}</label>
												</div>
											</c:forEach>
										</div>
									</div>
								</td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>

					<c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}&amp;srchYn=${param.srchYn}&amp;sortBy=${param.sortBy}" />
                    <div class="btn-group mt-8 right">
                        <button type="submit" class="btn-primary large shadow">저장</button>
                        <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
                    </div>
                </form:form>
            </div>

<script>
function fileCheck(obj) {

	if(obj.value != ""){

		/* 첨부파일 확장자 체크*/
		var atchLmttArr = new Array();
		atchLmttArr.push("jpg");
		atchLmttArr.push("png");
		atchLmttArr.push("gif");

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


$(function(){
	//정규식
	var phonechk =  /^[0-9]+-/;

   		<c:if test="${brandVO.useYn eq 'Y'}">
	//tinymce editor
		tinymce.overrideDefaults(baseConfig);
		tinymce.init({selector:"#intrcn"});
		</c:if>

		if($("#crud").val() == 'UPDATE'){
			$("#brandNm").attr("readonly",true);
			$("#searchNm").attr("disabled",true);
		}

		  //검색 기능
		  $("#searchNm").on("click",function(){
				$.ajax({
					type : "post",
					url  : "ChkBrand.json",
					data : {
						nm : $("#brandNm").val()
						, crud : $("#crud").val()
						, no : $("#brandNo").val()
					},
					dataType : 'json'
				})
				.done(function(data) {
					if(data == false){
						$("#searchNm").attr("data-chkbtn","unchecked");
						alert("이미 사용중인 브랜드입니다.");
					}else{
						$("#searchNm").attr("data-chkbtn","checked");
						alert("사용 가능한 브랜드입니다. ");
					}
				})
				.fail(function(data, status, err) {
					alert("금지어 중복 검사 중 오류가 발생했습니다.");
					console.log('error forward : ' + data);
				});
		  });

		  //버튼 검사
		  $.validator.addMethod("searchchk", function(value,element){
			  if($("#crud").val == 'CREATE'){
				  if($("#searchNm").attr("data-chkbtn") == "unchecked"){
					  return false;
				  }else{
					  return true;
				  }
			  }else{
				  console.log($("#searchNm").attr("data-chkbtn"));
				  return true;
			  }
		  }, "사용 가능한 금지어를 검사해주세요.");


		$.validator.addMethod("regex", function(value, element, regexpr) {
			if(value != ''){
				return regexpr.test(value)
			}else{
				return true;
			}
		}, "형식이 올바르지 않습니다.");

		// 첨부파일 검사 메소드
		$.validator.addMethod("filechk", function(value,element){
			if($("#crud").val() == "UPDATE"){
				if($("#attachFileInputDiv0").attr("style") != ''){
					return true;
				}else{
					if($("#attachFile0").val() == ''){
						return false;
					}else{
						return true;
					}
				}
			}else{
				if($("#attachFile0").val() == ''){
					return false;
				}else{
					return true;
				}
			}
		}, "파일은 필수 입력 항목입니다.");

		$("form#frmBrand").validate({
		    ignore: "input[type='text']:hidden",
		    rules : {
		    	brandNm : { required : true ,searchchk : true},
		    	attachFile0 : {filechk : true}
		    },
		    messages : {
		    	brandNm : { required : "브랜드명은 필수 입력 항목입니다.", maxlength : "50자 이내로 입력해주세요."},
		    	qlityGrnte : {maxlength : "50자 이내로 입력해주세요"},
		    	intrcn : {maxlength : "500자 이내로 입력해주세요."}
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

