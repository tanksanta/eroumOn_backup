<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
            <div id="page-content">
                <form:form name="frmDspy" id="frmDspy" modelAttribute="planningDspyVO" method="post" action="./action" enctype="multipart/form-data">
                <form:hidden path="crud" />
                <form:hidden path="planngDspyNo" />
                <form:hidden path="grpNo" />
                <input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />
                <input type="hidden" id="updtImgFileDc" name="updtImgFileDc" value="" />
                <input type="hidden" id="grpGdsTotal" name="grpGdsTotal" value="" />
                <input type="hidden" id="clickDataNum" name="clickDataNum" value="" />

				<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
				<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn}" />
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
				<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />

				<fieldset>
                        <legend class="text-title2 relative">
                            ${planningDspyVO.crud eq 'CREATE'?'등록':'수정' }
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
                                    <th scope="row"><label for="planngDspyNm" class="require">기획전명</label></th>
                                    <td><form:input type="text" class="form-control w-full" path="planngDspyNm" /></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="bgngDt" class="require">기간</label></th>
                                    <td>
                                        <div class="form-group" >
                                            <input type="date" class="form-control w-40 calendar" id="bgngDt" name="bgngDt" value="<fmt:formatDate value="${planningDspyVO.bgngDt}" pattern="yyyy-MM-dd" />"/>
                                            <input type="time" class="form-control w-35" name="bgngTime"  value="<fmt:formatDate value="${planningDspyVO.bgngDt}" pattern="HH:mm" />"/>
                                            <i>~</i>
                                            <input type="date" class="form-control w-35 calendar" id="endDt"  name="endDt" value="<fmt:formatDate value="${planningDspyVO.endDt}" pattern="yyyy-MM-dd" />"/>
                                            <input type="time" class="form-control w-35" name="endTime" value="<fmt:formatDate value="${planningDspyVO.endDt}" pattern="HH:mm" />"/>
                                         </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="dspyYn" class="require">상태</label></th>
									<td>
										<div class="form-group">
											<div class="form-check-group">
												<c:forEach var="sttus" items="${dspyYnCode}">
													<div class="form-check">
														<form:radiobutton path="dspyYn" class="form-check-input" id="${sttus.key}" value="${sttus.key}" />
														<label class="form-check-label" for="${sttus.key}">${sttus.value}</label>
													</div>
												</c:forEach>
											</div>
											</div>
									</td>
								</tr>
                                <tr>
                                    <th scope="row"><label for="form-item4" class="require">목록 이미지</label></th>
									<td><c:forEach var="fileList" items="${planningDspyVO.fileList }" varStatus="status">
											<div id="attachFileViewDiv${fileList.fileNo}" class="">
												<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp; <a href="#delFile" class="btn-secondary" onclick="delFile('${fileList.fileNo}', 'ATTACH', '${status.index}'); return false;"> 삭제</a>
												<div class="form-group mt-1 w-full">
													<label for="updtAttachFileDc${fileList.fileNo}"">대체텍스트</label> <input type="text" class="form-control flex-1 ml-2" id="updtAttachFileDc${fileList.fileNo}" name="updtAttachFileDc${fileList.fileNo}" value="${fileList.fileDc}" maxlength="200" data-update-dc>
												</div>
											</div>
										</c:forEach>

										<div id="attachFileDiv">
											<c:forEach begin="0" end="0" varStatus="status">
												<!-- 첨부파일 갯수 -->
												<div class="row" id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(planningDspyVO.fileList) }">style="display:none;"</c:if>>
													<div class="col-12">
														<div class="custom-file" id="uptAttach">
															<input type="file" class="form-control w-2/3" id="attachFile${status.index}" name="attachFile${status.index}" onchange="fileCheck(this);" />
														</div>
													</div>
													<div class="col-12">
														<div class="form-group mt-1 w-full">
															<label for="updtAttachFileDc${fileList.fileNo}"">대체텍스트</label> <input type="text" class="form-control flex-1 ml-2" id="attachFileDc${status.index}" name="attachFileDc${status.index}" maxlength="200">
														</div>
													</div>
												</div>
											</c:forEach>
										</div>
										</td>
								</tr>
                                <tr>
                                    <th scope="row"><label for="cn">프로모션 본문 영역</label></th>
                                    <td><form:textarea path="cn"  cols="30" rows="10" class="form-control w-full" /></td>

                                </tr>
                            </tbody>
                        </table>
                    </fieldset>

		<div id="fieldWrap">
         <!-- 디폴트 그룹 -->
         <div id="DummyField"  style="display:none;" >
		<fieldset class="mt-13 grpView/{num}/oriCL">
			<legend class="text-title2 relative">
				상품구성 <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
				</span>
			</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><div class="require">그룹명</div></th>
						<td><input class="form-control w-full grpNmVal" id="grpNmIdVal" name="grpNm/{num}/ori" data-rule-required="true" data-msg-required="그룹명은 필수 입력 항목입니다." ></td>
					</tr>
					<!--
					<tr>
						<th scope="row"><label for="">진열 개수</label></th>
						<td>
							<div class="form-check-group">
								<c:forEach var="co" items="${exhibiCo}" varStatus="status">
									<div class="form-check">
										<input type="radio" class="form-check-input" id="/{num}/oriexhbiCo${status.index}" name="exhbiCo/{num}/ori"  value="${co.key}" checked >
										<label class="form-check-label" for="/{num}/oriexhbiCo${status.index}">${co.value}</label>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					 -->
					<tr>
						<th scope="row"><label for="">노출 순서</label></th>
						<td><input type="number" class="form-control w-57 grpSortVal" id="sortNoIdVal" name="sortNo/{num}/ori" maxlength="1" min="1" title="최솟값은 1입니다."/></td>
					</tr>
				</tbody>
			</table>
			<p class="text-right my-3">
				<button type="button" class="btn grpRemoveBtn" data-del-btn="/{num}/oriCL">상품그룹 삭제</button>
				<button type="button" class="btn f_srchGds" data-bs-toggle="modal" data-bs-target="#gdsModal" data-grp-idx="/{num}/oriCL">상품검색</button>
			</p>

			<table class="table-list" >
				<colgroup>
					<col class="w-15">
					<col class="w-[15%]">
					<col>
					<col class="w-25">
					<col class="w-30">
					<col class="w-20">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">
							<div class="form-check">
							</div>
						</th>
						<th scope="col">상품코드</th>
						<th scope="col">상품명</th>
						<th scope="col">노출상태</th>
						<th scope="col">등록 기획전 수</th>
						<th scope="col">노출 순서</th>
					</tr>
				</thead>
				<tbody id="bodyView/{num}/ori" class="relGdsList/{num}/oriCL">
					<c:forEach var="resultList" items="${itemList}" varStatus="status">
						<tr class="draggableTr">
							<td>
								<div class="form-check">
									<button type="button" class="btn-danger tiny btn-relGds-remove">
										<i class="fa fa-trash"></i>
									</button>
									<input type="hidden" name="gdsNo/{num}/ori" value="${resultList.gdsNo }">
								</div>
							</td>
							<td><a href="#">${resultList.gdsCd}</a></td>
							<td class="text-left">${resultList.gdsNm }</td>
							<td>${useYn[resultList.useYn]}</td>
							<td><a href="#modal2" data-bs-toggle="modal" data-bs-target="#modal2">123</a></td>
							<td class="draggable" style="cursor: pointer;">
								<button type="button" class="btn-warning tiny" data-click-val="${status.index +1}">
									<i class="fa fa-arrow-down-up-across-line"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
						<tr class="noresult blankVal/{num}/ori">
							<td colspan="6">등록된 상품이 없습니다.</td>
						</tr>
				</tbody>
			</table>
		</fieldset>
		</div>

		<!-- 디폴트 그룹 -->

	<c:forEach var="resultList" items="${dspyGrpList }" varStatus="status">
		<fieldset class="mt-13 grpView${status.index+1}CL">
			<legend class="text-title2 relative">
				상품구성 <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
				</span>
			</legend>
			<table class="table-detail">
				<colgroup>
					<col class="w-43">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th scope="row"><label for="grpNm${status.index+1}" class="require">그룹명</label></th>
						<td><input class="form-control w-full" id="grpNm${status.index+1}" name="grpNm${status.index+1}" value="${resultList.grpNm}" data-rule-required="true" data-msg-required="그룹명은 필수 입력 항목입니다." /></td>
					</tr>
					<%--
					<tr>
						<th scope="row"><label for="">진열 개수</label></th>
						<td>
							<div class="form-check-group">
								<c:forEach var="co" items="${exhibiCo}" varStatus="stus">
									<div class="form-check">
										<input type="radio" class="form-check-input" id="${stus.index+1}exhbiCo${status.index}" name="exhbiCo${status.index + 1}"  value="${co.key}" <c:if test="${resultList.exhibiCo eq co.key }" >checked="checked"</c:if>>
										<label class="form-check-label" for="${stus.index+1}exhbiCo${status.index}">${co.value}</label>
									</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					 --%>
					<tr>
						<th scope="row"><label for="sortNo${status.index+1}">노출 순서</label></th>
						<td><input type="number" class="form-control w-57" id="sortNo${status.index+1}" name="sortNo${status.index+1}"  value="${resultList.sortNo }" data-rule-maxlength="1" data-rule-min="1" data-msg-min="최솟값은 1입니다."/></td>
					</tr>
				</tbody>
			</table>
			<p class="text-right my-3">
				<button type="button" class="btn grpRemoveBtn" data-del-btn="${status.index+1}CL">상품그룹 삭제</button>
				<button type="button" class="btn f_srchGds" data-bs-toggle="modal" data-bs-target="#gdsModal" data-grp-idx="${status.index+1}CL">상품검색</button>
			</p>

			<table class="table-list" >
				<colgroup>
					<col class="w-15">
					<col class="w-[15%]">
					<col>
					<col class="w-25">
					<col class="w-30">
					<col class="w-20">
				</colgroup>
				<thead>
					<tr>
						<th scope="col">
							<div class="form-check">
							</div>
						</th>
						<th scope="col">상품코드</th>
						<th scope="col">상품명</th>
						<th scope="col">노출상태</th>
						<th scope="col">등록 기획전 수</th>
						<th scope="col">노출 순서</th>
					</tr>
				</thead>
				<tbody id="bodyView${status.index+1}CL" class="relGdsList${status.index+1}CL">
					<c:forEach var="result" items="${resultList.grpGdsList}" varStatus="stts">
						<tr class="draggableTr">
							<td>
								<div class="form-check">
									<button type="button" class="btn-danger tiny btn-relGds-remove">
										<i class="fa fa-trash"></i>
									</button>
									<input type="hidden" name="gdsNo${status.index +1 }" value="${result.gdsNo }">
									<input type="hidden" name="gdsCd${status.index +1 }" value="${result.gdsCd }">
								</div>
							</td>
							<td><a href="#">${result.gdsCd}</a></td>
							<td class="text-left">${result.gdsNm }</td>
							<td>${useYn[result.useYn]}</td>
							<td><a href="#modal2" data-bs-toggle="modal" data-bs-target="#modal2" class="f_dspyList" data-gds-no="${result.gdsNo }">${result.regCount.size()}</a></td>
							<td class="draggable" style="cursor: pointer;">
								<button type="button" class="btn-warning tiny" data-click-val="${status.index +1}">
									<i class="fa fa-arrow-down-up-across-line"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${empty resultList.grpGdsList}">
						<tr class="noresult blankVal${stts.index+1}">
							<td colspan="6">등록된 상품이 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</fieldset>
		</c:forEach>

			<div class="modal fade" id="modal2" tabindex="-1">
				<div class="modal-dialog modal-lg modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<p>
								상품코드 <span class="text-success" id="modalGdsCd"></span> 기획전 내역
							</p>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
						</div>
						<div class="modal-body">
							<table class="table-list" id="DspyDataTable">
								<colgroup>
									<col class="w-25">
									<col>
									<col class="w-30">
								</colgroup>
								<thead>
									<tr>
										<th scope="col">기획전 No.</th>
										<th scope="col">기획전 명</th>
										<th scope="col">진행상태</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td></td>
										<td class="text-left"></td>
										<td></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

		</div>


					<p class="text-right mt-3">
                        <button type="button" class="btn-primary addGrpBtn">상품그룹 추가</button>
                    </p>

					<c:set var="pageParam" value="?curPage=${param.curPage}${!empty(listVO.urlParam)? '&amp;' : ''}${listVO.urlParam}&srchBgngDt=${param.srchBgngDt}&srchEndDt=${param.srchEndDt}&srchText=${param.srchText}&srchYn=${param.srchYn}" />
                    <div class="btn-group mt-8 right">
                        <button type="submit" class="btn-primary large shadow">저장</button>
                        <a href="/_mng/promotion/dspy/list${pageParam}" class="btn-secondary large shadow">목록</a>
                    </div>
                </form:form>

                 <c:import url="/_mng/gds/gds/modalGdsSearch" />




			</div>



            <script>
            var clickLocation = 1;
            var i=1;
            var arrGdsNo = [];



        	//첨부파일 이미지 제한
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


        	$(function(){

        		var delDataVal = "";
        		var sameVal = "";
        		var oriVal = "";
        		var oriVal2 = "";

        		if($("#crud").val() == "CREATE"){
            		var html = $("#DummyField").clone().html();

            		html = html.replaceAll('/{num}/ori',1);
            		html = html.replaceAll("Dummy", "Grp1");
           			$("#fieldWrap").append(html);

           			//그룹명
           			$("#Grp1").css({"display":""});
            	}

				if($("#grpNmIdVal").val() != null){
   					oriVal = $("#DummyField").clone().html();
   					oriVal2 = $("#DummyField").clone().html();
					$("#grpNmIdVal").remove();
				}


            	//tinymce editor
           		tinymce.overrideDefaults(baseConfig);
           		tinymce.init({selector:"#cn"});

            	//상품 그룹 추가
            	$(".addGrpBtn").on("click",function(){
    				var grpCnt = $(".mt-13").length;


    				if(oriVal == ''){
    			 		oriVal = oriVal.replaceAll("grpNmIdVal", "grpNm"+grpCnt);
                   		oriVal = oriVal.replaceAll("sortNoIdVal", "sortNo"+grpCnt);
                   		oriVal = oriVal.replaceAll('/{num}/ori',grpCnt);
                   		oriVal = oriVal.replaceAll("Dummy", "Grp"+grpCnt);

                    	$("#fieldWrap").append(oriVal);
                   		$("#Grp"+(grpCnt+1)).css({"display":""});
    				}else{
    					oriVal = oriVal2

    					oriVal = oriVal.replaceAll("grpNmIdVal", "grpNm"+grpCnt);
                   		oriVal = oriVal.replaceAll("sortNoIdVal", "sortNo"+grpCnt);
                   		oriVal = oriVal.replaceAll('/{num}/ori',grpCnt);
                   		oriVal = oriVal.replaceAll("Dummy", "Grp"+grpCnt);

                    	$("#fieldWrap").append(oriVal);
                   		$("#Grp"+(grpCnt+1)).css({"display":""});
    				}

            		//그룹 인덱싱



            	});

           		//상품 그룹 삭제
           		$(document).on("click", ".grpRemoveBtn", function(e){
           			delDataVal = $(this).data("delBtn");
           			$(".grpView"+delDataVal).remove();
           		});


           		// 상품검색 모달
           		$(document).on("click", ".f_srchGds", function(e){
           			arrGdsNo = [];
           			$("#gdsDataTable td :checkbox, #gdsDataTable div :checkbox").prop("checked",false);
           			clickLocation = $(this).data("grpIdx");
           			console.log("상품 검색 버튼 값 : "+ clickLocation);

           			sameVal = clickLocation.replace("CL","");
           			console.log("상품 검색 필드 값 : " + sameVal);

           			var gdsNoVal = "gdsNo"+sameVal;

           			$('input[name='+gdsNoVal+']').each(function (i){
           				arrGdsNo.push($('input[name='+gdsNoVal+']').eq(i).attr("value"));
           			});
           				console.log("선택한 필드에 존재하는 번호 : " + arrGdsNo);

          			for(var i=0; i<arrGdsNo.length; i++){
       					$("#gdss"+arrGdsNo[i]).prop("checked",true);
       				}

    				if ( !$.fn.dataTable.isDataTable('#DspyDataTable') ) { //데이터 테이블이 있으면x
    					DspyDataTable.init();
    		 		}



    			});

    			// 관련상품 목록 삭제
    			$(document).on("click", ".btn-relGds-remove", function(e){
    				e.preventDefault();
    				$(this).parents("tr").remove();
    				if($(".draggableTr").length == 0){
    					$("#bodyView"+$(this).data("grpIdx")).append('<tr><td colspan="6" class="noresult">등록된 관련상품이 없습니다.</td></tr>');
    				}
    			});

    		   	//draggable js loading
    			$.getScript("<c:url value='/html/core/vendor/draggable/draggable.bundle.js'/>", function(data,textStatus,jqxhr){
    				if(jqxhr.status == 200) {
    					Dragable.init();
    				} else {
    					console.log("draggable is load failed");
    				}
    			});

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

        	//날짜 시작일 < 마감일 체크
			$.validator.addMethod("SizeValidate", function(value,element){
				var bgng = $("#bgngDt").val();
				var end = $("#endDt").val();
				if(end < bgng){
					return false;
				}else {
					return true;
				}
			}, "기간을 확인해주세요.");

       		//날짜, 시간 체크 추가 유효성 검사 메소드
       		$.validator.addMethod("dtValidate", function(value,element){
       			var arrDate = [];
       			arrDate.push($("#bgngDt").val() == "");
       			arrDate.push($("#bgngTime").val() == "");
       			arrDate.push($("#endDt").val() == "");
       			arrDate.push($("#endTime").val() == "");
       			for (var i=0; i < 4; i ++){
       				if(arrDate.includes(true)){
       					return false;
       				}else{
       					return true;
       				}
       			}
       		}, "항목을 입력해주세요.");


        	$("form#frmDspy").validate({
        		ignore: "input[type='text']:hidden",
        		rules: {
        			planngDspyNm : {required : true},
        			bgngDt : {dtValidate : true, SizeValidate : true},
        			dspyYn : {required : true},
        			attachFile0 : {filechk : true},
        			attachFileDc0 : {required : true}
        		},
        		messages : {
        			planngDspyNm : {required : "기획전 명은 필수 입력 사항입니다."},
        			dspyYn : {required : "상태를 선택해주세요"},
        			attachFileDc0 : {required : "대체 텍스트는 필수 입력 사항입니다."}
        		},
        	    submitHandler: function (frm) {
        	     	var grpGdsTotal =  $(".mt-13").length;
        	    	$("#grpGdsTotal").val(grpGdsTotal);

			 		var arrUpdateDc = [];
		    		$("input[data-update-dc]").each(function(){
			    		arrUpdateDc.push($(this).attr("name"));
			    		console.log(arrUpdateDc);
			    	});
			    	if(arrUpdateDc.length>0){
			    		console.log(arrUpdateDc.join(","));
				    	$("input#updtImgFileDc").val(arrUpdateDc.join(","));
				    	console.log($("input#updtImgFileDc").val());
			    	}
			    	if(confirm("저장 하시겠습니까?")){
				    	frm.submit();
			    	} else{
			    		return false;
			    	}
			    }
        	});


        	});

        	//삭제 스크립트
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

			//노출 상태
			var useYn = {
			<c:forEach items="${useYn}" var="iem" varStatus="status">
			${iem.key} : "${iem.value}",
			</c:forEach>
			}

			//상품검색 콜백
			function f_modalGdsSearch_callback(gdsNos){
				i = clickLocation.substr(0,1);

				console.log("선택한 위치 : " + clickLocation);
				//console.log("callback: " + gdsNos);
				if($("#relGdsList tbody td").hasClass("no-data")){
					$("#relGdsList tbody tr").remove();
				}

				//똑같은 번호 추가 x
				//클릭한 지역의 상품 번호(디비에서 불러온 번호)가 있으면 선택한 목록에서 삭제
				for(var s=0; s < arrGdsNo.length; s++){
					gdsNos = arrayRemove(gdsNos, arrGdsNo[s]);
				}
				console.log("있는 번호 제외한 나머지 : " + gdsNos);

				//$(".relGdsList"+i+"CL").children("tr").remove();
				gdsNos.forEach(function(gdsNo){
					console.log('gdsNo', gdsNo);
					//console.log(gdsMap.get(parseInt(gdsNo)));
					var gdsJson = gdsMap.get(parseInt(gdsNo));
					$(".noresult").remove();
					//relGdsList

					var html ="";
					html += '<tr class="draggableTr">';
					html += '<td>';
					html += '<div class="form-check">';
					html += '<button type="button" class="btn-danger tiny btn-relGds-remove" data-grp-idx="'+i+'"><i class="fa fa-trash"></i></button>';
					html += '<input type="hidden" name="gdsNo'+i+'"  value="'+gdsJson.gdsNo+'">';
					html += '<input type="hidden" name="gdsCd'+i+'"  value="'+gdsJson.gdsCd+'">';
					html += '</div>';
					html += '</td>';
					html += '<td><a href="#">'+gdsJson.gdsCd+'</a></td>';
					html += '<td class="text-left">'+gdsJson.gdsNm+'</td>';
					html += '<td>'+useYn[gdsJson.useYn]+'</td>';
					html += '<td><a href="#modal2" data-bs-toggle="modal" data-bs-target="#modal2" class="f_dspyList" data-gds-no='+gdsJson.gdsNo+'>'+gdsJson.regCount.length+'</a></td>';
			        html += '    <td class="draggable" style="cursor:pointer;">';
			        html += '	 	<button type="button" class="btn-warning tiny"><i class="fa fa-arrow-down-up-across-line"></i></button>';
			        html += '    </td>';
			        html += '</td>';
					html += '</tr>';

					$(".relGdsList"+clickLocation).append(html);

				});
				Dragable.init();
				$(".btn-close").click();


			}

			var Dragable = function(){
				return {
					init: function(){

						var containers = document.querySelectorAll('.relGdsList'+i+"CL");
						if (containers.length === 0) {
							return false;
						}
						var sortable = new Sortable.default(containers, {
							draggable: '.draggableTr',
							handle: '.draggable',
							delay:100,
							mirror: {
								appendTo: ".relGdsList"+i+"CL",
								constrainDimensions: true
							}
						});

					}
				};
			}();

			// 등록 기획전 수 모달
			$(document).on("click", ".f_dspyList", function(e){
				$("#clickDataNum").attr("value",$(this).data("gdsNo"));

				//상품코드
				$.ajax({
					type : "post",
					url  : "/_mng/promotion/dspy/modalTextGdsCd.json",
					data : {
						gdsNo : $("#clickDataNum").val()
					},
					dataType : 'json'
				})
				.done(function(data) {
					$("#modalGdsCd").text(data.gdsCd);
					dspyList.draw();
				})
				.fail(function(data, status, err) {
					alert("리스트 업 중 오류가 발생했습니다.");
					console.log('error forward : ' + data);
				});

			});

			// 상품검색 모달
			$(document).on("click", ".f_srchGds", function(){
				if ( !$.fn.dataTable.isDataTable('#gdsDataTable') ) { //데이터 테이블이 있으면x
		 			GdsDataTable.init();
		 		}
			});

			<%-- DataTable Script Start   --%>
			var dspyList = $("#DspyDataTable").DataTable({
				bServerSide: true,
				sAjaxSource: "/_mng/promotion/dspy/modalDspyList.json",
				bFilter: false,
				bInfo: false,
				bSort : false,
				bAutoWidth: false,
				bLengthChange: false,
				language: dt_lang,

				aoColumns: [
					{ mDataProp: "planngDspyNo"},
					{ mDataProp: "planngDspyNm"},
					{ mDataProp: "dspyYn",
						mRender: function(oObj){
							return oObj=="Y"?"전시":"미전시";
						}
					}
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
					restParams.push({name : "gdsNo", value :  $("#clickDataNum").val()});


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
					//console.log("drawCallback");
					gdsMap.clear();
					//console.log(gdsMap);
					var api = this.api();
			       	rows = api.rows( {page:'current'} ).data();
			       	for(var i=0; i < rows.length; i++){
			       		gdsMap.set(rows[i].gdsNo, rows[i]);
			       	}
				}
			});
			<%-- DataTable End--%>




            </script>
