<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<form:form name="frmNtt" id="frmNtt" modelAttribute="nttVO" method="post" action="./action" enctype="multipart/form-data">
				<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />
				<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
				<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
				<input type="hidden" name="srchBbsNo" id="srchBbsNo" value="${param.srchBbsNo}" />
				<input type="hidden" name="srchWrtYmdBgng" id="srchWrtYmdBgng" value="${param.srchWrtYmdBgng}" />
				<input type="hidden" name="srchWrtYmdEnd" id="srchWrtYmdEnd" value="${param.srchWrtYmdEnd}" />

				<form:hidden path="crud" />
				<form:hidden path="bbsNo" />
				<form:hidden path="nttNo" />

				<p class="text-title2">게시글 답변 등록</p>
                <table class="table-detail">
                    <colgroup>
                        <col class="w-43">
                        <col>
                    </colgroup>
                    <tbody>
                    	<c:if test="${nttVO.ntcYn eq 'Y' }">
                        <tr>
                            <th scope="row">공지글 등록</th>
                            <td>
 								<div class="form-check">
                                	<form:checkbox cssClass="form-check-input" path="ntcYn" id="ntcYn" value="Y" disabled="true" />
                                    <label class="form-check-label" for="ntcYn">공지글</label>
                                </div>
                            </td>
                        </tr>
                        </c:if>
                        <c:if test="${nttVO.secretYn eq 'Y' }">
                        <tr>
                            <th scope="row">고객명</th>
                            <td>
                            	<div class="form-check">
                                	<form:checkbox cssClass="form-check-input" path="secretYn" id="secretYn" value="Y" disabled="true" />
                                    <label class="form-check-label" for="secretYn">비밀글</label>
                                </div>
                            </td>
                        </tr>
                        </c:if>
                        <tr>
                            <th scope="row">작성자</th>
                            <td>${nttVO.wrtr} (${nttVO.wrtId})</td>
                        </tr>
                        <tr>
                            <th scope="row">작성일</th>
                            <td>${nttVO.wrtYmd}</td>
                        </tr>
                        <c:if test="${bbsSetupVO.ctgryUseYn eq 'Y' }">
                        <tr>
                            <th scope="row">작성자</th>
                            <td>${nttVO.ctgryNm}</td>
                        </tr>
                        </c:if>
                        <tr>
                            <th scope="row">제목</th>
                            <td>${nttVO.ttl}</td>
                        </tr>
                        <tr>
                            <th scope="row">내용</th>
                            <td>${nttVO.cn}</td>
                        </tr>
                        <c:if test="${bbsSetupVO.thumbUseYn eq 'Y'}">
						<tr>
							<th scope="row">썸네일</th>
							<td>
								<c:if test="${nttVO.bbsThumbFile.fileNo > 0}">
								<div>
								<img src="<c:url value='/comm/getImage?srvcId=BBS&amp;upNo=${nttVO.bbsThumbFile.upNo}&amp;fileTy=${nttVO.bbsThumbFile.fileTy }&amp;fileNo=${nttVO.bbsThumbFile.fileNo}&amp;thumbAt=Y'/>" alt="썸네일 이미지" />
								</div>
								<a href="<c:url value='/comm/getFile?srvcId=BBS&amp;upNo=${nttVO.bbsThumbFile.upNo }&amp;fileTy=${nttVO.bbsThumbFile.fileTy }&amp;fileNo=${nttVO.bbsThumbFile.fileNo }'/>">${nttVO.bbsThumbFile.orgnlFileNm} (용량 : ${fnc:fileSize(nttVO.bbsThumbFile.fileSz)}, 다운로드 : ${nttVO.bbsThumbFile.dwnldCnt}회)</a>
								</c:if>
								<c:if test="${empty nttVO.bbsThumbFile.fileNo }">등록된 썸네일이 없습니다.</c:if>
							</td>
						</tr>
						</c:if>
						<c:if test="${nttVO.bbsFileList.size() > 0}">
						<tr>
							<th scope="row">첨부파일</th>
							<td>
								<c:forEach var="bbsFileList" items="${nttVO.bbsFileList}" varStatus="status">
								<a href="<c:url value='/comm/getFile?srvcId=BBS&amp;upNo=${bbsFileList.upNo }&amp;fileTy=${bbsFileList.fileTy }&amp;fileNo=${bbsFileList.fileNo }'/>">${bbsFileList.orgnlFileNm} (용량 : ${fnc:fileSize(bbsFileList.fileSz)}, 다운로드 : ${bbsFileList.dwnldCnt}회)</a><br/>
								</c:forEach>
							</td>
						</tr>
						</c:if>
                    </tbody>
                </table>



                <fieldset class="mt-13">
                    <legend class="text-title2 relative">
                        답변하기
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
                                <th scope="row">답변자</th>
                                <td> ${nttVO.answr} (${nttVO.ansId})</td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="ansYmd" class="require">답변일</label></th>
                                <td>
                                	<form:input type="date" class="form-control calendar" path="ansYmd" />
                                 </td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="ansTtl" class="require">답변제목</label></th>
                                <td>
                                	<form:input path="ansTtl" cssClass="form-control w-full" />
                               	</td>
                            </tr>
                            <tr>
                                <th scope="row"><label for="ansCn" class="require">답변내용</label></th>
                                <td>
                                	<form:textarea path="ansCn" class="form-control w-full" title="답변 내용" cols="30" rows="4" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>

				<c:set var="pageParam" value="srchBbsNo=${param.srchBbsNo}&amp;curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage}&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}&amp;srchWrtYmdBgng=${param.srchWrtYmdBgng}&amp;srchWrtYmdEnd=${param.srchWrtYmdEnd}" />
                <div class="btn-group mt-8 right">

                	<c:if test="${nttVO.delYn eq 'N'}">
						<mngrAuth:btn btnTy="save" btnClass="btn-success large shadow" path="${_curPath}" mngrSession="${_mngrSession }">저장</mngrAuth:btn>
						<mngrAuth:btn btnTy="use" btnClass="btn-danger large shadow" path="${_curPath}" mngrSession="${_mngrSession }" script="f_deleteAnswer('N'); return false;">답변 삭제</mngrAuth:btn>
					</c:if>

					<a href="#" onclick="history.back(); return false;" class="btn large shadow">이전</a>
                    <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
                </div>
            </form:form>


            <script>
            function f_deleteAnswer(){
                if (confirm('답변 내용을 삭제하시겠습니까?')) {
                	$.ajax({
                		type : "post",
                		url: './deleteAnswer.json',
                		data: 'bbsNo=${nttVO.bbsNo}&nttNo=${nttVO.nttNo}'
                	}).done(function(json) {
               			if(json){
               				alert("답변 내용이 초기화되었습니다.");
               				location.reload();
               			}else{
               				alert("변경에 실패하였습니다\n\n잠시후 다시 시도해 주시기 바랍니다.");
               			}
                	}).fail(function(xhr,status,errorThrown){
	            		console.log(xhr, status, errorThrown);
                	});
            	}
            }

            $(function(){
            	<c:if test="${bbsSetupVO.editrUseYn eq 'Y'}">
            	//tinymce editor
           		tinymce.overrideDefaults(baseConfig);
           		tinymce.init({selector:"#ansCn"});
           		</c:if>

            	//작성일
            	if($("#wrtYmd").val() == ""){
            		$("#wrtYmd").val(f_getToday());
            	}


           		$("form[name='frmNtt']").validate({
           		    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
           		    rules : {
           		    	ansTtl		: { required : true }
           		 		, ansYmd	: { required : true }
           		    	, answr		: { required : true }
           		    },
           		    messages : {
           		    	ansTtl 		: { required : "답변 제목을 입력하세요"}
           		 		, ansYmd	: { required : "답변일을 선택하세요" }
           		    	, answr 	: { required : "답변 내용을 입력하세요"}
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