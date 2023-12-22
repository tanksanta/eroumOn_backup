<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
		
		<!--1.수급자 등록-->
        <div class="modal modal-default fade" id="regist-rcpt" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title">수급자(어르신) 등록</h2>
                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                    </div>
                    <div class="additional">
                        <i class="icon-alert"></i>
                        <p>요양정보를 조회할 수급자(어르신)를 등록해 주세요</p>
                    </div>
                    <div class="modal-body">
                        <div class="radio-tabs-wrap" data-name="userType">
                            <div class="radio-tabs-button">
                                <label for="tab1" class="form-check-radio is-active">
                                    <input type="radio"  name="userType" value="tab1" id="tab1" class="form-check-input" checked/>
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
                                                <input type="text" name="no-rcpt-nm" id="no-rcpt-lno" placeholder="홍길동" class="form-control w-48">
                                                <span>님 은</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-index1"><span>홍길동 </span>님의</div>
                                            <div> 
                                                <select name="no-rcpt-relation" id="no-rcpt-relation" class="form-control w-48" required>
                                                    <option value="" disabled selected hidden>관계선택</option>
                                                    <option value="">부모</option>
                                                </select>
                                                <span>입니다</span>
                                            </div>
                                        </li>
                                        <li>
                                            <div class="text-index1">요양인정번호는</div>
                                            <div> 
                                                <label for="rcpt-lno" class="rcpt-lno">
                                                    <input type="text" name="no-rcpt-nm" id="rcpt-lno" placeholder="뒤의 숫자 10자리 입력" class="form-control w-48">
                                                </label>
                                                <span>입니다</span>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="tab tab2 hidden">
                                    <div class="flex flex-col gap-4">
                                        <div>
                                            <strong class="text-xl">홍길동</strong>
                                            <span>님의</span>
                                        </div>
                                        <div class="bg-white rounded-md p-5">
                                            <div class="text-index1 mb-2">요양인정번호는</div>
                                            <div>
                                                <label for="rcpt-lno" class="rcpt-lno">
                                                    <input type="text" name="no-rcpt-nm" id="rcpt-lno" placeholder="뒤의 숫자 10자리 입력" class="form-control input-lno">
                                                </label>
                                                <span>입니다</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2 disabled" disabled onclick="startLoginNoRcpt();">등록하기</button>
                    </div>
                </div>
            </div>
        </div>

        <!--2.수급자정보확인-->
        <div class="modal modal-default fade" id="rcpts-conform" tabindex="-1" aria-hidden="true">      
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title">수급자(어르신) 정보 확인</h2>
                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                    </div>
                    <div class="additional">
                        <i class="icon-alert"></i>
                        <p>수급자(어르신) 정보가 올바른지 확인 후 요양정보를 조회하세요</p>
                    </div>
                    <div class="modal-body">
                        <div class="bg-box-beige">
                            <ul class="modal-list-box">
                                <li>
                                    <span class="modal-list-label">가족 관계</span>
                                    <span class="modal-list-value">본인</span>
                                </li>
                                <li>
                                    <span class="modal-list-label">수급자(어르신) 성명</span>
                                    <span class="modal-list-value">홍길동홍길동홍길동홍</span>
                                </li>
                                <li>
                                    <span class="modal-list-label">요양인정번호</span>
                                    <span class="modal-list-value">L0011436322</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2">확인</button>
                    </div>
                </div>
            </div>
        </div>

        <!--3.수급자선택-->
        <div class="modal modal-default fade" id="rcpts-select" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
                <div class="modal-content">
                    <div class="modal-content-inner rcpts-select-content">
                        <div class="modal-header">
                            <h2 class="text-title">수급자(어르신) 선택</h2>
                            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                        </div>
                        <div class="additional-wrap">
                            <div class="additional">
                                <i class="icon-alert"></i>
                                <p> 수급자(어르신) 선택 후 요양정보를 조회하세요</p>
                            </div>
                            <div class="additional">
                                <i class="icon-alert"></i>
                                <p> 요양정보를 조회하려면 요양인정번호가 필요해요</p>
                            </div>
                        </div>
                        <div class="modal-body">
                            <div class="flex justify-end">
                                <a href="/membership/info/recipients/list" class="btn-black btn-small w-auto gap-1">수급자 관리 <i class="icon-arrow-right-white"></i></a>
                            </div>
                            <div class="radio-check-group">
                                <p class="text-base ml-2">요양정보 조회 가능</p><!--인정등급테스트에서는 삭제-->
                                <div  class="form-check">
                                    <input class="form-check-input" type="radio" name="rcpts" id="rcpt01">
                                    <label class="form-check-label check-btn" for="rcpt01">
                                        <div class="rcpt-inner">
                                            <div>
                                                <img src="/html/page/members/assets/images/img-senoir-mono.svg" alt="시니어얼굴" class="img-senior"/>
                                                <strong class="text-xl text-left">김영자김영자김영자김</strong>
                                            </div>
                                            <span>L0987654321</span>
                                        </div>
                                    </label>
                                </div>
                                <div  class="form-check">
                                    <input class="form-check-input" type="radio" name="rcpts" id="rcpt02">
                                    <label class="form-check-label check-btn" for="rcpt02">
                                        <div class="rcpt-inner">
                                            <div>
                                                <img src="/html/page/members/assets/images/img-senoir-mono.svg" alt="시니어얼굴" class="img-senior"/>
                                                <strong class="text-xl text-left">김영자</strong>
                                            </div>
                                            <span>L0987654321</span><!--인정등급테스트에서는 삭제-->
                                        </div>
                                    </label>
                                </div>
                                <!--시작: 인정등급테스트에서는 삭제-->
                                <p class="text-base ml-2">요양인정번호 등록 필요</p>
                                <div class="form-check add-lno">
                                    <input class="form-check-input" type="radio" name="rcpts" id="rcpt03">
                                    <label class="form-check-label" for="rcpt03">
                                        <div class="rcpt-inner">
                                            <div>
                                                <img src="/html/page/members/assets/images/img-senoir-mono.svg" alt="시니어얼굴" class="img-senior"/>
                                                <strong class="text-xl text-left">김영자김영자김영자김</strong>
                                            </div>
                                            <button  class="add-lno-btn">등록하기 <i class="icon-round-plus"></i></button>
                                        </div>
                                    </label>
                                </div>
                                <div class="form-check  add-lno">
                                    <input class="form-check-input" type="radio" name="rcpts" id="rcpt04">
                                    <label class="form-check-label" for="rcpt04">
                                        <div class="rcpt-inner">
                                            <div>
                                                <img src="/html/page/members/assets/images/img-senoir-mono.svg" alt="시니어얼굴" class="img-senior"/>
                                                <strong class="text-xl text-left">김영자</strong>
                                            </div>
                                            <button class="add-lno-btn">등록하기 <i class="icon-round-plus"></i></button>
                                        </div>
                                    </label>
                                </div>
                                <!--끝: 인정등급테스트에서는 삭제-->
    
                                <button id="add-rcpts" class="btn btn-dotted-warning btn-xlarge">추가등록 <i class="icon-round-plus"></i></button>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2">요양정보 조회하기</button>
                        </div>
                    </div>
                    <!--추가등록-->
                    <div class="modal-content-inner regist-rcpts">
                        <div class="modal-header">
                            <div class="flex items-center gap-4">
                                <button class="rcpts-back"><i class="icon-arrow-left size-md"></i></button>
                                <h2 class="text-title">수급자(어르신) 추가 등록</h2>
                            </div>
                            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                        </div>
                        <div class="additional">
                            <i class="icon-alert"></i>
                            <p>요양정보를 조회할 수급자(어르신)를 등록해 주세요</p>
                        </div>
                        <div class="modal-body">
                            
                            <div class="radio-tabs-wrap" data-name="userTypeB">
                                <div class="radio-tabs-button">
                                    <label for="tabB1" class="form-check-radio is-active">
                                        <input type="radio" name="userTypeB" value="tabB1" id="tabB1" class="form-check-input" checked/>
                                        <span>가족,친척</span>
                                    </label>
                                    <label for="tabB2" class="form-check-radio">
                                        <input type="radio" name="userTypeB" value="tabB2" id="tabB2" class="form-check-input"/>
                                        <span>본인</span>
                                    </label>
                                </div>
                                <div class="radio-tabs-content">
                                    <div class="tab tabB1">
                                        <ul class="tab-inner">
                                            <li>
                                                <div class="text-index1">수급자(어르신)</div>
                                                <div>
                                                    <input type="text" name="no-rcpt-nm" id="no-rcpt-lno" placeholder="홍길동홍길동홍길동홍" class="form-control w-48">
                                                    <span>님 은</span>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="text-index1"><span>홍길동</span>님의</div>
                                                <div> 
                                                    <select name="no-rcpt-relation" id="no-rcpt-relation" class="form-control w-48" required>
                                                        <option value="" disabled selected hidden>관계선택</option>
                                                        <option value="">부모</option>
                                                    </select>
                                                    <span>입니다</span>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="text-index1">요양인정번호는</div>
                                                <div> 
                                                    <label for="rcpt-lno" class="rcpt-lno">
                                                        <input type="text" name="no-rcpt-nm" id="rcpt-lno" placeholder="뒤의 숫자 10자리 입력" class="form-control  w-48">
                                                    </label>
                                                    <span>입니다</span>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="tab tabB2 hidden">
                                        <div class="flex flex-col gap-4">
                                            <div>
                                                <strong class="text-xl">홍길동</strong><span>님의</span>
                                            </div>
                                            <div class="bg-white rounded-md p-5">
                                                <div class="text-index1 mb-2">요양인정번호는</div>
                                                <div>
                                                    <label for="rcpt-lno" class="rcpt-lno">
                                                        <input type="text" name="no-rcpt-nm" id="rcpt-lno" placeholder="뒤의 숫자 10자리 입력" class="form-control input-lno">
                                                    </label>
                                                    <span>입니다</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn-outline-black large2 rcpts-back">이전으로</button>
                            <button type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2" onclick="startLoginNoRcpt();">등록하기</button>
                        </div>
                    </div>
                    <!--요양정보등록-->
                    <div class="modal-content-inner regist-lno">
                        <div class="modal-header">
                            <div class="flex items-center gap-4">
                                <button class="rcpts-back"><i class="icon-arrow-left size-md"></i></button>
                                <h2 class="text-title">요양인정번호 등록</h2>
                            </div>
                            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                        </div>
                        <div class="additional">
                            <i class="icon-alert"></i>
                            <p>수급자(어르신)의 요양인정번호를 등록해 주세요</p>
                        </div>
                        <div class="modal-body">
                            
                            <div class="radio-tabs-wrap" data-name="userType">
                                <div class="radio-tabs-content">
                                    <div class="">
                                        <div class="flex flex-col gap-4">
                                            <div>
                                                <strong class="text-xl">홍길동</strong><span>님의</span>
                                            </div>
                                            <div class="bg-white rounded-md p-5">
                                                <div class="text-index1 mb-2">요양인정번호는</div>
                                                <div>
                                                    <label for="rcpt-lno" class="rcpt-lno">
                                                        <input type="text" name="no-rcpt-nm" id="rcpt-lno" placeholder="뒤의 숫자 10자리 입력" class="form-control input-lno">
                                                    </label>
                                                    <span>입니다</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <p class="text-center font-medium mt-8 mb-2">정보가 잘못되었나요?</p>
                                <div class="text-center">
                                    <a href="/membership/info/recipients/list" class="text-path-box">마이페이지 &gt; 수급자관리</a>
                                    <span>에서 수정할 수 있어요</span>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn-outline-black large2 rcpts-back">이전으로</button>
                            <button type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2" onclick="startLoginNoRcpt();">인정번호 등록하기</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!--4.수급자등록알림-->
        <div class="modal modal-default fade" id="modal4" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title">알림</h2>
                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="bg-box-beige">
                            <div class="text-center text-xl">
                                진행중인 요양정보 상담이 있습니다. <br>
                                상담 내역을 확인하시겠습니까?
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer gap-1">
                        <button type="button" class="btn-warning large2 w-full md:w-1/2" data-bs-dismiss="modal" class="btn-close">상담내역 확인하기</button>
                    </div>
                </div>
            </div>
        </div>

        <!--5.상담신청완료-->
        <div class="modal modal-default fade" id="modal5" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
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
                    <a href="#" class="btn-warning large2 flex-1 md:flex-none md:w-1/2">신청내역 보러가기</a>
                </div>
                </div>
            </div>
        </div>
        
        <!--6.수급자등록알림-->
        <div class="modal modal-default fade" id="modal6" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title">수급자(어르신) 등록</h2>
                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <div class="bg-box-beige flex flex-col gap-6 md:gap-5">
                            <div class="flex items-start gap-2 text-lg md:whitespace-nowrap">
                                <img src="/html/page/members/assets/images/img-senoir-mono.svg" alt="시니어얼굴" class="w-5 mt-1.5"/>
                                
                                <div class="flex flex-wrap items-center gap-1">
                                    <span>수급자(어르신)</span>
                                    <strong class="text-indexKey1">이영수</strong>
                                    <span>님은</span>
                                    <strong>이로움이</strong>
                                    <span>님의</span>
                                    <strong>친척</strong>
                                    <span>입니다</span>
                                </div>
                            </div>
                            <div class="flex items-start gap-2 text-lg md:whitespace-nowrap">
                                <img src="/html/page/members/assets/images/img-nhis.svg" alt="국민건강보험 심볼" class="w-5 mt-1"/>
                                <div class="flex flex-wrap items-center gap-1">
                                    <div class="mr-1">요양인정번호는</div>
                                    <strong class="text-indexKey1">L1904014349</strong><span>입니다</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn large2 btn-outline-black">취소하기</button>
                        <button type="button" class="btn-warning large2 flex-1 md:flex-none md:w-1/2">상담신청하기</button>
                    </div>
                </div>
            </div>
        </div>

        <!-- 7.등록된 수급자가 없을 때 -->
        <div class="modal modal-default fade" id="modal7" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="text-title">요양인정번호 유무</h2>
                        <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
                    </div>
                    <div class="additional-wrap">
                        <div class="additional">
                            <i class="icon-alert"></i>
                            <p>요양인정등급을 받으신 경우 ‘있어요' 를 선택해 주세요</p>
                        </div>
                        <div class="additional">
                            <i class="icon-alert"></i>
                            <p>요양인정등급이 없어도 상담이 가능해요</p>
                        </div>
                    </div>

                    <div class="modal-body">

                        <div class="radio-check-group">
                            <div  class="form-check">
                                <input class="form-check-input" type="radio" name="rcpts-yn" id="rcpts-yn1">
                                <label class="form-check-label" for="rcpts-yn1">
                                    <span class="mx-auto">있어요</span>
                                </label>
                            </div>
                            <div  class="form-check">
                                <input class="form-check-input" type="radio" name="rcpts-yn" id="rcpts-yn2">
                                <label class="form-check-label" for="rcpts-yn2">
                                    <span class="mx-auto">없어요</span>
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="rcpts-yn" id="rcpts-yn3">
                                <label class="form-check-label" for="rcpts-yn3">
                                    <span class="mx-auto">기억이 안나요</span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- 예상치 못한 오류 팝업 -->
        <div class="modal modal-default fade" id="modalError" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered ">
                <div class="modal-content">
                    <div class="modal-header">
                    </div>
                    <div class="modal-body md:min-w-[26rem]">
                        <!-- 예상치 못한 오류로 결과를 확인할 수 없는 상황에 호출되는 모달(팝업) -->
                        <div class="flex flex-col items-center text-xl">
                            <i class="ico-alert orange mb-8"></i>
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

		
        
        <script src="../../../core/vendor/twelements/index.min.js"></script>
	    <script>
	
	        $(function () {
	            //수급자 등록, 요양정보 등록 팝업 div높이 구하기
	            $('#rcpts-select').on('shown.bs.modal', function () {
	                var modalContentHeight = $('.modal-content-inner').outerHeight();
	                var modalHeaderHeight = $('.modal-content-inner .modal-header').outerHeight();
	                var modalFooterHeight = $('.modal-content-inner .modal-footer').outerHeight();
	                var additionalHeight = $('.modal-content-inner .additional-wrap').outerHeight();
	                var maxModalHeight = $(window).height() - (modalHeaderHeight + modalFooterHeight + additionalHeight) - 80;
	                $('.modal-body').css('max-height', maxModalHeight + 'px');
	            });
	
	            //수급자 등록, 요양정보 등록
	            $('#add-rcpts').click(function () {
	                $('.regist-rcpts').removeClass('inactive').addClass('active');
	                $('.rcpts-select-content').removeClass('active').addClass('inactive');
	                $('.regist-lno').removeClass('active').addClass('inactive');
	            });
	
	            $('.rcpts-back').click(function () {
	                $('.regist-rcpts, .regist-lno').removeClass('active').addClass('inactive');
	                $('.rcpts-select-content').removeClass('inactive').addClass('active');
	            });
	
	            $('.add-lno').click(function () {
	                $('.regist-rcpts, .rcpts-select-content').removeClass('active').addClass('inactive');
	                $('.regist-lno').removeClass('inactive').addClass('active');
	            });
	
	            //수급자 등록 라디오버튼 탭 컨텐츠
	            function tabCheckEvent(name, css) {
	                const tabWrap = $('.radio-tabs-wrap[data-name="'+ name+'"]');
	                tabWrap.on('change', ':radio', function() {
	                    if ($(this).attr('name') !== name) return;
	
	                    const tabToShow = tabWrap.find('.tab.'+ $(this).val());
	                    const tabs = tabWrap.find('.tab.'+css);
	                    tabs.addClass('hidden');
	                    tabToShow.removeClass('hidden');
	
	                    const labels = tabWrap.find('label');
	                    labels.removeClass('is-active');
	                    $(this).closest('label').addClass('is-active');
	                });
	            }
	
	            tabCheckEvent('userType', 'tab');
	            tabCheckEvent('userTypeB', 'tab');
	        });
	    </script>
        
        
        <script>
	        var sr_mbrNm = null;
	    	var sr_recipients = null;
	    	var sr_prevPath = ''; 
        
        	function openSelectRecipientModal(prevPath) {
        		sr_prevPath = prevPath;
        		
        		$.ajax({
            		type : "post",
    				url  : "/membership/info/myinfo/getMbrInfo.json",
    				dataType : 'json'
            	})
            	.done(function(data) {
            		//로그인 한 경우
            		if (data.isLogin) {
            			//ajax 받아온 데이터 저장
            			sr_mbrNm = data.mbrVO.mbrNm;
            			sr_recipients = data.mbrRecipients;
            			
            			modalSelectRecipient();
            		}
            		//로그인 안한 경우
            		else {
            			//테스트는 로그인 안할 때 띄우는 폼이 따로 있어 실제 실행은 안된다.
            			if (sr_prevPath === 'test') {
            				location.href='/membership/login?returnUrl=/main/cntnts/test';	
            			}
            		}
            	})
            	.fail(function(data, status, err) {
            		alert('서버와 연결이 좋지 않습니다.');
    			});
        	}
        	
        	function modalSelectRecipient() {
        		//등록된 수급자가 없는 경우
        		if (!sr_recipients || sr_recipients.length === 0) {
        			$('#regist-rcpt').modal('show');
        		}
        		//회원에 등록된 수급자가 있는 경우
        		else {
        			
        			
        			//추가 등록은 4명 미만인 경우 가능
        		}
        	}
        </script>