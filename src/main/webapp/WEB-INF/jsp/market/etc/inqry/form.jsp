<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<main id="container">
   	<jsp:include page="../../layout/page_header.jsp" >
		<jsp:param value="1:1 문의" name="pageTitle"/>
	</jsp:include>

        <div id="page-container">

			<jsp:include page="../../layout/page_sidenav.jsp" />

            <div id="page-content">
                <p class="text-alert">마이페이지 > 1:1 문의내역에서 답변을 확인하실 수 있습니다.</p>

                <div class="mt-4 p-4 bg-gray2 rounded-md md:mt-5">
                    <div class="h-44 md:h-58 scrollbars">
                        1. 수집 항목</br>
						이름, 이메일,휴대전화번호</br>
						2. 목적</br>
						문의/신고(반품,교환)접수 및 결과 회신</br>
						3. 보유 및 이용 기간</br>
						전자상거래법 시행령 제6조(소비자의 불만 및 분쟁처리 관한 기록)에 따라 3년 보관 후 파기합니다.</br>
						※고객님께서는 개인정보 수집에 동의를 거부할 권리가 있으며, 동의 거부 시 1:1 문의하기 이용이 불가합니다
                    </div>
                </div>

                <div class="form-check mt-3 md:mt-4">
                    <input class="form-check-input" type="checkbox" id="termsChk" name="termsChk" value="N">
                    <label class="form-check-label" for="termsChk">개인정보 취급방침 약관에 동의합니다</label>
                </div>

                <p class="mt-14 text-lg font-bold md:mt-17 md:text-xl">문의내용</p>

                <form:form action="./action" class="mypage-inquiry mt-2.5 md:mt-3" id="inqryFrm" name="inqryFrm" method="post" modelAttribute="mbrInqryVO" enctype="multipart/form-data">
                <form:hidden path="crud" />
                <form:hidden path="inqryNo" />
                <input type="hidden" id="delAttachFileNo" name="delAttachFileNo" value="" />

                    <fieldset>
                        <legend>1:1문의내용</legend>
                        <div class="inquiry-top">
                            <table>
                                <colgroup>
                                    <col class="w-14 md:w-19">
                                    <col>
                                </colgroup>
                                <tr>
                                    <th scope="row">고객명</th>
                                    <td><strong>${mbrVO.mbrNm}</strong></td>
                                </tr>
                                <tr>
                                    <th scope="row">답변알림</th>
                                    <td class="space-y-2 md:space-y-3">
                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="telnoChk" name="telnoChk" value="N">
                                                <label class="form-check-label min-w-16 md:min-w-19" for="inquiry-item1-1">휴대폰번호</label>
                                            </div>
                                            <form:input class="form-control" path="mblTelno" maxlength="13" value="${_mbrSession.mblTelno}" oninput="autoHyphen(this);"/>
                                        </div>
                                        <div class="form-group">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="emlChk" name="emlChk" value="N">
                                                <label class="form-check-label min-w-16 md:min-w-19" for="inquiry-item1-2">이메일</label>
                                            </div>
                                            <form:input class="form-control" path="eml" maxlength="50" value="${_mbrSession.eml}"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="inquiry-item1-3">문의유형</label></th>
                                    <td>
                                        <div class="form-group">
                                            <form:select path="inqryTy" class="form-control" >
                                                <option value="">선택하세요</option>
	                                                <c:forEach var="firstTy" items="${inqryTy1}" >
	                                                	<form:option value="${firstTy.key}">${firstTy.value}</form:option>
	                                                </c:forEach>
                                            </form:select>
                                            <form:select path="inqryDtlTy" class="form-control">
                                                <option value="">선택하세요</option>
	                                                <c:forEach var="secondTy" items="${inqryTy2}" varStatus="status">
	                                                	<form:option value="${secondTy.key}" class="optVal${status.index} allVal" style="display:none;">${secondTy.value}</form:option>
	                                                </c:forEach>
                                            </form:select>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="ordrCd">주문번호</label></th>
                                    <td>
                                        <div class="form-group large">
                                            <form:input class="form-control" path="ordrCd" />
                                            <button type="button" class="btn btn-success w-19 md:w-24" id="srchOrdrCd" disabled>검색</button>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="inquiry-bottom">
                            <table>
                                <colgroup>
                                    <col class="w-14 md:w-19">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row"><label for="ttl">제목</label></th>
                                        <td><form:input class="form-control w-full" path="ttl" maxlength="50"/></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="cn">내용</label></th>
                                        <td><form:textarea path="cn" cols="30" rows="11" class="form-control w-full max-h-48 md:max-h-68" placeholder="문의 내용을 1000자까지 작성 가능합니다." maxlength="1000" /></td>
                                    </tr>
                                    <tr>
                                        <th scope="row" ><label for="attachFile">파일첨부</label></th>
                                        <%--<th scope="row" class="file"><label for="attachFile">파일첨부</label></th> --%>
                                        <td>
                                        	<%--
                                            <div class="form-upload attachView" style="display:none;">
                                                <label for="attachFile" class="form-upload-trigger">파일을 선택하거나<br> 사진을 드래그 해서 등록하세요 </label>
                                                <input type="file" class="form-upload-control" id="attachFile" name="attachFile" >
                                            </div>
                                             --%>
                                            <input type="file" id="attachFile" name="attachFile" style="display:none;" class="form-control w-full">

                                            <c:forEach var="fileList" items="${mbrInqryVO.fileList}" varStatus="status">
	                                         	 <div class="form-upload-link">
	                                                <span class="form-upload-link-name">${fileList.orgnlFileNm}</span>
	                                                <a href="/comm/getFile?srvcId=INQRY&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }" class="form-upload-link-download">다운로드</a>
	                                                <button type="button" class="form-upload-link-delete " onclick="f_delFile('${fileList.fileNo}', 'ATTACH', '${status.index}',this); return false;">삭제</button>
	                                            </div>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="mt-8 text-center md:mt-9">
                            <button type="submit" class="btn btn-large btn-primary w-46 md:w-53">문의하기</button>
                        </div>
                    </fieldset>
                </form:form>
            </div>

           <div id="ordrView"></div>

        </div>
    </main>

    <script>
	 // 모달
    function f_ordrModal(page){
    	if($("#ordrView").html() == ''){
    		$("#ordrView").load("${_marketPath}/etc/inqry/modalOrdrSearch",
    				{curPage : page}
    				, function(){
    		  			$("#itemModal").addClass("fade").modal("show");
    				});
    	}else{
    		$("#itemModal").addClass("fade").modal("show");
    	}
    }

    // 페이징 클릭시
    function f_ordrListModal(page){
    	$("#listView").load("${_marketPath}/etc/inqry/modalOrdrList",
    		{curPage : page}
    	);
    }


    //문의 유형
    function f_inqryTyChg(idx){
    	console.log(idx);
    	$(".allVal").css("display","none");
    	for(var i=0; i<7;  i++){
    		if(idx == i){
    			//2번째 그룹 예외
    			if(idx == 1){
    				$(".optVal"+(i*3)).css("display","");
        			$(".optVal"+(i*3+1)).css("display","");
        			$(".optVal"+(i*3+2)).css("display","");
        			$(".optVal"+(i*3+3)).css("display","");
    			}else if(idx ==0){
	    			$(".optVal"+(i)).css("display","");
	    			$(".optVal"+(i+1)).css("display","");
	    			$(".optVal"+(i+2)).css("display","");
    			}else{
    				$(".optVal"+(i*3+1)).css("display","");
    				$(".optVal"+(i*3+2)).css("display","");
    				$(".optVal"+(i*3+3)).css("display","");
    			}
    		}
    	}
    }

	//첨부파일 삭제
    function f_delFile(fileNo, type, spanNo, obj){
		console.log(type);
    	if(confirm("삭제하시겠습니까?")){
    		if(type == "ATTACH"){
    			$(obj).closest("div").remove();
    			if($("#delAttachFileNo").val()==""){
    				$("#delAttachFileNo").val(fileNo);
    			}else{
    				$("#delAttachFileNo").val($("#delAttachFileNo").val()+","+fileNo);
    			}
    			$(".attachView").css("display","");
    			$("#attachFile").val('');
    		}
    	}
    }


    $(function(){

    	//정규식
    	const emailchk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		const telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;

    	//주문번호 비활성화
    	$("#ordrCd").attr("readonly",true);

		// 검색 모달
		$("#srchOrdrCd").on("click",function(){
			f_ordrModal(1);
       	});


		//문의유형
		$("#inqryTy").on("change", function() {
			f_inqryTyChg($(this).val());
			$("#inqryDtlTy").val('');
			if($("#inqryTy").val() == 0 || $("#inqryTy").val() == 1){
				$("#srchOrdrCd").attr("disabled",false);
			}else{
				$("#srchOrdrCd").attr("disabled",true);
			}
		});

    	//약관동의
    	$("#termsChk").on("click",function(){
    		if($("#termsChk").is(":checked")){
    			$("#termsChk").val("Y");
    		}else{
    			$("#termsChk").val("N");
    		}
    	});

     	//알림서비스 비활성화, 첨부파일 활성화
    	if("${mbrInqryVO.crud}" == "CREATE"){
    		$("#mblTelno").attr("disabled",true);
        	$("#eml").attr("disabled",true);
        	$(".attachView").css("display","");
    	}

    	//휴대전화 알림 서비스
    	if("${_mbrSession.mblTelno}" != null){
    		$("#telnoChk").prop("checked",true);
    		$("#mblTelno").attr("disabled",false);
    	}else{
    		$("#telnoChk").prop("checked",false);
    		$("#mblTelno").attr("disabled",true);
    	}


    	//휴대전화 알림 서비스 체크박스
    	$("#telnoChk").on("click",function(){
    		if($("#telnoChk").is(":checked")){
    			$("#telnoChk").val("Y");
    			$("#mblTelno").attr("disabled",false);
    		}else{
    			$("#telnoChk").val("N");
    			$("#mblTelno").val('');
    			$("#mblTelno").attr("disabled",true);
    		}
    	});

    	//이메일 알림 서비스 체크박스
    	$("#emlChk").on("click",function(){
    		if($("#emlChk").is(":checked")){
    			$("#emlChk").val("Y");
    			$("#eml").attr("disabled",false);
    		}else{
    			$("#eml").val('');
    			$("#emlChk").val("N");
    			$("#eml").attr("disabled",true);
    		}
    	});

    	//이메일 알림 서비스
    	if("${_mbrSession.eml}" != null){
    		$("#emlChk").prop("checked",true);
    		$("#eml").attr("disabled",false);
    	}else{
    		$("#emlChk").prop("checked",false);
    		$("#eml").attr("disabled",true);
    	}

    	//첨부파일
    	if("${mbrInqryVO.crud}" == "CREATE"){
    		$("#attachFile").css("display","");
    	}

    	//첨부파일
    	$(document).on("change", "#attachFile", function(e){
    		var html = "";
    	    html += '<div class="form-upload-link">';
    	    html += ' <span class="form-upload-link-name">첨부파일1.hwp</span>';
    	    /*html += '<a href="#" class="form-upload-link-download">다운로드</a>';*/
    	    html += '<button type="button" class="form-upload-link-delete deltFile">삭제</button>';
    	    html += '</div>';

    	    $(".attachView").append(html);
    	});

    	//버튼 활성화
		if($("#crud").val() == "UPDATE"){
			if("${inqryVO.inqryTy}" == 0 || "${inqryVO.inqryTy}" == 1){
				$("#srchOrdrCd").attr("disabled",false);
			}
		}

    	// 정규식 체크
    	$.validator.addMethod("regex", function(value, element, regexpr) {
    		if(value != ''){
    			return regexpr.test(value)
    		}else{
    			return true;
    		}
    	}, "형식이 올바르지 않습니다.");

    	//휴대전화
   		$.validator.addMethod("mblTelnoChk", function(value, element) {
   			if($("#telnoChk").is(":checked")){
   				if($("#mblTelno").val() != ''){
   					return true;
   				}else{
   					return false;
   				}
   			}else{
   				return true;
   			}
    	});

    	// 이메일
    	$.validator.addMethod("emlChk", function(value, element) {
    		if($("#emlChk").is(":checked")){
   				if($("#eml").val() != ''){
   					return true;
   				}else{
   					return false;
   				}
   			}else{
   				return true;
   			}
    	});

    	// 주문 번호
		$.validator.addMethod("ordrCdChk", function(value, element) {

			if($("#inqryTy").val() === "0" || $("#inqryTy").val() === "1"){
    			if($("#ordrCd").val() == ''){
    				return false;
    			}else{
    				return true;
    			}
    		}else{
    			return true;
    		}

    	});

    	//유효성
    	$("form#inqryFrm").validate({
    	    ignore: "input[type='text']:hidden",
    	    rules : {
    	    	mblTelno : {regex : telchk, mblTelnoChk : true}
    	    	, inqryDtlTy : {required : true}
    	    	, eml : {regex : emailchk, emlChk : true}
    	    	, ordrCd : {ordrCdChk : true}
    			, ttl : {required : true}
    			, cn : {required : true}
    	    },
    	    messages : {
    	    	mblTelno : {regex : "! 전화번호 형식이 잘못되었습니다.\n(000-0000-0000)", mblTelnoChk : "! 전화번호는 필수 입력 항목입니다."}
    	    	, inqryDtlTy : {required : "! 문의유형은 필수 선택 항목입니다."}
		    	, eml : {regex : "! 이메일 형식이 잘못되었습니다.\n(abc@def.com)", emlChk : "! 이메일은 필수 입력 항목입니다."}
		    	, ordrCd : {ordrCdChk : "! 주문코드는 필수 선택 항목입니다."}
				, ttl : {required : "! 제목은 필수 입력 항목입니다."}
				, cn : {required : "! 내용은 필수 입력 항목입니다."}
    	    },
    	    errorElement:"p",
    	    errorPlacement: function(error, element) {
    		    var group = element.closest('.form-group, .form-check');
    		    if (group.length) {
    		        group.after(error.addClass('text-danger'));
    		    } else {
    		        element.after(error.addClass('text-danger'));
    		    }
    		},
    	    submitHandler: function (frm) {
    	    	var crud = "";
    	    	if($("#termsChk").val() == "N"){
    	    		alert("약관동의는 필수 입니다.");
    	    		return false;
    	    	}else{
        	    	if($("#crud").val() == "CREATE"){
        	    		crud="등록";
        	    	}else{
        	    		crud="수정";
        	    	}

	    	   		if(confirm("등록하시겠습니까?")){
	    	   			frm.submit();
	    	   		}else{
	    	   			return false;
	    	   		}
    	    	}
    	    }
    	});

    });
    </script>