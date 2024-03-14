<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/jsp/common/ckeditor_online.jsp" />

				<form:form name="frmNtt" id="frmNtt" modelAttribute="nttVO" method="post" action="./action" enctype="multipart/form-data" class="form-horizontal">
					<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />
					<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
					<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
					<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
					<input type="hidden" name="srchBbsNo" id="srchBbsNo" value="${param.srchBbsNo}" />
					<input type="hidden" name="srchWrtYmdBgng" id="srchWrtYmdBgng" value="${param.srchWrtYmdBgng}" />
					<input type="hidden" name="srchWrtYmdEnd" id="srchWrtYmdEnd" value="${param.srchWrtYmdEnd}" />

					<form:hidden path="crud" />
					<form:hidden path="nttNo" />
					<form:hidden path="nttGrp" />
					<form:hidden path="nttOrdr" />
					<form:hidden path="nttLevel" />
					<input type="hidden" id="delThumbFileNo" name="delThumbFileNo" value="" />
					<input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />

					<form:hidden path="bbsNo" />

                    <fieldset>
                        <legend class="text-title2 relative">
                            <c:choose>
								<c:when test="${!empty param.srchBbsNo || !empty param.bbsNo}">
								[${bbsSetupVO.bbsNm}]
								</c:when>
								<c:otherwise>게시글 </c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${nttVO.crud eq 'CREATE'}">등록</c:when>
								<c:when test="${nttVO.crud eq 'UPDATE'}">수정</c:when>
								<c:when test="${nttVO.crud eq 'ANSWER'}">답글 등록</c:when>
							</c:choose>
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
                            	<c:if test="${bbsSetupVO.bbsTy ne 3 && bbsSetupVO.bbsTy ne 4 && bbsSetupVO.bbsTy ne 6}"><%-- 이미지/동영상/FAQ게시판은 공지 없음 --%>

                            	<c:if test="${nttVO.crud ne 'ANSWER'}"><%--답글의 경우 공지로 등록 불가--%>
                                <tr>
                                    <th scope="row"><label for="ntcYn">공지글 등록</label></th>
                                    <td>
                                        <div class="form-check">
                                        	<form:checkbox cssClass="form-check-input" path="ntcYn" id="ntcYn" value="Y" />
                                            <label class="form-check-label" for="ntcYn">공지글</label>
                                        </div>
                                    </td>
                                </tr>
                                </c:if>
                                </c:if>
                                <c:if test="${bbsSetupVO.secretUseYn eq 'Y'}">
                                <tr>
                                    <th scope="row"><label for="secretYn">비밀글 등록</label></th>
                                    <td>
                                        <div class="form-check">
                                        	<form:checkbox cssClass="form-check-input" path="secretYn" id="secretYn" value="Y" />
                                            <label class="form-check-label" for="secretYn">비밀글</label>
                                        </div>
                                        <div class="pwd-div" ${nttVO.secretYn eq 'N'?'style="display:none;"':'' }">
											<form:password path="pswd" cssClass="form-control w-52" maxlength="20" />
											<p class="py-1">* 비밀글 열람시 필요한 비밀번호를 입력하세요.(사용자 화면에서만 사용, 복호화 불가)</p>
										</div>

                                    </td>
                                </tr>
                                </c:if>

                                <tr>
                                    <th scope="row"><label for="wrtr" class="require">작성자</label></th>
                                    <td>
                                    	<form:hidden path="wrtId" />
                                    	<form:input path="wrtr" cssClass="form-control w-52" maxlength="50" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="wrtYmd" class="require">작성일</label></th>
                                    <td>
                                    	<form:input type="date" class="form-control calendar" path="wrtYmd" />
                                    </td>
                                </tr>
								<c:if test="${bbsSetupVO.ctgryUseYn eq 'Y' }">
                                <tr>
                                    <th scope="row"><label for="ctgryNo" class="require">카테고리</label></th>
                                    <td>
                                    	<form:select path="ctgryNo" cssClass="form-control w-52" items="${bbsSetupVO.ctgryList}" itemLabel="ctgryNm" itemValue="ctgryNo" />
                                   	</td>
                                </tr>
                                </c:if>
								<tr>
                                    <th scope="row"><label for="ttl" class="require">제목</label></th>
                                    <td>
                                        <form:input path="ttl" class="form-control w-full" maxlength="250" />
                                    </td>
                                </tr>
								<c:if test="${!empty bbsSetupVO.getAddColumnChk01()}">
									<tr >
										<th scope="row"><label for="addValueChk01">${bbsSetupVO.getAddColumnChk01()}</label></th>
										<td>
											<div class="form-check">
												<form:checkbox cssClass="form-check-input" path="addValueChk01" id="addValueChk01" value="Y" />
											</div>
										</td>
									</tr>
								</c:if>
								
								<c:if test="${!empty bbsSetupVO.getAddColumnChk02()}">
									<tr>
										<th scope="row"><label for="addValueChk02">${bbsSetupVO.getAddColumnChk02()}</label></th>
										<td>
											<div class="form-check">
												<form:checkbox cssClass="form-check-input" path="addValueChk02" id="addValueChk02" value="Y" />
											</div>
										</td>
									</tr>
								</c:if>
								
								<c:if test="${!empty bbsSetupVO.getAddColumnChk03()}">
									<tr>
										<th scope="row"><label for="addValueChk03">${bbsSetupVO.getAddColumnChk03()}</label></th>
										<td>
											<div class="form-check">
												<form:checkbox cssClass="form-check-input" path="addValueChk03" id="addValueChk03" value="Y" />
											</div>
										</td>
									</tr>
								</c:if>
								
								<c:if test="${!empty bbsSetupVO.getAddColumnText01()}">
									<tr>
										<th scope="row"><label for="addValueText01">${bbsSetupVO.getAddColumnText01()}</label></th>
										<td>
											<form:input path="addValueText01" class="form-control w-full" maxlength="250" />
										</td>
									</tr>
								</c:if>
								
								<c:if test="${!empty bbsSetupVO.getAddColumnText02()}">
									<tr>
										<th scope="row"><label for="addValueText02">${bbsSetupVO.getAddColumnText02()}</label></th>
										<td>
											<form:input path="addValueText02" class="form-control w-full" maxlength="250" />
										</td>
									</tr>
								</c:if>
								
								<c:if test="${!empty bbsSetupVO.getAddColumnText03()}">
									<tr>
										<th scope="row"><label for="addValueText03">${bbsSetupVO.getAddColumnText03()}</label></th>
										<td>
											<form:input path="addValueText03" class="form-control w-full" maxlength="250" />
										</td>
									</tr>
								</c:if>
								
								<c:if test="${!empty bbsSetupVO.getAddColumnText04()}">
									<tr>
										<th scope="row"><label for="addValueText04">${bbsSetupVO.getAddColumnText04()}</label></th>
										<td>
											<form:input path="addValueText04" class="form-control w-full" maxlength="250" />
										</td>
									</tr>
								</c:if>
								
								<c:if test="${!empty bbsSetupVO.getAddColumnText05()}">
									<tr>
										<th scope="row"><label for="addValueText05">${bbsSetupVO.getAddColumnText05()}</label></th>
										<td>
											<form:input path="addValueText05" class="form-control w-full" maxlength="250" />
										</td>
									</tr>
								</c:if>
								
								<c:if test="${!empty bbsSetupVO.getAddColumnText06()}">
									<tr>
										<th scope="row"><label for="addValueText06">${bbsSetupVO.getAddColumnText06()}</label></th>
										<td>
											<form:input path="addValueText06" class="form-control w-full" maxlength="250" />
										</td>
									</tr>
								</c:if>
								
								<c:if test="${!empty bbsSetupVO.getAddColumnText07()}">
									<tr>
										<th scope="row"><label for="addValueText07">${bbsSetupVO.getAddColumnText07()}</label></th>
										<td>
											<form:input path="addValueText07" class="form-control w-full" maxlength="250" />
										</td>
									</tr>
								</c:if>
								
								<c:if test="${!empty bbsSetupVO.getAddUniqueText01()}">
									<tr>
										<th scope="row"><label for="addUniqueText01">${bbsSetupVO.getAddUniqueText01()}</label></th>
										<td>
											<form:input path="addUniqueText01" class="form-control w-full" maxlength="250" />
										</td>
									</tr>
								</c:if>
                                
                                <tr>
                                    <th scope="row"><label for="cn" class="require">내용</label></th>
                                    <td>
                                        <form:textarea path="cn" class="form-control w-full" title="내용" cols="30" rows="4" />
                                    </td>
                                </tr>
                                <%-- 썸네일 --%>
								<c:if test="${bbsSetupVO.thumbUseYn eq 'Y'}">
                                <tr>
                                    <th scope="row"><label for="form-item6">썸네일</label></th>
                                    <td>
                                    	<c:if test="${not empty nttVO.bbsThumbFile.fileNo}">
										<div style="display:block;" id="thumbFileViewDiv${nttVO.bbsThumbFile.fileNo}">
											<img src="/comm/getImage?srvcId=BBS&amp;upNo=${nttVO.bbsThumbFile.upNo}&amp;fileTy=${nttVO.bbsThumbFile.fileTy }&amp;fileNo=${nttVO.bbsThumbFile.fileNo}&amp;thumbYn=Y" alt="썸네일 이미지" />
											<a href="/comm/getFile?srvcId=BBS&amp;upNo=${nttVO.bbsThumbFile.upNo }&amp;fileTy=${nttVO.bbsThumbFile.fileTy }&amp;fileNo=${nttVO.bbsThumbFile.fileNo }">
												${nttVO.bbsThumbFile.orgnlFileNm} (용량 : ${fnc:fileSize(nttVO.bbsThumbFile.fileSz)}, 다운로드 : ${nttVO.bbsThumbFile.dwnldCnt}회)</a>&nbsp;
											<a href="#f_delFile" onclick="f_delFile('${nttVO.bbsThumbFile.fileNo}', 'THUMB', '${nttVO.bbsThumbFile.fileNo}'); return false;"><i class="fa fa-trash"></i></a>
										</div>
										</c:if>

										<div id="thumbFileDiv" <c:if test="${not empty nttVO.bbsThumbFile.fileNo}">style="display: none;"</c:if>>
											<input type="file" id="thumbFile" name="thumbFile" onchange="f_thumbnailFileChk(this)" class="form-control w-full" accept="image/*"/>
											<p class="py-1">※ 썸네일 이미지는 jpg, png, gif 파일만 가능합니다.</p>
										</div>

                                    </td>
                                </tr>
                                </c:if>
                                <%-- 첨부파일 --%>
								<c:if test="${bbsSetupVO.atchfileUseYn eq 'Y' && bbsSetupVO.atchfileCnt > 0}">
                                <tr>
                                    <th scope="row"><label for="form-item6">파일첨부</label></th>
                                    <td>
                                    	<c:forEach var="fileList" items="${nttVO.bbsFileList }" varStatus="status">
											<div id="attachFileViewDiv${fileList.fileNo}">
												<a href="/comm/getFile?srvcId=BBS&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">
													${fileList.orgnlFileNm} (용량 : ${fnc:fileSize(fileList.fileSz)}, 다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;
												<a href="#f_delFile" onclick="f_delFile('${fileList.fileNo}', 'ATTACH', '${status.index}'); return false;"><i class="fa fa-trash"></i></a>
											</div>
										</c:forEach>

										<c:forEach begin="0" end="${bbsSetupVO.atchfileCnt-1}" varStatus="status"><!-- 첨부파일 갯수 -->
										<div id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(nttVO.bbsFileList) }">style="display:none;"</c:if>>
											<input type="file" id="attachFile${status.index}" name="attachFile${status.index}" onchange="f_fileCheck(this);" class="form-control w-full" onchange="f_fileCheck(this);" />
										</div>
										</c:forEach>

                                        <p class="py-1">※ 첨부파일은 최대 ${bbsSetupVO.atchfileCnt}개까지 가능하며 ${bbsSetupVO.atchfilePermExtnVal } 파일만 가능합니다. (첨부파일 용량제한 : ${bbsSetupVO.atchfileSz}MB 이하)</p>
                                    </td>
                                </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </fieldset>

                    <c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}&amp;srchBbsNo=${param.srchBbsNo }&amp;srchWrtYmdBgng=${param.srchWrtYmdBgng}&amp;srchWrtYmdEnd=${param.srchWrtYmdEnd}" />
                    <div class="btn-group mt-8 right">
                        <button type="submit" class="btn-primary large shadow">저장</button>
	                    <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
                    </div>

                </form:form>


                <script>

                function f_thumbnailFileChk(fileObj){
                	if(fileObj.value != ""){

                		var file = fileObj.value;
                		var fileExt = file.substring(file.lastIndexOf('.') + 1, file.length).toLowerCase();
                		var reg = /gif|jpg|png|bmp/i;

                		if(reg.test(fileExt) == false) {
                			alert("썸네일이미지는 확장자가 gif, jpg, png, bmp로 된\n파일만 첨부 가능합니다.");
                			fileObj.value = "";
                			return false;
                		}
                		return true;
                	}
                }

                function f_fileCheck(obj) {
            		if(obj.value != ""){
            			<c:set var="arrAtchfilePermExtn" value="${fn:split(bbsSetupVO.atchfilePermExtnVal, ', ')}" />
            			<c:if test="${fn:length(arrAtchfilePermExtn) > 0}">
            			/* 첨부파일 확장자 체크*/
            			var arrAtchfilePermExtn = new Array();
            			<c:forEach items="${arrAtchfilePermExtn}" var="atchfilePermExtn">
            			arrAtchfilePermExtn.push("${atchfilePermExtn}");
            			</c:forEach>

            			var file = obj.value;
            			var fileExt = file.substring(file.lastIndexOf('.') + 1, file.length).toLowerCase();
            			var isFileExt = false;

            			for (var i = 0; i < arrAtchfilePermExtn.length; i++) {
            				if (arrAtchfilePermExtn[i] == fileExt) {
            					isFileExt = true;
            					break;
            				}
            			}

            			if (!isFileExt) {
            				alert("<spring:message code='errors.ext.limit' arguments='" + arrAtchfilePermExtn + "' />");
            				obj.value = "";
            				return false;
            			}
            			/* 첨부파일 확장자 체크*/
            			</c:if>

            			/* 첨부파일 사이즈 체크*/
            			var uploadFileSize = 0;
            			var limitSize = <c:out value="${bbsSetupVO.atchfileSz}" default="0"/>;
            			var	uploadFileSize = (obj.files[0].size / 1024);

            			//메가바이트(MB)단위 변환
            			uploadFileSize = (Math.round((uploadFileSize / 1024) * 100) / 100);

            			if(limitSize != 0 && uploadFileSize > limitSize){
            				alert("<spring:message code='errors.exceed.limit' arguments='" + uploadFileSize + ";" + limitSize + "' argumentSeparator=';'/>");
            				obj.value = "";
            				return false;
            			}
            			/* 첨부파일 사이즈 체크*/
            		}
            	}

                function f_delFile(fileNo, type, spanNo){
                	if(confirm("삭제하시겠습니까?")){
                		if(type == "ATTACH"){
                			if($("#delAttachFileNo").val()==""){
                				$("#delAttachFileNo").val(fileNo);
                			}else{
                				$("#delAttachFileNo").val($("#delAttachFileNo").val()+","+fileNo);
                			}
                			$("#attachFileViewDiv"+fileNo).remove();
                			$("#attachFileInputDiv"+spanNo).show();
                		}else{
                			$("#delThumbFileNo").val(fileNo);
                			$("#thumbFileViewDiv" + spanNo).remove();
                			$("#thumbFileDiv").show();
                		}
                	}
                }

                $(function(){
					var jsCKEditorHelper;
                	<c:if test="${bbsSetupVO.editrUseYn eq 'Y'}">
						jsCKEditorHelper = new JsCKEditorHelperOnline();
						jsCKEditorHelper.init('#cn');
               		</c:if>

                	//비밀번호
                	$("input[name='secretYn']").on("change", function(){
                		if($(this).is(':checked')){
                			$(".pwd-div").css({"display":""});
                		} else {
                			$(".pwd-div").css({"display":"none"});
                		}
                	});

                	//작성일
                	if($("#wrtYmd").val() == ""){
                		$("#wrtYmd").val(f_getToday());
                	}


                	$("form[name='frmNtt']").validate({
                	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
                	    rules : {
                	    	bbsNo	: { required : true, min:1 }
                	    	, ttl	: { required : true }
                	    	, cn	: { required : true }
                	    },
                	    messages : {
                	    	bbsNo : { required : "게시판을 선택하세요", min:"게시판을 선택하세요"}
                	    	, ttl : { required : "제목을 입력하세요"}
                	    	, cn : { required : "내용을 입력하세요"}
                	    },
                	    submitHandler: function (frm) {
               	            if (confirm('<spring:message code="action.confirm.save"/>')) {
               	            	frm.submit();
               	        	}else{
               	        		return false;
               	        	}
                	    }
                	});


                });

                </script>