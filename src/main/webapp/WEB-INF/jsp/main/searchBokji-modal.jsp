<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!--모달: 어르신용품(복지용구) 구매비 지원-->
<div class="modal modal-index fade " id="pop-welfare-1" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl">
        <div class="modal-content">
        <div class="modal-header">
            <h4 class="text-header-title">어르신 복지 서비스</h4>
            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
        </div>
        <hr class="divide-x-1 mt-5"/>
        <div class="modal-body">
            <div class="flex flex-col gap-8 items-start">
                <h3 class="text-body-title">어르신용품(복지용구) <span class="text-indexKey1 text-normal">구매비 지원</span></h3>
                <div class="">
                    <p class="text-xl">신체활동이 불편하신 어르신이라면, <strong>어르신용품을 신청하세요.</strong></p>
                    <p><span class="font-semibold">[국민건강보험]</span>에서 어르신의 편안한 일상생활을 돕도록 <span class="font-semibold underline underline-offset-1">용품 구매비를 지원합니다.</span></p>
                </div>
                <div class="beige-card-wrap">
                    <h4 class="font-medium">지원내용 및 자격요건</h4>
                    <ul class="check-lists">
                        <li><span class="font-semibold">장기요양인정등급</span>을 받으셔야 신청 가능</li>
                        <li>거동, 생활 보조용품(복지용구) <span class="text-indexKey1 font-semibold">지원금 연 160만원</span></li>
                        <li>전동침대부터 요실금팬티까지 대부분 <span class="font-semibold">생활용품 지원</span></li>
                    </ul>
                </div>
                <div class="flex flex-col w-full">
                    <div class="text-subtitle pb-1 border-b border-gray-300">
                        <i class="icon-alert"></i>
                        <p class="font-medium">숙지사항</p>
                    </div>
                    <ul class="circle-lists">
                        <li>복지용구 구매시 6~15%의 본인부담금이 발생합니다. (단, 기초생활수급자는 전액 지원)</li>
                        <li>시설에 모시는 어르신은 복지용구를 신청할 수 없어요.</li>
                        <li>복지용구 구매비 지원을 받기 위한 절차가 간단하지 않아 국민건강보험공단에 먼저 상담 후 신청을 권장합니다.</li>
                    </ul>
                </div>
                <div class="welfare-contact">
                    <p>주관처 : 국민건강보험공단 (<strong>1577-1000</strong>, 발신자 부담)  </p>
                    <div>
                        <a href="https://www.longtermcare.or.kr/npbs/e/g/550/openCyberCstMain.web?menuId=npe0000000460" target="_blank" class="btn btn-outline-primary2 btn-small mr-auto"><strong>문의처 바로가기</strong></a>
                        <a href="tel:1577-1000" class="md:hidden btn btn-primary3 btn-small"><i class="icon-tel"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer flex-col md:flex-row gap-1 mt-6">
            <a href="/main/cntnts/test" target="_blank"  class="btn btn-primary2 btn-arrow btn-center large w-full md:w-2/5"><strong>내 인정등급 확인하기</strong></a>
            <a href="/main/welfare/equip/sub" target="_blank"  class="btn btn-primary3 btn-arrow btn-center large w-full md:w-2/5"><strong>관심 복지용구 상담하기</strong></a>
        </div>
        </div>
    </div>
</div>

<!--모달: 요양시설 입소(시설급여) 이용비 지원-->
<div class="modal modal-index fade" id="pop-welfare-2" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
        <div class="modal-header">
            <h4 class="text-header-title">어르신 복지 서비스</h4>
            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
        </div>
        <hr class="divide-x-1 mt-5"/>
        <div class="modal-body">
            <div class="flex flex-col gap-8 items-start">
                <h3 class="text-body-title">요양시설 입소(시설급여) <span class="text-indexKey1 text-normal">이용비 지원</span></h3>
                <div class="">
                    <p class="text-xl">집에서 생활이 어려운 어르신이라면, <strong>요양 전문 시설 입소를 신청하세요.</strong></p>
                    <p><span class="font-semibold">[국민건강보험]</span>에서 어르신의 삶을 위해 <span class="font-semibold underline underline-offset-1">요양 시설 입소 비용을 지원합니다.</span></p>
                </div>
                <div class="beige-card-wrap">
                    <h4 class="font-medium">지원내용 및 자격요건</h4>
                    <ul class="check-lists">
                        <li><span class="font-semibold">장기요양인정등급 1, 2등급</span> 판정을 받으셔야 신청 가능</li>
                        <li>시설 입소에 따른 지원금 <span class="text-indexKey1 font-semibold">최대 연 2,438만원(월 206만원)</span></li>
                    </ul>
                </div>
                <div class="flex flex-col w-full">
                    <div class="text-subtitle w-full pb-1 border-b border-gray-300">
                        <i class="icon-alert"></i>
                        <p class="font-medium">숙지사항</p>
                    </div>
                    <ul class="circle-lists">
                        <li>장기요양인정등급 3~5등급 어르신도 조건에 부합하면, 방문요양보호사 요청 대신 요양 시설에 모실 수 있습니다.</li>
                        <li>등급외 판정의 경우 시설이나 재가, 복지용구 이용이 안됩니다.</li>
                        <li>시설 이용비 지원을 받기 위한 절차가 간단하지 않아 국민건강보험공단에 먼저 상담을 진행하시길 권장합니다.</li>
                    </ul>
                </div>
                <div class="welfare-contact">
                    <p>주관처 : 국민건강보험공단 (<strong>1577-1000</strong>, 발신자 부담)  </p>
                    <div>
                        <a href="https://www.longtermcare.or.kr/npbs/e/g/550/openCyberCstMain.web?menuId=npe0000000460" target="_blank" class="btn btn-outline-primary2 btn-small mr-auto"><strong>문의처 바로가기</strong></a>
                        <a href="tel:1577-1000" class="md:hidden btn btn-primary3 btn-small"><i class="icon-tel"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer gap-1 mt-6">
           <a href="/main/cntnts/test" target="_blank"  class="btn btn-primary2 btn-arrow btn-center large w-full md:w-1/2"><strong>내 인정등급 확인하기</strong></a>
        </div>
        </div>
    </div>
</div>

<!--모달: 가정방문(재가급여) 이용비 지원-->
<div class="modal modal-index fade" id="pop-welfare-3" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
        <div class="modal-header">
            <h4 class="text-header-title">어르신 복지 서비스</h4>
            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
        </div>
        <hr class="divide-x-1 mt-5"/>
        <div class="modal-body">
            <div class="flex flex-col gap-8 items-start">
                <h3 class="text-body-title">가정방문(재가급여) <span class="text-indexKey1 text-normal">이용비 지원</span></h3>
                <div class="">
                    <p class="text-xl">일상생활에서 부분적인 도움이 필요한 어르신이라면, <br>
						<strong>전문요원의 도움을 받을 수 있는 방문요양과 주야간보호 서비스를 신청하세요.</strong>
					</p>
                    <p><span class="font-semibold">[국민건강보험]</span>에서 어르신의 원활한 생활이 가능하도록 <span class="font-semibold underline underline-offset-1">재가 서비스 비용을 지원합니다.</span></p>
                </div>
                <div class="beige-card-wrap">
                    <h4 class="font-medium">지원내용 및 자격요건</h4>
                    <ul class="check-lists">
                        <li><span class="font-semibold">장기요양인정등급 3, 4, 5등급 </span>판정을 받으셔야 신청 가능</li>
                        <li>재가 이용에 따른 지원금 <span class="text-indexKey1 font-semibold">최대 연 1,746만원(월 145만원)</span></li>
                        <li><span class="font-semibold">방문</span>(방문요양, 방문간호, 방문목욕)과 <span class="font-semibold">주야간보호</span> 서비스 이용 가능 </li>
                    </ul>
                </div>
                <div class="flex flex-col w-full">
                    <div class="text-subtitle w-full pb-1 border-b border-gray-300">
                        <i class="icon-alert"></i>
                        <p class="font-medium">숙지사항</p>
                    </div>
                    <ul class="circle-lists">
                        <li>인지지원등급 판정을 받으신 어르신의 경우에는 주야간보호만 이용 하실 수 있습니다.</li>
                        <li>재가 이용비 서비스 지원을 받기 위한 절차가 간단하지 않아 국민건강보험공단에 먼저 상담을 진행하시길 권장합니다.</li>
                    </ul>
                </div>
                <div class="welfare-contact">
                    <p>주관처 : 국민건강보험공단 (<strong>1577-1000</strong>, 발신자 부담)  </p>
                    <div>
                        <a href="https://www.longtermcare.or.kr/npbs/e/g/550/openCyberCstMain.web?menuId=npe0000000460" target="_blank" class="btn btn-outline-primary2 btn-small mr-auto"><strong>문의처 바로가기</strong></a>
                        <a href="tel:1577-1000" class="md:hidden btn btn-primary3 btn-small"><i class="icon-tel"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-footer gap-1 mt-6">
            <a href="/main/cntnts/test" target="_blank"  class="btn btn-primary2 btn-arrow btn-center large w-full md:w-1/2"><strong>내 인정등급 확인하기</strong></a>
        </div>
        </div>
    </div>
</div>

<!--모달: 보청기 구매비 지원-->
<div class="modal modal-index fade" id="pop-welfare-4" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
	        <div class="modal-header">
	            <h4 class="text-header-title">어르신 복지 서비스</h4>
	            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	        </div>
	        <hr class="divide-x-1 mt-5"/>
	        <div class="modal-body">
	            <div class="flex flex-col gap-8 items-start">
	                <h3 class="text-body-title">보청기 <span class="text-indexKey1 text-normal">구매비 지원</span></h3>
	                <div class="">
	                    <p class="text-xl">청력에 문제가 있으신 어르신이라면, <strong>보청기 바로 신청하세요.</strong></p>
	                    <p><span class="font-semibold">[국민건강보험]</span>에서 어르신의 <span class="font-semibold underline underline-offset-1">청력 건강을 챙겨드립니다.</span></p>
	                </div>
	                <div class="beige-card-wrap">
	                    <h4 class="font-medium">지원내용 및 자격요건</h4>
	                    <ul class="check-lists">
	                        <li><span class="font-semibold">청각 장애인으로 등록 </span>되어 있어야 지원금 신청 가능 <span class="font-semibold">(나이 무관)</span></li>
	                        <li>청각장애인 정부 지원금 <span class="text-indexKey1 font-semibold">최대 131만원</span></li>
	                        <li>보건복지부에 고시된 제품에 한해 <span class="font-semibold">5년에 1회 한정, 보청기 1대 지원</span></li>
	                    </ul>
	                </div>
	                <div class="flex flex-col w-full">
	                    <div class="text-subtitle w-full pb-1 border-b border-gray-300">
	                        <i class="icon-alert"></i>
	                        <p class="font-medium">숙지사항</p>
	                    </div>
	                    <ul class="circle-lists">
	                        <li>이비인후과에 방문하셔서 청각장애 진단을 받으셔야 합니다. (전화로 진단 가능 병원인지 먼저 확인하세요.)</li>
	                        <li>보청기 지원금을 받기 위한 절차가 간단하지 않아 거주시 읍,면 주민선터에서 먼저 상담 후 구매 신청을 권장합니다.</li>
	                    </ul>
	                </div>
	                <div class="welfare-contact">
	                    <div>
	                        <p>주관처 : 국민건강보험공단 (<strong>1577-1000</strong>, 발신자 부담)  </p>
	                        <p>신청 문의 : 주민센터 또는 보건소 </p>
	                    </div>
	                    <div>
	                        <a href="https://map.naver.com/p/search/주민센터?c=15.00,0,0,0,dh" target="_blank" class="btn btn-outline-primary2 btn-small mr-auto"><strong>문의처 바로가기</strong></a>
	                        <a href="tel:1577-1000" class="md:hidden btn btn-primary3 btn-small"><i class="icon-tel"></i></a>
	                    </div>
	                </div>
	            </div>
	        </div>
        </div>
    </div>
</div>

<!--모달: 임플란트 비용 지원-->
<div class="modal modal-index fade" id="pop-welfare-5" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
	        <div class="modal-header">
	            <h4 class="text-header-title">어르신 복지 서비스</h4>
	            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	        </div>
	        <hr class="divide-x-1 mt-5"/>
	        <div class="modal-body">
	            <div class="flex flex-col gap-8 items-start">
	                <h3 class="text-body-title">임플란트 <span class="text-indexKey1 text-normal">비용 지원</span></h3>
	                <div class="">
	                    <p class="text-xl">치아가 빠진 어르신이라면, <strong>임플란트 바로 신청하세요.</strong></p>
	                    <p><span class="font-semibold">[보건복지부]</span>어르신의 치아 치료 지원으로 <span class="font-semibold underline underline-offset-1">맛있는 인생을 지원합니다.</span></p>
	                </div>
	                <div class="beige-card-wrap">
	                    <h4 class="font-medium">지원내용 및 자격요건</h4>
	                    <ul class="check-lists">
	                        <li><span class="font-semibold">치과에서 진료</span>를 통해 지원 대상자 판정 <span class="font-semibold">(만 65세 이상)</span></li>
	                        <li><span class="font-semibold">1인 기준,</span> <span class="text-indexKey1 font-semibold">평생 2개 지원</span></li>
	                    </ul>
	                </div>
	                <div class="flex flex-col w-full">
	                    <div class="text-subtitle w-full pb-1 border-b border-gray-300">
	                        <i class="icon-alert"></i>
	                        <p class="font-medium">숙지사항</p>
	                    </div>
	                    <ul class="circle-lists">
	                        <li>본인부담금은 급여비용총액의 1종 수급권자는 10%, 2종 수급권자는 20%입니다.</li>
	                        <li>가까운 치과에 방문하셔서 문의 상담하시면 정확한 시술 범위와 지원금을 안내 받을 수 있습니다.</li>
	                    </ul>
	                </div>
	                <div class="welfare-contact">
	                    <div>
	                        <p>주관처 : 건강보험심사평가원 (<strong>1644-2000</strong>),보건복지부 (<strong>129</strong>) </p>
	                        <p>문의처: 치과 병.의원</p>
	                    </div>
	                    <div>
	                        <a href="https://map.naver.com/p/search/치과?c=14.00,0,0,0,dh" target="_blank" class="btn btn-outline-primary2 btn-small mr-auto"><strong>문의처 바로가기</strong></a>
	                        <a href="tel:1577-1000" class="md:hidden btn btn-primary3 btn-small"><i class="icon-tel"></i></a>
	                    </div>
	                </div>
	            </div>
	        </div>
        </div>
    </div>
</div>

<!--모달: 틀니 비용 지원-->
<div class="modal modal-index fade" id="pop-welfare-6" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
	        <div class="modal-header">
	            <h4 class="text-header-title">어르신 복지 서비스</h4>
	            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	        </div>
	        <hr class="divide-x-1 mt-5"/>
	        <div class="modal-body">
	            <div class="flex flex-col gap-8 items-start">
	                <h3 class="text-body-title">틀니 <span class="text-indexKey1 text-normal">비용 지원</span></h3>
	                <div class="">
	                    <p class="text-xl">치아가 거의 없는 어르신이라면, <strong>틀니 제작비 지원을 바로 신청하세요.</strong></p>
	                    <p><span class="font-semibold">[보건복지부]</span>에서 어르신의 치아 치료 지원으로 <span class="font-semibold underline underline-offset-1">맛있는 인생을 지원합니다.</span></p>
	                </div>
	                <div class="beige-card-wrap">
	                    <h4 class="font-medium">지원내용 및 자격요건</h4>
	                    <ul class="check-lists">
	                        <li><span class="font-semibold">치과에서 진료</span>를 통해 지원 대상자 판정 <span class="font-semibold">(만 65세 이상)</span></li>
	                        <li><span class="font-semibold">완전틀니, 부분틀니 </span> <span class="text-indexKey1 font-semibold">7년에 1회 지원</span></li>
	                    </ul>
	                </div>
	                <div class="flex flex-col w-full">
	                    <div class="text-subtitle w-full pb-1 border-b border-gray-300">
	                        <i class="icon-alert"></i>
	                        <p class="font-medium">숙지사항</p>
	                    </div>
	                    <ul class="circle-lists">
	                        <li>본인부담금은 급여비용총액의 1종 수급권자는 5%, 2종 수급권자는 15%입니다.</li>
	                        <li>가까운 치과에 방문하셔서 문의 상담하시면 정확한 시술 범위와 지원금을 안내 받을 수 있습니다.</li>
	                    </ul>
	                </div>
	                <div class="welfare-contact">
	                    <div>
	                        <p>주관처 : 건강보험심사평가원 (<strong>1644-2000</strong>),보건복지부 (<strong>129</strong>) </p>
	                        <p>문의처 : 치과 병.의원</p>
	                    </div>
	                    <div>
	                        <a href="https://map.naver.com/p/search/치과?c=14.00,0,0,0,dh" class="btn btn-outline-primary2 btn-small mr-auto"><strong>문의처 바로가기</strong></a>
	                        <a href="tel:1577-1000" class="md:hidden btn btn-primary3 btn-small"><i class="icon-tel"></i></a>
	                    </div>
	                </div>
	            </div>
	        </div>
        </div>
    </div>
</div>

<!--모달: 인공관절 수술비 지원-->
<div class="modal modal-index fade" id="pop-welfare-7" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
	        <div class="modal-header">
	            <h4 class="text-header-title">어르신 복지 서비스</h4>
	            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	        </div>
	        <hr class="divide-x-1 mt-5"/>
	        <div class="modal-body">
	            <div class="flex flex-col gap-8 items-start">
	                <h3 class="text-body-title">인공관절 <span class="text-indexKey1 text-normal">수술비 지원</span></h3>
	                <div class="">
	                    <p class="text-xl">무릎관절에 문제가 있으신 어르신이라면, <strong>인공관절 수술비 지원을 신청하세요.</strong></p>
	                    <p><span class="font-semibold">[노인의료나눔재단]</span>에서 어르신의 <span class="font-semibold underline underline-offset-1">무릎관절 건강을 지원합니다.</span></p>
	                </div>
	                <div class="beige-card-wrap">
	                    <h4 class="font-medium">지원내용 및 자격요건</h4>
	                    <ul class="check-lists">
	                        <li><span class="font-semibold">‘인공관절치환술(슬관절)’ </span>이 필요한 저소득층 어르신<span class="font-semibold">(만 60세 이상)</span></li>
	                        <li><span class="font-semibold">한쪽 무릎 기준, </span> <span class="text-indexKey1 font-semibold">지원금 120만원 한도 실비 지원</span></li>
	                    </ul>
	                </div>
	                <div class="flex flex-col w-full">
	                    <div class="text-subtitle w-full pb-1 border-b border-gray-300">
	                        <i class="icon-alert"></i>
	                        <p class="font-medium">숙지사항</p>
	                    </div>  
	                    <ul class="circle-lists">
	                        <li>반드시 병원 진단서가 필요합니다.</li>
	                        <li>해당 수술비를 제외한 검사비, 간병비, 입원비 등은 지원되지 않습니다.</li>
	                        <li>기초생활수급자 및 차상위계층 또는 한부모가족지원법에 따른 지원 대상자에 한하여 지원합니다.</li>
	                        <li>인공관절 수술비 지원금을 받기 위해 가까운 주민센터 또는 보건소에 상담 후 진행을 권장합니다.</li>
	                    </ul>
	                </div>
	                <div class="welfare-contact">
	                    <div>
	                        <p>주관처 : 노인의료나눔재단 (<strong>02-711-6599</strong>)</p>
	                        <p>문의처 : 주민센터, 보건소</p>
	                    </div>
	                    <div>
	                        <a href="https://map.naver.com/p/search/보건소?c=13.00,0,0,0,dh" target="_blank" class="btn btn-outline-primary2 btn-small mr-auto"><strong>문의처 바로가기</strong></a>
	                        <a href="tel:1577-1000" class="md:hidden btn btn-primary3 btn-small"><i class="icon-tel"></i></a>
	                    </div>
	                </div>
	            </div>
	        </div>
        </div>
    </div>
</div>

<!--모달: 노안 개안 수술비 지원-->
<div class="modal modal-index fade" id="pop-welfare-8" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
	        <div class="modal-header">
	            <h4 class="text-header-title">어르신 복지 서비스</h4>
	            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	        </div>
	        <hr class="divide-x-1 mt-5"/>
	        <div class="modal-body">
	            <div class="flex flex-col gap-8 items-start">
	                <h3 class="text-body-title">노인 개안 <span class="text-indexKey1 text-normal">수술비 지원</span></h3>
	                <div class="">
	                    <p class="text-xl">눈에 문제가 있으신 어르신이라면, <strong>안검진 및 개안수술비 지원을 신청하세요.</strong></p>
	                    <p><span class="font-semibold">[보건복지부]</span>에서 어르신의 <span class="font-semibold underline underline-offset-1">눈 건강을 지원합니다.</span></p>
	                </div>
	                <div class="beige-card-wrap">
	                    <h4 class="font-medium">지원내용 및 자격요건</h4>
	                    <ul class="check-lists">
	                        <li><span class="font-semibold">백내장, 망막질환, 녹내장 </span>등 안질환 수술이 필요한 어르신 <span class="font-semibold">(만 60세 이상)</span></li>
	                        <li><span class="font-semibold">저소득층</span>을 우선 지원</li>
	                        <li>1안 당 본인 부담 수술비 및 사전 검사비 <span class="font-semibold">전액 1회 지원</span></li>
	                    </ul>
	                </div>
	                <div class="flex flex-col w-full">
	                    <div class="text-subtitle w-full pb-1 border-b border-gray-300">
	                        <i class="icon-alert"></i>
	                        <p class="font-medium">숙지사항</p>
	                    </div>  
	                    <ul class="circle-lists">
	                        <li>해당 수술비외 검사비를 제외한 간병비, 입원비 등은 지원되지 않습니다.</li>
	                        <li>기초생활수급자 및 차상위계층 또는 한부모가족지원법에 따른 지원 대상자에게 우선 지원합니다.</li>
	                        <li>노인 개안 수술비 지원금을 받기 위해 가까운 주민센터 또는 보건소에 상담 후 진행을 권장합니다.</li>
	                    </ul>
	                </div>
	                <div class="welfare-contact">
	                    <div>
	                        <p>주관처 : 한국실명예방재단 (<strong>20-718-110</strong>), 보건복지부 (<strong>129</strong>)</p>
	                        <p>문의처 : 보건소, 안과 병.의원</p>
	                    </div>
	                    <div>
	                        <a href="https://map.naver.com/p/search/보건소?c=13.00,0,0,0,dh" target="_blank" class="btn btn-outline-primary2 btn-small mr-auto"><strong>문의처 바로가기</strong></a>
	                        <a href="tel:1577-1000" class="md:hidden btn btn-primary3 btn-small"><i class="icon-tel"></i></a>
	                    </div>
	                </div>
	            </div>
	        </div>
        </div>
    </div>
</div>

<!--모달: 치매 검진비 지원-->
<div class="modal modal-index fade" id="pop-welfare-9" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
	        <div class="modal-header">
	            <h4 class="text-header-title">어르신 복지 서비스</h4>
	            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	        </div>
	        <hr class="divide-x-1 mt-5"/>
	        <div class="modal-body">
	            <div class="flex flex-col gap-8 items-start">
	                <h3 class="text-body-title">치매 <span class="text-indexKey1 text-normal">검진비 지원</span></h3>
	                <div class="">
	                    <p class="text-xl">치매가 의심되는 어르신이라면, <strong>치매검진비 지원을 신청하세요.</strong></p>
	                    <p><span class="font-semibold">[보건복지부]</span>에서 어르신의 <span class="font-semibold underline underline-offset-1">치매 여부를 조기에 발견하여 관리</span>하도록 지원합니다.</p>
	                </div>
	                <div class="beige-card-wrap">
	                    <h4 class="font-medium">지원내용 및 자격요건</h4>
	                    <ul class="check-lists">
	                        <li><span class="font-semibold">조기 치매로 선별검사, 진단/감별검사</span>가 필요한 어르신 <span class="font-semibold">(만 60세 이상)</span></li>
	                        <li><span class="font-semibold">저소득층</span>을 우선 지원</li>
	                        <li><span class="font-semibold">치매선별검사는 무료 </span>(치매안심센터에서 진행)</li>
	                        <li><span class="font-semibold">진단/감별검사비 무료 </span>(만 65세 이상, 저소득층에 해당)</li>
	                    </ul>
	                </div>
	                <div class="flex flex-col w-full">
	                    <div class="text-subtitle w-full pb-1 border-b border-gray-300">
	                        <i class="icon-alert"></i>
	                        <p class="font-medium">숙지사항</p>
	                    </div>  
	                    <ul class="circle-lists">
	                        <li>보건소에서 1단계 치매선별검사를 무료로 실시하고, 그 중 인지기능저하 어르신을 대상으로 보건소와 지정, 연계한 거점병원에서 진단검사, 감별검사를 진행합니다.</li>
	                    </ul>
	                </div>
	                <div class="welfare-contact">
	                    <div>
	                        <p>주관처 : 보건복지부 (<strong>129</strong>)</p>
	                        <p>문의처 : 보건소</p>
	                    </div>
	                    <div>
	                        <a href="https://map.naver.com/p/search/보건소?c=13.00,0,0,0,dh" target="_blank" class="btn btn-outline-primary2 btn-small mr-auto"><strong>문의처 바로가기</strong></a>
	                        <a href="tel:1577-1000" class="md:hidden btn btn-primary3 btn-small"><i class="icon-tel"></i></a>
	                    </div>
	                </div>
	            </div>
	        </div>
        </div>
    </div>
</div>

<!--모달: 치매 치료비 지원-->
<div class="modal modal-index fade" id="pop-welfare-10" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
        <div class="modal-content">
	        <div class="modal-header">
	            <h4 class="text-header-title">어르신 복지 서비스</h4>
	            <button data-bs-dismiss="modal" class="btn-close">모달 닫기</button>
	        </div>
	        <hr class="divide-x-1 mt-5"/>
	        <div class="modal-body">
	            <div class="flex flex-col gap-8 items-start">
	                <h3 class="text-body-title">치매 <span class="text-indexKey1 text-normal">치료비 지원</span></h3>
	                <div>
	                    <p class="text-xl">치매 치료가 필요한 어르신이라면, <strong>치매치료관리비 지원을 신청하세요.</strong></p>
	                    <p><span class="font-semibold">[보건복지부]</span>에서 어르신의 <span class="font-semibold underline underline-offset-1"> 치매 증상을 초기에 치료함</span>으로 행복한 노후를 지원합니다.</p>
	                </div>
	                <div class="beige-card-wrap">
	                    <h4 class="font-medium">지원내용 및 자격요건</h4>
	                    <ul class="check-lists">
	                        <li><span class="font-semibold">치매환자로 등록되고, </span> 치매치료약을 복용하는 어르신 <span class="font-semibold">(만 60세 이상)</span></li>
	                        <li><span class="font-semibold">월 3만원(연 36만원) 상한 내 </span>본인납부 실비 지원</li>
	                    </ul>
	                </div>
	                <div class="flex flex-col w-full">
	                    <div class="text-subtitle w-full pb-1 border-b border-gray-300">
	                        <i class="icon-alert"></i>
	                        <p class="font-medium">숙지사항</p>
	                    </div>  
	                    <ul class="circle-lists">
	                        <li>치매진단코드 : F00~03, G30</li>
	                        <li>의료급여 수급권자는 월 3만원(연간 36만원) 한도 내에서 지원됩니다.</li>
	                    </ul>
	                </div>
	                <div class="welfare-contact">
	                    <div>
	                        <p>주관처 : 보건복지부 (<strong>129</strong>)</p>
	                        <p>문의처 : 보건소</p>
	                    </div>
	                    <div>
	                        <a href="https://map.naver.com/p/search/보건소?c=13.00,0,0,0,dh" target="_blank" class="btn btn-outline-primary2 btn-small mr-auto"><strong>문의처 바로가기</strong></a>
	                        <a href="tel:1577-1000" class="md:hidden btn btn-primary3 btn-small"><i class="icon-tel"></i></a>
	                    </div>
	                </div>
	            </div>
	        </div>
        </div>
    </div>
</div>

<script>
	$(function() {		
		//modal dimmed 되는 현상 수정
		function modalOpen(id) {
			$(id).on('show.bs.modal', function () {     
				var modal = $(this);
				modal.appendTo('body');
				modal.css('outline', 'none');
			});
		}

		modalOpen('#pop-welfare-1');
		modalOpen('#pop-welfare-2');
		modalOpen('#pop-welfare-3');
		modalOpen('#pop-welfare-4');
		modalOpen('#pop-welfare-5');
		modalOpen('#pop-welfare-6');
		modalOpen('#pop-welfare-7');
		modalOpen('#pop-welfare-8');
		modalOpen('#pop-welfare-9');
		modalOpen('#pop-welfare-10');
	})
</script>
