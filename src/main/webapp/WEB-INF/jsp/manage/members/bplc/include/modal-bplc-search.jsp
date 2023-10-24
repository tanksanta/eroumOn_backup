<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


				<!-- 사업소 선택 -->
                <div class="modal fade" id="bplcModal" tabindex="-1">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <p>장기요양기관 선택</p>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                            </div>
                            <div class="modal-body">
                                <ul class="nav tab-list tab-full">
                                    <li><a href="#modal-pane1" class="active" data-bs-toggle="pill" role="tab" aria-selected="true" data-rcmdtn-yn="Y">추천 장기요양기관</a></li>
                                    <li><a href="#modal-pane2" data-bs-toggle="pill" role="tab" aria-selected="false" data-rcmdtn-yn="">장기요양기관 찾기</a></li>
                                </ul>
                                <div class="tab-content mt-5">
                                            <fieldset>
                                                <legend class="text-title2">장기요양기관 검색</legend>
                                                <table class="table-detail">
                                                    <colgroup>
                                                        <col class="w-43">
                                                        <col>
                                                    </colgroup>
                                                    <tbody>
                                                        <tr>
                                                            <th scope="row"><label for="modalSrchSido">시/도 선택</label></th>
                                                            <td>
                                                                <select name="modalSrchSido" id="modalSrchSido" class="form-control w-52">
                                                                    <option value="">선택</option>
                                                                    <c:forEach items="${stdgCdList}" var="stdg">
										                            	<option value="${stdg.stdgCd}">${stdg.ctpvNm }</option>
										                            </c:forEach>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th scope="row"><label for="modalSrchGugun">구/군 선택</label></th>
                                                            <td>
                                                                <select name="modalSrchGugun" id="modalSrchGugun" class="form-control w-52">
                                                                    <option value="">선택</option>
                                                                </select>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th scope="row"><label for="modalSrchText">장기요양기관명</label></th>
                                                            <td><input type="text" class="form-control w-full" id="modalSrchText" name="modalSrchText"></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </fieldset>

                                            <div class="btn-group mt-4">
                                                <button type="button" class="btn-primary large w-36" id="modalSrchBplcBtn">검색</button>
                                            </div>

                                        <p class="mt-10 text-title2">장기요양기관 목록</p>
                                        <!-- 일반 테이블-->
                                        <table class="table-list" id="bplcDataTable">
                                            <colgroup>
                                                <col class="w-21">
                                                <col class="w-55">
                                                <col>
                                                <col class="w-35">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">선택</th>
                                                    <th scope="col">장기요양기관명</th>
                                                    <th scope="col">주소</th>
                                                    <th scope="col">전화번호</th>
                                                </tr>
                                            </thead>
                                        </table>

                                </div>
                            </div>
                            <div class="modal-footer">
                                <button tyep="button" class="btn large btn-primary w-36 f_modalSelBplc">선택</button>
                                <button type="button" class="btn large btn-secondary w-36 f_modalCancel" data-bs-dismiss="modal" aria-label="close">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //사업소 선택 -->

<script>
const bplcMap = new Map();
const BplcDataTable = function() {
	var bplcSrchList;
	var dtCall = function(){
		bplcSrchList = $("#bplcDataTable").DataTable({
			bServerSide: true,
			sAjaxSource: "/_mng/members/bplc/bplcSearchList.json",
			bFilter: false,
			bInfo: false,
			bSort : false,
			bAutoWidth: false,
			bLengthChange: false,
			language: dt_lang,

			aoColumns: [
				{ mDataProp: "uniqueId",
					mRender: function(oObj, dp, aDt) {
						var str  = '<div class="form-check">';
							str += '<input class="form-check-input" id="modalBplc_'+aDt.uniqueId+'" name="modalBplcUniqueId" type="radio" value="'+aDt.uniqueId+'" data-bplc-nm="'+ aDt.bplcNm +'" data-bplc-id="'+ aDt.bplcId +'" data-rcmd-cnt="'+ aDt.rcmdCnt +'" data-telno="'+ aDt.telno +'">';
							str += '</div>';
				 		return str;
					}
				},
				{ mDataProp: "bplcNm",
					mRender: function(oObj, dp, aDt) {
						var str  = aDt.bplcNm + ' [<img src="/html/page/members/assets/images/ico-mypage-recommend.svg" style="display: inline; margin-top: -2px; margin-right: 3px; height: 13px;">'+ aDt.rcmdCnt +']';
						return str;
					}

				},
				{ mDataProp: "addr"},
				{ mDataProp: "telno"}
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
				restParams.push({name : "rcmdtnYn", value :  $("#bplcModal .tab-full li a.active").data("rcmdtnYn")});
				restParams.push({name : "srchSido", value :  ($("#modalSrchSido").val() != "")?$("#modalSrchSido option:selected").text().substring(0,2):""});
				restParams.push({name : "srchGugun", value :  ($("#modalSrchGugun").val() != "")?$("#modalSrchGugun option:selected").text():""});
				restParams.push({name : "srchBplcNm", value :  $("#modalSrchText").val()});
				restParams.push({name : "mbGiupMatching", value : 'Y' });

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

				//console.log("drawCallback");
				bplcMap.clear();
				//console.log(bplcMap);
				var api = this.api();
		       	rows = api.rows( {page:'current'} ).data();
		       	for(var i=0; i < rows.length; i++){
		       		bplcMap.set(rows[i].uniqueId, rows[i]);
		       	}
			}
		});
	}
	return {
		init: function(){
			dtCall();
			$("#bplcModal .tab-full li a").on("click", function(e){
				e.preventDefault();
				bplcSrchList.draw();
			});

			// 검색창 이벤트 추가
			$("#modalSrchText").on("keyup", function(e){
				if (e.keyCode == 13) {
					bplcSrchList.draw();
				}
				e.preventDefault();
			});
			$("#modalSrchBplcBtn").on("click", function(e){
				e.preventDefault();
				bplcSrchList.draw();
			});

			$(".f_modalSelBplc").on("click", function(){
				let uniqueId = $("#bplcDataTable td :radio:checked").map(function(){return $(this).val();}).get();
				if(uniqueId==null||uniqueId.length==0) {
					alert("선택된 사업소가 없습니다.");
				}else{
					console.log(uniqueId);
					let bplcId = $("#bplcDataTable td :radio:checked").data("bplcId");
					let bplcNm = $("#bplcDataTable td :radio:checked").data("bplcNm");
					let telno = $("#bplcDataTable td :radio:checked").data("telno");
					let rcmdCnt = $("#bplcDataTable td :radio:checked").data("rcmdCnt");
					f_modalBplcSearch_callback(uniqueId, bplcId, bplcNm, telno, rcmdCnt);

					$("#bplcDataTable td :radio, #bplcDataTable div :radio").prop("checked",false);
					$(".f_modalCancel").click();
				}
			});
		}
	};
}();


$(function(){

	//시/군/구 검색
	$("#modalSrchSido").on("change", function(){
		$("#modalSrchGugun").empty();
		$("#modalSrchGugun").append("<option value=''>시/군/구</option>");
		if($("#modalSrchSido").val() != ""){
			$.ajax({
				type : "post",
				url  : "/members/stdgCd/stdgCdList.json",
				data : {stdgCd:$("#modalSrchSido").val()},
				dataType : 'json'
			})
			.done(function(data) {
				if(data.result){
					$.each(data.result, function(index, item){
						$("#modalSrchGugun").append("<option value='"+ item.sggNm +"'>"+ item.sggNm +"</option>");
	                });
				}
			})
			.fail(function(data, status, err) {
				console.log('지역호출 error forward : ' + data);
			});
		}
	});



});
</script>