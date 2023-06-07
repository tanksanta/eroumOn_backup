<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<form:form name="frmMbr" id="frmMbr" modelAttribute="mbrVO" method="post" action="./action" enctype="multipart/form-data">
<!-- enctype="multipart/form-data" -->
	<!-- 검색조건 -->
	<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
	<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
	<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
	<input type="hidden" id="mbrIdCheck" name="mbrIdCheck" value="N"	/>

	<form:hidden path="crud" />
	<form:hidden path="uniqueId" />

	<fieldset>
		<legend class="text-title2 relative">
			${mbrVO.crud eq 'CREATE'?'등록':'수정' }<span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm"> (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)</span>
		</legend>
            <div id="page-content">
                <div class="text-right mt-6">
                    <button type="button" class="btn shadow">임시비밀번호 발송</button>
                </div>

                <form action="#" class="mt-2">
                    <fieldset>
                        <legend class="text-title2">기본정보</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">회원분류</th>
                                    <td>
									<div class="form-check-group">
										<c:forEach var="recipter" items="${recipterYn}" varStatus="status">
											<div class="form-check">
												<form:radiobutton value="${recipter.key}" path="recipterYn" id="recipterYn${status.index}" class="form-check-input" />
												<label class="form-check-label" for="recipterYn${status.index}">${recipter.value}</label>
											</div>
										</c:forEach>
									</div>
								</td>
                                </tr>
                                <tr>
                                    <th scope="row">아이디</th>
									<td>
									<form:input path="mbrId" class="form-control w-90" value="${mbrVO.mbrId}" maxlength="40" />
									<button type="button" class="btn-primary w-20" id="idCheck">중복체크</button>
									<br />! 영문으로 띄어쓰기 없이 6~15자 영문,숫자를 조합하여 입력해주세요.
									</td>
									<th>비밀번호</th>
                                  	<td><form:password path="pswd" class="form-control w-90" value="${mbrVO.pswd }" maxlength="40" /></td>
                                </tr>
                                <tr>
                                	 <th scope="row">휴대폰 번호</th>
                                     <td>본인인증 데이터</td>
                                     <th>비밀번호 확인</th>
                                     <td><input type="password" class="form-control w-90" maxlength="40" ></td>
                                </tr>
                                <tr>
                                    <th scope="row">이름</th>
                                    <td><form:input path="mbrNm" class="form-control w-90" value="${mbrVO.mbrNm}" maxlength="20" /></td>
                                    <th scope="row">생년월일</th>
                                    <td>본인인증 데이터</td>
                                </tr>
                                <tr>
                                	<th>성별</th>
                                	<td>
                                		<!-- <div class="form-check-group">
	                                		<c:forEach var="gender" items="${gender}" varStatus="status">
	                                			<div class="form-check">
	                                				<form:radiobutton path="gender" id="gender${status.index}" class="form-check-input" value="${gender.key }"/>
	                                				<label class="form-check-label" for="gender${status.index}">${gender.value}</label>
	                                			</div>
	                                		</c:forEach>
                                		</div> -->
                                		본인인증 데이터
                                	</td>
									<th>기본 결제 유형</th>
									<td>
										<form:select path="bassStlmTy" class="form-control w-90">
											<form:option value="" label="선택" />
												<c:forEach items="${bassStlmTy}" var="bass" varStatus="status">
													<form:option value="${bass.key}" id="bassStlmTy${status.index}">${bass.value}</form:option>
												</c:forEach>
										</form:select>
									</td>
								</tr>
								<tr>
									<th scope="row">회원 주소</th>
									<td>
										<div class="form-group">
											<form:input path="zip" class="form-control w-50" />
											<button type="button" class="btn-primary w-30" onclick="f_findAdres('zip', 'addr', 'daddr'); return false;">우편번호 검색</button>
										</div> <form:input class="form-control w-full mt-1" path="addr" /> <form:input class="form-control w-full mt-1" path="daddr" maxlength="40" />
									</td>
								</tr>
								<tr>
									<th scope="row">이메일</th>
									<td colspan="3">본인인증데이터</td>
								</tr>
								<tr>
									<th>포인트 누계</th>
									<td><form:input path="pointAcmtl" value="${mbrVO.pointAcmtl}" class="form-control w-90" /></td>
									<th>마일리지 누계</th>
									<td><form:input path="mlgAcmtl" value="${mbrVO.mlgAcmtl}" class="form-control w-90" /></td>
								</tr>
								<tr>
									<th>가입 경로</th>
									<td>
										<div class="form-check-group">
											<c:forEach var="cours" items="${joinCours}" varStatus="status">
												<div class="form-check">
													<form:radiobutton path="joinCours" id="cours${status.index}" class="form-check-input" value="${cours.key }"/>
													<label class="form-check-label" for="cours${status.index}">${cours.value}</label>
												</div>
											</c:forEach>
										</div>
									</td>
									<th>임시 비밀번호 여부</th>
									<td>
										<div class="form-check-group">
											<c:forEach var="sttus" items="${useYn}" varStatus="status">
												<div class="form-check">
													<form:radiobutton path="tmprPswdYn" class="form-check-input" id="tmprPswdYn${status.index}" value="${sttus.key}" />
													<label class="form-check-label" for="tmprPswdYn${status.index}">${sttus.value}</label>
												</div>
											</c:forEach>
										</div>
									</td>
								</tr>
								<tr>
									<th>회원 상태</th>
									<td>
										<form:select path="mberSttus" class="form-control w-90">
											<form:option value="" label="선택" />
												<c:forEach items="${mberSttus}" var="mbrsttus" varStatus="status">
													<form:option value="${mbrsttus.key}" label="mberSttus${status.index}" >${mbrsttus.value }</form:option>
												</c:forEach>
										</form:select>
									</td>
								</tr>
							<tr>
								<th scope="row"><label for="mngrNm">프로필 이미지</label></th>
								<td>
									<c:if test="${!empty mbrVO.proflImg}">
										<div class="form-group" style="display: flex;">
											<img src="/comm/proflImg?fileName=${mbrVO.proflImg}" id="profile" style="width: 55px; height: 55px; border-radius: 25%;">
											<button type="button" class="delProfileImgBtn">
												<i class="fa fa-trash"></i>
											</button>
										</div>
									</c:if>
									<input type="file" id="profileImg" name="profileImg" class="form-control w-90" />
									<input type="hidden" id="delProfileImg" name="delProfileImg" value="N" /></td>
							</tr>


						</tbody>
                        </table>
                    </fieldset>

                    <fieldset class="mt-13">
                        <legend class="text-title2">수급자정보</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">수급자여부</th>
                                    <td colspan="3">장기요양등급수급자 (수정예정)</td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>

                    <fieldset class="mt-13">
                        <legend class="text-title2">선택정보</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">전화번호</th>
                                    <td><form:input path="telno" class="form-control w-90" value="${mbrVO.telno }" maxlength="15" placeholder="000-0000-0000" /></td>
                                    <th scope="row">추천인 ID</th>
                                    <td><form:input path="rcmdtnId" value="${mbrVO.rcmdtnId}" class="form-control w-90" /></td>
                                </tr>
                                <tr>
                                    <th scope="row">정보수신</th>
                                    <td colspan="3">
                                        <div class="flex flex-wrap -mx-2">
                                            <div class="form-group px-2 my-1 mr-auto">
                                                <label for="member-item2-1" class="pr-1">SMS 수신</label>
												<div class="form-check-group">
													<c:forEach var="sttus" items="${useYn}" varStatus="status">
														<div class="form-check">
															<form:radiobutton path="smsRcptnYn" class="form-check-input" id="smsRcptnYn${status.index}" value="${sttus.key}" />
															<label class="form-check-label" for="smsRcptnYn${status.index}">${sttus.value}</label>
														</div>
													</c:forEach>
												</div>
										</div>
                                            <div class="form-group px-2 my-1 mr-auto">
                                                <label for="member-item2-2" class="pr-1">이메일 수신</label>
                               					<div class="form-check-group">
													<c:forEach var="sttus" items="${useYn}" varStatus="status">
														<div class="form-check">
															<form:radiobutton path="emlRcptnYn" class="form-check-input" id="emlRcptnYn${status.index}" value="${sttus.key}" />
															<label class="form-check-label" for="emlRcptnYn${status.index}">${sttus.value}</label>
														</div>
													</c:forEach>
												</div>
                                            </div>
                                            <div class="form-group px-2 my-1">
                                                <label for="member-item2-4" class="pr-1">DM(전화)</label>
												<div class="form-check-group">
													<c:forEach var="sttus" items="${useYn}" varStatus="status">
														<div class="form-check">
															<form:radiobutton path="telRecptnYn" class="form-check-input" id="telRecptnYn${status.index}" value="${sttus.key}" />
															<label class="form-check-label" for="telRecptnYn${status.index}">${sttus.value}</label>
														</div>
													</c:forEach>
												</div>
										</div>
                                        </div>
                                    </td>
                                </tr>
							<!-- <tr>
								<th scope="row"><label for="form-item7">사진등록</label></th>
								<td><c:forEach var="fileList" items="${mbrVO.fileList }" varStatus="status">
										<div id="attachFileViewDiv${fileList.fileNo}" class="form-control w-full">
											<a href="/comm/getFile?srvcId=${fileList.srvcId }&amp;upNo=${fileList.upNo }&amp;fileTy=${fileList.fileTy }&amp;fileNo=${fileList.fileNo }">${fileList.orgnlFileNm} (다운로드 : ${fileList.dwnldCnt}회)</a>&nbsp;&nbsp; <a href="#delFile" class="btn-secondary" onclick="delFile('${fileList.fileNo}', 'ATTACH', '${status.index}'); return false;"> 삭제</a>
										</div>
									</c:forEach>

									<div id="attachFileDiv">
										<c:forEach begin="0" end="0" varStatus="status">

											<div class="row" id="attachFileInputDiv${status.index}" <c:if test="${status.index < fn:length(mbrVO.fileList) }">style="display:none;"</c:if>>
												<div class="col-12">
													<div class="custom-file" id="uptAttach">
														<input type="file" class="form-control w-full" id="attachFile${status.index}" name="attachFile${status.index}" onchange="fileCheck(this);" />
													</div>
												</div>
											</div>
										</c:forEach>
									</div>
									</td>
							</tr> -->
							</tr>
                            </tbody>
                        </table>
                    </fieldset>

                    <fieldset class="mt-13">
                        <legend class="text-title2">관리정보</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row" rowspan="5">관리대상</th>
                                    <td>
                                        <div class="form-group w-full">
                                            <button type="button" class="btn shadow" data-bs-toggle="offcanvas" data-bs-target="#offcanvas1">경고관리</button>
                                            <p class="flex-1 mx-2">30일이내 사용후 반품고객</p>
                                            <button type="button" class="btn shadow ml-auto" data-bs-toggle="modal" data-bs-target="#modal1">변경내역보기</button>
                                        </div>
                                    </td>
                                    <th scope="row">최종변경일/처리자</th>
                                    <td>2022.07.22 14:22:14 / digh8201</td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="form-group w-full">
                                            <button type="button" class="btn shadow" data-bs-toggle="offcanvas" data-bs-target="#offcanvas2">블랙리스트관리</button>
                                            <p class="flex-1 mx-2">
                                                일시정지 (2015-10-10~2015-12-31)<br>
                                                사유 : 상습반품고객
                                            </p>
                                        </div>
                                    </td>
                                    <th scope="row">최종변경일/처리자</th>
                                    <td>2022.07.22 14:22:14 / digh8201</td>
                                </tr>
                                <tr>
                                    <td>
                                        <div class="form-group w-full">
                                            <button type="button" class="btn" data-bs-toggle="offcanvas" data-bs-target="#offcanvas3">직권탈퇴관리</button>
                                            <p class="flex-1 mx-2">
                                                직권탈퇴<br>
                                                사유 : 영리 목적의 홍보 반복
                                            </p>
                                        </div>
                                    </td>
                                    <th scope="row">최종변경일/처리자</th>
                                    <td>2022.07.22 14:22:14 / digh8201</td>
                                </tr>
                                <tr>
                                    <td colspan="3">
                                        <div class="form-group">
                                            <label for="member-item4" class="mr-1">이벤트 당첨자 제외</label>
                                            <div class="form-check-group">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="zzz" id="member-item4" checked>
                                                    <label class="form-check-label" for="member-item4">Y</label>
                                                </div>
                                                <div class="form-check">
                                                    <input class="form-check-input" type="radio" name="zzz" id="member-item4-2">
                                                    <label class="form-check-label" for="member-item4-2">N</label>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>

                    <fieldset class="mt-13">
                        <legend class="text-title2">탈퇴정보</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row">회원탈퇴사유</th>
                                    <td>-</td>
                                    <th scope="row">탈퇴일</th>
                                    <td>-</td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>


				<div class="btn-group right mt-8">
					<button type="submit" class="btn-primary large shadow">저장</button>

					<c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage}&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}" />
					<a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
				</div>
                </form>

                <!-- 경고관리 -->
                <div class="offcanvas offcanvas-end w-95" tabindex="-1" id="offcanvas1">
                    <div class="offcanvas-header">
                        <p>경고관리</p>
                    </div>
                    <div class="offcanvas-body">
                        <form action="#">
                            <fieldset>
                                <label for="modal-item1-1" class="block font-bold mb-2">구분</label>
                                <div class="form-check-group w-full">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="m1" id="modal-item1-1" checked>
                                        <label class="form-check-label" for="modal-item1-1">1차경고</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="m1" id="modal-item1-1-2">
                                        <label class="form-check-label" for="modal-item1-1-2">2차경고</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="m1" id="modal-item1-1-3">
                                        <label class="form-check-label" for="modal-item1-1-3">3차경고</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="m1" id="modal-item1-1-4">
                                        <label class="form-check-label" for="modal-item1-1-4">해제</label>
                                    </div>
                                </div>

                                <label for="modal-item1-2" class="block font-bold mt-5 mb-2">사유선택</label>
                                <select name="" id="modal-item1-2" class="form-control w-full">
                                    <option value="">선택하세요</option>
                                </select>

                                <label for="modal-item1-3" class="block font-bold mt-5 mb-2">관리자 메모</label>
                                <textarea name="" id="modal-item1-3" cols="30" rows="7" class="form-control w-full"></textarea>

                                <div class="flex mt-6">
                                    <button type="submit" class="btn-primary large shadow flex-1 mr-2">저장</button>
                                    <button type="button" class="btn-secondary large shadow w-20">취소</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                    <button type="button" data-bs-dismiss="offcanvas" class="offcanvas-close">닫기</button>
                </div>
                <!-- //경고관리 -->

                <!-- 블랙리스트 관리 -->
                <div class="offcanvas offcanvas-end w-95" tabindex="-1" id="offcanvas2">
                    <div class="offcanvas-header">
                        <p>블랙리스트관리</p>
                    </div>
                    <div class="offcanvas-body">
                        <form action="#">
                            <fieldset>
                                <label for="modal-item2-1" class="block font-bold mb-2">구분</label>
                                <div class="form-check-group w-full whitespace-nowrap">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="m2" id="modal-item2-1" checked>
                                        <label class="form-check-label" for="modal-item2-1">일시정지</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="m2" id="modal-item2-1-2">
                                        <label class="form-check-label" for="modal-item2-1-2">영구정지</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="m2" id="modal-item2-1-3">
                                        <label class="form-check-label" for="modal-item2-1-3">해제</label>
                                    </div>
                                </div>

                                <label for="modal-item2-3" class="block font-bold mt-5 mb-2">정지기간</label>
                                <div class="form-group">
                                    <input type="text" class="form-control flex-1 calendar" id="modal-item2-3">
                                    <i>~</i>
                                    <input type="text" class="form-control flex-1 calendar">
                                </div>

                                <label for="modal-item2-4" class="block font-bold mt-5 mb-2">사유선택</label>
                                <select name="" id="modal-item2-4" class="form-control w-full">
                                    <option value="">선택하세요</option>
                                </select>

                                <label for="modal-item2-5" class="block font-bold mt-5 mb-2">관리자 메모</label>
                                <textarea name="" id="modal-item2-5" cols="30" rows="7" class="form-control w-full"></textarea>

                                <div class="flex mt-6">
                                    <button type="submit" class="btn-primary large shadow flex-1 mr-2">저장</button>
                                    <button type="button" class="btn-secondary large shadow w-20">취소</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                    <button type="button" data-bs-dismiss="offcanvas" class="offcanvas-close">닫기</button>
                </div>
                <!-- //블랙리스트 관리 -->

                <!-- 직권탈퇴 -->
                <div class="offcanvas offcanvas-end w-95" tabindex="-1" id="offcanvas3">
                    <div class="offcanvas-header">
                        <p>직권탈퇴 관리</p>
                    </div>
                    <div class="offcanvas-body">
                        <form action="#">
                            <fieldset>
                                <label for="modal-item3-1" class="block font-bold mt-5 mb-2">사유선택</label>
                                <select name="" id="modal-item3-1" class="form-control w-full">
                                    <option value="">선택하세요</option>
                                </select>

                                <label for="modal-item3-2" class="block font-bold mt-5 mb-2">사유입력</label>
                                <textarea name="" id="modal-item3-2" cols="30" rows="5" class="form-control w-full"></textarea>

                                <div class="flex mt-6">
                                    <button type="submit" class="btn-primary large shadow flex-1 mr-2">저장</button>
                                    <button type="button" class="btn-secondary large shadow w-20">취소</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                    <button type="button" data-bs-dismiss="offcanvas" class="offcanvas-close">닫기</button>
                </div>
                <!-- //직권탈퇴 -->

                <!-- 경고관리 내역 -->
                <div class="modal fade" id="modal1" tabindex="-1">
                    <div class="modal-dialog modal-lg modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <p>변경 내역</p>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                            </div>
                            <div class="modal-body">
                                <ul class="nav tab-list">
                                    <li>
                                        <a href="#modal-pane1" class="active" data-bs-toggle="pill" data-bs-target="#modal-pane1" role="tab" aria-selected="true">경고내역</a>
                                    </li>
                                    <li>
                                        <a href="#modal-pane2" data-bs-toggle="pill" data-bs-target="#modal-pane2" role="tab" aria-selected="false">정지/해제 내역</a>
                                    </li>
                                </ul>
                                <div class="tab-content mt-5">
                                    <div class="tab-pane fade show active" id="modal-pane1" role="tabpanel">
                                        <table class="table-list">
                                            <colgroup>
                                                <col class="w-16">
                                                <col class="w-22">
                                                <col class="w-[25%]">
                                                <col>
                                                <col class="w-31">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">번호</th>
                                                    <th scope="col">구분</th>
                                                    <th scope="col">사유</th>
                                                    <th scope="col">관리자메모</th>
                                                    <th scope="col">변경일/처리자명</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>123</td>
                                                    <td>3차경고</td>
                                                    <td>무리한손해배상요청고객</td>
                                                    <td>손배진행</td>
                                                    <td>
                                                        2014-02-02<br>
                                                        14:00:02<br>
                                                        admin1
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="tab-pane fade" id="modal-pane2" role="tabpanel">
                                        <table class="table-list">
                                            <colgroup>
                                                <col class="w-16">
                                                <col class="w-22">
                                                <col class="w-[18%]">
                                                <col>
                                                <col class="w-28">
                                                <col class="w-31">
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th scope="col">번호</th>
                                                    <th scope="col">구분</th>
                                                    <th scope="col">사유</th>
                                                    <th scope="col">관리자메모</th>
                                                    <th scope="col">정지기간</th>
                                                    <th scope="col">변경일/처리자명</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>123</td>
                                                    <td>영구</td>
                                                    <td>무리한손해배상요청고객</td>
                                                    <td>손배진행</td>
                                                    <td>
                                                        2015-10-10 ~<br>
                                                        2015-12-31
                                                    </td>
                                                    <td>
                                                        2014-02-02<br>
                                                        14:00:02<br>
                                                        admin1
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //경고관리 내역 -->
            </div>
	</fieldset>

</form:form>

<script>
const f_checkId = function() {
	let REG = /^([a-z0-9]){6,15}$/;
	if(!REG.test($("#mbrId").val())) {
		alert("아이디는 6-15자 이내의 영문소문자와 숫자로 구성되어야 합니다.");
		$("#mbrId").focus();
		return false;
	}
	return true;
}

	$(function() {

		$("#idCheck").on("click",function(){
			$.ajax({
				type : "post",
				url  : "mbrIdCheck.json",
				data : {mbrId:$("#mbrId").val()},
				dataType : 'json'
			})
			.done(function(data) {
				console.log(data.isUsed);
				if(data.isUsed===true){// 이미 사용중인 아이디
					$("#mbrIdCheck").val("N");
					alert("입력하신 아이디는 사용 중입니다.\n다른 아이디를 선택하세요.");
					$("#mbrId").focus();
				}else{
					$("#mbrIdCheck").val("Y");
					alert("사용할 수 있는 아이디입니다.");
				}
			})
			.fail(function(data, status, err) {
				alert("아이디 사용 가능 여부 확인 중 오류가 발생했습니다.");
				console.log('error forward : ' + data);
			});
		});
	});
</script>