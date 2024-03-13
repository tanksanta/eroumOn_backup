<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<form:form modelAttribute="nttVO" method="post" name="frmNtt" id="frmNtt" enctype="multipart/form-data" action="./action">
				<form:hidden path="crud" />
				<form:hidden path="bbsNo" />
				<form:hidden path="nttNo" />

				<p class="text-title2">상세정보</p>
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
                            <th scope="row">카테고리</th>
                            <td>${nttVO.ctgryNm}</td>
                        </tr>
                        </c:if>
                        <tr>
                            <th scope="row">제목</th>
                            <td>${nttVO.ttl}</td>
                        </tr>
                        <c:if test="${!empty bbsSetupVO.getAddColumnChk01()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddColumnChk01()}</th>
                                <td>${nttVO.addValueChk01}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty bbsSetupVO.getAddColumnChk02()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddColumnChk02()}</th>
                                <td>${nttVO.addValueChk02}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty bbsSetupVO.getAddColumnChk03()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddColumnChk03()}</th>
                                <td>${nttVO.addValueChk03}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty bbsSetupVO.getAddColumnText01()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddColumnText01()}</th>
                                <td>${nttVO.addValueText01}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty bbsSetupVO.getAddColumnText02()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddColumnText02()}</th>
                                <td>${nttVO.addValueText02}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty bbsSetupVO.getAddColumnText03()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddColumnText03()}</th>
                                <td>${nttVO.addValueText03}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty bbsSetupVO.getAddColumnText04()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddColumnText04()}</th>
                                <td>${nttVO.addValueText04}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty bbsSetupVO.getAddColumnText05()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddColumnText05()}</th>
                                <td>${nttVO.addValueText05}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty bbsSetupVO.getAddColumnText06()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddColumnText06()}</th>
                                <td>${nttVO.addValueText06}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty bbsSetupVO.getAddColumnText07()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddColumnText07()}</th>
                                <td>${nttVO.addValueText07}</td>
                            </tr>
                        </c:if>
                        <c:if test="${!empty bbsSetupVO.getAddUniqueText01()}">
                            <tr>
                                <th scope="row">${bbsSetupVO.getAddUniqueText01()}</th>
                                <td>${nttVO.addUniqueText01}</td>
                            </tr>
                        </c:if>
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
				<c:if test="${bbsSetupVO.bbsTy eq '5' && !empty nttVO.ansTtl }">
                <fieldset>
                    <legend class="text-title2 relative">
                        답변
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
                                <th scope="row">답변일</th>
                                <td> ${nttVO.ansYmd}</td>
                            </tr>
                            <tr>
                                <th scope="row">답변제목</th>
                                <td>${nttVO.ansTtl}</td>
                            </tr>
                            <tr>
                                <th scope="row">답변내용</th>
                                <td>${nttVO.ansCn}</td>
                            </tr>
                        </tbody>
                    </table>
                </fieldset>
                </c:if>

				<c:set var="pageParam" value="srchBbsNo=${param.srchBbsNo}&amp;curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage}&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}&amp;srchWrtYmdBgng=${param.srchWrtYmdBgng}&amp;srchWrtYmdEnd=${param.srchWrtYmdEnd}" />
                <div class="btn-group mt-8 right">
                    <c:if test="${nttVO.useYn eq 'N'}">
						<c:if test="${nttVO.ntcYn eq 'N' && bbsSetupVO.bbsTy eq '2'}"><%--답글형 게시판이고 공지글이 아닐경우 경우 --%>
					<a href="./form?srchBbsNo=${nttVO.bbsNo}&amp;bbsNo=${nttVO.bbsNo}&amp;nttGrp=${nttVO.nttGrp}&amp;nttOrdr=${nttVO.nttOrdr}&amp;nttLevel=${nttVO.nttLevel}&amp;srchBbsNo=${param.srchBbsNo}" class="btn-warning large shadow">답글</a>
						</c:if>
						<c:if test="${nttVO.ntcYn eq 'N' && bbsSetupVO.bbsTy eq '5'}"><%--Q&A 게시판이고 공지글이 아닐경우 경우 --%>
					<a href="./answer?srchBbsNo=${nttVO.bbsNo}&amp;bbsNo=${nttVO.bbsNo}&amp;nttNo=${nttVO.nttNo}" class="btn-warning large shadow">답변</a>
						</c:if>
						<mngrAuth:btn btnTy="modify" btnClass="btn-success large shadow" path="${_curPath}" mngrSession="${_mngrSession }" modifyParam="?srchBbsNo=${nttVO.bbsNo}&amp;bbsNo=${nttVO.bbsNo}&amp;nttNo=${nttVO.nttNo}&amp;${pageParam}">수정</mngrAuth:btn>
						<mngrAuth:btn btnTy="use" btnClass="btn-danger large shadow" path="${_curPath}" mngrSession="${_mngrSession }" script="f_delYnChg('N'); return false;">삭제</mngrAuth:btn>
                    </c:if>
                    <c:if test="${nttVO.useYn eq 'Y'}">
						<mngrAuth:btn btnTy="delete" btnClass="btn-danger large shadow" path="${_curPath}" mngrSession="${_mngrSession }" script="f_delete(); return false;">완전삭제</mngrAuth:btn>
                    </c:if>

                    <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
                    <a href="./form?srchBbsNo=${param.srchBbsNo}&amp;nttNo=${param.nttNo}&amp;bbsNo=${param.bbsNo}" class="btn-success large shadow">수정</a>
                </div>
            </form:form>


            <script>
			function f_delYnChg(){
				if(confirm("'사용안함'처리되어 목록에서 보이지 않습니다.")){
					$.ajax({
						type : "post",
						url: './delYnChg.json',
						data: 'bbsNo=${nttVO.bbsNo}&nttNo=${nttVO.nttNo}',
						dataType: 'json'
					}).done(function(json) {
						if(json){
							alert("사용안함 처리 되었습니다.");
							location.reload();
						}else{
							alert("상태변경에 실패하였습니다\n\n잠시후 다시 시도해 주시기 바랍니다.");
						}
					}).fail(function(xhr,status,errorThrown){
	            		console.log(xhr, status, errorThrown);
					});
				}
			}

			function f_delete(){
		        if (confirm("정말 삭제하시겠습니까?\n모든 정보가 삭제되어 복구가 불가능합니다.")) {
		        	$("#crud").val("DELETE");
					$("#frmNtt").submit();
		    	}else{
		    		return false;
		    	}
			}
			</script>
