<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

				<p class="text-title2 relative">
                    카테고리관리
                    <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                        (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                    </span>
                </p>
                <div class="tree-content">


                    <div id="ctgryTree" class="list-jqtree">
                    </div>


                    <form:form name="frmGdsCtgry" id="frmGdsCtgry" modelAttribute="gdsCtgryVO" method="post" action="./action" class="form-horizontal form-bordered mb-md" enctype="multipart/form-data">
					<form:hidden path="crud" />
					<form:hidden path="levelNo" />
					<form:hidden path="upCtgryNo" />

                        <fieldset>
                            <table class="table-detail mb-7">
                                <colgroup>
                                    <col class="w-43">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="row">카테고리 ID</th>
                                        <td>
                                        	<form:input path="ctgryNo" class="form-control" readonly="true" />
											<form:hidden path="orgCtgryNo"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="ctgryNm" class="require">카테고리명</label></th>
                                        <td>
                                        	<form:input path="ctgryNm" class="form-control w-90" maxlength="100" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">현재 위치</th>
                                        <td><span id="upCtgryNm"></span></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><label for="useYn0">사용 여부</label></th>
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
                                    <tr>
                                        <th scope="row">하위 카테고리 수</th>
                                        <td><span id="childCnt"></span></td>
                                    </tr>
                                    <tr id="imgView" style="display:none;">
                                    	<th scope="row">카테고리 이미지</th>
                                    	<td>
                                    		<div class="custom-file" id="uptAttach">
                                    			<input type="file" class="form-control w-90" id="attachFile" name="attachFile" onchange="fileCheck(this);"  style="display:none;"/></otherwise>
											</div>
											<div class="custom-file" id="attachImg">
											</div>
									</td>
                                    </tr>
                                </tbody>
                            </table>

	                        <div class="btn-group">
	                            <button type="submit" class="btn-primary large shadow">저장</button>
	                            <button type="button" class="btn-secondary large shadow" onclick="f_delete(); return false;">삭제</button>
	                        </div>
                        </fieldset>

                    </form:form>
                </div>

                <script>


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

                function f_delete(){
                	if($("#childCnt").text() > 0){
                		alert("하위 카테고리가 있을 경우 삭제할 수 없습니다.\n하위 카테고리를 이동/삭제 후 다시 시도 해주세요.");
                	}else if(confirm("삭제된 카테고리는 복구할 수 없습니다.\n선택하신 카테고리를 삭제하시겠습니까?")){
                		$("#crud").val("DELETE");
                		$("#frmGdsCtgry").submit();
                	}
                }

                const f_open_tree = function(depth) {
                	let tree = $("#ctgryTree").jstree(true);
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
                	let tree = $("#ctgryTree").jstree(true);
                	let allId = [].concat(tree.get_node('#').children_d);

                	//console.log(allId);

                	allId.splice(0, 1);
                	tree.close_node(allId);
                };

                const f_hide_block = function() {
                	$(".tree-content fieldset").unblock();

                }

                const f_show_block = function() {
                	$(".tree-content fieldset").block({
                		message: '<div class="blockui"><span>카테고리를 선택하여 정보를 수정하세요.</span></div>',
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

                const iconType = {
                   	"home":  {"icon": "jstree-folder"},
                   	"folder":{"icon": "jstree-folder"},
                   	"basic": {"icon": "jstree-file"}
                };
                const GdsCtgryList = function() {
                	var drawTree = function() {
                		$("#ctgryTree").jstree({
                			"plugins" : ["wholerow", "types", "contextmenu", "dnd"],
                			"core" : {
                				"multiple" : false,
                	            "themes" : { "responsive": false},
                	            "ui" : {"select_limit" : 1},
                	            "check_callback" : function(operation, node, node_parent, node_pos, more) {
                	            	//console.log("@@ : " + operation, node, node_parent, node_pos, more);
                	            	if(operation === 'move_node') {
                                    	if(node_parent.id === "#"){return false;} // 최상위 레벨로 이동 금지
                                    	if(node.state.disabled){return false;} // 비활성 상태 이동 금지
                						if(node_parent.parents.length>3){return false;}
                						if(node_parent.parents.length==2&&node.children.length>0){return false;}
                						if(node_parent.parents.length==1&&(node.children.length!=node.children_d.length)){return false;}
                                    }
                                    if(operation==="create_node") {
                						if(node_parent.parents.length>4){return false;} // 메뉴는 3depth까지만(3depth 메뉴 아래에는 생성 안됨)
                                    }
                                	return true;
                	            },
                	            "data" : function(obj, callback) {
                	            	$.ajax({
                            			type : "post",
                            			url  : "getGdsCtgryList.json",
                            			dataType : 'json'
                            		})
                            		.done(function(json){
                            			var ctgryArr = [];
                            			//ctgryArr.push({'id':'0', 'parent':'#', 'text':'상품카테고리'})
                            			for (var idx in json) {

                            				var iconType = '';
		                    				if(json[idx].childCnt > 0){
		                    					iconType = 'folder';
		                    				}else{
		                    					iconType = 'basic';
		                    				}

                            				ctgryArr.push({
                            					'id' : json[idx].ctgryNo
                            					, 'parent' : json[idx].upCtgryNo != 0 ? json[idx].upCtgryNo : '#'
                            					, 'text' : json[idx].ctgryNm
                            					, 'sortNo' : json[idx].sortNo
                            					, 'type' : iconType
                            				});
                            			}
                            			callback.call(this, ctgryArr);
                            		})
                            		.fail(function(xhr,status,errorThrown){
                            			console.log(xhr, status, errorThrown);
                            			alert("트리 갱신에 실패하였습니다.");
                            		});
                	            }
                		    },
                		    "types": iconType,
                			"contextmenu": {
                				"items": function($node) {
                					var tree = $("#ctgryTree").jstree(true);
                					//console.log($node);
                					let ctxMenu = {
                							"Create": {
                								"separator_before":false,
                								"separator_after":false,
                								"label": "새 카테고리 만들기",
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
                							"Delete": {
                								"separator_before":false,
                								"separator_after":false,
                								"label": '카테고리 삭제',
                								"_disabled": function(obj) {
                									return ($node.children_d.length > 2) ? true : false; // 카테고리 삭제 depth
                								},
                								"action": function(obj) {
                									$.ajax({
                										type: 'post',
                										url : 'action.json',
                										data: {ctgryNo:$node.id,upCtgryNo:$node.parent,crud:'DELETE'},
                										dataType: 'json'
                									})
                									.done(function(json){
                										if(json.result) {
                											alert(json.msg);
                										} else {
                											alert("카테고리 삭제 중 오류가 발생하였습니다.");
                										}
                									})
                									.fail(function(xhr,status,errorThrown){
                										console.log(xhr,status,errorThrown);
                										alert("카테고리 삭제가 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의 바랍니다.");
                									})
                									.always(function(){
                										let x = obj.parent;
                										tree.refresh();
                										tree.activate_node(x);
                										//f_mng_menu_form_reset("clear");
                									});
                								}
                							}
                						};
                					if($node.children.length>1){delete ctxMenu.Delete;}
                					if($node.parents.length>4){delete ctxMenu.Create;} //새 카테고리 만들기 depth
                					return ctxMenu;
                				}
                			},
                			"dnd": {
                				copy: false, //노드 복사 금지 (Ctrl+드래그)
                				inside_pos: "last", //폴더 내로 이동 시 맨 마지막으로 이동
                			}
                		}).on('create_node.jstree',function(e,obj){
                			// 같은 레벨의 노드 맨 마지막 sortNo에 +1을 한 값을 sortNo로 사용
                			let siblingNode = $('#ctgryTree').jstree(true).get_node(obj.parent).children;
                			let sort_no = obj.position+1;

                			//console.log("obj.position:" + obj.position);
                			for(let run=siblingNode.length-1; run>=0; run--) {
                				if(obj.node.id!=siblingNode[run]) {
                					sort_no = $('#ctgryTree').jstree(true).get_node(siblingNode[run]).original.sortNo + 1;
                					//console.log(sort_no);
                					break;
                				}
                			}
                			$.ajax({
                				type: 'post',
                				url : 'setNewGdsCtgry.json',
                				data : {
                					//ctgryNo : obj.parent +'_'+sort_no,
                					upCtgryNo : obj.parent,
                					levelNo : obj.node.parents.length-1,
                					sortNo : sort_no,
                					ctgryNm : obj.node.text,
                					useYn : 'Y',
                					id : obj.node.id
                				},
                				dataType : 'json'
                			})
                			.done(function(json){
                				if(json.oldNo == obj.node.id) {
                					$('#ctgryTree').jstree(true).set_id(obj.node,json.vo.ctgryNo);
                					$('#ctgryTree').jstree(true).edit(obj.node);
                				} else {
                					alert("비정상 접근이 감지되었습니다.");
                				}
                			})
                			.fail(function(xhr,status,errorThrown){
                				console.log(xhr,status,errorThrown);
                				alert("카테고리 추가에 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의 바랍니다.");
                				$('#ctgryTree').jstree(true).delete_node(obj.node);
                			})
                			.always(function(xhr,status){
                				// TODO -- 작업 스크린 삭제
                			});
                		}).on('rename_node.jstree',function(e,obj){
                			var tree = $("#ctgryTree").jstree(true);
                			if(obj.text!=obj.old) {
                				$.ajax({
                					type: 'post',
                					url : 'setGdsCtgryNm.json',
                					data: {
                						ctgryNo: obj.node.id,
                						upCtgryNo : obj.node.parent,
                						ctgryNm: obj.text
                					},
                					dataType: 'json'
                				})
                				.done(function(json){
                					obj.node.original.text = obj.text;
									tree.refresh();
                				})
                				.fail(function(){
                					$('#ctgryTree').jstree(true).set_text(obj.node,obj.old);
                					alert("카테고리명 변경에 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의바랍니다.");
                				})
                				.always(function(){

                				});
                			}
                		}).on('move_node.jstree',function(e,obj){
                			var tree = $("#ctgryTree").jstree(true);
                			let seq = tree.get_node(obj.parent).children.join(",");
                			tree.disable_node(tree.get_node('#').children_d);

                			console.log("@@:" + obj.node.parents.length);

                			$.ajax({
                				type: 'post',
                				url : 'moveGdsCtgry.json',
                				data: {
                					ctgryNo: obj.node.id,
                					upCtgryNo: obj.parent,
                					sortNo: obj.position,
                					levelNo : obj.node.parents.length-1,
                					sortSeq: seq
                				},
                				dataType: 'json'
                			})
                			.done(function(json){
                				if(json.ok===false) {
                					alert("카테고리 이동이 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의바랍니다.");
                				}
                			})
                			.fail(function(){
                				alert("카테고리 이동이 실패하였습니다. 계속해서 에러가 발생할 경우 운영자에게 문의바랍니다.");
                			})
                			.always(function(){
                				let x = obj.node.id;
                				tree.refresh();
                				tree.activate_node(x);
                			});

                		}).on("select_node.jstree", function(e, obj){
                			if(obj.selected.length>1) {
                				$('#ctgryTree').jstree(true).deselect_node(obj);
                				return false;
                			} else if(obj.node.parent == "#") {
                				$('#ctgryTree').jstree(true).deselect_all();
                				return false;
                			} else {

                				$.ajax({
                		      		dataType : "json",
                		      	    type : "POST",
                		      	    url : "./getGdsCtgry.json",
                					contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                		      	    data : "upCtgryNo="+ obj.node.parent +"&ctgryNo="+obj.node.id,
                		      	    success : function(data) {
                		      	    	$("#attachFile").val('');
                		      	    	//console.log("childCnt" + data.gdsCtgryVO.childCnt);

                		      	    	//값 설정
                		      	    	$("#crud").val("UPDATE");
                		    			$("#upCtgryNo").val(data.gdsCtgryVO.upCtgryNo);
                		    			$("#ctgryNo").val(data.gdsCtgryVO.ctgryNo);
                		    			$("#orgCtgryNo").val(data.gdsCtgryVO.ctgryNo);
                		    			$("#levelNo").val(data.gdsCtgryVO.levelNo);
                		    			$("#childCnt").text(data.gdsCtgryVO.childCnt);

                		    			if(data.gdsCtgryVO.upCtgryNo == "0"){
                		    				$("#upCtgryNm").text("최상위 카테고리");
                		    			}else{
                		    				$("#upCtgryNm").text(data.gdsCtgryVO.upCtgryNm +" > "+ data.gdsCtgryVO.ctgryNm);
                		    			}
                		    			$("#ctgryNm").val(data.gdsCtgryVO.ctgryNm);

                		    			//이미지
                		    			if(data.gdsCtgryVO.levelNo == 1){
                		    				$("#imgView").hide();
                		    			}else{
                		    				$("#imgView").show();
                		    	 			$("#attachImg").empty();

                    		    			var html ="";
                    		    			html += '<img src="/comm/CTGRY_IMG/getFile?fileName='+data.gdsCtgryVO.ctgryImg+'" alt="" >';
                    		    			html += '<a href="#deleteImg" class="btn-secondary" onclick="deleteImg('+data.gdsCtgryVO.ctgryNo+','+data.gdsCtgryVO.upCtgryNo+','+data.gdsCtgryVO.ctgryNo+'); return false;"> 삭제</a>';

                    		    			if(data.gdsCtgryVO.ctgryImg != null){
                    		    				$("#attachImg").append(html);
                    		    				$("#attachFile").hide();
                    		    			}else{
                    		    				$("#attachFile").show();
                    		    			}
                		    			}

                		    			$("#sortNo").val(data.gdsCtgryVO.sortNo);

                		    			$("input:radio[name='useYn'][value='"+ data.gdsCtgryVO.useYn +"']").prop("checked", true);	//사용여부

                		    			f_hide_block();
                					},
                					error: function(data, status, err) {
                						f_show_block();
                						console.log('error forward : ' + data);
                					}
                				});
                			}
                		})
                		.on('ready.jstree',function(e,obj){
                			var tree = $('#ctgryTree').jstree(true);
                			tree.open_all(); // 전체 열기
                			/*
                			$.each(tree.get_node('#').children, function(idx, item){
                				console.log("item" + item);
                				tree.open_node(item);
                			});
                			*/
                		})
                	}
                	return {
                		init: function(){
                			drawTree();
                		}
                	};
                }();

                function deleteImg(ctgryNo,upCtgryNo,orgCtgryNo){

                	var ctgryNo = Number(ctgryNo);
                	var upCtgryNo = Number(upCtgryNo);
                	var orgCtgryNo = orgCtgryNo
                	var tree = $("#ctgryTree").jstree(true);
        			if(confirm("삭제하시겠습니까?")){
         	   			$.ajax({
            				type : "post",
            				url  : "delCtgryImg.json",
            				dataType : 'json',
            				data :
            					{ctgryNo : ctgryNo
            					, upCtgryNo : upCtgryNo
            					, orgCtgryNo : orgCtgryNo},
            			})
            			.done(function(data) {
            				if(data.result == true){
            					alert("이미지가 삭제되었습니다.");
            					tree.refresh();
            				}else{
            					alert("이미지 삭제 오류입니다.");
            				}

            			})
            			.fail(function(data, status, err) {
            				alert("이미지 삭제 중 오류가 발생했습니다.");
            				console.log('error forward : ' + data);
            			});
        			}
                }

                $(function(){

                	//ctgry img
                	$("#attachFile").on("change",function(e){
                		var imageFile = e.target.files[0];
                		var imgFrm = $("#frmGdsCtgry");
            			var formData = new FormData(imgFrm[0]);
            			var ctgryNo = $("#upCtgryNo").val();
            			var upCtgryNo = $("#upCtgryNo").val();
            			var orgCtgryNo = $("#orgCtgryNo").val();
            			var tree = $("#ctgryTree").jstree(true);

            			formData.append("imgFile",imageFile);

        	   			$.ajax({
            				type : "post",
            				url  : "ctgryImg.json",
            				dataType : 'json',
            				data : formData,ctgryNo,upCtgryNo,orgCtgryNo,
            				contentType : false,
            				processData : false,
            			})
            			.done(function(data) {
            				if(data.result == true){
            					alert("이미지가 등록되었습니다.");
            					tree.refresh();
            				}else{
            					alert("이미지 등록 오류입니다.");
            				}

            			})
            			.fail(function(data, status, err) {
            				alert("이미지 등록 중 오류가 발생했습니다.");
            				console.log('error forward : ' + data);
            			});
                	});

                	//blockUI js loading
					$.getScript("/html/core/vendor/jquery.blockui/jquery.blockUI.js", function(data,textStatus,jqxhr){
						if(jqxhr.status == 200) {
							console.log("blockUI is load success")
							f_show_block();
						} else {
							console.log("blockUI is load failed")
						}
					});


					GdsCtgryList.init();

                	$("form#frmGdsCtgry").validate({
                	    ignore: "input[type='text']:hidden",
                	    rules : {
                	    	upCtgryNo	: { required : true }
                	    	, ctgryNo			: { required : true }
                	    	, ctgryNm			: { required : true }
                	    },
                	    messages : {
                	    	upCtgryNo	: { required : "상위카테고리를 먼저 선택하세요" }
                	    	, ctgryNo			: { required : "코드번호를 입력하세요" }
                		    , ctgryNm			: { required : "카테고리명을 입력하세요" }
                	    },
                	    submitHandler: function (frm) {
                			f_show_block();
                	    	if(confirm("입력하신 정보를 저장 하시겠습니까?")){
                				$.ajax({
                					type: 'post',
                					url : 'action.json',
                					data: $("form#frmGdsCtgry").serialize(),
                					dataType: 'json'
                				})
                				.done(function(json){
                					$("#ctgryTree").jstree(true).refresh();
                				})
                				.fail(function(){
                					alert("정보 수정에 실패하였습니다.\\n계속해서 에러가 발생할 경우 운영자에게 문의바랍니다.");
                				})
                				.always(function(){
                					f_hide_block();
                				});
                	    	}
                    		return false;
                	    }
                	});
                });
                </script>