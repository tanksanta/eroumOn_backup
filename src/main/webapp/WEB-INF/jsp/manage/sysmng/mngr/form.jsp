<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


				<p class="text-title2 relative">
                    관리자관리
                    <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                        (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                    </span>
                </p>
                <div class="tree-content">


                    <div id="mng_menu_tree" class="list-jqtree"></div>

						<form:form name="frmMngr" id="frmMngr" modelAttribute="mngrVO" method="post" action="./action" enctype="multipart/form-data">
						<form:hidden path="crud" />
						<form:hidden path="uniqueId" />
						<form:hidden path="mngrPswd" />

						<c:set var="authMngMenus" />
						<c:forEach items="${mngMenuList }" var="mngMenu" varStatus="status">
							<c:if test="${mngMenu.authrtYn eq 'Y'}">
							<c:set var="authMngMenus">${authMngMenus}${not status.first ? "," : "" }${mngMenu.menuNo}</c:set>
							</c:if>
						</c:forEach>
						<c:if test="${fn:startsWith(authMngMenus, ',')}">
							<c:set var="authMngMenusLength" value="${fn:length(authMngMenus)}"/>
							<c:set var="authMngMenus" value="${fn:substring(authMngMenus,1,authMngMenusLength)}"/>
						</c:if>
						<input type="hidden" name="authMngMenus" id="authMngMenus" value="${authMngMenus}" />

                        <fieldset>
                            <legend class="sr-only">관리자 등록/수정</legend>
                            <table class="table-detail mb-7"> <!-- mb-8이 없어서 임시, btn-group에 mt-8 안됨..important -->
                                <colgroup>
                                    <col class="w-43">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row"><label for="form-item1" class="require">아이디</label></th>
                                        <td>
                                        	<c:if test="${mngrVO.crud == 'CREATE' }">
                                        	<input type="hidden" id="mngrIdCheck" name="mngrIdCheck" value="N"	/>

                                            <div class="form-group w-90">
                                            	<form:input path="mngrId" cssClass="form-control flex-1" autocomplete="off" maxlength="50"/>
                                                <button type="button" class="btn-primary w-20" id="mngrId_checker">중복확인</button>
                                            </div>
                                            </c:if>
                                            <c:if test="${mngrVO.crud == 'UPDATE' }">
												<form:hidden path="mngrId" />
												<input type="text" id="mngrId_view" readonly="readonly" class="form-control flex-1" value="${mngrVO.mngrId }"/>
											</c:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="mngrNm" class="require">이름</label></th>
                                        <td>
                                        	<form:input path="mngrNm" cssClass="form-control w-90" autocomplete="off" maxlength="50" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="newPswd" class="require">비밀번호</label></th>
                                        <td>
                                        	<form:password path="newPswd" cssClass="form-control w-90" autocomplete="off" maxlength="50"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="newPswd1" class="require">비밀번호 확인</label></th>
                                        <td>
                                        	<input type="password" name="newPswd1" id="newPswd1" class="form-control w-90" autocomplete="off" maxlength="50"/>
                                        </td>
                                    </tr>
                                    <c:if test="${mngrVO.crud ne 'CREATE' }">
                                    <tr>
                                        <th scope="row"><label for="form-item5">로그인 오류 횟수</label></th>
                                        <td>
                                            <div class="form-group">
                                                <input type="text" class="form-control w-30" id="form-item5" value="${passCk}" disabled>
                                                <span class="ml-2 text-danger">* 비밀번호 변경 시 초기화됩니다.</span>
                                            </div>
                                        </td>
                                    </tr>
                                    </c:if>
                                    <tr>
                                        <th scope="row"><label for="mngrNm" >프로필 이미지</label></th>
                                        <td>
                                        	<div class="flex w-90">

											<c:if test="${!empty mngrVO.proflImg}">
												<div class="flex-none mr-1.5 border border-gray3 w-19 profile-div">
	                                            	<img src="/comm/proflImg?fileName=${mngrVO.proflImg}" id="profile" class="object-cover w-full h-full">
	                                            </div>
	                                            <div class="flex-1">
	                                            	<button type="button" class="btn-primary small mb-1 delProfileImgBtn">삭제 <i class="fa fa-trash ml-1"></i></button>
		                                            <input type="file" id="profileImg" name="profileImg" class="form-control w-full" />
	                                            </div>
											</c:if>
											<c:if test="${empty mngrVO.proflImg}">
												<div class="flex-1">
		                                            <input type="file" id="profileImg" name="profileImg" class="form-control w-full" />
	                                            </div>
											</c:if>
                                            	<input type="hidden" id="delProfileImg" name="delProfileImg" value="N" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="telNo" class="require">휴대폰</label></th>
                                        <td>
                                            <form:input type="text" path="telno" class="form-control w-90" maxlength="13" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="eml" class="require">이메일</label></th>
                                        <td>
                                            <form:input type="text" path="eml" class="form-control w-90" maxlength="200" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="jobTy">업무구분</label></th>
                                        <td>
                                            <form:select path="jobTy" class="form-control w-90">
                                            	<form:option value="" label="선택" />
                                            	<c:forEach items="${jobTyCode}" var="iem" varStatus="status">
                                                <form:option value="${iem.key}" label="${iem.value}" />
                                                </c:forEach>
                                            </form:select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="form-item9" class="require">관리자 권한</label></th>
                                        <td>
                                            <div class="form-check-group">
                                            	<c:forEach items="${authrtTyCode}" var="authrtTy" varStatus="status">
                                                <div class="form-check">
                                                    <form:radiobutton class="form-check-input" path="authrtTy" id="authrtTy${status.index}" value="${authrtTy.key}"/>
                                                    <label class="form-check-label" for="authrtTy${status.index}">${authrtTy.value}</label>
                                                </div>
                                                </c:forEach>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="form-item10">관리자 권한 복사</label></th>
                                        <td>
                                            <button type="button" class="btn-primary w-40" data-bs-toggle="modal" data-bs-target="#modal1">관리자 권한 선택</button>
                                            <p class="py-1 text-danger">* 권한을 복사할 관리자를 선택합니다. 권한을 복사하면 위에 설정된 권한은 삭제됩니다.</p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="form-item11" class="require">상태</label></th>
                                        <td>
                                            <div class="form-check-group">
                                            	<c:forEach items="${useYnCode}" var="iem" varStatus="status">
                                                <div class="form-check">
                                                	<form:radiobutton path="useYn" id="useYn${status.index }" value="${iem.key}" class="form-check-input"/>
                                                    <label class="form-check-label" for="useYn${status.index }">${iem.value }</label>
                                                </div>
                                                </c:forEach>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
	                                    <th scope="row"><label for="form-item12">입점업체</label></th>
	                                    <td>
	                                        <form:select path="entrpsNo" class="form-control w-70">
	                                            <form:option value="0" label="선택" />
	                                            <c:forEach items="${entrpsList}" var="entrps" varStatus="status">
	                                                <form:option value="${entrps.entrpsNo}" label="${entrps.entrpsNm}" />
	                                            </c:forEach>
	                                        </form:select>
	                                    </td>
	                                </tr>
                                </tbody>
                            </table>


	                        <div class="btn-group">
	                            <button type="submit" class="btn-primary large shadow">저장</button>

	                            <c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage }&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}&amp;srchAuthTy=${param.srchAuthTy }&amp;srchUseYn=${param.srchUseYn }" />
	                            <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
	                        </div>
                        </fieldset>

                        </form:form>
                </div>

                <!-- 관리자 목록 -->
                <div class="modal fade" id="modal1" tabindex="-1">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <p>관리자 목록</p>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                            </div>
                            <div class="modal-body">
                                <p class="text-title2">관리자 검색</p>
                                <table class="table-detail">
                                    <colgroup>
                                        <col class="w-34">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th scope="row"><label for="srchMngrNm">관리자이름</label></th>
                                            <td><input type="text" class="form-control w-full" id="srchMngrNm" name="srchMngrNm"></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><label for="srchTelno">전화번호</label></th>
                                            <td><input type="text" class="form-control w-full" id="srchTelno" name="srchTelno"></td>
                                        </tr>
                                    </tbody>
                                </table>
                                <div class="btn-group mt-4">
                                    <button type="button" class="btn-primary large shadow w-30" id="datatableSrchBtn">검색</button>
                                </div>

                                <p class="text-title2 mt-10">관리자 목록</p>


                                <table id="datatable" class="table-list">
                                    <colgroup>
                                        <col class="w-25">
                                        <col>
                                        <col class="w-35">
                                        <col class="w-35">
                                        <col class="w-25">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">NO</th>
                                            <th scope="col">관리자ID</th>
                                            <th scope="col">관리자명</th>
                                            <th scope="col">관리자권한</th>
                                            <th scope="col">선택</th>
                                        </tr>
                                    </thead>
                                </table>

                            </div>
                            <div class="modal-footer">
                                <div class="btn-group">
                                    <button type="button" class="btn-secondary large shadow" data-bs-dismiss="modal">취소</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //관리자 목록 -->

				<script>

				const f_checkId = function() {
					let REG = /^([a-z0-9]){4,25}$/;
					if(!REG.test($("#mngrId").val())) {
						alert("아이디는 4-25자 이내의 영문소문자와 숫자로 구성되어야 합니다.");
						$("#mngrId").focus();
						return false;
					}
					return true;
				}

				const f_hide_block = function() {
					$('#mng_menu_tree').unblock();
				}
				const f_show_default_block = function() {
					$("#mng_menu_tree").block({
						message: '<div class="blockui"><span>일반관리자만 설정 가능합니다.</span></div>',
					    centerX: true,
					    centerY: true,
				        css: {
				            top: '30%',
				            border: '0',
				            padding: '0',
				            padding: '10',
                            backgroundColor: '#fff',
                            cursor: 'not-allowed',
				            width: 'auto'
				        },
				        overlayCSS: {
				            backgroundColor: '#000000',
				            opacity: 0.1,
				            cursor: 'not-allowed',
				            zIndex: 10
				        }
					});
				}

				const authMngMenu = [<c:forEach items="${mngMenuList}" var="mngMenu" varStatus="status"><c:if test="${mngMenu.authrtYn eq 'Y' or mngMenu.inqYn eq 'Y'}">'${mngMenu.menuNo}',</c:if></c:forEach>];

				const mngMenuType = {
						"home":  {"icon": "jstree-folder"},
	                	"folder":{"icon": "jstree-folder"},
	                	"basic": {"icon": "jstree-file"}
					};

				const MngMenu = function() {
					var drawTree = function() {
						$("#mng_menu_tree").jstree({
							'plugins': ["wholerow", "types", "checkbox"],
							'core': {
								/*
								"multiple":false,
								"themes" : {
									"responsive": false
								},
								*/
				                "data" : function(obj, callback) {
				            		$.ajax({
				            			type : "post",
				            			url  : "../mngAuthrt/getMngMenuList.json",
				            			dataType : 'json'
				            		})
				            		.done(function(json){
				            			var menu = [];
                                        for (var idx = 0; idx < json.length; idx++) {
				            				var menuType = '';
				            				var disableCheckbox = true;
				            				if(json[idx].upMenuNo == '0'){
				            					// 최상위 메뉴
				            				}else{
				            					disableCheckbox = false;
				            				}

		                    				if(json[idx].childCnt > 0){
		                    					menuType = 'folder';
		                    				}else{
		                    					menuType = 'basic';
		                    				}

				            				let nodeChecked = authMngMenu.indexOf(''+json[idx].menuNo) > -1;
				            				menu.push({
				            					'id' : json[idx].menuNo
				            					, 'menuNo' : json[idx].menuNo
				            					, 'parent' : json[idx].upMenuNo != 0 ? json[idx].upMenuNo : '#'
				            					, 'text' : json[idx].menuNm
				            					, 'type' : menuType
				            					, 'menuTy' : json[idx].menuTy
				            					, 'useYn' : json[idx].useYn
				            					, 'sortNo' : json[idx].sortNo
				            					, 'state' : {'checkbox_disabled' : disableCheckbox, 'selected' : nodeChecked}
				            				});
				            			}
				            			callback.call(this, menu);
				            		})
				            		.fail(function(xhr,status,errorThrown){
				            			//console.log(xhr, status, errorThrown);
				            			alert("메뉴 트리 갱신에 실패하였습니다.");
				            		});
				                }
							},
							'types': mngMenuType,
							'checkbox': {
								"three_state" : false,
								"keep_selected_style" : true
							}
						})
						.on('ready.jstree',function(e,obj){
							var tree = $('#mng_menu_tree').jstree(true);
							$.each(tree.get_node('#').children, function(idx, item){
								//tree.open_node(item); // 1depth만 열기
								tree.open_all(); // 전체 열기
							});
							$.each(authMngMenu, function(idx, item) {
								if(item!=""&&item.length>0) {
									tree.open_node(tree.get_node(item));
								}
							});

							<c:if test="${mngrVO.authrtTy eq '1'}">
							//최고관리자 일때 default
							f_show_default_block();
							</c:if>
						});
					}
					return {
						init: function(){
							drawTree();
						}
					};
				}();

				function setMngMenu(){
					let tree = $('#mng_menu_tree').jstree(true);
					let mngMenuList = [];
					$.each(tree.get_checked(), function(idx, item) {
						mngMenuList.push(tree.get_node(item).original.menuNo);
					});
					$("#authMngMenus").val(mngMenuList.join(","));
				}

				function f_chargerSrch_callback(data) {
					if(data[4] && data[4].indexOf("@")>0) {
						let mngrId = data[4].substring(0, data[4].indexOf("@"));
						mngrId = mngrId.replaceAll((new RegExp(/[^a-z|^0-9]/gi)), "").toLowerCase();
						$("#mngrId").val(mngrId);
					}
				}

				function f_mngr_auth_info_callback(authrtTy, data) {
					console.log(authrtTy, data);
					$("input[name=authrtTy]:radio[value='"+authrtTy+"']").prop("checked",true).trigger('change');
					if(authrtTy=="2"){
						if(data.mngMenu) {
							let tree = $('#mng_menu_tree').jstree(true);
							tree.uncheck_all();
							tree.close_all();
							$.each(data.mngMenu, function(idx, item){
								tree.check_node(item);
								tree.open_node(tree.get_node(item).parents);
							});
							setMngMenu();
						}
					}
				}

				$(function(){

					//blockUI js loading
					$.getScript("/html/core/vendor/jquery.blockui/jquery.blockUI.js", function(data,textStatus,jqxhr){
						if(jqxhr.status == 200) {
							console.log("blockUI is load success")

							MngMenu.init();
						} else {
							console.log("blockUI is load failed")
						}
					});

					$(".delProfileImgBtn").on("click", function(){
						$("#delProfileImg").val("Y");
						//$(this).closest("div").slideUp(10);
						$(this).remove();
						$(".profile-div").remove();
					});

					$("input[name=authrtTy]").on("change", function(){
						let chk = $("input[name=authrtTy]:checked").val();
						//let tree = $("#mng_menu_tree").jstree(true);
						switch(chk) {
							case "2":
								f_hide_block();
								break;
							default:
								//tree.close_all();
								//f_open_tree('LV1')
								f_show_default_block();
								break;
						}
					});

					$(document).on('focus','.untouchable',function(){$(this).blur();})
					.on('click','#mngrId_checker',function(){
						if(f_checkId()) {
							$.ajax({
								type : "post",
								url  : "mngrIdCheck.json",
								data : {mngrId:$("#mngrId").val()},
								dataType : 'json'
							})
							.done(function(data) {
								if(data.isUsed===true){// 이미 사용중인 아이디
									$("#mngrIdCheck").val("N");
									alert("입력하신 아이디는 사용 중입니다.\n다른 아이디를 선택하세요.");
									$("#mngrId").focus();
								}else{
									$("#mngrIdCheck").val("Y");
									alert("사용할 수 있는 아이디입니다.");
								}
							})
							.fail(function(data, status, err) {
								alert("아이디 사용 가능 여부 확인 중 오류가 발생했습니다.");
								console.log('error forward : ' + data);
							});
						}
					})
					.on('click','.btn-find-mngr-auth-info',function(){
						let mngauthinfopopup = window.open("./popup/mngrSearch?pagination[perpage]=5", "popMngrAuthInfo", "width=940, height=700");
					})
					.on('focus','.untouchable',function(){$(this).blur();})
					.on('change','#authrtNo',function(){f_set_authrt()})
					;

					// method 사용시
					$.validator.addMethod("passwordCk",  function( value, element ) {
						return this.optional(element) ||  /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/.test(value);
					});

					$.validator.addMethod("regex", function(value, element, regexpr) {
					    return regexpr.test(value);
					}, "형식이 올바르지 않습니다.");

					// 정규식
					var idchk = /^[a-zA-Z][A-Za-z0-9]{3,24}$/;
					var passwordChk = /^.*(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
					var emailchk = /^[0-9a-zA-Z]([-_.]*[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
					var phonechk = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;

					$("form[name='frmMngr']").validate({
					    ignore: "input[type='text']:hidden",
					    rules : {
					    	mngrId	: { required : true, regex: idchk},
					    	mngrNm	: { required : true},
					    	newPswd	: { required:${mngrVO.crud eq 'CREATE' ? 'true' : 'false'}, minlength: 8, maxlength:25, passwordCk: true},
					    	newPswd1 : { required:${mngrVO.crud eq 'CREATE' ? 'true' : 'false'}, equalTo:"#newPswd" },
					    	telNo : { required : true, regex: phonechk },
					    	eml : { required : true, regex: emailchk },
					    	authrtTy : {required:true}
					    },
					    messages : {
					    	mngrId	: { required : "아이디를 입력 해주세요", regex: "아이디 형식이 잘못되었습니다."},
					    	mngrNm	: { required : "이름을 입력 해주세요"},
					    	newPswd   : { required: "비밀번호를 입력 해주세요", minlength: jQuery.validator.format("{0}자 이상 입력 해주세요"),
										maxlength: jQuery.validator.format("{0}자 이하로 입력해 주십시요"), passwordCk : "비밀번호는 영문자, 숫자, 특수문자 조합을 입력해야 합니다."},
							newPswd1 : { required: "비밀번호 확인을 해주세요", equalTo: "비밀번호가 일치하지 않습니다." },
							telNo : { required : "휴대폰 번호를 입력 해주세요", regex: "휴대전화번호 형식이 잘못되었습니다.\n(010-0000-0000)"  },
					    	eml : { required : "이메일 주소를 입력 해주세요", regex: "이메일 형식이 잘못되었습니다.\n(abc@def.com)" },
							authrtTy : {required: "관리자 권한을 선택 해주세요."}
					    },
					    submitHandler: function (frm) {
					    	setMngMenu();
							if(confirm('<spring:message code="action.confirm.save"/>')){
								frm.submit();
							}else{
								return false;
							}
					    }
					});


					// 관리자 권한 타입
					const authTyCode = {
					<c:forEach items="${authrtTyCode}" var="auth">
					${auth.key} : '${auth.value}',
					</c:forEach>
					};


					//관리자 모달
					var mngrList = $("#datatable").DataTable({
						bServerSide: true,
						sAjaxSource: "./mngrSearchList.json",
						bFilter: false,
						bInfo: false,
						bSort : false,
						bAutoWidth: false,
						//bStateSave: true,
						bLengthChange: false,
						iDisplayLength : 10,
					 	oLanguage: {
					 		sEmptyTable: '데이터가 없습니다.'
					    },
						aoColumns: [
							{ mDataProp: null, sClass: "text-center"},
							{ mDataProp: "mngrId"},
							{ mDataProp: "mngrNm"},
							{ mDataProp: "authrtTy",
								mRender : function(oObj){
									return authTyCode[oObj];
								}
							},
							{ mDataProp: "uniqueId",
								mRender: function(oObj, dp, aDt) {
									var str = "<button type=\"button\" class=\"btn-primary tiny  w-full btn-set-mngr-auth-info\" data-authrt-no=\""+aDt.authrtNo+"\" data-authrt-ty=\""+aDt.authrtTy+"\">선택</button>";
							 		return str;
							} }
						],
						fnServerData: function ( sSource, aoData, fnCallback ) {
							var paramMap = {};
							for ( var i = 0; i < aoData.length; i++) {
				          		paramMap[aoData[i].name] = aoData[i].value;
				          		//console.log(aoData[i].name + " : " + aoData[i].value);
							}
							var pageSize = paramMap.iDisplayLength;
							var start = paramMap.iDisplayStart;
							var pageNum = (start == 0) ? 1 : (start / pageSize) + 1; // pageNum is 1 based

							var restParams = new Array();
							restParams.push({name : "sEcho", value : paramMap.sEcho});
							restParams.push({name : "curPage", value : pageNum });
							restParams.push({name : "cntPerPage", value : pageSize});
							restParams.push({name : "srchMngrNm", value :  $("#srchMngrNm").val()});
							restParams.push({name : "srchTelno", value :  $("#srchTelno").val()});

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
							/* NO > 넘버링 */
							var oSettings = this.fnSettings();
							var startNum = oSettings.fnRecordsDisplay() - oSettings._iDisplayStart;
							var endNum = startNum - oSettings._iDisplayLength + 1;
							if(endNum < 0){ endNum = 1;}
							for ( var i=0, iLen=oSettings.aiDisplay.length ; i<iLen ; i++ ){
								$('td:eq(0)', oSettings.aoData[ oSettings.aiDisplay[i] ].nTr ).html( startNum - i );
							}

						}
					});

					// 모달창 > 검색 이벤트 추가
					$("#srchMngrNm, #srchTelno").on("keyup", function(e){
						if (e.keyCode == 13) {
							mngrList.draw();
						}
					});
					$("#datatableSrchBtn").on("click", function(e){
						e.preventDefault();
						mngrList.draw();
					});


					$(document).on('click', '.btn-set-mngr-auth-info', function(e){
						let authrtNo = $(this).data('authrtNo');
						let authrtTy = $(this).data('authrtTy');

						if(confirm("선택하신 관리자의 권한을 가져오겠습니까?")) {
				        	$(".btn-set-mngr-auth-info").prop("disabled", true);
							$.ajax({
								type: 'post',
								url : 'getMngrAuthrtInfo.json',
								data: {authrtNo:authrtNo,authrtTy:authrtTy},
								dataType: 'json'
							})
							.done(function(json){
								f_mngr_auth_info_callback(authrtTy,json);
								if(json) {
									console.log("success");
									$(".btn-close").click();
								} else {
									alert("권한 복사에 실패하였습니다.\n잠시 후 다시 시도해주세요.");
								}
							})
							.fail(function(){
								alert("권한 복사 작업이 실패하였습니다.<br>계속해서 에러가 발생할 경우\n운영자에게 문의바랍니다.");
							})
							.always(function(){
					        	$(".btn-set-mngr-auth-info").prop("disabled", false);
							});

						}
					});


				});
				</script>
