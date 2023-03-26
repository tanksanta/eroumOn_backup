<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


				<!-- 상품검색 -->
                <div class="modal fade " id="gdsModal" tabindex="-1">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <p>상품검색</p>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                            </div>
                            <div class="modal-body dataTables_wrapper">
                                <p class="text-title2">상품 검색</p>
                                <table class="table-detail">
                                    <colgroup>
                                        <col class="w-34">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                        <tr>
                                            <th scope="row"><label for="search-item1">상품코드</label></th>
                                            <td><input type="text" class="form-control w-61" id="modalSrchGdsCd" name="modalSrchGdsCd"></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><label for="search-item2">상품명</label></th>
                                            <td><input type="text" class="form-control w-full" id="modalSrchGdsNm" name="modalSrchGdsNm"></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><label for="search-item3">카테고리</label></th>
                                            <td>
                                                <div class="form-group w-full">
                                                    <select name="modalSrchUpCtgryNo" id="modalSrchUpCtgryNo" class="form-control w-30">
                                                        <option value="0">대분류선택</option>
                                                        <c:forEach items="${gdsCtgryList}" var="ctgryList" varStatus="status">
		                                            	<option value="${ctgryList.ctgryNo}">${ctgryList.ctgryNm}</option>
		                                                </c:forEach>
                                                    </select>
                                                    <select name="modalSrchCtgryNo" id="modalSrchCtgryNo" class="form-control w-30">
                                                        <option value="0">중분류선택</option>
                                                    </select>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="btn-group mt-4">
                                    <button type="button" class="btn-primary large shadow w-30" id="modalSrchGdsBtn">검색</button>
                                </div>

                                <p class="text-title2 mt-10">상품 목록</p>
                                <table id="gdsDataTable" class="table-list">
                                    <colgroup>
                                        <col class="w-15">
                                        <col class="w-32">
                                        <col>
                                        <col class="w-25">
                                        <col class="w-25">
                                        <!-- <col class="w-25"> -->
                                        <col class="w-20">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">
                                            	<div class="form-check">
                                                    <input class="form-check-input" type="checkbox">
                                                </div>
                                            </th>
                                            <th scope="col">상품코드</th>
                                            <th scope="col">상품명</th>
                                            <th scope="col">판매가</th>
                                            <th scope="col">급여가</th>
                                            <!-- <th scope="col">대여가</th> -->
                                            <th scope="col">전시여부</th>
                                        </tr>
                                    </thead>
                                </table>

                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn-primary large shadow w-26 f_modalSelGds">선택</button>
                                <button type="button" class="btn-secondary large shadow w-26" data-bs-dismiss="modal" aria-label="close">취소</button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //상품검색 -->

<script>
//상품검색 데이터 테이블(modal)
//1. ID중복 방지를 위해 접두어(modal) 사용
//2. fnDrawCallback : gdsMap.set(gdsNo, Obejct) -> callback function : f_callbackModalGdsSearch(gdsNos)
/* 예시
$(".f_srchGds").on("click", function(){ // 검색버튼
	if ( !$.fn.dataTable.isDataTable('#gdsDataTable') ) { //DT 생셩여부 판단
		GdsDataTable.init();
	}
});

function f_modalGdsSearch_callback(gdsNos){
//something
}
*/
const gdsMap = new Map();
const GdsDataTable = function() {
	var gdsSrchList;
	var dtCall = function(){
		gdsSrchList = $("#gdsDataTable").DataTable({
			bServerSide: true,
			sAjaxSource: "/_mng/gds/gds/gdsSearchList.json",
			bFilter: false,
			bInfo: false,
			bSort : false,
			bAutoWidth: false,
			bLengthChange: false,
			language: dt_lang,

			aoColumns: [
				{ mDataProp: "gdsNo",
					mRender: function(oObj, dp, aDt) {
						var str  = '<div class="form-check">';
							str += '<input class="form-check-input" id="gdss'+aDt.gdsNo+'" type="checkbox" value="'+aDt.gdsNo+'">';
							str += '</div>';
				 		return str;
					}
				},
				{ mDataProp: "gdsCd"},
				{ mDataProp: "gdsNm"},
				{ mDataProp: "pc"},
				{ mDataProp: "bnefPc"},
				//{ mDataProp: "lendPc"},
				{ mDataProp: "dspyYn",
					mRender: function(oObj, dp, aDt) {
						var str='미판매';
						if(aDt.dspyYn == 'Y' && aDt.stockQy > 0){
							str = '판매중';
						}else if(aDt.dspyYn == 'Y' && aDt.stockQy < 1){
							str = '품절';
						}
						return str;
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
				restParams.push({name : "srchGdsCd", value :  $("#modalSrchGdsCd").val()});
				restParams.push({name : "srchGdsNm", value :  $("#modalSrchGdsNm").val()});
				restParams.push({name : "srchUpCtgryNo", value :  $("#modalSrchUpCtgryNo").val()});
				restParams.push({name : "srchCtgryNo", value :  $("#modalSrchCtgryNo").val()});

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
				gdsMap.clear();
				//console.log(gdsMap);
				var api = this.api();
		       	rows = api.rows( {page:'current'} ).data();
		       	for(var i=0; i < rows.length; i++){
		       		gdsMap.set(rows[i].gdsNo, rows[i]);
		       	}
			}
		});
	}
	return {
		init: function(){
			dtCall();
			// 검색창 이벤트 추가
			$("#modalSrchGdsCd, #modalSrchGdsNm").on("keyup", function(e){
				if (e.keyCode == 13) {
					gdsSrchList.draw();
				}
			});
			$("#modalSrchGdsBtn").on("click", function(e){
				e.preventDefault();
				gdsSrchList.draw();
			});
			// 클릭 이벤트 추가
			$("#gdsDataTable th :checkbox").click(function(){
				let isChecked = $(this).is(":checked");
				$("#gdsDataTable td :checkbox").prop("checked",isChecked);
			});
			$(".f_modalSelGds").on("click", function(){
				let gdsNos = $("#gdsDataTable td :checkbox:checked").map(function(){return $(this).val();}).get();
				if(gdsNos==null||gdsNos.length==0) {
					alert("선택된 상품이 없습니다.");
				}else{
					f_modalGdsSearch_callback(gdsNos);
					$("#gdsDataTable td :checkbox, #gdsDataTable div :checkbox").prop("checked",false);
				}
			});
		}
	};
}();


$(function(){
	//상품 카테고리
	$("#modalSrchUpCtgryNo").on("change", function(){
		$("#modalSrchCtgryNo").empty();
		$("#modalSrchCtgryNo").append("<option value='0'>선택</option>");

		let modalSrchUpCtgryNoVal = $(this).val();
		if(modalSrchUpCtgryNoVal > 0){ //값이 있을경우만..
			$.ajax({
				type : "post",
				url  : "/_mng/gds/ctgry/getGdsCtgryListByFilter.json",
				data : {upCtgryNo:modalSrchUpCtgryNoVal},
				dataType : 'json'
			})
			.done(function(data) {
				for(key in data){
					$("#modalSrchCtgryNo").append("<option value='"+ key +"'>"+ data[key] +"</option>");
				}
			})
			.fail(function(data, status, err) {
				alert("카테고리 호출중 오류가 발생했습니다.");
				console.log('error forward : ' + data);
			});
		}
	}).trigger("change");

});
</script>