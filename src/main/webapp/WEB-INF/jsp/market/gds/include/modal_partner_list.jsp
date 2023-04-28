<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="tab-content" id="tabs-tabContent">
	<!-- 관심 멤버스 START-->
	<c:if test="${pageType eq 'itrst' }">
		<div class="tab-pane show active" id="itrst">
			<c:if test="${!empty itrstList}"><p class="text-alert">마이페이지에서 등록한 관심 멤버스입니다. 멤버스를 선택해 주세요. (최대 5개까지 제공)</p></c:if>
			<c:if test="${empty itrstList}"><div class="box-result">관심 멤버스로 등록한 멤버스가 없습니다.</div></c:if>

			<c:forEach var="resultList" items="${itrstList}" varStatus="status">
				<div class="product-partners" data-unique-id="${resultList.bplcInfo.uniqueId}">
					<c:if test="${resultList.bplcInfo.proflImg ne null}">
						<img src="/comm/PROFL/getFile?fileName=${resultList.bplcInfo.proflImg}" alt="">
					</c:if>
					<c:if test="${resultList.bplcInfo.proflImg eq null }">
						<img src="/html/page/market/assets/images/partners_default.png" alt="">
					</c:if>
					<dl>
						<dt>${resultList.bplcInfo.bplcNm}</dt>
						<dd class="info">
							<p class="addr">${resultList.bplcInfo.zip}&nbsp;${resultList.bplcInfo.addr}&nbsp;${resultList.bplcInfo.daddr}</p>
							<p class="call">
								<a href="tel:${resultList.bplcInfo.telno}">${resultList.bplcInfo.telno}</a>
							</p>
						</dd>
						<dd class="desc">
							<div class="time">
								<c:set var="hldys" value="${fn:split(fn:replace(resultList.bplcInfo.hldy,' ',''),',')}" />
							    <p>
							        <small>영업시간</small>
									<c:if test="${resultList.bplcInfo.bsnHrBgng ne null}">${resultList.bplcInfo.bsnHrBgng} ~ ${resultList.bplcInfo.bsnHrEnd}</c:if>
							    </p>
							    <p>
							        <small>휴무</small>
									<c:if test="${resultList.bplcInfo.hldy ne null}">
											<c:forEach var="day" items="${hldys}">
												<c:choose>
													<c:when test="${day ne 'Z'}">${bplcRstdeCode[day]}&nbsp;</c:when>
													<c:otherwise>${resultList.bplcInfo.hldyEtc }</c:otherwise>
												</c:choose>
											</c:forEach>
											&nbsp;
									</c:if>
							    </p>
							</div>
							<a href="/members/${resultList.bplcInfo.bplcId}/gds/list" class="btn btn-primary btn-small flex-none" target="_blank">홈페이지 방문</a>
						</dd>
					</dl>
					<label class="partners-select" > <input type="radio" name="itrstClick"> <span>선택</span>
					</label>
				</div>
			</c:forEach>
		</div>
	</c:if>
	<!-- 관심 멤버스 END-->

	<c:if test="${pageType eq 'recommend' }">
	<div class="tab-pane" id="recommend">

		<c:if test="${!empty listVO.listObject}"><p class="text-alert">이로움ON 마켓에서 추천한 멤버스입니다. 멤버스를 선택해 주세요.</p></c:if>
		<c:if test="${empty listVO.listObject}"><div class="box-result">추천 멤버스가 없습니다.</div></c:if>

		<c:forEach var="rcmmd" items="${listVO.listObject}" varStatus="status">
		<div class="product-partners" data-unique-id="${rcmmd.uniqueId}">
			<c:if test="${rcmmd.proflImg eq null}"><img src="/html/page/market/assets/images/partners_default.png" alt=""></c:if>
			<c:if test="${rcmmd.proflImg ne null}"><img src="/comm/PROFL/getFile?fileName=${rcmmd.proflImg}" alt=""></c:if>
					<dl>
						<dt>${rcmmd.bplcNm}</dt>
						<dd class="info">
							<p class="addr">${rcmmd.zip}&nbsp;${rcmmd.addr}&nbsp;${rcmmd.daddr}</p>
							<p class="call">
								<a href="tel:${rcmmd.telno}">${rcmmd.telno}</a>
							</p>
						</dd>

						<dd class="desc">
							<div class="time">
								<c:set var="hldys" value="${fn:split(fn:replace(rcmmd.hldy,' ',''),',')}" />
								<p>
									<small>영업시간</small>
									<c:if test="${rcmmd.bsnHrBgng ne null}">${rcmmd.bsnHrBgng} ~ ${rcmmd.bsnHrEnd}</c:if>
								</p>
								<p>
									<small>휴무</small>
									<c:if test="${rcmmd.hldy ne null}">
										<c:forEach var="day" items="${hldys}">
											<c:choose>
												<c:when test="${day ne 'Z'}">${bplcRstdeCode[day]}&nbsp;</c:when>
												<c:otherwise>${rcmmd.hldyEtc }</c:otherwise>
											</c:choose>
										</c:forEach>
											&nbsp;
									</c:if>
								</p>
							</div>
							<a href="/members/${rcmmd.bplcId}/gds/list" class="btn btn-primary btn-small flex-none" target="_blank">홈페이지 방문</a>
						</dd>
					</dl>

					<label class="partners-select">  <input type="radio" name="itrstClick"> <span>선택</span>
			</label>
		</div>
		</c:forEach>
			<div class="pagination">
				<front:jsPaging listVO="${listVO}" targetObject="recommend-pager" />
			</div>
		</div>
	</c:if>
	<!-- 추천 멤버스 END -->


	<!-- 최근 구매 START -->
	<c:if test="${pageType eq 'recent' }">
	<div class="tab-pane" id="recent">
		<c:if test="${!empty listVO.listObject}"><p class="text-alert">최근 구매한 멤버스 정보를 제공합니다. 멤버스를 선택해 주세요.</p></c:if>
		<c:if test="${empty listVO.listObject}"><div class="box-result">최근 구매한 멤버스가 없습니다.</div></c:if>

		<c:forEach var="recent" items="${listVO.listObject}" varStatus="status">
			<div class="product-partners" data-unique-id="${recent.bplcInfo.uniqueId}">
				<c:if test="${recent.bplcInfo.proflImg ne null }"><img src="/comm/PROFL/getFile?fileName=${recent.bplcInfo.proflImg}" alt=""></c:if>
				<c:if test="${recent.bplcInfo.proflImg eq null}"><img src="/html/page/market/assets/images/partners_default.png" alt=""></c:if>
					<dl>
						<dt>${recent.bplcInfo.bplcNm}</dt>
						<dd class="info">
							<p class="addr">${recent.bplcInfo.zip}&nbsp;${recent.bplcInfo.addr}&nbsp;${recent.bplcInfo.daddr}</p>
							<p class="call">
								<a href="tel:${recent.bplcInfo.telno}">${recent.bplcInfo.telno}</a>
							</p>
						</dd>
						<dd class="desc">
							<div class="time">
								<c:set var="hldys" value="${fn:split(fn:replace(recent.bplcInfo.hldy,' ',''),',')}" />
								<p>
								<small>영업시간</small>
								<c:if test="${recent.bplcInfo.bsnHrBgng ne null}">${recent.bplcInfo.bsnHrBgng} ~ ${recent.bplcInfo.bsnHrEnd}</c:if>
								</p>
								<p>
								<small>휴무</small>
									<c:if test="${recent.bplcInfo.hldy ne null}">
										<c:forEach var="day" items="${hldys}">
											<c:choose>
												<c:when test="${day ne 'Z'}">${bplcRstdeCode[day]}&nbsp;</c:when>
												<c:otherwise>${recent.bplcInfo.hldyEtc }</c:otherwise>
											</c:choose>
										</c:forEach>
											&nbsp;
									</c:if>
								</p>
							</div>
							<a href="/members/${recent.bplcInfo.bplcId}/gds/list" class="btn btn-primary btn-small flex-none" target="_blank">홈페이지 방문</a>
						</dd>
					</dl>
					<label class="partners-select">  <input type="radio" name="itrstClick"> <span>선택</span>
				</label>
			</div>
		</c:forEach>

		<div class="pagination">
			<front:jsPaging listVO="${listVO}" targetObject="recent-pager" />
		</div>
	</div>
	</c:if>
	<!-- 최근 구매 END -->

	<!-- 멤버스 찾기 START -->
	<c:if test="${pageType eq 'search' }">
		<div class="tab-pane" id="search">
			<fieldset class="layer-search">
				<select name="sido" id="sido" class="form-control">
					<option value="">시/도 선택</option>
					<c:forEach items="${stdgCdList}" var="stdg">
						<option value="${stdg.stdgCd}">${stdg.ctpvNm }</option>
					</c:forEach>
				</select> <select name="gugun" id="gugun" class="form-control">
					<option value="">시/군/구 선택</option>
				</select>
				<input type="text" id="srchText" name="srchText" class="form-control" placeholder="기본">
				<input type="text" id="srchs" name="srchs" class="form-control" style="display:none;">
				<button type="button" class="btn btn-primary" id="searchBplcs">검색</button>
			</fieldset>

			<div id="detailList">
				<c:forEach var="search" items="${listVO.listObject}">
					<div class="product-partners" data-unique-id="${search.uniqueId}">
						<c:if test="${!empty search.proflImg}"><img src="/comm/PROFL/getFile?fileName=${search.proflImg}"></c:if>
						<c:if test="${empty search.proflImg}"><img src="/html/page/market/assets/images/partners_default.png" alt=""></c:if>
						<dl>
							<dt>${search.bplcNm}</dt>
							<dd class="info">
								<p class="addr">${search.zip}&nbsp;${search.addr}&nbsp;${search.daddr}</p>
								<p class="call">
									<a href="tel:${search.telno}">${search.telno}</a>
								</p>
							</dd>
							<dd class="desc">
								<div class="time">
									<c:set var="hldys" value="${fn:split(fn:replace(search.hldy,' ',''),',')}" />
									<p><small>영업시간</small>
										<c:if test="${search.bsnHrBgng ne null}">${search.bsnHrBgng} ~ ${search.bsnHrEnd}</c:if>
									</p>
									<p>
										<small>휴무</small>
										<c:if test="${search.hldy ne null}">
											<c:forEach var="day" items="${hldys}">
												<c:choose>
													<c:when test="${day ne 'Z'}">${bplcRstdeCode[day]}&nbsp;</c:when>
													<c:otherwise>${search.hldyEtc }</c:otherwise>
												</c:choose>
											</c:forEach>
											&nbsp;
									</c:if>
									</p>
								</div>
								<a href="/members/${search.bplcId}/gds/list" class="btn btn-primary btn-small flex-none" target="_blank">홈페이지 방문</a>
							</dd>
						</dl>
						<label class="partners-select">  <input type="radio" name="itrstClick"> <span>선택</span>
						</label>
					</div>
				</c:forEach>
				<div class="pagination">
					<front:jsPaging listVO="${listVO}" targetObject="search-pager" />
				</div>
			</div>

		</div>
	</c:if>
	<!-- 멤버스 찾기 END -->

</div>
<script>

$(function(){

	var keys = "";
	var srcs = "";
	var partnerImg = "";
	var partnerName = "";
	var partnerAddrs = "";
	var partnerTel = "";

	//시/군/구 검색
	$("#sido").on("change", function(){
		$("#gugun").empty();
		$("#gugun").append("<option value=''>시/군/구</option>");
		if($("#sido").val() != ""){
			$.ajax({
				type : "post",
				url  : "/members/stdgCd/stdgCdList.json",
				data : {stdgCd:$("#sido").val()},
				dataType : 'json'
			})
			.done(function(data) {
				if(data.result){
						$.each(data.result, function(index, item){
							if(gugun == item.sggNm){
								$("#gugun").append("<option value='"+ item.sggNm +"' selected='selected'>"+ item.sggNm +"</option>");
							}else{
								$("#gugun").append("<option value='"+ item.sggNm +"'>"+ item.sggNm +"</option>");
							}

		                });
				}
			})
			.fail(function(data, status, err) {
				console.log('지역호출 error forward : ' + data);
			});
		}

	});
	// 멤버스 선택

	$(document).on("click",".product-partners", function(e){
		var uniqueKey = $(this).data("uniqueId");
		$(".product-partners").removeClass("is-active");


		if(!$(this).hasClass("is-active")){
			$(this).addClass("is-active");
			keys = uniqueKey;
			console.log("@@ : " + keys);
			srcs = $(this).children("img");
			partnerImg = srcs.attr("src");

			var nmDt = $(this).children("dl");
			var nmDl = nmDt.children("dt");
			partnerName = nmDl.text();

			var ad = nmDt.children("dd");
			var ads = ad.children(".addr");
			var tt = ads.text();
			partnerAddrs = tt.substr(5);

			var telInfo = ad.children(".call");
			var tels = telInfo.children("a");
			partnerTel = tels.text();
		}else{
			$(this).removeClass("is-active");
		}
	});

	// 멤버스 추가
	$(document).on("click", "#subPartners", function(e){
		$("#bplcUniqueId").val(keys);
		console.log("@@ : " + $("#bplcUniqueId").val());
		$(".btn-cancel").click();

		if(keys != ''){
			$(".noSelect").hide();
			$(".selectPart").show();
			$("#pImg").attr("src",partnerImg);
			$("#pName").text(partnerName);
			$(".pAddrs").text(partnerAddrs);
			$(".pTel").text(partnerTel);
			$(".pTel").attr("href","tel:" + partnerTel);
		}else{
			//$(".noSelect").show();
		}

		e.preventDefault();
	});

	// 페이징 클릭 이벤트
	$(document).on("click", ".recommend-pager a, .recent-pager a, .search-pager a", function(e){
		let pageNo = $(this).data("pageNo");
		var param = "${pageType}";
		f_gdsBplcList(param, pageNo);
		e.preventDefault();
	});

	// 검색 이벤트
	$(document).on("click", "#searchBplcs", function(e){
		var sido = $("#sido").val();
		var gugun = $("#gugun").val();
		var text = $("#srchText").val();
		var pageType = "${pageType}";

		var params = {
				sido : sido
				, gugun : gugun
				, text : text
				, pageType : pageType
		}

		f_DtlList(params);
		e.preventDefault();
	});

	// 엔터키
	$("#srchText").on("keyup",function(e){
		if(e.code == "Enter"){
			$("#searchBplcs").click();
		}
	});

})	;
</script>