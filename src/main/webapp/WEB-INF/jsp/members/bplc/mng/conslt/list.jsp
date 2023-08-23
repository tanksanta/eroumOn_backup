<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<jsp:include page="../layout/page_header.jsp">
				<jsp:param value="1:1상담(인정등급테스트)" name="pageTitle"/>
			</jsp:include>

			<!-- page content -->
            <div id="page-content">
                <p class="mb-7">인정등급테스트 후 1:1상담 신청한 내역을 확인하는 페이지입니다.</p>

                <form id="searchFrm" name="searchFrm" method="get" action="./list">
				<input type="hidden" name="cntPerPage" id="cntPerPage" value="${listVO.cntPerPage}" />
                    <fieldset>
                        <legend class="text-title2">1:1상담 검색</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="search-item1">상담신청일</label></th>
                                    <td>
                                        <div class="form-group">
                                            <input type="date" class="form-control w-39 calendar" id="srchRegBgng" name="srchRegBgng" value="${param.srchRegBgng}">
											<i>~</i>
											<input type="date" class="form-control w-39 calendar" id="srchRegEnd" name="srchRegEnd" value="${param.srchRegEnd}">&nbsp;
											<button type="button" class="btn shadow" onclick="f_srchDtSet('1'); return false;">오늘</button>
											<button type="button" class="btn shadow" onclick="f_srchDtSet('2'); return false;">7일</button>
											<button type="button" class="btn shadow" onclick="f_srchDtSet('3'); return false;">15일</button>
											<button type="button" class="btn shadow" onclick="f_srchDtSet('4'); return false;">1개월</button>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
									<th scope="row"><label for="srchMbrNm">성명</label></th>
									<td><input type="text" class="form-control w-100" id="srchMbrNm" name="srchMbrNm" value="${param.srchMbrNm}" maxlength="30"></td>
								</tr>
								<tr>
									<th scope="row"><label for="srchMbrTelno">연락처</label></th>
									<td><input type="text" class="form-control w-100" id="srchMbrTelno" name="srchMbrTelno" value="${param.srchMbrTelno}" maxlenth="15" /></td>
								</tr>
								<tr>
			                        <th scope="row"><label for="srchConsltSttus">상담 진행 상태</label></th>
			                        <td>
			                            <select name="srchConsltSttus" id="srchConsltSttus" class="form-control w-84">
			                                <option value="">선택</option>
			                                <option value="CS02" ${param.srchConsltSttus eq 'CS02'?'selected="selected"':''}>상담 신청 접수</option>
			                                <option value="CS05" ${param.srchConsltSttus eq 'CS05'?'selected="selected"':''}>상담 진행 중</option>
			                                <option value="CS04" ${param.srchConsltSttus eq 'CS04'?'selected="selected"':''}>상담 취소</option>
			                                <option value="CS06" ${param.srchConsltSttus eq 'CS06'?'selected="selected"':''}>상담 완료</option>
			                            </select>
			                        </td>
			                    </tr>
                            </tbody>
                        </table>
                    </fieldset>

                    <div class="btn-group mt-5">
                        <button type="submit" class="btn-primary large shadow w-52">검색</button>
                    </div>
                </form>

                <div class="mt-13 flex items-end gap-1.5">
                    <p class="text-title2 mr-auto">1:1상담 목록</p>
                    <button type="button" class="btn-primary mb-3 btn-excel">엑셀 다운로드</button>
                </div>
                <div class="scroll-table">
                    <table class="table-list">
                        <colgroup>
                            <col class="min-w-18 w-22">
                            <col class="min-w-35 w-[15%]">
                            <col class="min-w-22 w-28">
                            <col class="min-w-18 w-18">
                            <col class="min-w-25 w-30">
                            <col class="min-w-15 w-20">
                            <col class="min-w-22 w-28">
                            <col>
                            <col class="min-w-22 w-28">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">상담진행상태</th>
                                <th scope="col">성명</th>
                                <th scope="col">성별</th>
                                <th scope="col">연락처</th>
                                <th scope="col">만나이</th>
                                <th scope="col">생년월일</th>
                                <th scope="col">거주지주소</th>
                                <th scope="col">상담신청일</th>
                            </tr>
                        </thead>
                        <tbody>
						<c:forEach var="resultList" items="${listVO.listObject}" varStatus="status">
						<c:set var="pageParam" value="bplcConsltNo=${resultList.bplcConsltNo}&amp;consltNo=${resultList.consltNo}&amp;curPage=${listVO.curPage}&amp;cntPerPage=${param.cntPerPage}&amp;srchRegBgng=${param.srchRegBgng}&amp;srchRegEnd=${param.srchRegEnd}&amp;srchMbrNm=${param.srchMbrNm}&amp;srchMbrTelno=${param.srchMbrTelno}&amp;srchConsltSttus=${param.srchConsltSttus}" />
							<tr>
								<td>${listVO.startNo - status.index }</td>
								<td>
									<c:choose>
										<c:when test="${resultList.consltSttus eq 'CS01'}"><span class="text-red1">상담 신청 접수</span></c:when>
										<c:when test="${resultList.consltSttus eq 'CS02'}"><span class="text-red1">상담 신청 접수</span></c:when>
										<c:when test="${resultList.consltSttus eq 'CS03'}">상담 취소</c:when>
										<c:when test="${resultList.consltSttus eq 'CS04'}">상담 취소</c:when>
										<c:when test="${resultList.consltSttus eq 'CS09'}">상담 취소</c:when>
										<c:when test="${resultList.consltSttus eq 'CS05'}">상담 진행 중</c:when>
										<c:when test="${resultList.consltSttus eq 'CS06'}">상담 완료</c:when>
										<c:when test="${resultList.consltSttus eq 'CS07'}"><span class="text-red1">상담 신청 접수</span></c:when>
										<c:when test="${resultList.consltSttus eq 'CS08'}"><span class="text-red1">상담 신청 접수</span></c:when>
									</c:choose>

								</td>
								<td><a href="./view?${pageParam}" class="btn shadow w-full">${resultList.mbrConsltInfo.mbrNm}</a></td>
								<td>${genderCode[resultList.mbrConsltInfo.gender]}</td>
								<td>${resultList.mbrConsltInfo.mbrTelno}</td>
								<td>만 ${resultList.mbrConsltInfo.age} 세</td>
								<td>${fn:substring(resultList.mbrConsltInfo.brdt,0,4)}/${fn:substring(resultList.mbrConsltInfo.brdt,4,6)}/${fn:substring(resultList.mbrConsltInfo.brdt,6,8)}</td>
								<td>(${resultList.mbrConsltInfo.zip})&nbsp;${resultList.mbrConsltInfo.addr}<br>${resultList.mbrConsltInfo.daddr}</td>
								<td><fmt:formatDate value="${resultList.mbrConsltInfo.regDt }" pattern="yyyy-MM-dd" /></td>
							</tr>
						</c:forEach>
						<c:if test="${empty listVO.listObject}">
							<tr>
								<td class="noresult" colspan="9">검색조건을 만족하는 결과가 없습니다.</td>
							</tr>
						</c:if>
						</tbody>
                    </table>
                </div>

                <div class="pagination mt-7">
                    <front:paging listVO="${listVO}"/>

                    <div class="sorting2">
                        <label for="countPerPage">출력</label>
                        <select name="countPerPage" id="countPerPage" class="form-control">
                            <option value="10" ${listVO.cntPerPage eq '10' ? 'selected' : '' }>10개</option>
							<option value="20" ${listVO.cntPerPage eq '20' ? 'selected' : '' }>20개</option>
							<option value="30" ${listVO.cntPerPage eq '30' ? 'selected' : '' }>30개</option>
                        </select>
                    </div>

                    <div class="counter">총 <strong>${listVO.totalCount}</strong>건, <strong>${listVO.curPage}</strong>/${listVO.totalPage} 페이지</div>
                </div>
            </div>
            <!-- //page content -->

            <script>
            function f_srchDtSet(ty){
            	$("#srchRegEnd").val(f_getToday());
            	if(ty == "1"){//오늘
               		$("#srchRegBgng").val(f_getToday());
            	}else if(ty == "2"){//일주일
            		$("#srchRegBgng").val(f_getDate(-7));
            	}else if(ty == "3"){//15일
            		$("#srchRegBgng").val(f_getDate(-15));
            	}else if(ty == "4"){//한달
            		$("#srchRegBgng").val(f_getDate(-30));
            	}
            }

            $(function(){

            	$(".btn-excel").on("click", function(){
            		$("#searchFrm").attr("action","excel").submit();
            		$("#searchFrm").attr("action","list");
            	});

            	// 출력 갯수
                $("#countPerPage").on("change", function(){
					var cntperpage = $("#countPerPage option:selected").val();
					$("#cntPerPage").val(cntperpage);
					$("#searchFrm").submit();
				});


            });
            </script>