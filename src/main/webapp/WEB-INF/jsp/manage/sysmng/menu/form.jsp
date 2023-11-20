<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<p class="text-title2 relative">
                    메뉴관리
                    <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                        (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                    </span>
                </p>
                <div class="tree-content">


                    <div id="mng_menu_tree" class="list-jqtree"></div>


                    <form id="mng_menu_setting_form" name="mng_menu_setting_form">
					<input type="hidden" name="crud"   value="" />
					<input type="hidden" name="menuNo" value="0" />
					<input type="hidden" name="sortNo" value="0" />
					<input type="hidden" name="upMenuNo" value="0" />
                        <fieldset>
                            <legend class="sr-only">메뉴 등록/수정</legend>
                            <table class="table-detail mb-7">
                                <colgroup>
                                    <col class="w-43">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row"><label for="menuNm" class="require">메뉴 이름</label></th>
                                        <td><input type="text" class="form-control w-91" id="menuNm" name="menuNm"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="form-item2">메뉴 종류</label></th>
                                        <td>
                                            <div class="form-check-group">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="menuTy" id="menuTy1" value="1" disabled>
                                                    <label class="form-check-label" for="menuTy1">기본 메뉴</label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="menuTy" id="menuTy2" value="2" disabled>
                                                    <label class="form-check-label" for="menuTy2">기본 기능</label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="menuTy" id="menuTy3" value="3" disabled>
                                                    <label class="form-check-label" for="menuTy3">상위 메뉴</label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="menuTy" id="menuTy4" value="4" disabled checked>
                                                    <label class="form-check-label" for="menuTy4">추가 기능</label>
                                                </div>
                                            </div>
                                            <p class="py-1 text-danger">* 기본 메뉴/기능은 관리URL 수정 및 메뉴 삭제가 불가능합니다.</p>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="menuUrl" class="require">관리 URL</label></th>
                                        <td><input type="text" class="form-control w-full" id="menuUrl" name="menuUrl"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="icon">아이콘</label></th>
                                        <td><input type="text" class="form-control w-full" id="icon" name="icon"></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="useYn0" class="require">상태</label></th>
                                        <td>
                                            <div class="form-check-group">
                                            	<c:forEach items="${useYnCode}" var="iem" varStatus="status">
                                                <div class="form-check">
                                                	<input class="form-check-input" type="radio" id="useYn${status.index }" name="useYn" value="${iem.key}" ${status.first ? 'checked':''}>
                                                    <label class="form-check-label" for="useYn${status.index }">${iem.value }</label>
                                                </div>
                                                </c:forEach>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                            <div class="btn-group">
                            	<button type="submit" class="btn-primary large shadow">저장</button>
                            	<button type="button" class="btn large shadow btn-reset">취소</button>
                        	</div>
                        </fieldset>


                    </form>
                </div>

                <script>
                const f_hide_menu_block = function() {
                	$(".tree-content fieldset").unblock();
                }
                const f_show_wait_menu_block = function() {
                    $(".tree-content fieldset").block({
                        overlayColor: '#000000',
                        opacity: 0.1,
                        message: 'Please wait...'
                    });
                }
                const f_show_default_menu_block = function() {
                	$(".tree-content fieldset").block({
                		message: '<div class="blockui"><span>메뉴를 선택하여 정보를 수정하세요.</span></div>',
                	    centerX: true,
                	    centerY: true,
                        css: {
                            top: '30%',
                            left: '50%',
                            border: '0',
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
                const f_mng_menu_form_reset = function(type) {
                	if(type===undefined||type===null) {
                		type="clear";
                	}
                	let menuNo = $("#mng_menu_setting_form").find("input[name=menuNo]").val();
                	$("#mng_menu_setting_form")[0].reset();
                	$.each($("#mng_menu_setting_form").find("input[type=hidden]"), function(){ $(this).val(($(this).attr('name').endsWith("No")?"0":"")); });
                	$.each($("#mng_menu_setting_form").find("input[readonly]"), function(){ $(this).prop("readonly",false);});
                	$.each($("#mng_menu_setting_form").find("input[disabled]"), function(){ if("menuTy"!=$(this).attr("name")){$(this).prop("disabled",false);}});
                	if(type=="reset"&&menuNo!=''&&menuNo>0) {
                		f_get_mng_menu(menuNo);
                	}
                }
                const f_get_mng_menu = function(menuNo) {
                	f_mng_menu_form_reset("clear");

                	$.ajax({
                		type : "post",
                		url  : "getMngMenu.json",
                		data : {menuNo:menuNo},
                		dataType : 'json'
                	})
                	.done(function(json){
                 		console.log(json);
                		$("#mng_menu_setting_form").find("input[name=crud]").val("UPDATE");
                		$("#mng_menu_setting_form").find("input[name=menuNo]").val(json.menuNo);
                		$("#mng_menu_setting_form").find("input[name=menuNm]").val(json.menuNm);
                		$("#mng_menu_setting_form").find("input[name=upMenuNo]").val(json.upMenuNo);
                		$("#mng_menu_setting_form").find("input[name=menuUrl]").val(json.menuUrl);
                		$("#mng_menu_setting_form").find("input[name=icon]").val(json.icon);
                		$("#mng_menu_setting_form").find("input[name=sortNo]").val(json.sortNo);
                		if(json.menuTy=="1"||json.menuTy=="2"||json.menuTy=="3") {
                			$("#mng_menu_setting_form").find("input[name=menuUrl]").prop("readonly", true);
                		} else {
                			$("#mng_menu_setting_form").find("input[name=menuUrl]").prop("readonly", false);
                		}
                		if(json.menuTy=="1"||json.menuTy=="2") {
                			$("#mng_menu_setting_form").find("input:radio[name=menuTy]").prop('disabled', true);
                		} else {
                			$("#mng_menu_setting_form").find("input:radio[name=menuTy][value='3']").prop('disabled', false);
                			$("#mng_menu_setting_form").find("input:radio[name=menuTy][value='4']").prop('disabled', false);
                		}

                		$("#mng_menu_setting_form").find("input:radio[name=menuTy][value="+json.menuTy+"]").prop('checked', true);
                		$("#mng_menu_setting_form").find("input:radio[name=useYn][value="+json.useYn+"]").prop('checked', true);

                		f_hide_menu_block();
                	})
                	.fail(function(xhr,status,errorThrown){
                		console.log(xhr,status,errorThrown);
                		f_hide_menu_block();
                		//f_show_default_menu_block();
                	})
                	.always(function(xhr,status){
//                 		f_hide_menu_block();
                	});
                };
                const f_refresh_tree = function() {
                	$("#mng_menu_tree").jstree(true).refresh();
                }
                const f_find_childrens_tree = function(id) {
                	return $("#mng_menu_tree").jstree(true).tree.get_node(id).children;
                }
                const f_open_tree = function(depth) {
                	let tree = $("#mng_menu_tree").jstree(true);
                	if(/^[1-9]$/g.test(depth.substring(2))) {
                		let lv = parseInt(depth.substring(2));
                		let children = [].concat(tree.get_node('#').children);
                		let ids = [].concat(children);
                		for(;lv>0;lv--) {
                			let c = [].concat(children);
                			for(let i in c) {
                				children = children.concat(tree.get_node(c[i]).children);
                			}
                			ids = ids.concat(children);
                		}
                		tree.open_node(ids);
                	} else {
                		tree.open_all();
                	}
                };
                const f_close_tree = function() {
                	let tree = $("#mng_menu_tree").jstree(true);
                	let allId = [].concat(tree.get_node('#').children_d);
                	allId.splice(0, 1);
                	tree.close_node(allId);
                };
                const siteMenuType = {
                	"home":  {"icon": "jstree-folder"},
                	"folder":{"icon": "jstree-folder"},
                	"basic": {"icon": "jstree-file"}
                };
                const preventDblSelector = class {
                	constructor(timeStamp, selected) {
                		this.timeStamp = timeStamp;
                		this.selected  = selected;
                	}
                	check(timeStamp, selected) {
                		var checked = (timeStamp-this.timeStamp)>500 || selected.indexOf(this.selected) < 0;
                		this.timeStamp = timeStamp;
                		this.selected = selected[0];
                		return checked;
                	}
                };
                const preventDblSelected = new preventDblSelector(+ new Date(), '0');
                let selectedTimer;
				const SiteMenu = function() {
					var drawTree = function() {
		                $('#mng_menu_tree').jstree({
		                	'plugins': ["wholerow", "types", "contextmenu", "dnd"],
		        			'core': {
		        				"multiple":false,
		        				"themes" : {
		        					"responsive": false
		        				},
		                        "check_callback" : function(operation, node, node_parent, node_pos, more) {
		                        	console.log(operation, node, node_parent, node_pos, more);
		                            if(operation === 'move_node') {
		                            	if(node_parent.id === "#"){return false;} // 최상위 레벨로 이동 금지
		                            	if(node.state.disabled){return false;} // 비활성 상태 이동 금지
		                            	if(node_parent.type!="folder"&&node_parent.type!="home"){return false;} // 폴더가 아니면 못들어감
		        						if(node_parent.parents.length>3){return false;} // 메뉴는 3depth까지만(3depth 메뉴 아래로는 못 들어감)
		        						if(node_parent.parents.length==3&&node.children.length>0){return false;} // 메뉴는 3depth까지만(2depth메뉴는 자식이 있으면 못들어감)
		        						if(node_parent.parents.length==2&&(node.children.length!=node.children_d.length)){return false;}// 메뉴는 3depth까지만(1depth에 있던 메뉴 중 자식이 3depth까지 있으면 못 들어감)
		                            }
		                            if(operation==="create_node") {
		        						if(node_parent.parents.length>3){return false;} // 메뉴는 3depth까지만(3depth 메뉴 아래에는 생성 안됨)
		                            }
		                        	return true;
		                        },
		                        "data" : function(obj, callback) {
		                    		$.ajax({
		                    			type : "post",
		                    			url  : "getMenuList.json",
		                    			dataType : 'json'
		                    		})
		                    		.done(function(json){
		                    			var menu = [];
                                        for (var idx = 0; idx < json.length; idx++) {
		                    				var menuType = '';
		                    				if(json[idx].childCnt > 0){
		                    					menuType = 'folder';
		                    				}else{
		                    					menuType = 'basic';
		                    				}

		                    				menu.push({
		                    					'id' : json[idx].menuNo
		                    					, 'menuNo' : json[idx].menuNo
		                    					, 'parent' : json[idx].upMenuNo != 0 ? json[idx].upMenuNo : '#'
		                    					, 'text' : json[idx].menuNm
		                    					, 'type' : menuType
		                    					, 'menuTy' : json[idx].menuTy
		                    					, 'useYn' : json[idx].useYn
		                    					, 'sortNo' : json[idx].sortNo
		                    				});
		                    			}
		                    			callback.call(this, menu);
		                    		})
		                    		.fail(function(xhr,status,errorThrown){
		                    			console.log(xhr, status, errorThrown);
		                    			alert("메뉴 트리 갱신에 실패하였습니다.");
		                    		});
		                        }
		        			},
		        			'types': siteMenuType,
		        			'contextmenu': {
		        				"items": function($node) {
		        					var tree = $("#mng_menu_tree").jstree(true);
		        					console.log($node);
		        					let ctxMenu = {
		        							"Create": {
		        								"separator_before":false,
		        								"separator_after":false,
		        								"label": "새 메뉴 만들기",
		        								"action": function(obj) {
		        									$node = tree.create_node($node);
		        								}
		        							},
		        							"Rename": {
		        								"separator_before":false,
		        								"separator_after":false,
		        								"label": "이름 바꾸기",
		        								"_disabled": function(obj) {
		        									return ($node.parent == '#') ? true : false;
		        								},
		        								"action": function(obj) {
		        									tree.edit($node);
		        								}
		        							},
		        							"ChangeUseYn": {
		        								"separator_before":false,
		        								"separator_after":false,
		        								"label": function(obj) {
		        									return ($node.original.useYn == 'Y') ? '메뉴 사용안함' : '메뉴 사용함';
		        								},
		        								"_disabled": function(obj) {
		        									return ($node.parent == '#') ? true : false;
		        								},
		        								"action": function(obj) {
		        									var toUseYn = $node.original.useYn =='Y' ? 'N' : 'Y';
		        									$.ajax({
		        										type: 'post',
		        										url : 'setMenuUseYn.json',
		        										data: {
		        											menuNo: $node.id,
		        											useYn: toUseYn
		        										},
		        										dataType: 'json'
		        									})
		        									.done(function(json){
		        										var mtype = $node.type;
		        										$node.original.useYn = toUseYn;
		        										tree.set_type($node.id, mtype);
		        									})
		        									.fail(function(xhr,status,errorThrown){
		        										//console.log(xhr,status,errorThrown);
		        										alert("메뉴 상태 변경에 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의 바랍니다.");
		        									})
		        									.always();
		        								}
		        							},
		        							"Delete": {
		        								"separator_before":false,
		        								"separator_after":false,
		        								"label": '메뉴 삭제',
		        								"_disabled": function(obj) {
		        									return ($node.children_d.length > 0) ? true : false;
		        								},
		        								"action": function(obj) {
		        									$.ajax({
		        										type: 'post',
		        										url : 'action.json',
		        										data: {menuNo:$node.id,crud:'DELETE'},
		        										dataType: 'json'
		        									})
		        									.done(function(json){
		        										if(json.result=="Y") {
		        											alert(json.resultMsg);
		        										} else {
		        											alert("메뉴 삭제 중 오류가 발생하였습니다.");
		        										}
		        									})
		        									.fail(function(xhr,status,errorThrown){
		        										console.log(xhr,status,errorThrown);
		        										alert("메뉴 삭제가 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의 바랍니다.");
		        									})
		        									.always(function(){
		        										let x = obj.parent;
		        										tree.refresh();
		        										tree.activate_node(x);
		        										f_mng_menu_form_reset("clear");
		        									});
		        								}
		        							}
		        						};
		        					if($node.type!="folder"){delete ctxMenu.Delete;}
		        					if($node.children.length>0){delete ctxMenu.Delete;}
		        					//if($node.type!="home"&&$node.type!="folder"){delete ctxMenu.Create;}
		        					if($node.parents.length>3){delete ctxMenu.Create;}
		        					return ctxMenu;
		        				}
		        			},
		        			'dnd': {
		        				copy: false, //노드 복사 금지 (Ctrl+드래그)
		        				inside_pos: "last", //폴더 내로 이동 시 맨 마지막으로 이동
		        			}
		        		})
		                .on('ready.jstree',function(e,obj){
							var tree = $('#mng_menu_tree').jstree(true);
							$.each(tree.get_node('#').children, function(idx, item){
								tree.open_node(item); // 1depth만 열기
								//tree.open_all(); // 전체 열기
							});
						})
		                .on('create_node.jstree',function(e,obj){
							// 같은 레벨의 노드 맨 마지막 sortNo에 +1을 한 값을 sortNo로 사용
							let siblingNode = $('#mng_menu_tree').jstree(true).get_node(obj.parent).children;
							let sort_no = obj.position+1;

							console.log("obj.position:" + obj.position);
							for(let run=siblingNode.length-1; run>=0; run--) {
								if(obj.node.id!=siblingNode[run]) {
									sort_no = $('#mng_menu_tree').jstree(true).get_node(siblingNode[run]).original.sortNo + 1;
									break;
								}
							}

							// TODO -- 작업 스크린 띄움
							$.ajax({
								type: 'post',
								url : 'setNewMenu.json',
								data : {
									upMenuNo : obj.parent,
									levelNo : obj.node.parents.length,
									sortNo : sort_no,
									menuNm : obj.node.text,
									useYn : 'Y',
									menuUrl : '#',
									icon : '',
									id : obj.node.id
								},
								dataType : 'json'
							})
							.done(function(json){
								if(json.oldId == obj.node.id) {
									$('#mng_menu_tree').jstree(true).set_id(obj.node,json.vo.menuNo);
									$('#mng_menu_tree').jstree(true).set_type(obj.node,'folder');
									$('#mng_menu_tree').jstree(true).edit(obj.node);
								} else {
									// TODO - 메뉴 삭제 코드
									alert("비정상 접근이 감지되었습니다.");
								}
							})
							.fail(function(xhr,status,errorThrown){
								console.log(xhr,status,errorThrown);
								alert("메뉴 추가에 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의 바랍니다.");
								$('#mng_menu_tree').jstree(true).delete_node(obj.node);
							})
							.always(function(xhr,status){
								// TODO -- 작업 스크린 삭제
							});
						})
						.on('rename_node.jstree',function(e,obj){
							var tree = $("#mng_menu_tree").jstree(true);
							if(obj.text!=obj.old) {
								$.ajax({
									type: 'post',
									url : 'setMenuName.json',
									data: {
										menuNo: obj.node.id,
										menuNm: obj.text
									},
									dataType: 'json'
								})
								.done(function(json){
									obj.node.original.text = obj.text;
									// 이름변경후
									tree.refresh();
								})
								.fail(function(){
									$('#mng_menu_tree').jstree(true).set_text(obj.node,obj.old);
									alert("이름 변경이 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의바랍니다.");
								})
								.always(function(){

								})
								;
							}
						})
						.on('move_node.jstree',function(e,obj){
							var tree = $("#mng_menu_tree").jstree(true);
							let seq = tree.get_node(obj.parent).children.join(",");
							tree.disable_node(tree.get_node('#').children_d);
							$.ajax({
								type: 'post',
								url : 'moveMenu.json',
								data: {
									menuNo: obj.node.id,
									upMenuNo: obj.parent,
									sortNo: obj.position,
									sortSeq: seq
								},
								dataType: 'json'
							})
							.done(function(json){
								if(json.ok===false) {
									alert("메뉴 이동이 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의바랍니다.");
								}
							})
							.fail(function(){
								alert("메뉴 이동이 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의바랍니다.");
							})
							.always(function(){
								let x = obj.node.id;
								tree.refresh();
								tree.activate_node(x);
							})
							;
						})
						.on('select_node.jstree',function(e,obj) {
							if(obj.selected.length>1) {
								$('#mng_menu_tree').jstree(true).deselect_node(obj);
								return false;
							} else if(obj.node.parent == "#") {
								$('#mng_menu_tree').jstree(true).deselect_all();
								return false;
							} else if(!preventDblSelected.check(e.timeStamp, obj.selected)) {
								clearTimeout(selectedTimer);
							} else {
								clearTimeout(selectedTimer);
								selectedTimer = setTimeout(function(){
									f_get_mng_menu(obj.node.id);
								}, 500);
							}
						});
					}
					return {
						init: function(){
							drawTree();
						}
					};
				}();


                $(function(){

                	//blockUI js loading
					$.getScript("/html/core/vendor/jquery.blockui/jquery.blockUI.js", function(data,textStatus,jqxhr){
						if(jqxhr.status == 200) {
							console.log("blockUI is load success")
							f_show_default_menu_block();
						} else {
							console.log("blockUI is load failed")
						}
					});

                	SiteMenu.init();

                    $("form#mng_menu_setting_form").validate({
                	    ignore: "input[type='text']:hidden",
                	    rules : {
                	    	menuNm			: { required : true },
                	    	menuUrl			: { required : true }
                	    },
                	    messages : {
                		    menuNm			: { required : "메뉴명을 입력하세요" },
                		    menuUrl			: { required : "관리URL을 입력하세요" }
                	    },
                	    submitHandler: function (frm) {
                			f_show_wait_menu_block();
                	    	if(confirm("입력하신 정보를 저장 하시겠습니까?")){
                				$.ajax({
                					type: 'post',
                					url : 'action.json',
                					data: $("form#mng_menu_setting_form").serialize(),
                					dataType: 'json'
                				})
                				.done(function(json){
                					$("#mng_menu_tree").jstree(true).refresh();
                				})
                				.fail(function(){
                					alert("메뉴 정보 수정에 실패하였습니다.\\n계속해서 에러가 발생할 경우 운영자에게 문의바랍니다.");
                				})
                				.always(function(){
                					f_hide_menu_block();
                				});
                	    	} else{
                	    		f_hide_menu_block();
                	    	}
                    		return false;
                	    }
                	});

                });

                $("form#mng_menu_setting_form button.btn-reset").on("click", function(e){
            		e.preventDefault();
            		f_mng_menu_form_reset("reset");
            		return false;
            	});
            	$("#mng_menu_setting_form input[name=menuTy]").on("propertychange change keyup paste input", function(){
            		if("3"==$("#mng_menu_setting_form input[name=menuTy]:checked").val()) {
            			$("#mng_menu_setting_form input#menuUrl").prop("disabled",false).prop("readonly",true).val("#f");
            		} else if ("4"==$("#mng_menu_setting_form input[name=menuTy]:checked").val()) {
            			if($('#mng_menu_tree').jstree(true).get_node($("#mng_menu_setting_form input[name=menuNo]").val()).children.length>0) {
            				alert("자식 메뉴를 보유한 상위 메뉴는 추가 메뉴로 변경할 수 없습니다.");
            				$("#mng_menu_setting_form input[name=menuTy][value=3]").prop("checked",true);
            				return;
            			}
            			$("#mng_menu_setting_form input#menuUrl").prop("disabled",false).prop("readonly",false);
            		}
            	});

                </script>