<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header id="subject">
    <nav class="breadcrumb">
        <ul>
            <li class="home"><a href="#">홈</a></li>
            <li>이로움 서비스</li>
            <li>인정 등급 예상 테스트</li>
        </ul>
    </nav>
</header>

<div id="content">
    <div class="result-content1">
        <h2 class="grade-title2">
            <small>노인장기요양보험</small>
            인정등급 예상 테스트
        </h2>
        <p class="warning">※ 보건복지부에서 고시한 장기 요양 등급 판정 기준을 근거로 만들어진 테스트로, <strong>실제 등급 판정 결과와 상이할 수 있어요.</strong></p>
        <div class="result">
            <div class="container">
                
            </div>
        </div>
        <div class="explan">
            <li>
                <dl>
                    <dt><strong>1</strong>등급</dt>
                    <dd>
                        95점~<br>
                        <em>전적 도움</em>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><strong>2</strong>등급</dt>
                    <dd>
                        94점~75점<br>
                        <em>상당부분 도움</em>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><strong>3</strong>등급</dt>
                    <dd>
                        74점~60점<br>
                        <em>부분적 도움</em>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><strong>4</strong>등급</dt>
                    <dd>
                        59점~51점<br>
                        <em>일정부분 도움</em>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><strong>5</strong>등급</dt>
                    <dd>
                        50점~ 45점<br>
                        <em>노인성질병 치매</em>
                    </dd>
                </dl>
            </li>
            <li>
                <dl>
                    <dt><strong>인지지원</strong> 등급</dt>
                    <dd>
                        45점 이하<br>
                        <em>노인성질병 치매</em>
                    </dd>
                </dl>
            </li>
        </div>
        
        <c:choose>
            <c:when test="${_mbrSession.loginCheck}">
                <div class="mainSend">
                    <form class="provide-form">
                        <div class="form-agree">                                    
                            <div class="flex gap-3 items-center py-2 justify-center">
                            <input class="rounded-md border-2 relative" style="width: 1.4rem; height: 1.4rem;" type="checkbox" name="chk-email" id="chk-email">
                            <label class="form-check-label text-1xl" for="chk-email">나에게 예상 테스트 결과 보내기</label>
                            </div>
                        </div>                        
                        <ul>
                            <li> 예상 테스트 결과를 메일로 보내고 1:1상담을 신청하세요.</li>
                            <li> 이 페이지를 벗어나면 더 이상 결과를 확인할 수 없어요.</li>
                        </ul>                   
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <%-- <button type="button" class="btn btn-primary large w-[52.5%]" onclick="location.href='/membership/conslt/appl/list'">메일보내기</button> --%> 
            </c:otherwise>
        </c:choose>
        
    </div>

    <div class="result-content2">
        <h2 class="grade-title">
            전문가 상담
            <small>무료 전문가 상담으로 등급 신청까지 의뢰 가능해요.</small>
            <c:if test="${_mbrSession.loginCheck}">
            	<small>아래 1:1 상담하기 버튼을 눌러주세요.</small>	
            </c:if>
        </h2>
        <div class="images" >
            <img src="/html/page/index/assets/images/img-grade-result1.svg" alt="전문가 상담 이미지">
        </div>
    </div>
    
    <div class="result-content3">
        <h2 class="grade-title">
            예상 복지용구 확인
            <small>
                내가 신청할 수 있는 예상 복지용구를 확인해보세요.<br>
                실제 수령하는 복지용구와는 다를 수 있어요.
            </small>
        </h2>
        <div class="grade-slider mt-9 md:mt-7.5">
            <div class="swiper">
                <div class="swiper-wrapper">
                    
                </div>
            </div>
            <div class="swiper-button-prev"></div>
            <div class="swiper-button-next"></div>
        </div>
    </div>
    
    <div class="result-content4">
        <h2 class="grade-title">
            상세 결과 확인
            <small>테스트 문항과 내가 선택한 답변을 확인하세요.</small>
        </h2>

		<!-- 
        <div class="text-right mt-4 mb-5 md:mt-35 md:-mb-35">
            <button type="button" class="result-share">공유하기</button>
        </div>
         -->

        <h3 class="result-question">
            <img src="/html/page/index/assets/images/img-grade-result2.svg" alt="" class="w-6 md:w-12">
            신체기능
        </h3>

        <div id="physical-select" class="mt-5 space-y-1 md:mt-5.5 md:space-y-1.5">
            <dl class="result-answer">
                <dt>옷 벗고 입기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>세수하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>양치질하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>목욕하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>식사하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>체위 변경하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>일어나 앉기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>옮겨앉기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>방 밖으로 나오기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>화장실 사용하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>대변 조절하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
            <dl class="result-answer">
                <dt>소변 조절하기가 가능하십니까?</dt>
                <dd></dd>
            </dl>
        </div>

        <h3 class="result-question mt-21 md:mt-42">
            <img src="/html/page/index/assets/images/img-grade-result3.svg" alt="" class="w-7.5 md:w-15">
            인지기능
        </h3>
        <div class="mt-7.5 space-y-7.5 md:mt-6 md:space-y-15">
            <div class="space-y-1 md:space-y-1.5">
                <dl id="cognitive-select" class="result-answer3">
                </dl>
            </div>
        </div>
        
        <h3 class="result-question mt-21 md:mt-42">
            <img src="/html/page/index/assets/images/img-grade-result4.svg" alt="" class="w-11 md:w-22">
            행동변화
        </h3>
        <div class="mt-7.5 space-y-7.5 md:mt-6 md:space-y-15">
            <div class="space-y-1 md:space-y-1.5">
                <dl id="behavior-select" class="result-answer3">
                </dl>
            </div>
        </div>
        
        <h3 class="result-question mt-21 md:mt-42">
            <img src="/html/page/index/assets/images/img-grade-result5.svg" alt="" class="w-10 md:w-[4.875rem]">
            간호처치
        </h3>
        <div class="mt-7.5 space-y-7.5 md:mt-6 md:space-y-15">
            <div class="space-y-1 md:space-y-1.5">
                <dl id="nurse-select" class="result-answer3">
                </dl>
            </div>
        </div>
        
        <h3 class="result-question mt-21 md:mt-42">
            <img src="/html/page/index/assets/images/img-grade-result6.svg" alt="" class="w-[2.8125rem] md:w-[5.625rem]">
            재활
        </h3>
        <div id="rehabilitate-select" class="mt-7.5 space-y-7.5 md:mt-6 md:space-y-15">
            <div class="space-y-1 md:space-y-1.5">
                <h4 class="text-xl font-bold md:mb-2.5 md:text-2xl">운동장애 정도</h4>
                <dl class="result-answer">
                    <dt>오른쪽 상지(손, 팔, 어깨)가 의지대로 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>오른쪽 하지(발, 다리)가 의지대로 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>왼쪽 상지(손, 팔, 어깨)가 의지대로 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>왼쪽 하지(발, 다리)가 의지대로 움직이시나요?</dt>
                    <dd></dd>
                </dl>
            </div>
            <div class="space-y-1 md:space-y-1.5">
                <h4 class="text-xl font-bold md:mb-2.5 md:text-2xl">운동제한 정도</h4>
                <dl class="result-answer">
                    <dt>어깨관절이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>팔꿈치관절이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>손목 및 손관절이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>고관절(엉덩이관절)이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>무릎관절이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
                <dl class="result-answer">
                    <dt>발목관절이 자유롭게 움직이시나요?</dt>
                    <dd></dd>
                </dl>
            </div>
        </div>
        
        <h3 class="result-question mt-21 md:mt-42">
            <img src="/html/page/index/assets/images/img-grade-result7.svg" alt="" class="w-10 md:w-20">
            질병
        </h3>
        <div class="mt-7.5 space-y-7.5 md:mt-6 md:space-y-15">
            <dl id="disease-select-1" class="result-answer2">
            </dl>
            <dl id="disease-select-2" class="result-answer2">
            </dl>
        </div>
    </div>

	<!--
    <div class="text-right mt-6">
        <button type="button" class="result-share">공유하기</button>
    </div>
    -->

    <div class="result-content5">
        다른 결과를 확인하고 싶으시다면? <a href="#" onclick="restartTest();">테스트 다시하기</a>
    </div>

    <a id="go-consult" class="grade-floating">다른 혜택 확인하기</a>
    
    
    <!-- 공유하기 모달 start-->
    <button href="#modal-email" data-bs-toggle="modal" data-bs-target="#modal-email" type="button" class="result-share" style="display: none;">공유하기</button>
    <div class="modal fade" id="modal-email" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content-email">
                <div class="modal-header">
                    <p>테스트 결과 메일로 보내기</p>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                </div>
                <div class="modal-bod">
                    <form class="provide-form" >                            
                        <fieldset class="form-fieldset" style="background-color: transparent;">   
                            <div class="md:flex gap-1 items-center">                                        
                                <label for="form-item5" style="display: none;">이메일</label>
                                <div>
                                    <div class="md:flex gap-1 items-center">
                                        <input id="email-front" type="text" placeholder="이메일주소" class="form-control w-full xs:max-w-40">
                                        <i>@</i>
                                        <input id="email-back" type="text" placeholder="직접입력"  class="form-control w-full xs:max-w-40">
                                        <select id="select-email" name="select-email" class="form-control w-full xs:max-w-40">
                                            <option value="">선택해 주세요</option>
                                            <option value="naver.com">naver.com</option>
                                            <option value="hanmail.net">hanmail.net</option>
                                            <option value="daum.net">daum.net</option>
                                            <option value="gmail.com">gmail.com</option>
                                            <option value="kakao.com">kakao.com</option>
                                            <option value="nate.com">nate.com</option>
                                            <option value="hotmail.com">hotmail.com</option>                                                   
                                        </select>
                                    </div>
                                </div>
                            </div>                                   
                        </fieldset>                            
                     </form>            
                </div>
                <div class="modal-footer">
                    <a id='sendEmailBtn'  href="#" class="btn large btn-primary w-36">전송하기</a>
                </div>
            </div>
        </div>
    </div>
    <!-- 공유하기 모달 end-->
    
    <!--상담하기 팝업소스-->
    <div class="modal modal-index fade" id="modal-my-consulting" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
            <div class="modal-header">
                <h2 class="text-title">알림</h2>
                <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
            </div>
            <div class="modal-body">
                <div class="modal-bg-wrap">
                    <div class="text-center text-xl">
                        진행중인 요양정보 상담이 있습니다.<br>
                        상담 내역을 확인하시겠습니까?
                    </div>
                </div>
            </div>
            <div class="modal-footer gap-1">
                <button type="button" class="btn btn-primary large w-[52.5%]" onclick="location.href='/membership/conslt/appl/list'">상담내역 확인하기</button>
                <button type="button" class="btn btn-outline-primary large w-[47.5%] md:whitespace-nowrap" onclick="openNewConsltInfo();">새롭게 진행하기</button>
            </div>
            </div>
        </div>
    </div>

    <!--L번호가 있는 수급자의 경우 : 상담정보확인-->
    <div class="modal modal-index fade" id="modal-consulting-info" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
            <div class="modal-header">
                <h2 class="text-title">상담 정보 확인</h2>
                <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
            </div>
            <div class="modal-body">
                <div class="text-subtitle -mb-4">
                    <i class="icon-alert"></i>
                    <p>회원이 이용약관에 따라 수급자 등록과 관리하는 것에 동의합니다</p>
                </div>
                <table class="table-detail">
                    <caption class="hidden">상담정보확인 위한 수급자와의 관계(필수), 수급자성명(필수), 요양인정번호, 상담받을연락처(필수), 실거주지 주소(필수), 생년월일(필수),성별(필수), 상담유형 입력폼입니다 </caption>
                    <colgroup>
                        <col class="w-22 xs:w-32">
                        <col>
                    </colgroup>
                    <tbody>
                        <tr class="wrapRelation">
                            <tr class="top-border">
                                <td></td>
                                <td></td>
                            </tr>
                            <th scope="row">
                                <p>
                                    <label for="recipter">수급자와의 관계</label>
                                    <sup class="text-danger text-base md:text-lg">*</sup>
                                </p>
                            </th>
                            <td>
                                <select name="relationSelect" id="info-relationSelect" class="form-control w-full lg:w-8/12">
                                    <option value="">관계 선택</option>
						<c:forEach var="relation" items="${mbrRelationCode}" varStatus="status">
							<option value="${relation.key}">${relation.value}</option>	
						</c:forEach>
                                </select>
                            </td>
                        </tr>
                        <tr class="wrapNm">
                            <th scope="row">
                                <p>
                                    <label for="recipter">수급자 성명</label>
                                    <sup class="text-danger text-base md:text-lg">*</sup>
                                </p>
                            </th>
                            <td>
                                <input type="text" class="form-control  lg:w-8/12" id="info-recipientsNm" name="info-recipientsNm" maxlength="50" value="">
                            </td>
                        </tr>
                        <tr class="wrapNo">
                            <th scope="row">
                                <p>
                                    <label for="rcperRcognNo">요양인정번호</label>
                                </p>
                            </th>
                            <td>
                                <div class="flex flex-row gap-2.5 mb-1.5">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="info-rcperRcognNo-yn" id="info-rcperRcognNo-y" value="Y" checked onchange="changeRcperRcognNoYn();">
                                        <label class="form-check-label" for="info-rcperRcognNo-y">있음</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="info-rcperRcognNo-yn" id="info-rcperRcognNo-n" value="N" onchange="changeRcperRcognNoYn();">
                                        <label class="form-check-label" for="info-rcperRcognNo-n">없음</label>
                                    </div>
                                </div>
                                <div class="form-group w-full lg:w-8/12" id="input-rcperRcognNo">
                                    <p class="px-1.5 font-serif text-[1.375rem] font-bold md:text-2xl">L</p>
                                    <input type="text" class="form-control " id="info-rcperRcognNo" name="info-rcperRcognNo" maxlength="13" value="">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">
                                <p>
                                    <label for="search-item6">상담받을 연락처</label>
                                    <sup class="text-danger text-base md:text-lg">*</sup>
                                </p>
                            </th>
                            <td><input type="text" class="form-control w-full lg:w-8/12" id="info-tel"></td>
                        </tr> 
                        <tr>
                            <th scope="row">
                                <p>
                                    <label for="search-item6">실거주지 주소</label>
                                    <sup class="text-danger text-base md:text-lg">*</sup>
                                </p>
                            </th>
                            <td>
                                <fieldset  class="addr-select">
                                    <select name="sido" id="sido" class="form-control" onchange="setSigugun();">
                                    </select>
                                    <select name="sigugun" id="sigugun" class="form-control" onchange="setDong();">
                                    	<option value="">시/군/구</option>
                                    </select>
                                    <select name="dong" id="dong" class="form-control md:col-span-2 lg:col-span-1">
                                        <option value="">동/읍/면</option>
                                    </select>
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">
                                <p>
                                    <label for="search-item4">생년월일</label>
                                    <sup class="text-danger text-base md:text-lg">*</sup>
                                </p>
                            </th>
                            <td><input type="text" class="form-control  lg:w-8/12" id="info-brdt" placeholder="1950/01/01"></td>
                        </tr>
                        <tr>
                        	<th scope="row">
                                <p>
                                    <label for="search-item4">성별</label>
                                    <sup class="text-danger text-base md:text-lg">*</sup>
                                </p>
                            </th>
                        	<td>
                        		<div class="flex flex-row gap-2.5 mb-1.5">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="info-gender" id="info-gender-m" value="M">
                                        <label class="form-check-label" for="info-gender-m">남성</label>
                                    </div>
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="info-gender" id="info-gender-w" value="W">
                                        <label class="form-check-label" for="info-gender-w">여성</label>
                                    </div>
                                </div>
                        	</td>
                        </tr>
                        <tr>
                            <th scope="row"><p><label for="search-item4">상담유형</label></p></th>
                            <td>인정등급상담</td>
                        </tr>
                        <tr class="top-border">
                            <td></td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                <ul class="list-style1">
                    <li>상기 정보는 장기요양등급 신청 및 상담이 가능한 장기요양기관에 제공되며 원활한 상담 진행 목적으로 상담 기관이 변경될 수도 있습니다.</li>
                    <li>제공되는 정보는 상기 목적으로만 활용하며 1년간 보관 후 폐기됩니다.</li>
                    <li>가입 시 동의받은 개인정보 제3자 제공동의에따라 위의 개인정보가 제공됩니다. 동의하지 않을 경우 서비스 이용이 제한될 수 있습니다.</li>
                </ul>
            </div>
            <div class="modal-footer md:w-3/4 mx-auto mt-4">
                <button type="button" class="btn btn-primary3 large w-[60%] md:w-[70%]" onclick="requestConslt();">상담신청하기</button>
                <button type="button" class="btn btn-outline-primary large w-[40%] md:w-[30%] md:whitespace-nowrap" onclick="$('#modal-consulting-info').modal('hide');">취소하기</button>
            </div>
            </div>
        </div>
    </div>

    <!--상담신청완료-->
    <div class="modal modal-index fade" id="modal-consulting-complated" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog  modal-dialog-centered">
            <div class="modal-content">
            <div class="modal-header">
                <h2 class="text-title">알림</h2>
                <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <div class="provide-complate">
                        <div class="wrapper">
                            <svg width="45.1731884px" height="44.9930805px" viewBox="0 0 45.1731884 44.9930805">
                                <g id="airplane" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                    <g id="airplane" transform="translate(-836.3067, -384.1337)" fill="#FFFFFF">
                                        <g id="airplane" transform="translate(787, 329)">
                                            <path d="M49.8149249,79.6635069 L92.9878533,55.2632727 C93.4686607,54.9915327 94.078721,55.1610153 94.350461,55.6418227 C94.4586743,55.8332916 94.5007484,56.0550947 94.470169,56.2728912 L89.2316897,93.5830877 C89.0781107,94.6769283 88.0668774,95.439161 86.9730368,95.285582 C86.8468774,95.2678688 86.7226991,95.2381419 86.6021946,95.1968067 L75.5767429,91.4148747 C74.7376734,91.1270585 73.8092758,91.426319 73.2962443,92.1499725 L67.940117,99.7050262 C67.620703,100.155574 66.9965258,100.261879 66.5459782,99.9424645 C66.2814978,99.7549621 66.1243285,99.4508781 66.1243285,99.1266759 L66.1243285,89.5357494 C66.1243285,88.8171161 66.3822929,88.1223582 66.8512931,87.5778653 L81.6305995,70.4196045 C81.8108177,70.2103773 81.7873014,69.8946695 81.5780742,69.7144512 C81.3931938,69.555204 81.1203694,69.552664 80.9325561,69.7084415 L62.4817313,85.0120537 C61.6191487,85.727503 60.4297149,85.9025231 59.3976054,85.4658696 L49.9173201,81.4550557 C49.4086824,81.2398669 49.1707951,80.6530897 49.3859839,80.1444521 C49.4719751,79.9411962 49.6227902,79.7720965 49.8149249,79.6635069 Z" id="Path-4"></path>
                                        </g>
                                    </g>
                                </g>
                            </svg>
                            <div class="object1"></div>
                            <div class="object2"></div>
                            <div class="object3"></div>
                        </div>
                    </div>
                    <p class="mt-5.5 text-lg font-bold md:mt-6 md:text-xl lg:mt-7 lg:text-2xl">상담 신청이 완료되었습니다.</p>
                    <p class="mt-2 mb-4 text-sm md:text-base tracking-tight">
                        "영업일 기준, 2일 이내 해피콜 통해 <span class="block md:inline-block">안내 받으실 수 있어요"</span>
                    </p>
                </div>

                <script>
                    $('.provide-complate').addClass('animate1');
                    $('.provide-complate svg').one('animationend transitionend',function(){
                        $('.provide-complate').removeClass('animate1').addClass('animate2');
                    });
                </script>
            </div>
            <div class="modal-footer">
                <a href="#" class="btn btn-large btn-primary3 w-57 md:w-70" onclick="location.href='/membership/conslt/appl/list'">신청 내역 보러가기</a>
            </div>
            </div>
        </div>
    </div>
    
    <!-- 예상치 못한 오류 팝업 -->
    <div class="modal modal-index fade" id="modalError" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered ">
            <div class="modal-content">
                <div class="modal-header">
                </div>
                <div class="modal-body md:min-w-[26rem]">
                    <!-- 예상치 못한 오류로 결과를 확인할 수 없는 상황에 호출되는 모달(팝업) -->
                    <div class="flex flex-col items-center text-xl">
                        <i class="icon-alert orange mb-8"></i>
                        <p>죄송합니다</p>
                        <p><strong>일시적 오류</strong>가 발생했습니다</p>
                        <p>잠시후 다시 시도해 주세요</p>
                    </div>
                    <!--// 예상치 못한 오류로 결과를 확인할 수 없는 상황에 호출되는 모달(팝업) -->
                </div>
                <div class="modal-footer">
                    <a href="/main/cntnts/test" class="btn btn-primary">테스트 시작하기</a>
                </div>
            </div>
        </div>
    </div>
    
    
    
    <script>
    	var testResult = {};
    	var me = {};
    	var myRecipientInfo = {};
    	var mbrRecipients = {};
    	
    	//상담하기 버튼 클릭
    	function clickStartConsltBtn() {
    		$.ajax({
    			type : "post",
    			url  : "/membership/info/myinfo/getMbrInfo.json",
    			dataType : 'json'
    		})
    		.done(function(data) {
    			//로그인 한 경우
    			if (data.isLogin) {
    				var testData = JSON.parse(sessionStorage.getItem('testData'));
    				me = data.mbrVO;
    				myRecipientInfo = data.mbrRecipients.filter(f => f.recipientsNo === testData.recipientsNo)[0];
    				mbrRecipients = data.mbrRecipients;
    				
    				//진행중인 상담이 있는 경우
    				if (data.isExistConsltInProcess) {
    					$('#modal-my-consulting').modal('show');
    					return;
    				}
    				
    				openNewConsltInfo();
    			}
    			//로그인 안한 경우
    			else {
    				alert('로그인 이후 이용가능합니다')
    			}
    		})
    		.fail(function(data, status, err) {
    			alert('서버와 연결이 좋지 않습니다');
    		});
    	}


    	//상담신청 모달창 띄우기(또는 진행중인 상담존재 모달에서 새롭게 진행하기 클릭)
    	function openNewConsltInfo() {
    		$('#info-relationSelect').val(myRecipientInfo.relationCd);
    		$('#info-recipientsNm').val(myRecipientInfo.recipientsNm);
    		
    		if(myRecipientInfo.rcperRcognNo) {
    			//L번호가 있는 경우 이름, L번호 수정 불가
    			$('#info-recipientsNm').prop('readonly', true);
    			$('#info-rcperRcognNo-y').prop('disabled', true);
    			$('#info-rcperRcognNo-n').prop('disabled', true);
    			
    			$('#info-rcperRcognNo-y').prop('checked', true); 
    			$('#info-rcperRcognNo').val(myRecipientInfo.rcperRcognNo);
    			$('#input-rcperRcognNo').css('display', 'inline-flex');
    			$('#info-rcperRcognNo').prop('readonly', true);
    		} else {
    			$('#info-recipientsNm').prop('readonly', false);
    			$('#info-rcperRcognNo-y').prop('disabled', false);
    			$('#info-rcperRcognNo-n').prop('disabled', false);
    			
    			$('#info-rcperRcognNo-n').prop('checked', true);
    			$('#info-rcperRcognNo').val('');
    			$('#input-rcperRcognNo').css('display', 'none');
    		}
    		
    		$('#info-tel').val(myRecipientInfo.tel);
    		
    		if (myRecipientInfo.sido) {
    			var options = $('#sido option');
    			for(var i = 0; i < options.length; i++) {
    				if ($('#sido option')[i].text === myRecipientInfo.sido) {
    					$('#sido option')[i].selected = true;
    				}
    			}
    			setSigugun();
    		}
    		if (myRecipientInfo.sigugun) {
    			var options = $('#sigugun option');
    			for(var i = 0; i < options.length; i++) {
    				if ($('#sigugun option')[i].text === myRecipientInfo.sigugun) {
    					$('#sigugun option')[i].selected = true;
    				}
    			}
    			setDong();
    		}
    		if (myRecipientInfo.dong) {
    			var options = $('#dong option');
    			for(var i = 0; i < options.length; i++) {
    				if ($('#dong option')[i].text === myRecipientInfo.dong) {
    					$('#dong option')[i].selected = true;
    				}
    			}
    		}
    		
    		if(myRecipientInfo.brdt) {
    			$('#info-brdt').val(myRecipientInfo.brdt.substring(0, 4) + '/' + myRecipientInfo.brdt.substring(4, 6) + '/' + myRecipientInfo.brdt.substring(6, 8));	
    		} else {
    			$('#info-brdt').val('');    			
    		}
    		
    		if (myRecipientInfo.gender === 'M') {
    			$('#info-gender-m').prop('checked', true);
    		} else if (myRecipientInfo.gender === 'W') {
    			$('#info-gender-w').prop('checked', true);
    		} else {
    			$('#info-gender-m').prop('checked', false);
    			$('#info-gender-w').prop('checked', false);
    		}
    		
    		
    		$('#modal-consulting-info').modal('show').appendTo('body');
    	}

    	//상담신청정보 모달창안에 L번호 있음, 없음 체크로 readonly 처리
    	function changeRcperRcognNoYn() {
    		var checkedVal = $('input[name=info-rcperRcognNo-yn]:checked').val();
    		if (checkedVal === 'Y') {
    			$('#info-rcperRcognNo').prop('readonly', false);
    			$('#input-rcperRcognNo').css('display', 'inline-flex');
    		} else {
    			$('#info-rcperRcognNo').prop('readonly', true);
    			$('#input-rcperRcognNo').css('display', 'none');
    		}
    	}


    	//상담신청하기
    	var doubleClickCheck = false;
    	var telchk = /^([0-9]{2,3})?-([0-9]{3,4})?-([0-9]{3,4})$/;
    	var datechk = /^([1-2][0-9]{3})\/([0-1][0-9])\/([0-3][0-9])$/;
    	function requestConslt() {
    		if (doubleClickCheck) {
	    		return;
	    	}
    		
    		var relationCd = $('#info-relationSelect').val();
    		var recipientsNm = $('#info-recipientsNm').val();
    		var rcperRcognNoYn = $('input[name=info-rcperRcognNo-yn]:checked').val();
    		var rcperRcognNo = $('#info-rcperRcognNo').val();
    		var tel = $('#info-tel').val();
    		var sidoCode = $('#sido option:selected').val();
    		var sido = $('#sido option:selected').text();
    		var sigugunCode = $('#sigugun option:selected').val();
    		var sigugun = $('#sigugun option:selected').text();
    		var dongCode = $('#dong option:selected').val();
    		var dong = $('#dong option:selected').text();
    		var brdt = $('#info-brdt').val();
    		var gender = $('input[name=info-gender]:checked').val();
    		
    		//필수항목 입력검사
    		if (!relationCd) {
    			alert('수급자와의 관계를 선택하세요');
    			return;
    		}
    		if (!recipientsNm) {
    			alert('수급자 성명을 입력하세요');
    			return;
    		}
    		if (rcperRcognNoYn === 'Y' && !rcperRcognNo) {
    			alert('요양인정번호를 입력하세요');
    			return;
    		}
            //요양번호 10자리 검사
            if (rcperRcognNoYn === 'Y' && rcperRcognNo.length != 10) {
                alert('요양인정번호 숫자 10자리를 입력하세요 (예: 1234567890)');
                return;
            }
    		if (!tel) {
    			alert('상담받을 연락처를 입력하세요');
    			return;
    		}
    		
            //동은 선택값이 없으면 검사하지 않음
	    	var dongOptions = $('#dong option');
	    	if (dongOptions.length === 1) {
	    		if (!sidoCode || !sigugunCode) {
		    		alert('실거주지 주소를 선택하세요');
		    		return;
		    	}
	    		dong = null;
	    	} 
	    	else {
	    		if (!sidoCode || !sigugunCode || !dongCode) {
		    		alert('실거주지 주소를 모두 선택하세요');
		    		return;
		    	}
	    	}
            
    		if (!brdt) {
    			alert('생년월일를 입력하세요');
    			return;
    		}
    		if (!gender) {
    			alert('성별을 입력하세요');
    			return;
    		}
    		
    		//본인인지 체크
    		if (relationCd === '007' && recipientsNm !== me.mbrNm) {
    			alert('수급자와의 관계를 확인해주세요');
    			return;
    		}
    		//본인과 배우자는 한명만 등록
    		var meCount = mbrRecipients.filter(f => f.recipientsNo !== myRecipientInfo.recipientsNo && f.relationCd === '007').length; //내 수급자가 아닌 다른수급자도 본인인지 확인
    		var spouseCount = mbrRecipients.filter(f => f.recipientsNo !== myRecipientInfo.recipientsNo && f.relationCd === '001').length; //내 수급자가 아닌 다른수급자도 배우자인지 확인
    		if ((relationCd === '007' && meCount > 0) ||
    			(relationCd === '001' && spouseCount > 0)) {
    			alert('수급자와의 관계를 확인해주세요');
    			return;
    		}
    		
    			
    		//연락처 형식 검사
    		if (telchk.test(tel) === false) {
    			alert('연락처 형식이 올바르지 않습니다 (예시: 010-0000-0000)');
    			return;
    		}
    		
    		//생년월일 형식 검사
    		if (datechk.test(brdt) === false) {
    			alert('생년월일 형식이 올바르지 않습니다 (예시: 1950/01/01)');
    			return;
    		}
    		
            if (rcperRcognNoYn === 'N') {
				rcperRcognNo = '';
			}
    		
          	//입력된 정보가 수정되었는지 체크 후 alert처리
            var saveRecipientInfo = false;
            if (myRecipientInfo.relationCd !== (relationCd ? relationCd : null) ||
            		myRecipientInfo.recipientsNm !== (recipientsNm ? recipientsNm : null) ||
            		myRecipientInfo.rcperRcognNo !== (rcperRcognNo ? rcperRcognNo : null) ||
            		myRecipientInfo.tel !== (tel ? tel : null) ||
            		myRecipientInfo.sido !== (sido ? sido : null) ||
            		myRecipientInfo.sigugun !== (sigugun ? sigugun : null) ||
            		myRecipientInfo.dong !== (dong ? dong : null) ||
            		(brdt && myRecipientInfo.brdt !== (brdt ? brdt.replaceAll('/', '') : null) ) ||
            		myRecipientInfo.gender !== (gender ? gender : null)) {
            	saveRecipientInfo = confirm('입력하신 수급자 정보를 마이페이지에도 저장하시겠습니까?');	
            }
    		
            doubleClickCheck = true;
            
            //상담신청 API 호출
            jsCallApi.call_api_post_json(window, "/main/conslt/addMbrConslt.json", "addMbrConsltCallback", {
				relationCd
				, mbrNm: recipientsNm
				, rcperRcognNo
				, mbrTelno: tel
				, zip: sido
				, addr: sigugun
				, daddr: dong
				, brdt
				, gender
				, recipientsNo: myRecipientInfo.recipientsNo
				, prevPath: 'test'
				, saveRecipientInfo
			});
    	}

    	// 상담신청하기 콜백
    	function addMbrConsltCallback(result, errorResult, data, param) {
    		if (errorResult == null) {
    			var data = result;
    			
    			doubleClickCheck = false;
    			if(data.success) {
    				$('#modal-consulting-info').modal('hide');
    				$('#modal-consulting-complated').modal('show').appendTo('body');
    				
    				
    				//채널톡 이벤트 처리
    	        	eventChannelTalk('click_gradetest_matching');
    			}else{
    				alert(data.msg);
    			}
    		} else {
    			alert('서버와 연결이 좋지 않습니다.');
    		}
    	}
    	

    	// 시/도 Select 박스 셋팅
    	function initSido() {
    		var template = '<option value="">시/도</option>';
    		
    		for(var i = 0; i < hangjungdong.sido.length; i++) {
    			template += '<option value="' + hangjungdong.sido[i].sido + '">' + hangjungdong.sido[i].codeNm + '</option>';
    		}
    		
    		$('#sido').html(template);
    	}
    	// 시/구/군 Select 박스 셋팅
    	function setSigugun() {
    		var sidoCode = $('#sido option:selected').val();
    		
    		if (sidoCode) {
    			var sigugunArray = hangjungdong.sigugun.filter(f => f.sido === sidoCode);
    			var template = '<option value="">시/군/구</option>';
    			
    			for(var i = 0; i < sigugunArray.length; i++) {
    				template += '<option value="' + sigugunArray[i].sigugun + '">' + sigugunArray[i].codeNm + '</option>';
    			}
    			
    			$('#sigugun').html(template);
    		}
    	}
    	// 동/읍/면 Select 박스 셋팅
    	function setDong() {
            var sidoCode = $('#sido option:selected').val();
    		var sigugunCode = $('#sigugun option:selected').val();
    		
    		if (sigugunCode) {
    			var dongArray = hangjungdong.dong.filter(f => f.sido === sidoCode && f.sigugun === sigugunCode);
    			var template = '<option value="">동/읍/면</option>';
    			
    			for(var i = 0; i < dongArray.length; i++) {
    				template += '<option value="' + dongArray[i].dong + '">' + dongArray[i].codeNm + '</option>';
    			}
    			
    			$('#dong').html(template);
    		}
    	}
    
    	
    	//채널톡 event 처리 (테스트 결과보기 페이지 실행, 1:1 상담하기 버튼 실행)
		function eventChannelTalk(eventName) {
		    //예상결과 등급
		    var grade = testResult.grade;
		    
		    var propertyObj = {
		   		 grade
		   	}
		    
		    //테스트 완료 일자(현재시간)
		    if (eventName === 'view_testresult') {
		    	//테스트 완료 일자
		    	var now = new Date();
		    	propertyObj.testEndDate = now.getFullYear() + '년 ' + String(now.getMonth() + 1).padStart(2, "0") + '월 ' + String(now.getDate()).padStart(2, "0") + '일';
		    } else {
		    	//상담 신청 일자
				var now = new Date();
				propertyObj.consltDate = now.getFullYear() + '년 ' + String(now.getMonth() + 1).padStart(2, "0") + '월 ' + String(now.getDate()).padStart(2, "0") + '일';
		    }
		    
		     ChannelIO('track', eventName, propertyObj);
		     
		     
		     //GA 이벤트 처리
		     var gaProp = {
		         grade,
		     };
		     
		     if (eventName === 'click_gradetest_matching') {
		    	 gaProp.consltDate = propertyObj.consltDate;
		     }
		     
		     gtag('event', eventName, gaProp);
		}
    	
    	
        $(function() {
        	loadTestResult();
        	initSido();
    		
        	
            var swiper = new Swiper(".swiper", {
                loop: true,
                slidesPerView: 2,
                spaceBetween : 0,
                grid: {
                    rows: 2,
                },
                speed: 1000,
                autoplay: {
                    delay: 5000,
                    disableOnInteraction: false,
                },
                breakpoints: {
                    480: {
                        grid: {
                            rows: 1,
                        },
                        slidesPerView: 3,
                    },
                    768: {
                        grid: {
                            rows: 1,
                        },
                        slidesPerView: 4
                    },
                    1024: {
                        grid: {
                            rows: 1,
                        },
                        slidesPerView: 6
                    }
                },
                navigation: {
                    prevEl: '.swiper-button-prev',
                    nextEl: '.swiper-button-next'
                },
            });
            
            //테스트 결과 조회 ajax
            function getTestResultAjax(recipientsNo) {
            	var result = null;
            	$.ajax({
            		type: "get",
            		url: "/test/result.json",
            		data: {recipientsNo},
            		dataType : 'json',
            		async: false
            	})
            	.done(function(res) {
            		if (res.success) {
            			result = JSON.parse(res.mbrTestResult);
            		}
            	})
            	.fail(function(data, status, err) {
            		alert('통신중 오류가 발생하였습니다.');
            	});
            	return result;
            }
            
            //로딩시 테스트 결과 조회
            function loadTestResult() {
            	var testData = JSON.parse(sessionStorage.getItem('testData'));
            	//테스트 결과가 없을 시
            	if (!testData) {
            		$('#modalError').modal('show');
            		return;
            	}
            	
            	if (testData.isLogin) {
            		//api 방식으로 테스트결과 가져오기
            		testResult = getTestResultAjax(testData.recipientsNo);
            		//api 요청 후 테스트 결과가 없을 시
                	if (!testResult) {
                		$('#modalError').modal('show');
                		return;
                	}
            		
            		$('#go-consult').css({'display':'flex', 'cursor':'pointer'});
            	}
            	else {
            		var finalTestResult = JSON.parse(sessionStorage.getItem('finalTestResult'));
            		//세션 방식으로 테스트결과 가져오기
            		testResult = {
            			...testData,
            			...finalTestResult,
            		};
            		
            		$('#go-consult').css('display', 'none');
            	}
            	
            	
            	//등급 문구 표시
            	drawTestResultGradeAndScore(testResult.grade, testResult.score);
            	//복지용구 표시
            	drawWelfareEquipment();
            	//내가 선택한 문항결과 확인
            	drawMbrTestSelectResult();
            	
            	
            	//채널톡 이벤트 처리
            	eventChannelTalk('view_testresult');
            }
            
            //등급 문구 표시
            function drawTestResultGradeAndScore(grade, score) {
            	$('.explan li').each(function (index, item) { $(item).removeClass('is-active') });
            	
            	let templete = `
            		<div class="grade">
	                    <strong>((grade))</strong>
	                    <small>등급</small>
	                </div>
	                <p class="point">장기요양인정 예상점수 : <strong>((score))점</strong></p>
	                <p class="desc">보건복지부에서 고시한 장기 요양 등급 판정 기준을 근거로 만들어진 테스트로, <strong class="underline">실제 등급 판정 결과와 상이할 수 있어요.</strong></p>
            	`;
            	
            	switch (grade) {
            		case 1 : {
            			templete += `
                            <p class="cost"><strong>월 188만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                            <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                            <ul class="alert">
                                <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                <li>1~2등급 어르신은 재가급여 대신 시설급여 선택 가능(시설급여 선택 시 복지용구 신청 불가)</li>
                            </ul>
                        `
                        $('.explan li:nth-child(1)').addClass('is-active');
            			break;
            		}
            		case 2 : {
            			templete += `
                            <p class="cost"><strong>월 169만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                            <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                            <ul class="alert">
                                <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                <li>1~2등급 어르신은 재가급여 대신 시설급여 선택 가능(시설급여 선택 시 복지용구 신청 불가)</li>
                            </ul>
                        `
                        $('.explan li:nth-child(2)').addClass('is-active');
            			break;
            		}
            		case 3 : {
            			templete += `
                            <p class="cost"><strong>월 141만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                            <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                            <ul class="alert">
                                <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                <li>조건 부합 시, 재가급여 대신 시설 급여 선택 가능(시설급여 선택 시 복지용구 신청 불가)</li>
                            </ul>
                        `
                        $('.explan li:nth-child(3)').addClass('is-active');
            			break;
            		}
            		case 4 : {
            			templete += `
                            <p class="cost"><strong>월 130만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                            <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                            <ul class="alert">
                                <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                <li>조건 부합 시, 재가급여 대신 시설 급여 선택 가능(시설급여 선택 시 복지용구 신청 불가)</li>
                            </ul>
                        `
                        $('.explan li:nth-child(4)').addClass('is-active');
            			break;
            		}
            		case 5 : {
            			templete += `
                            <p class="cost"><strong>월 112만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                            <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                            <ul class="alert">
                                <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                <li>조건 부합 시, 재가급여 대신 시설 급여 선택 가능(시설급여 선택 시 복지용구 신청 불가)</li>
                            </ul>
                        `
                        $('.explan li:nth-child(5)').addClass('is-active');
            			break;
            		}
            		default: {
            			//5등급 미만인 경우는 등급 및 점수 표시 HTML 재정의
            			templete = `
                    		<div class="grade">
        	                    <strong class="!text-2xl md:!text-4xl">((grade))</strong>
        	                </div>
        	                <p class="point">장기요양인정 예상점수 : <strong>((score))점</strong></p>
        	                <p class="desc">보건복지부에서 고시한 장기 요양 등급 판정 기준을 근거로 만들어진 테스트로, <strong class="underline">실제 등급 판정 결과와 상이할 수 있어요.</strong></p>
                    	`;
            			
            			//치매환자 인경우
            			if (testResult.diseaseSelect1 && testResult.diseaseSelect1[0] 
            				|| testResult.diseaseSelect2 && testResult.diseaseSelect2[0]) {
            				grade = '인지지원';
            				
            				templete += `
                                <p class="cost"><strong>월 62만원</strong>의 한도액 내에서 재가급여 또는 주야간센터를 이용할 수 있어요.</p>
                                <p class="cost"><strong>연 160만원</strong>의 한도액 내에서 복지용구 대여 또는 구입할 수 있어요.</p>
                                <ul class="alert">
                                    <li><strong>6~15%의 본인부담금이 발생(기초생활수급자는 전액 지원)</strong></li>
                                </ul>
                            `
            				$('.explan li:nth-child(6)').addClass('is-active');
            			} else {
            				grade = '등급 외';
            				
            				templete += `
                                <p class="cost">장기요양보험 <strong>혜택 불가</strong></p>
                                <ul class="alert">
                                    <li>등급판정은 "건강이 매우 안좋다", "큰 병에 걸렸다." 등과 같은 주관적인 개념이 아닌 
                                    "심신의 기능에 따라 일상생활에서 도움이 얼마나 필요한가?"를 기준으로 판단해요.</li>
                                </ul>
                            `
            			}
            			break;
            		}
            	}
            	
            	//등급, 점수값 넣기
            	templete = templete.replace('((grade))', grade);
            	templete = templete.replace('((score))', score);
            	
            	$('.result .container').html(templete);
            }
            
            //복지용구 표시
            function drawWelfareEquipment() {
            	const walfareEquipments = {
            		'성인용보행기': true,
            		'수동휠체어': true,
            		'지팡이': true,
            		'안전손잡이': true,
            		'미끄럼방지 매트': true,
            		'미끄럼방지 양말': true,
            		'욕창예방 매트리스': true,
            		'욕창예방 방석': true,
            		'자세변환용구': true,
            		'요실금 팬티': true,
            		'목욕의자': true,
            		'이동변기': true,
            		'간이변기': true,
            		'경사로': true,
            	};
            	
                //문서 1페이지
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[10] == 3    //대변변조절하기 [완전도움]
                    && testResult.physicalSelect[11] == 3)   //소변조절하기 [완전도움] 
                { 
                    //이동변기 품목제외
                	walfareEquipments['이동변기'] = false;
                }
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[5] == 3    //체위변경하기 [완전도움]
                    && testResult.physicalSelect[6] == 3)   //일어나 앉기 [완전도움] 
                {
                    //목욕의자 품목제외
                	walfareEquipments['목욕의자'] = false;
                }
                if (testResult && testResult.rehabilitateSelect
                    && 
                    ((testResult.rehabilitateSelect[0] == 3 && testResult.rehabilitateSelect[2] == 3)       //우측, 좌측상지 모두 [완전운동장애]
                    || (testResult.rehabilitateSelect[1] == 3 && testResult.rehabilitateSelect[3] == 3)))   //우측, 좌측하지 모두 [완전운동장애] 
                { 
                    //보행차 품목제외(보행차 -> 성인용 보행기)
                	walfareEquipments['성인용보행기'] = false;
                }
                if (testResult && testResult.physicalSelect &&
                    testResult && testResult.rehabilitateSelect
                    && 
                    ((testResult.physicalSelect[8] == 3)  //방 밖으로나가기 [완전도움]
                    || (testResult.rehabilitateSelect[0] == 3 && testResult.rehabilitateSelect[2] == 3)     //우측, 좌측상지 모두 [완전운동장애]
                    || (testResult.rehabilitateSelect[1] == 3 && testResult.rehabilitateSelect[3] == 3)))   //우측, 좌측하지 모두 [완전운동장애]
                { 
                    //보행 보조차 품목제외(보행보조차 -> 성인용 보행기)
                	walfareEquipments['성인용보행기'] = false;
                }
                if (testResult && testResult.rehabilitateSelect
                    && (testResult.rehabilitateSelect[0] == 3 && testResult.rehabilitateSelect[2] == 3))   //우측, 좌측상지 모두 [완전운동장애]
                {
                    //안전 손잡이 품목제외
                	walfareEquipments['안전손잡이'] = false;
                }
                if (testResult && testResult.rehabilitateSelect
                    && (testResult.rehabilitateSelect[1] == 3 && testResult.rehabilitateSelect[3] == 3))   //우측, 좌측하지 모두 [완전운동장애]
                {
                    //미끄럼 방지용품 품목제외(미끄럼 방지용품 -> 미끄럼방지 매트, 미끄럼방지 양말)
                	walfareEquipments['미끄럼방지 매트'] = false;
                	walfareEquipments['미끄럼방지 양말'] = false;
                }
                if (testResult && testResult.rehabilitateSelect
                    && 
                    ((testResult.rehabilitateSelect[0] == 3 && testResult.rehabilitateSelect[2] == 3)       //우측, 좌측상지 모두 [완전운동장애]
                    || (testResult.rehabilitateSelect[1] == 3 && testResult.rehabilitateSelect[3] == 3)))   //우측, 좌측하지 모두 [완전운동장애]
                {
                    //지팡이 품목제외
                	walfareEquipments['지팡이'] = false;
                }
                
                //문서 2페이지
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[5] == 1    //체위변경하기   [완전자립]
                    && testResult.physicalSelect[7] == 1    //옮겨 앉기     [완전자립]
                    && testResult.physicalSelect[8] == 1)   //방밖으로 나가기 [완전자립]
                {
                    //욕창 예방 방석 품목제외
                	walfareEquipments['욕창예방 방석'] = false;
                }
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[5] == 1    //체위변경하기  [완전자립]
                    && testResult.physicalSelect[6] == 1)   //일어나 앉기  [완전자립]
                {
                    //자세 변환 용구 품목제외
                	walfareEquipments['자세변환용구'] = false;
                }
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[8] == 1)   //방밖으로 나가기 [완전자립]
                {
                    //전동 침대 품목제외(이로움온 품목이 없어서 코드는 없음)
                    //수동 침대 품목제외(이로움온 품목이 없어서 코드는 없음)
                }
                if (testResult && testResult.physicalSelect &&
                    testResult && testResult.nurseSelect
                    && 
                    (testResult.physicalSelect[5] == 1     //체위변경하기 [완전자립]
                     && testResult.physicalSelect[6] == 1  //일어나 앉기  [완전자립]
                     && testResult.physicalSelect[7] == 1  //옮겨 앉기   [완전자립]
                     && testResult.nurseSelect[3] == 0))    //욕창간호   [없음]
                { 
                    //욕창 예방 매트리스 품목제외
                	walfareEquipments['욕창예방 매트리스'] = false;
                }
                if (testResult && testResult.physicalSelect
                    && testResult.physicalSelect[8] == 1)   //방밖으로 나가기 [완전자립]
                {
                    //이동 욕조 품목제외(이로움온 품목이 없어서 코드는 없음)
                    //목욕리프트 품목제외(이로움온 품목이 없어서 코드는 없음)
                }
            	
                let templete = '';
                if(walfareEquipments['성인용보행기']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category1.png" alt="성인용보행기"></a></div>';
                }
                if(walfareEquipments['수동휠체어']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category2.png" alt="수동휠체어"></a></div>';
                }
                if(walfareEquipments['지팡이']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category3.png" alt="지팡이"></a></div>';
                }
                if(walfareEquipments['안전손잡이']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category4.png" alt="안전손잡이"></a></div>';
                }
                if(walfareEquipments['미끄럼방지 매트']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category5.png" alt="미끄럼방지 매트"></a></div>';
                }
                if(walfareEquipments['미끄럼방지 양말']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category6.png" alt="미끄럼방지 양말"></a></div>';
                }
                if(walfareEquipments['욕창예방 매트리스']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category7.png" alt="욕창예방 매트리스"></a></div>';
                }
                if(walfareEquipments['욕창예방 방석']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category8.png" alt="욕창예방 방석"></a></div>';
                }
                if(walfareEquipments['자세변환용구']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category9.png" alt="자세변환용구"></a></div>';
                }
                if(walfareEquipments['요실금 팬티']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category10.png" alt="요실금 팬티"></a></div>';
                }
                if(walfareEquipments['목욕의자']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category11.png" alt="목욕의자"></a></div>';
                }
                if(walfareEquipments['이동변기']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category12.png" alt="이동변기"></a></div>';
                }
                if(walfareEquipments['간이변기']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category13.png" alt="간이변기"></a></div>';
                }
                if(walfareEquipments['경사로']) {
                	templete += '<div class="swiper-slide"><a><img src="/html/page/index/assets/images/img-page2-category14.png" alt="경사로"></a></div>';
                }
                
                $('.swiper-wrapper').html(templete);
            }
            
          	//내가 선택한 문항결과 확인
          	function drawMbrTestSelectResult() {
          		//신체기능 문항
          		if (testResult && testResult.physicalSelect) {
          			$('#physical-select .result-answer dd').each(function (index, item) {
             			 $(item).html(testResult.physicalSelect[index] == 1 ? '혼자서 가능' :
             			   			  testResult.physicalSelect[index] == 2 ? '일부 도움 필요' :
             			   			  testResult.physicalSelect[index] == 3 ? '완전히 도움 필요' : '')
             		});	
          		}
          		
          		//인지기능 문항
          		if (testResult && testResult.cognitiveSelect) {
          			const cognitiveQuestion = [
              			'방금 전에 들었던 이야기나 일을 잊는다.',
              			'오늘이 몇 년, 몇 월, 몇 일인지 모른다.',
              			'자신이 있는 장소를 알지 못한다.',
              			'자신의 나이와 생일을 모른다.',
              			'지시를 이해하지 못한다.',
              			'주어진 상황에 대한 판단력이 떨어져 있다.',
              			'의사소통이나 전달에 장애가 있다.',
              		];
              		
              		let cognitiveTemplete = '<dt>최근 한 달간의 상황을 종합하여 아래 항목 중 해당하는 모든 증상을 선택해 주세요.</dt>';
              		
              		//선택한 문항이 없는 경우
              		if (testResult.cognitiveSelect.findIndex(select => select === 1) === -1) {
              			cognitiveTemplete += '<dd>해당하는 증상이 없다.</dd>'
              		} else {
              			for (var i = 0; i < testResult.cognitiveSelect.length; i++) {
                  			if (testResult.cognitiveSelect[i]) {
                  				cognitiveTemplete += '<dd>' + cognitiveQuestion[i] + '</dd>';
                  			}
                  		}
              		}
              		
              		$('#cognitive-select').html(cognitiveTemplete);
          		}
          		
          		//행동변화
          		if (testResult && testResult.behaviorSelect) {
          			const behaviorQuestion = [
          				'사람들이 무엇을 훔쳤다고 믿거나, 자기를 해하려 한다고 잘못 믿고 있다.',
          				'헛것을 보거나 환청을 듣는다.',
          				'슬퍼 보이거나 기분이 처져 있으며 때로 울기도 한다.',
          				'밤에 자다가 일어나 주위 사람을 깨우거나 아침에 너무 일찍 일어난다. 또는 낮에는 지나치게 잠을 자고 밤에는 잠을 이루지 못한다.',
          				'주위사람이 도와주려 할 때 도와주는 것에 저항한다.',
          				'한군데 가만히 있지 못하고 서성거리거나 왔다 갔다 하며 안절부절 못한다.',
          				'길을 잃거나 헤맨 적이 있다. 외출하면 집이나 병원, 시설로 혼자 들어올 수 없다.',
          				'화를 내며 폭언이나 폭행을 하는 등 위협적인 행동을 보인다.',
          				'혼자서 밖으로 나가려고 해서 눈을 뗄 수가 없다.',
          				'물건을 망가뜨리거나 부순다.',
          				'의미 없거나 부적절한 행동을 자주 보인다.',
          				'돈이나 물건을 장롱같이 찾기 어려운 곳에 감춘다.',
          				'옷을 부적절하게 입는다.',
          				'대소변을 벽이나 옷에 바르는 등의 행위를 한다.',
          			];
          			
          			let behaviorTemplete = '<dt>최근 한 달간의 상황을 종합하여 아래 항목 중해당하는 모든 증상을 선택해 주세요.</dt>';
          			
          			//선택한 문항이 없는 경우
              		if (testResult.behaviorSelect.findIndex(select => select === 1) === -1) {
              			behaviorTemplete += '<dd>해당하는 증상이 없다.</dd>'
              		} else {
              			for (var i = 0; i < testResult.behaviorSelect.length; i++) {
                  			if (testResult.behaviorSelect[i]) {
                  				behaviorTemplete += '<dd>' + behaviorQuestion[i] + '</dd>';
                  			}
                  		}
              		}
              		
              		$('#behavior-select').html(behaviorTemplete);
          		}
          		
          		//간호처치
          		if (testResult && testResult.nurseSelect) {
          			const nurseQuestion = [
          				'<strong>기관지 절개관</strong><br>기관지를 절개하여 인공기도를 확보하는 간호',
              			'<strong>흡인</strong><br>카테터 등으로 인위적으로 분비물을 제거하여 기도유지',
              			'<strong>산소요법</strong><br>저산소증이나 저산소혈증을 치료, 감소 시키기 위해 산소공급장치를 통해 추가적인 산소 공급',
              			'<strong>욕창간호</strong><br>장기적인 고정체위로 인해 압박 부위의 피부와 하부조직 손상되어 지속적인 드레싱과 체위변경 처치',
              			'<strong>경관 영양</strong><br>구강으로 음식섭취가 어려워 관을 통해서 위, 십이지장 등에 직접 영양을 공급해야 하는 경우',
              			'<strong>암성통증</strong><br>암의 진행을 억제하지 못하여 극심한 통증에 발생',
              			'<strong>도뇨관리</strong><br>배뇨가 자율적으로 관리가 불가능하여 인위적으로 방광을 비우거나 관리',
              			'<strong>장루</strong><br>인공항문을 통해 체외로 대변을 배설 시킴으로 부착장치의 지속적인 관리',
              			'<strong>투석</strong><br>장기적인 신부전증으로 인해 혈액 투석이 필요한 경우',
              		];
              		
              		let nurseTemplete = '<dt>최근 2주간의 상황을 종합하여 필요하거나 제공 받고 있는 의료처리를 아래 항목 중 선택해 주세요.</dt>';
              		
              		//선택한 문항이 없는 경우
              		if (testResult.nurseSelect.findIndex(select => select === 1) === -1) {
              			nurseTemplete += '<dd>해당하는 증상이 없다.</dd>'
              		} else {
              			for (var i = 0; i < testResult.nurseSelect.length; i++) {
                  			if (testResult.nurseSelect[i]) {
                  				nurseTemplete += '<dd>' + nurseQuestion[i] + '</dd>';
                  			}
                  		}
              		}
              		
              		$('#nurse-select').html(nurseTemplete);
          		}
          		
          		//재활
          		if (testResult && testResult.rehabilitateSelect) {
          			$('#rehabilitate-select .result-answer dd').each(function (index, item) {
             			 if (index < 4) {
             				$(item).html(testResult.rehabilitateSelect[index] == 1 ? '운동장애 없음' :
       			   			  			 testResult.rehabilitateSelect[index] == 2 ? '불완전 운동장애' :
       			   			  			 testResult.rehabilitateSelect[index] == 3 ? '완전 운동장애' : '');
             			 } else {
             				$(item).html(testResult.rehabilitateSelect[index] == 1 ? '제한 없음' :
			   			  			 	 testResult.rehabilitateSelect[index] == 2 ? '한쪽관절 제한' :
			   			  			 	 testResult.rehabilitateSelect[index] == 3 ? '양쪽관절 제한' : '');
             			 }
             		});	
          		}
          		
          		//질병1
          		const diseaseQuestion = [
       				'치매',
       				'중풍(뇌졸증)',
       				'고혈압',
       				'당뇨병',
       				'관절염(퇴행성,류마티스)',
       				'요통,좌골통(디스크)',
       				'심부전,폐질환,천식 등',
       				'난청',
       				'백내장,녹내장',
       				'골절,탈골,사고 후유증',
       				'암',
       				'신부전',
       				'욕창',
           		];
          		if (testResult && testResult.diseaseSelect1) {
              		let diseaseTemplete = '<dt>현재 앓고 있는 질병 또는 증상을 모두 선택해 주세요.</dt>';
              		
              		for (var i = 0; i < testResult.diseaseSelect1.length; i++) {
              			if (testResult.diseaseSelect1[i]) {
              				diseaseTemplete += '<dd>' + diseaseQuestion[i] + '</dd>';
              			}
              		}
              		
              		$('#disease-select-1').html(diseaseTemplete);
          		}
          		//질병2
          		if (testResult && testResult.diseaseSelect2) {
              		let diseaseTemplete = '<dt>위에 선택한 질병 중,어르신의 현재 기능저하에 가장 직접적이고 중요한 원인이 되고 비중이 높은 항목 하나를 선택 하세요.</dt>';
              		
              		for (var i = 0; i < testResult.diseaseSelect2.length; i++) {
              			if (testResult.diseaseSelect2[i]) {
              				diseaseTemplete += '<dd>' + diseaseQuestion[i] + '</dd>';
              			}
              		}
              		
              		$('#disease-select-2').html(diseaseTemplete);
          		}
          		
          		
          		//등급에 따라서 버튼명 결정(다른 혜택 확인하기, 상담하기)
          		if (testResult.grade !== 0) {
          			$('#go-consult').text('1:1 상담하기');
          		} else if (testResult.grade === 0) {
          			$('.mainSend').css('display', 'none');
          		}
          	}
          	
          	//이메일 SELECT Event
          	$('#select-email').change(function() {
          		var emailBack = $('#select-email')[0].value;
          		$('#email-back')[0].value = emailBack;
          	});
          	
          	//이메일 전송 버튼 클릭
          	$('#sendEmailBtn').click(function() {
          		var emailFront = $('#email-front')[0].value;
          		var emailBack = $('#email-back')[0].value;
          		var email = emailFront + '@' + emailBack;
          		
          		if (!email || !emailFront || !emailBack || email.length < 3) {
          			alert('이메일을 입력하세요.');
          			return;
          		}
          		
          		var testData = JSON.parse(sessionStorage.getItem('testData'));
          		
          		$.ajax({
          			type: "post",
          			url: "/test/send/email.json",
          			data: {
          				email,
          				recipientsNo: testData.recipientsNo
          			},
          			dataType: 'json'
          		})
          		.done(function(res) {
          			if (res.success) {
          				alert('전송이 완료되었어요.');				
          				
          				$('#modal-email').modal('hide');
          				clickStartConsltBtn();
          			} else {
          				alert('다시 시도해주세요.');
          			}
          		})
          		.fail(function(data, status, err) {
          			alert('통신중 오류가 발생하였습니다.');
          		});
          	});
          	
          	//모달 닫기 버튼 클릭
          	$('#sendModalClose').click(function() {
          		$('#sendModal').fadeOut();
          	});
          	
          	
          	//다른 혜택 확인하기 또는 1:1 상담하기 버튼 클릭
          	$('#go-consult').click(function() {
          		//0등급인 경우 다른 혜택 확인하기
          		if (testResult.grade === 0) {
          			location.href="/main/searchBokji"
          			return;
          		}
          		
          		
          		const isCheckedEmail = $('#chk-email')[0].checked;
          		
          		//이메일 전송 폼 띄우기
          		if (isCheckedEmail) {
          			var email = '${mbrEml}';
          			if (email) {
          				const splitStr = email.split('@');
          				if (splitStr.length === 2) {
          					$('#email-front')[0].value = splitStr[0];
              				$('#email-back')[0].value = splitStr[1];
          				}
          			}
          			
          			$('.result-share').click();
          		} else {
          			clickStartConsltBtn();
          		}
          	});


            //연락처 형식 - 자동작성
	    	const telKeyInputRegex = /^(45|48|49|50|51|52|53|54|55|56|57|58|59)$/;
	    	$("#info-tel").keypress(function(e) {
	    		//숫자와 /만 입력받도록 추가
	    		if (!telKeyInputRegex.test(e.keyCode)) {
	    			return false;
	    		}
	    	});
	    	$("#info-tel").on("keydown",function(e){
	    		//백스페이스는 무시
	    		if (e.keyCode !== 8) {
	    			if($(this).val().length == 3){
	    				$(this).val($(this).val() + "-");
	    			}

	    			if($(this).val().length == 8){
	    				$(this).val($(this).val() + "-");
	    			}
	    			
	    			if($(this).val().length == 13){
	    				$(this).val($(this).val() + "-");
	    			}
	    		}
	    	});
	    	$("#info-tel").on("keyup",function(){
	    		if($(this).val().length > 13){
	    			$(this).val($(this).val().substr(0,13));
	    		}
	    	});
	    	
	    	
	    	//생년월일 형식 / 자동작성
	    	const brdtKeyInputRegex = /^(48|49|50|51|52|53|54|55|56|57|58|59|191)$/;
	    	$("#info-brdt").keypress(function(e) {
	    		//숫자와 /만 입력받도록 추가
	    		if (!brdtKeyInputRegex.test(e.keyCode)) {
	    			return false;
	    		}
	    	});
	    	$("#info-brdt").on("keydown",function(e){
	    		//백스페이스는 무시
	    		if (e.keyCode !== 8) {
	    			if($(this).val().length == 4){
	    				$(this).val($(this).val() + "/");
	    			}

	    			if($(this).val().length == 7){
	    				$(this).val($(this).val() + "/");
	    			}
	    		}
	    	});
	    	$("#info-brdt").on("keyup",function(){
	    		if($(this).val().length > 10){
	    			$(this).val($(this).val().substr(0,10));
	    		}
	    	});
        });
        
      	//테스트 다시하기 버튼 클릭
	   	function restartTest() {
	   		var testData = JSON.parse(sessionStorage.getItem('testData'));
	   		if (testData.isLogin) {
	   			location.href = '/test/physical?recipientsNo=' + testData.recipientsNo;	
	   		} else {
	   			location.href = '/test/physical';	   			
	   		}
	   	}
    </script>
</div>