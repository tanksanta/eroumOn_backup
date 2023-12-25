<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
                        
                        <div class="radio-tabs-wrap" data-name="userType">
                            <div class="radio-tabs-button">
                                <label for="tab1" class="form-check-radio is-active">
                                    <input type="radio" name="userType" value="tab1" id="tab1" class="form-check-input" checked/>
                                    <span>가족</span>
                                </label>
                                <label for="tab2" class="form-check-radio">
                                    <input type="radio" name="userType" value="tab2" id="tab2" class="form-check-input"/>
                                    <span>본인</span>
                                </label>
                            </div>
                            <div class="radio-tabs-content">
                                <div class="tab tab1">
                                    <ul class="tab-inner">
                                        <li>
                                            <div class="text-index1">수급자(어르신)</div>
                                            <div>
                                                <input type="text" name="no-rcpt-nm" id="no-rcpt-nm" placeholder="홍길동" class="form-control w-48" maxlength="10" oninput="checkAddRecipientBtnDisable();">
                                                <span>님 은</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-index1"><span>${_mbrSession.mbrNm} </span>님의</div>
                                            <div> 
                                                <select name="no-rcpt-relation" id="no-rcpt-relation" class="form-control w-48" required onchange="checkAddRecipientBtnDisable();">
                                                    <option value="" disabled selected hidden>관계선택</option>
                                                    <c:forEach var="relation" items="${relationCd}" varStatus="status">
                                                    	<%-- 본인은 제외 --%>
                                                    	<c:if test="${relation.key ne '007'}">
                                                    		<option value="${relation.key}">${relation.value}</option>
                                                    	</c:if>
													</c:forEach>
                                                </select>
                                                <span>입니다</span>
                                            </div>
                                        </li>
                                        <li id="regist-rcpt-lno">
                                            <div class="text-index1">요양인정번호는</div>
                                            <div> 
                                                <label for="rcpt-lno" class="rcpt-lno">
                                                    <input type="text" id="no-rcpt-tab1-lno" placeholder="뒤의 숫자 10자리 입력" class="form-control w-48 keycontrol numberonly" maxlength="10" oninput="checkAddRecipientBtnDisable();">
                                                </label>
                                                <span>입니다</span>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="tab tab2 hidden">
                                    <div class="flex flex-col gap-4">
                                        <div>
                                            <strong class="text-xl">${_mbrSession.mbrNm}</strong>
                                            <span class="regist-rcpt-lno-yes">님의</span>
                                            <span class="regist-rcpt-lno-no">님</span>
                                        </div>
                                        <div class="bg-white rounded-md p-5 regist-rcpt-lno-yes">
                                            <div class="text-index1 mb-2">요양인정번호는</div>
                                            <div>
                                                <label for="rcpt-lno" class="rcpt-lno">
                                                    <input type="text" id="no-rcpt-tab2-lno" placeholder="뒤의 숫자 10자리 입력" class="form-control input-lno keycontrol numberonly" maxlength="10" oninput="checkAddRecipientBtnDisable();">
                                                </label>
                                                <span>입니다</span>
                                            </div>
                                        </div>
                                        <div class="bg-white rounded-md p-5 regist-rcpt-lno-no">
                                            <div class="text-index1 mb-2">본인을 수급자(어르신)로 등록하시겠습니까?</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>