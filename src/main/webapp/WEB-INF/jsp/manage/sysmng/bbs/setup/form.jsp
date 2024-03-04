<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<form:form name="frmBbsSetup" id="frmBbsSetup" modelAttribute="bbsSetupVO" method="post" action="./action" enctype="multipart/form-data">
				<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />
				<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
				<input type="hidden" name="srchUseYn" id="srchUseYn" value="${param.srchUseYn }" />
				<input type="hidden" name="srchBbsTy" id="srchBbsTy" value="${param.srchBbsTy }" />
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
				<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />

				<form:hidden path="crud" />
				<form:hidden path="bbsNo" />

                    <fieldset>
                        <legend class="text-title2 relative">

                            ${bbsSetupVO.crud eq 'CREATE'?'등록':'상세/수정' }
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
                                    <th scope="row"><label for="bbsNm" class="require">게시판명</label></th>
                                    <td>
                                        <form:input path="bbsNm" class="form-control w-90" title="게시판명" placeholder="게시판명" maxlength="100" />
                                    </td>
                                </tr>
                                
                                <tr>
                                    <th scope="row"><label for="srvcCd" class="require">서비스</label></th>
                                    <td>
                                        <form:input path="srvcCd" class="form-control w-90" title="서비스" placeholder="서비스" maxlength="50" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="bbsCd" class="require">게시판코드</label></th>
                                    <td>
                                        <form:input path="bbsCd" class="form-control w-90" title="게시판코드" placeholder="게시판코드" maxlength="50" />
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="bbsTy" class="require">게시판 유형</label></th>
                                    <td>

                                   	<c:choose>
										<c:when test="${bbsSetupVO.crud == 'CREATE' }">
                                        <div class="form-check-group">
                                        	<c:forEach items="${boardTyCode}" var="bt" varStatus="status">
                                            <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="bbsTy" id="bbsTy${status.index}" value="${bt.key }" />
                                                <label class="form-check-label" for="bbsTy${status.index}">${bt.value}</label>
                                            </div>
                                            </c:forEach>
                                        </div>
                                        <p class="py-1 text-danger bbs-ty-msg" style="display:none;">* 이미지/동영상 유형의 게시판은 '첨부파일 사용'여부를 확인하세요.</p>
                                        </c:when>
                                        <c:otherwise>
										${boardTyCode[bbsSetupVO.bbsTy]}
										<form:hidden path="bbsTy" />
										</c:otherwise>
                                    </c:choose>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="useYn1" class="require">사용 여부</label></th>
                                    <td>
                                        <div class="form-check-group">
                                            <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="useYn" id="useYn1" value="Y"/>
                                                <label class="form-check-label" for="useYn1">사용</label>
                                            </div>
                                            <div class="form-check">
                                                <form:radiobutton cssClass="form-check-input" path="useYn" id="useYn2" value="N"/>
                                                <label class="form-check-label" for="useYn2">미사용</label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="secretUseYn1" class="require">공개/비공개</label></th>
                                    <td>
                                        <div class="form-check-group">
                                            <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="secretUseYn" id="secretUseYn1" value="Y"/>
                                                <label class="form-check-label" for="secretUseYn1">사용</label>
                                            </div>
                                            <div class="form-check">
                                                <form:radiobutton cssClass="form-check-input" path="secretUseYn" id="secretUseYn2" value="N"/>
                                                <label class="form-check-label" for="secretUseYn2">미사용</label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="editrUseYn1" class="require">에디터 사용</label></th>
                                    <td>
                                        <div class="form-check-group">
                                           <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="editrUseYn" id="editrUseYn1" value="Y"/>
                                                <label class="form-check-label" for="editrUseYn1">사용</label>
                                            </div>
                                            <div class="form-check">
                                                <form:radiobutton cssClass="form-check-input" path="editrUseYn" id="editrUseYn2" value="N"/>
                                                <label class="form-check-label" for="editrUseYn2">미사용</label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="mbrAuthrtYn1" class="require">사용자 작성 권한</label></th>
                                    <td>
                                        <div class="form-check-group">
                                            <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="mbrAuthrtYn" id="mbrAuthrtYn1" value="Y"/>
                                                <label class="form-check-label" for="mbrAuthrtYn1">사용</label>
                                            </div>
                                            <div class="form-check">
                                                <form:radiobutton cssClass="form-check-input" path="mbrAuthrtYn" id="mbrAuthrtYn2" value="N"/>
                                                <label class="form-check-label" for="mbrAuthrtYn2">미사용</label>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="otptCo" class="require">게시글 목록 출력 건수</label></th>
                                    <td>
                                        <form:select path="otptCo" class="form-control w-39">
                                            <c:forEach begin="10" end="50" step="10" var="index">
                                            <form:option value="${index}" label="${index}개" />
                                            </c:forEach>
                                        </form:select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="ctgryUseYn">카테고리 사용여부</label></th>
                                    <td>
                                        <div class="form-check-group">
                                            <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="ctgryUseYn" id="ctgryUseYn1" value="Y"/>
                                                <label class="form-check-label" for="ctgryUseYn1">사용</label>
                                            </div>
                                            <div class="form-check">
                                                <form:radiobutton cssClass="form-check-input" path="ctgryUseYn" id="ctgryUseYn2" value="N"/>
                                                <label class="form-check-label" for="ctgryUseYn2">미사용</label>
                                            </div>
                                        </div>
										<%-- 카테고리 영역 --%>
                                        <div class="border-t mt-4 pt-4 pb-2 ctgry-use-yn-div" style="display:none;">
                                            <div class="form-group w-100">
                                            	<input type="hidden" name="ctgryValue" id="ctgryValue" />
                                                <input type="text" class="form-control flex-1" name="ctgryNm" id="ctgryNm" placeholder="카테고리명" >
                                                <button type="button" class="btn-primary" onclick="f_ctgryAdd(); return false;">추가</button>
                                            </div>
                                            <div class="mt-2">
                                            	<form:select path="ctgry" cssClass="form-control w-100" items="${bbsSetupVO.ctgryList}" itemLabel="ctgryNm" itemValue="ctgryValue">
                                            	</form:select>
                                            </div>
                                            <div class="w-100 mt-1 text-right">
                                                <button type="button" class="btn-success" onclick="f_ctgryMod(); return false;">수정</button>
                                                <button type="button" class="btn-danger" onclick="f_ctgryRemove(); return false;">삭제</button>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="atchfileUseYn1">첨부파일 사용여부</label></th>
                                    <td>
                                        <div class="form-check-group">
                                            <div class="form-check">
                                            	<form:radiobutton cssClass="form-check-input" path="atchfileUseYn" id="atchfileUseYn1" value="Y"/>
                                                <label class="form-check-label" for="atchfileUseYn1">사용</label>
                                            </div>
                                            <div class="form-check">
                                                <form:radiobutton cssClass="form-check-input" path="atchfileUseYn" id="atchfileUseYn2" value="N"/>
                                                <label class="form-check-label" for="atchfileUseYn2">미사용</label>
                                            </div>
                                        </div>

                                        <div class="border-t mt-4 pt-4 pb-2 atchfile-use-yn-div" style="display:none;">
                                            <div>
                                                <div class="form-group">
                                                    <label for="atchfileCnt" class="mr-2">첨부파일 개수</label>
                                                    <form:input type="text" class="form-control w-45" path="atchfileCnt" maxlength="2" />
                                                </div>
                                                <div class="form-group ml-20">
                                                    <label for="atchfileSz" class="mr-2">사이즈 제한</label>
                                                    <form:input type="text" class="form-control w-45" path="atchfileSz" maxlength="3" />
                                                    <span>MB (0일 경우 제한 없음)</span>
                                                </div>
                                            </div>

                                            <div class="mt-3">
                                            	<c:forEach items="${extnKindCode}" var="iem" varStatus="status">
                                                <div class="form-check my-px mr-1.5">
                                                	<form:checkbox cssClass="form-check-input" path="atchfilePermExtn" id="atchfilePermExtn${status.index}" value="${iem.key}"/>
                                                    <label class="form-check-label" for="atchfilePermExtn${status.index}">${iem.value}</label>
                                                </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
								<%-- 이미지/동영상 --%>
                                <tr id="thumbTr">
                                    <th scope="row"><label for="thumbUseYn1">썸네일 사용여부</label></th>
                                    <td>
                                        <div class="form-group">
                                            <div class="form-check-group">
                                                <div class="form-check">
	                                            	<form:radiobutton cssClass="form-check-input" path="thumbUseYn" id="thumbUseYn1" value="Y"/>
	                                                <label class="form-check-label" for="thumbUseYn1">사용</label>
	                                            </div>
	                                            <div class="form-check">
	                                                <form:radiobutton cssClass="form-check-input" path="thumbUseYn" id="thumbUseYn2" value="N"/>
	                                                <label class="form-check-label" for="thumbUseYn2">미사용</label>
	                                            </div>
                                            </div>
                                            <p class="ml-6">* 목록에서 사용할 이미지를 첨부합니다.</p>
                                        </div>
                                    </td>
                                </tr>
								<%-- Q&A --%>
                                <tr id="picSmsTr" style="display:none;">
                                    <th scope="row"><label for="picSmsYn1" class="require">담당자 SMS 전송</label></th>
                                    <td>
                                        <div class="form-group">
                                            <div class="form-check-group">
                                                <div class="form-check">
	                                            	<form:radiobutton cssClass="form-check-input" path="picSmsYn" id="picSmsYn1" value="Y"/>
	                                                <label class="form-check-label" for="picSmsYn1">사용</label>
	                                            </div>
	                                            <div class="form-check">
	                                                <form:radiobutton cssClass="form-check-input" path="picSmsYn" id="picSmsYn2" value="N"/>
	                                                <label class="form-check-label" for="picSmsYn2">미사용</label>
	                                            </div>
                                            </div>

                                            <div class="form-group ml-6 pic-sms-yn-div" style="display:none;">
                                                <label for="picSms" class="w-30">담당자 휴대폰 번호</label>
                                                <form:input type="text" class="form-control w-85" path="picSms" placeholder="붙임표(-) 제외하고 입력" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr id="picEmlTr" style="display:none;">
                                    <th scope="row"><label for="picEmlYn1" class="require">담당자 이메일 전송</label></th>
                                    <td>
                                        <div class="form-group">
                                            <div class="form-check-group">
                                                <div class="form-check">
	                                            	<form:radiobutton cssClass="form-check-input" path="picEmlYn" id="picEmlYn1" value="Y"/>
	                                                <label class="form-check-label" for="picEmlYn1">사용</label>
	                                            </div>
	                                            <div class="form-check">
	                                                <form:radiobutton cssClass="form-check-input" path="picEmlYn" id="picEmlYn2" value="N"/>
	                                                <label class="form-check-label" for="picEmlYn2">미사용</label>
	                                            </div>
                                            </div>
                                            <div class="form-group ml-6 pic-eml-yn-div" style="display:none;">
                                                <label for="picEml" class="w-30">담당자 이메일</label>
                                                <form:input type="text" class="form-control w-85" path="picEml" placeholder="예) help@icubesystesms.co.kr" />
                                            </div>
                                        </div>
                                    </td>
                                </tr>

                                <tr style='<c:if test="${empty bbsSetupVO.addColumnText01}">display:none</c:if>'>
                                    <th scope="row"><label for="addColumnText01">추가 텍스트 필드01 </label></th>
                                    <td>
                                        <form:input path="addColumnText01" class="form-control w-90" maxlength="255" />
                                    </td>
                                </tr>
                                <tr style='<c:if test="${empty bbsSetupVO.getAddColumnText02()}">display:none</c:if>'>
                                    <th scope="row"><label for="addColumnText02">추가 텍스트 필드02 </label></th>
                                    <td>
                                        <form:input path="addColumnText02" class="form-control w-90" maxlength="255" />
                                    </td>
                                </tr>
                                <tr style='<c:if test="${empty bbsSetupVO.getAddColumnText03()}">display:none</c:if>'>
                                    <th scope="row"><label for="addColumnText03">추가 텍스트 필드03 </label></th>
                                    <td>
                                        <form:input path="addColumnText03" class="form-control w-90" maxlength="255" />
                                    </td>
                                </tr>
                                <tr style='<c:if test="${empty bbsSetupVO.getAddColumnText04()}">display:none</c:if>'>
                                    <th scope="row"><label for="addColumnText04">추가 텍스트 필드04 </label></th>
                                    <td>
                                        <form:input path="addColumnText04" class="form-control w-90" maxlength="255" />
                                    </td>
                                </tr>
                                <tr style='<c:if test="${empty bbsSetupVO.getAddColumnText05()}">display:none</c:if>'>
                                    <th scope="row"><label for="addColumnText05">추가 텍스트 필드05 </label></th>
                                    <td>
                                        <form:input path="addColumnText05" class="form-control w-90" maxlength="255" />
                                    </td>
                                </tr>
                                <tr style='<c:if test="${empty bbsSetupVO.getAddColumnText06()}">display:none</c:if>'>
                                    <th scope="row"><label for="addColumnText06">추가 텍스트 필드06 </label></th>
                                    <td>
                                        <form:input path="addColumnText06" class="form-control w-90" maxlength="255" />
                                    </td>
                                </tr>
                                <tr style='<c:if test="${empty bbsSetupVO.getAddColumnText07()}">display:none</c:if>'>
                                    <th scope="row"><label for="addColumnText07">추가 텍스트 필드07 </label></th>
                                    <td>
                                        <form:input path="addColumnText07" class="form-control w-90" maxlength="255" />
                                    </td>
                                </tr>
                                <tr style='<c:if test="${empty bbsSetupVO.getAddColumnChk01()}">display:none</c:if>'>
                                    <th scope="row"><label for="addColumnChk01">추가 체크 필드01 </label></th>
                                    <td>
                                        <form:input path="addColumnChk01" class="form-control w-90" maxlength="255" />
                                    </td>
                                </tr>
                                <tr style='<c:if test="${empty bbsSetupVO.getAddColumnChk02()}">display:none</c:if>'>
                                    <th scope="row"><label for="addColumnChk02">추가 체크 필드02 </label></th>
                                    <td>
                                        <form:input path="addColumnChk02" class="form-control w-90" maxlength="255" />
                                    </td>
                                </tr>
                                <tr style='<c:if test="${empty bbsSetupVO.getAddColumnChk03()}">display:none</c:if>'>
                                    <th scope="row"><label for="addColumnChk03">추가 체크 필드03 </label></th>
                                    <td>
                                        <form:input path="addColumnChk03" class="form-control w-90" maxlength="255" />
                                    </td>
                                </tr>
                                <c:if test="${!empty bbsSetupVO.addUniqueText01}">
                                    <tr>
                                        <th scope="row"><label for="addUniqueText01">추가 유일값 필드01 </label></th>
                                        <td>
                                            <form:input path="addUniqueText01" class="form-control w-90" maxlength="255" />
                                        </td>
                                    </tr>
                                </c:if>
                                
                            </tbody>
                        </table>
                    </fieldset>

                    <div class="btn-group right mt-8">
                        <button type="submit" class="btn-primary large shadow">저장</button>

                        <c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}&amp;srchBbsTy=${param.srchBbsTy }&amp;srchUseYn=${param.srchUseYn }" />
	                    <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
                    </div>
                </form:form>


                <script>

                function f_ctgryAdd() {
                	if( $("#ctgryNm").val() == "" ) {
                		alert("카테고리명을 입력하여 주십시요");
                		$("#ctgryNm").focus();
                		return false;
                	}
                	if( $("#ctgryValue").val() == "" ) {
                		var optLength = $("#ctgry > option").length;
                		var text = $("#ctgryNm").val();
                		$("#ctgry").append( new Option( text , "C-" + (optLength + 1), false, false  ) );

                	} else {
                		var selectValue = $("#ctgryValue").val();
                		var values = selectValue.split("-");
                		$("#ctgry option").each(function(){
                			if($(this).val() == selectValue) {
                				$(this).text( $("#ctgryNm").val() );
                				$(this).val( "U-" + values[1]);
                			}
                		});
                		$("#ctgryValue").val("");
                	}
                	$("#ctgryNm").val("");
                }
                function f_ctgryMod() {
                	var option = $("#ctgry option:selected");
                	if( option.length != 1 ) {
                		alert("수정할 항목을 하나만 선택하여 주십시요");
                		return;
                	}
                	$("#ctgryNm").val(option.text());
                	$("#ctgryValue").val(option.val());
                }
                function f_ctgryRemove() {
                	$("#ctgry option:selected").each(function(){
                		var values = $(this).val().split("-");
                		if( "C" == values[0]) {
                			$(this).remove();
                			return;
                		} else {
                			var html = getCtgryForm( "D-" + values[1], $(this).text() );
                			$("#frmBbsSetup").append( html );
                			$(this).remove();
                		}
                	});
                }
                function getCtgryForm(value, text) {
                	var html  = "<input type='hidden' name='ctgryValues' value='" + value  + "' />";
                		html += "<input type='hidden' name='ctgryTexts'  value='" + text + "' />";
                	return html;
                }

                function f_bbs_set(){
	            	let listCnt = [10, 20, 30, 40, 50];
	            	let imgListCnt = [6, 9, 12, 15, 18, 21, 24, 27, 30];

            		<c:choose>
            		<c:when test="${bbsSetupVO.crud eq 'CREATE' }">
					let bbsTy = $("input[name='bbsTy']:checked").val();
            		</c:when>
            		<c:otherwise>
					let bbsTy = $("input[name='bbsTy']").val();
            		</c:otherwise>
            		</c:choose>

					console.log("bbsTy: " + bbsTy);
					// default set
					$("select#otptCo").empty();
					$.each(listCnt, function(key, value){
						$("select#otptCo").append("<option value='"+ value +"'>"+ value +"개</option>");
					});
					$("#thumbTr").css({"display":""});
					$(".bbs-ty-msg, #picSmsTr, #picEmlTr").css({"display":"none"});

					if(bbsTy === "2"){ // 답글형
						$("#thumbTr").css({"display":"none"});
					}else if(bbsTy === "3" || bbsTy === "4"){ // 이미지 + 동영상
						$(".bbs-ty-msg").css({"display":""});
						$("select#otptCo").empty();
						$.each(imgListCnt, function(key, value){
							$("select#otptCo").append("<option value='"+ value +"'>"+ value +"개</option>");
						});
					}else if(bbsTy === "5"){ // Q&A
						$("#thumbTr").css({"display":"none"});
						$("#picSmsTr, #picEmlTr").css({"display":""});
					}else if(bbsTy === "6"){ // FAQ
						$("#thumbTr").css({"display":"none"});
					}
					$("select#otptCo").val("${bbsSetupVO.otptCo}").prop("selected", true);
            	}

                $(function(){

                	// 게시판 타입별 view
                	f_bbs_set();
                	$("input[name='bbsTy']").on("click", function(){
                		f_bbs_set();
                	});

	               	$("input[name='ctgryUseYn']").on("click", function(){
	               		if($("input[name='ctgryUseYn']:checked").val() == "Y"){
	               			$(".ctgry-use-yn-div").slideDown("fast");
	               		}else{
	               			$(".ctgry-use-yn-div").slideUp("fast");
	               		}
	               	});
	               	if($("input[name='ctgryUseYn']:checked").val() == "Y"){
	               		$(".ctgry-use-yn-div").css({"display":""});
	               	}

	               	$("input[name='atchfileUseYn']").on("click", function(){
	               		if($("input[name='atchfileUseYn']:checked").val() == "Y"){
	               			$(".atchfile-use-yn-div").slideDown("fast");
	               		}else{
	               			$(".atchfile-use-yn-div").slideUp("fast");
	               		}
	               	});
	               	if($("input[name='atchfileUseYn']:checked").val() == "Y"){
	               		$(".atchfile-use-yn-div").css({"display":""});
	               	}

	               	$("input[name='picSmsYn']").on("click", function(){
	               		if($("input[name='picSmsYn']:checked").val() == "Y"){
	               			$(".pic-sms-yn-div").slideDown("fast");
	               		}else{
	               			$(".pic-sms-yn-div").slideUp("fast");
	               		}
	               	});
	               	if($("input[name='picSmsYn']:checked").val() == "Y"){
	               		$(".pic-sms-yn-div").css({"display":""});
	               	}

	               	$("input[name='picEmlYn']").on("click", function(){
	               		if($("input[name='picEmlYn']:checked").val() == "Y"){
	               			$(".pic-eml-yn-div").slideDown("fast");
	               		}else{
	               			$(".pic-eml-yn-div").slideUp("fast");
	               		}
	               	});
	               	if($("input[name='picEmlYn']:checked").val() == "Y"){
	               		$(".pic-eml-yn-div").css({"display":""});
	               	}


	               	$("form[name='frmBbsSetup']").validate({
	            	    ignore: "input[type='text']:hidden, [contenteditable='true']:not([name])",
	            	    rules : {
	            	    	bbsNm	: { required : true }
                            , srvcCd	: { required : true }
                            , bbsCd	: { required : true }
	            	    },
	            	    messages : {
	            	    	bbsNm : { required : "<spring:message arguments='" + $("#bbsNm").prop("title") + "' code='errors.required'/>"}
                            , srvcCd : { required : "<spring:message arguments='" + $("#srvcCd").prop("title") + "' code='errors.required'/>"}
                            , bbsCd : { required : "<spring:message arguments='" + $("#bbsCd").prop("title") + "' code='errors.required'/>"}
	            	    },
	            	    submitHandler: function (frm) {
	            	    	if(confirm('<spring:message code="action.confirm.save"/>')){
            	            	// Category
            	            	$("#ctgry option").each(function(){
            	            		var ctgryValue 	= $(this).val();
            	            		var ctgryText 	= $(this).text();
            	            		var html = getCtgryForm(ctgryValue, ctgryText);
            	            		$("#frmBbsSetup").append( html );
            	            	});
            	            	frm.submit();
            	        	}else{
            	        		return false;
            	        	}
	            	    }
	            	});
                });
                </script>