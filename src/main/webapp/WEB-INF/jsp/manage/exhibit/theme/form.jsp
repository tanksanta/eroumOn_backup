<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		<form:form action="./action" method="post" id="themeFrm" name="themeFrm" modelAttribute="themeDspyVO" enctype="multipart/form-data">
		<form:hidden path="crud" />
		<form:hidden path="themeDspyNo" />
		 <input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />
         <input type="hidden" id="updtImgFileDc" name="updtImgFileDc" value="" />
		<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
		<input type="hidden" name="srchYn" id="srchYn" value="${param.srchYn }" />
		<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
		<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
		<input type="hidden" name="srchBgngDt" id="srchBgngDt" value="${param.srchBgngDt}" />
		<input type="hidden" name="srchEndDt" id="srchEndDt" value="${param.srchEndDt}" />
			<fieldset>
		         <legend class="text-title2 relative">
                 ${themeDspyVO.crud eq 'CREATE'?'등록':'수정' }
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
					<th scope="row"><label for="themeDspyNm" class="require">테마명</label></th>
					<td><form:input class="form-control w-full" path="themeDspyNm" value="${themeDspyVO.themeDspyNm }" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="" class="require">상태</label></th>
					<td>
						<div class="form-check-group">
							<c:forEach var="useYn" items="${useYn}" varStatus="status">
								<div class="form-check">
									<form:radiobutton value="${useYn.key}" path="dspyYn" id="item${status.index}" class="form-check-input" />
									<label class="form-check-label" for="item${status.index}">${useYn.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="item3" class="require">연관상품 등록여부</label></th>
					<td>
						<div class="form-check-group">
							<c:forEach var="yn" items="${useYn}" varStatus="status">
								<div class="form-check">
									<form:radiobutton value="${yn.key}" path="relYn" id="useYn${status.index}" class="form-check-input"/>
									<label class="form-check-label" for="useYn${status.index}">${yn.value}</label>
								</div>
							</c:forEach>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item4" class="require">목록 이미지</label></th>
					<td><c:forEach var="fileList" items="${themeDspyVO.fileList }" varStatus="status">
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
								<div class="row" id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(themeDspyVO.fileList) }">style="display:none;"</c:if>>
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
						</div></td>
				</tr>
				<tr>
					<th scope="row"><label for="form-item5">Story 본문 영역</label></th>
					<td><form:textarea path="cn" cols="30" rows="10" class="form-control w-full" value="${themeDspyVO.cn}"/></td>
				</tr>
				<tr class="regDtView">
					<th scope="row">등록일</th>
					<td><fmt:formatDate value="${themeDspyVO.regDt }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
			</tbody>
		</table>
			</fieldset>

	<fieldset class="mt-13 gdsView">
		<p class="text-right mb-2">
			<button type="button" class="btn f_srchGds" data-bs-toggle="modal" data-bs-target="#gdsModal">상품검색</button>
		</p>
		<legend class="text-title2">상품구성</legend>
		<table class="table-list" id="relGdsList">
			<colgroup>
				<col class="w-20">
				<col class="w-[15%]">
				<col class="w-[20%]">
				<col>
				<col class="w-30">
				<col class="w-25">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">
						<div class="form-check">
						<!-- 	<input class="form-check-input" type="checkbox"> -->
						</div>
					</th>
					<th scope="col">상품코드</th>
					<th scope="col">상품명</th>
					<th scope="col">상품 카테고리</th>
					<th scope="col">노출 상태</th>
					<th scope="col">노출 순서</th>
				</tr>
			</thead>
			<tbody id="bodyView">
				<c:forEach var="resultList" items="${itemList}" varStatus="status">
					<tr class="draggableTr">
						<td>
							<div class="form-check">
								<button type="button" class="btn-danger tiny btn-relGds-remove">
									<i class="fa fa-trash"></i>
								</button>
								<input type="hidden" name="gdsNo" value="${resultList.gdsNo }">
							</div>
						</td>
						<td><a href="#">${resultList.gdsCd}</a></td>
						<td class="text-left">${resultList.gdsNm }</td>
						<td class="text-left">${resultList.upCtgryNm }&nbsp;&gt;&nbsp;${resultList.ctgryNm }</td>
						<td>${dspyYnCode[resultList.useYn]}</td>
						<td class="draggable" style="cursor: pointer;">
							<button type="button" class="btn-warning tiny">
								<i class="fa fa-arrow-down-up-across-line"></i>
							</button>
						</td>
						</td>
					</tr>
					</c:forEach>
					<c:if test="${empty itemList }">
						<tr class="noresult">
							<td colspan="6">등록된 상품이 없습니다.</td>
						</tr>
					</c:if>
			</tbody>
		</table>
	</fieldset>
	<c:set var="pageParam" value="curPage=${param.curPage}&amp;cntPerPage=${param.cntPerPage }&amp;sortBy=${param.sortBy}&amp;srchBgngDt=${param.srchBgngDt }&amp;srchEndDt=${param.srchEndDt }&amp;srchText=${param.srchText }&amp;srchYn=${param.srchYn }" />
	<div class="btn-group mt-8 right">
				<button type="submit" class="btn-primary large shadow">저장</button>
				<a href="./list?${pageParam }" class="btn-secondary large shadow">목록</a>
			</div>
		</form:form>

		 <c:import url="/_mng/gds/gds/modalGdsSearch" />
	</div>

	<script>
		tinymce.overrideDefaults(baseConfig);
		tinymce.init({selector:"#cn"});

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

			if($("#crud").val() == "CREATE" ){
				$(".regDtView").hide();
			}

			if($("#useYn1").is(":checked")){
				$(".gdsView").hide();
			}else{
				$(".gdsView").show();
			}

			$("input[name='relYn']").on("click",function(){
				if($("#useYn1").is(":checked")){
					$(".gdsView").hide();
				}else{
					$(".gdsView").show();
				}
			});

			// 상품검색 모달
			$(".f_srchGds").on("click", function(){
				if ( !$.fn.dataTable.isDataTable('#gdsDataTable') ) { //데이터 테이블이 있으면x
		 			GdsDataTable.init();
		 		}
			});

			// 관련상품 목록 삭제
			$(document).on("click", ".btn-relGds-remove", function(e){
				e.preventDefault();
				$(this).parents("tr").remove();
				if($(".draggableTr").length == 0){
					$("#bodyView").append('<tr><td colspan="6" class="noresult">등록된 관련상품이 없습니다.</td></tr>');
				}
			});

		   	//draggable js loading
			$.getScript("<c:url value='/html/core/vendor/draggable/draggable.bundle.js'/>", function(data,textStatus,jqxhr){
				if(jqxhr.status == 200) {
					Dragable.init();
				} else {
					console.log("draggable is load failed")
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

			$("form[name='themeFrm']").validate({
			    ignore: "input[type='text']:hidden",
			    rules : {
			    	themeDspyNm	: { required : true},
			    	useYn	: { required : true},
			    	relYn	: {required : true },
			    	attachFile0 : {filechk : true },
			    	attachFileDc0 : {required : true}
			    },
			    messages : {
			    	themeDspyNm	: { required : "테마명은 필수 입력 항목입니다."},
			    	useYn	: { required : "상태는 필수 선택 항목입니다."},
			    	relYn	: {required : "연관상품 여부는 필수 선택 항목입니다." },
			    	attachFileDc0 : {required : "대체 텍스트는 필수 입력 항목입니다."}
			    },
			    submitHandler: function (frm) {
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
					if(confirm('<spring:message code="action.confirm.save"/>')){
						frm.submit();
					}else{
						return false;
					}
			    }
			});

		});
		//노출 상태
		var dspyYnCode = {
		<c:forEach items="${dspyYnCode}" var="iem" varStatus="status">
		${iem.key} : "${iem.value}",
		</c:forEach>
		}

		//상품검색 콜백
		function f_modalGdsSearch_callback(gdsNos){
			//console.log("callback: " + gdsNos);
			if($("#relGdsList tbody td").hasClass("no-data")){
				$("#relGdsList tbody tr").remove();
			}

			// 자신 번호도 추가x
			gdsNos = arrayRemove(gdsNos, ${gdsVO.gdsNo});
				// 중복된 상품이 있을 경우 추가x
				$("input[name='gdsNo']").each(function(){
		   		gdsNos = arrayRemove(gdsNos, $(this).val());
				});

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
				html += '<button type="button" class="btn-danger tiny btn-relGds-remove"><i class="fa fa-trash"></i></button>';
				html += '<input type="hidden" name="gdsNo"  value="'+gdsJson.gdsNo+'">';
				html += '</div>';
				html += '</td>';
				html += '<td><a href="#">'+gdsJson.gdsCd+'</a></td>';
				html += '<td class="text-left">'+gdsJson.gdsNm+'</td>';
				html += '<td class="text-left">'+gdsJson.upCtgryNm+' &gt; '+gdsJson.ctgryNm+'</td>';
				html += '<td>'+dspyYnCode[gdsJson.useYn]+'</td>';
		        html += '    <td class="draggable" style="cursor:pointer;">';
		        html += '	 	<button type="button" class="btn-warning tiny"><i class="fa fa-arrow-down-up-across-line"></i></button>';
		        html += '    </td>';
		        html += '</td>';
				html += '</tr>';

				$("#relGdsList tbody").append(html);
			});

			$(".btn-close").click();
		}

		var Dragable = function(){
			return {
				init: function(){

					var containers = document.querySelectorAll('#relGdsList tbody');
					if (containers.length === 0) {
						return false;
					}
					var sortable = new Sortable.default(containers, {
						draggable: '.draggableTr',
						handle: '.draggable',
						delay:100,
						mirror: {
							appendTo: "#relGdsList tbody",
							constrainDimensions: true
						}
					});

				}
			};
		}();
	</script>