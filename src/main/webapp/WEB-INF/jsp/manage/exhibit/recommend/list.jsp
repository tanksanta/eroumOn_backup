<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<form action="./action" method="post" id="rcmdFrm" name="rcmdFrm">
	<fieldset>
		<p class="text-right mb-2">
			<button type="button" class="btn f_srchGds" data-bs-toggle="modal" data-bs-target="#gdsModal">상품검색</button>
		</p>
		<legend class="text-title2">추천상품 설정</legend>
		<table class="table-list" id="relGdsList">
			<colgroup>
				<col class="w-20">
				<col class="w-[13%]">
				<col class="w-[15%]">
				<col>
				<col class="w-30">
				<col class="w-35">
				<col class="w-25">
			</colgroup>
			<thead>
				<tr >
					<th scope="col">
						<div class="form-check">
							<!-- <input class="form-check-input" type="checkbox"> -->
						</div>
					</th>
					<th scope="col">상품코드</th>
					<th scope="col">상품명</th>
					<th scope="col">상품 카테고리</th>
					<th scope="col">전시 여부</th>
					<th scope="col">등록일</th>
					<th scope="col">노출 순서</th>
				</tr>
			</thead>
			<tbody id="bodyView">
				<c:forEach var="resultList" items="${rcmdList}" varStatus="status">
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
						<td class="text-left">${resultList.upCtgryNm } &nbsp;&gt;&nbsp;${resultList.ctgryNm }</td>
						<td>${dspyYnCode[resultList.useYn]}</td>
						<td><fmt:formatDate value="${resultList.regDt}" pattern="yyyy-MM-dd" /></td>
						<td class="draggable" style="cursor: pointer;">
							<button type="button" class="btn-warning tiny">
								<i class="fa fa-arrow-down-up-across-line"></i>
							</button>
						</td>
						</td>
					</tr>
				</c:forEach>
				<!--<c:if test="${empty rcmdList}"><td colspan="7" class="noresult">등록된 관련상품이 없습니다.</td></c:if>-->
			</tbody>
		</table>
	</fieldset>

	<div class="btn-group mt-8">
		<button type="submit" class="btn-primary large shadow w-52">저장</button>
	</div>
</form>

<c:import url="/_mng/gds/gds/modalGdsSearch" />

<script>


$(function(){
	// no result
	if($(".draggableTr").length == 0){
		var html = "";
		html += '<tr>';
		html += '<td colspan="7" class="noresult">등록된 관련상품이 없습니다.</td>'
		html += '</tr>'

			$("#bodyView").append(html);
	}

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
			$("#bodyView").append('<tr><td colspan="7" class="noresult">등록된 관련상품이 없습니다.</td></tr>');
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
		html += '<td>'+f_dateFormat(gdsJson.regDt)+'</td>';
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


