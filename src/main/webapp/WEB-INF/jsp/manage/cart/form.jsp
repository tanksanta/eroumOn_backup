<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


				<form:form name="frmCart" id="frmCart" modelAttribute="cartVO" method="post" action="./action" enctype="multipart/form-data">
					<!-- 검색조건 -->
					<input type="hidden" name="srchTarget" id="srchTarget" value="${param.srchTarget}" />
					<input type="hidden" name="srchText" id="srchText" value="${param.srchText}" />
					<input type="hidden" name="srchUseAt" id="srchUseAt" value="${param.srchUseAt }" />
					<input type="hidden" name="cntPerPage" id="cntPerPage" value="${param.cntPerPage}" />
					<input type="hidden" name="curPage" id="curPage" value="${param.curPage}" />
					
					<form:hidden path="crud" />
					<!--TO-DO : PK정의 -->
					<form:hidden path="no" />
					
                    <fieldset>
                        <legend class="text-title2 relative">
                        
							$cartVO.crud eq 'CREATE'?'등록':'수정' }

                            <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
                                (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
                            </span>
                        </legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
													<tr>
								<th scope="row"><label for="cartNo" class="require">CART_NO</th>
								<td><form:input path="cartNo" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="gdsNo" class="require">GDS_NO</th>
								<td><form:input path="gdsNo" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="gdsCd" class="require">GDS_CD</th>
								<td><form:input path="gdsCd" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="bnefCd" class="require">BNEF_CD</th>
								<td><form:input path="bnefCd" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="gdsNm" class="require">GDS_NM</th>
								<td><form:input path="gdsNm" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="ordrPc" class="require">ORDR_PC</th>
								<td><form:input path="ordrPc" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="ordrOptn" class="require">ORDR_OPTN</th>
								<td><form:input path="ordrOptn" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="ordrOptnPc" class="require">ORDR_OPTN_PC</th>
								<td><form:input path="ordrOptnPc" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="ordrQy" class="require">ORDR_QY</th>
								<td><form:input path="ordrQy" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="regUniqueId" class="require">REG_UNIQUE_ID</th>
								<td><form:input path="regUniqueId" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="regDt" class="require">REG_DT</th>
								<td><form:input path="regDt" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="regId" class="require">REG_ID</th>
								<td><form:input path="regId" class="form-control w-full" /></td>
							</tr>	
													<tr>
								<th scope="row"><label for="rgtr" class="require">RGTR</th>
								<td><form:input path="rgtr" class="form-control w-full" /></td>
							</tr>	
						                            </tbody>
                        </table>
                    </fieldset>

                    <div class="btn-group right mt-8">
                        <button type="submit" class="btn-primary large shadow">저장</button>
                        
                        <c:set var="pageParam" value="curPage=${param.curPage }&amp;cntPerPage=${param.cntPerPage}&amp;srchTarget=${param.srchTarget}&amp;srchText=${param.srchText}" />
                        <a href="./list?${pageParam}" class="btn-secondary large shadow">목록</a>
                    </div>
                </form:form>

                <script>
                $(function(){
                
                });
                </script>