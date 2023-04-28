<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="x-ua-compatible" content="ie=edge">

	<title>dashboard</title>

    <link id="favicon" rel="shortcut icon" href="/html/core/images/favicon.ico" sizes="16x16">

	<!-- plugin -->
    <link rel="stylesheet" href="/html/core/vendor/jstree/dist/themes/default/style.min.css">
    <link rel="stylesheet" href="/html/core/vendor/datatables/datatables.min.css">

	<script src="/html/core/vendor/jquery/jquery-3.6.0.min.js"></script>
	<script src="/html/core/vendor/jquery.validate/jquery.validate.min.js"></script>
    <script src="/html/core/vendor/jstree/dist/jstree.min.js"></script>
    <script src="/html/core/vendor/datatables/datatables.min.js"></script>

    <!-- common -->
    <script src="/html/core/script/utility.js"></script>

	<!-- admin -->
    <link rel="stylesheet" href="/html/page/admin/assets/style/style.min.css">
	<script src="/html/page/admin/assets/script/common.js"></script>

</head>
<body style="background-color:#111">
    <div class="dashboard-wrapper">
        <div class="header">
            <a href="/_mng/intro"><h1 class="system-title small white">Management<br> System</h1></a>
            <div class="dashboard-today">
                <p class="date">${dsbdCount.date}</p>
            </div>
            <div class="dashboard-account">
                <div class="user-info">
                    <span class="name">
                        <strong>${_mngrSession.mngrId}</strong>
                        <small>마지막 접속 <fmt:formatDate value="${_mngrSession.recentLgnDt}" pattern="yyyy-MM-dd" /></small>
                    </span>
                    <span class="thum">
                    	<c:if test="${_mngrSession.proflImg ne null && _mngrSession.proflImg ne ''}">
                    		<img src="/comm/proflImg?fileName=${_mngrSession.proflImg}" alt="manager">
                    	</c:if>
                    </span>
                </div>
                <a href="/_mng/logout" class="btn-logout white">로그아웃</a>
                <button class="dashboard-menu white">메뉴</button>
                <ul class="dashboard-menu-layer">
                    <li>
                        <a href="/_mng/mbr/list">
                            <i class="icon1"></i>
                            <span>회원관리</span>
                        </a>
                    </li>
                    <li>
                        <a href="/_mng/gds/gds/list">
                            <i class="icon2"></i>
                            <span>상품관리</span>
                        </a>
                    </li>
                    <li>
                        <a href="/_mng/ordr/all/list">
                            <i class="icon3"></i>
                            <span>주문관리</span>
                        </a>
                    </li>
                    <li>
                        <a href="/_mng/exhibit/rcmd/list">
                            <i class="icon4"></i>
                            <span>전시관리</span>
                        </a>
                    </li>
                    <li>
                        <a href="/_mng/promotion/dspy/list">
                            <i class="icon5"></i>
                            <span>프로모션관리</span>
                        </a>
                    </li>
                    <li>
                        <a href="/_mng/consult/gdsReview/list">
                            <i class="icon6"></i>
                            <span>고객상담관리</span>
                        </a>
                    </li>
                    <li>
                        <a href="/_mng/sysmng/mngr/list">
                            <i class="icon7"></i>
                            <span>시스템관리</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" onclick="alert('Not ready'); return false;">
                            <i class="icon8"></i>
                            <span>정산관리</span>
                        </a>
                    </li>
                    <li>
                        <a href="/_mng/stats/mbr/join">
                            <i class="icon9"></i>
                            <span>통계관리</span>
                        </a>
                    </li>
                    <li>
                        <a href="/_mng/members/bplcApp/list">
                            <i class="icon10"></i>
                            <span>멤버스관리</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="container">
            <div class="dashboard-order">
                <div class="dashboard-box1">
                    <h2>
                        order status
                        <span class="desc">주문 현황</span>
                        <span class="date">${dsbdCount.now} 기준</span>
                    </h2>
                    <div class="order-status">
                        <dl>
                            <dt>
                            	<a href="/_mng/ordr/all/list" class="block">
	                                <i><img src="/html/page/admin/assets/images/ico-dashboard-payment1.svg" alt=""></i>
	                                주문
	                        	</a>
                            </dt>
                            <dd>
                                <a href="/_mng/ordr/all/list" class="dashboard-number is-yellow">
                                    <div class="numb">
										<jsp:include page="include/countTy.jsp">
											<jsp:param value="${dsbdCount.cntOr04}" name="countTy" />
										</jsp:include>
									</div>
                                </a>
                                <a href="/_mng/ordr/all/list" class="dashboard-number is-small">
                                    <div class="numb or04">
                                    	<script>
                                    		var sum = "${dsbdCount.sumOr04}";
                                    		for(var i=0; i<(9-sum.length); i++){
                                    			var html = "";
                                    			if($(".span-view").length == 3 || $(".span-view").length == 6){
                                    				html += '<span class="space span-view"></span>';
                                    			}else{
                                    				html += '<span class="span-view"></span>';
                                    			}
                                    			$(".or04").append(html);
                                    		}
                                    		for(var h=0; h < sum.length; h++){
                                    			var html = "";
                                    			if($(".span-view").length == 3 || $(".span-view").length == 6){
	                                    			html += '<span class="space span-view" data-num="'+sum.substring(h,h+1)+'">"'+sum.substring(h,h+1)+'"</span>';
                                    			}else{
                                    				html += '<span class="span-view" data-num="'+sum.substring(h,h+1)+'">"'+sum.substring(h,h+1)+'"</span>';
                                    			}
                                    			$(".or04").append(html);
                                    		}
                                    	</script>
                                    </div>
                                    <div class="desc">원</div>
                                </a>
                            </dd>
                        </dl>
                        <dl>
                            <dt>
                            	<a href="/_mng/ordr/or05/list" class="block">
	                                <i><img src="/html/page/admin/assets/images/ico-dashboard-payment2.svg" alt=""></i>
	                                결제
                                </a>
                            </dt>
                            <dd>
                                <a href="/_mng/ordr/or05/list" class="dashboard-number">
                                    <div class="numb">
										<jsp:include page="include/countTy.jsp">
											<jsp:param value="${dsbdCount.cntOr05}" name="countTy" />
										</jsp:include>
									</div>
                                </a>
                                <a href="/_mng/ordr/or05/list" class="dashboard-number is-small">
                                    <div class="numb or05">
                                    	<script>
                                    		var sum = "${dsbdCount.sumOr05}";
                                    		for(var i=0; i<(9-sum.length); i++){
                                    			var html = "";
                                    			if($(".span-view-pc").length == 3 || $(".span-view-pc").length == 6){
                                    				html += '<span class="space span-view-pc"></span>';
                                    			}else{
                                    				html += '<span class="span-view-pc"></span>';
                                    			}
                                    			$(".or05").append(html);
                                    		}
                                    		for(var h=0; h < sum.length; h++){
                                    			var html = "";
                                    			if($(".span-view-pc").length == 3 || $(".span-view-pc").length == 6){
                                    				html += '<span class="span-view-pc space" data-num="'+sum.substring(h,h+1)+'">"'+sum.substring(h,h+1)+'"</span>';
                                    			}else{
                                    				html += '<span class="span-view-pc" data-num="'+sum.substring(h,h+1)+'">"'+sum.substring(h,h+1)+'"</span>';
                                    			}
                                    			$(".or05").append(html);
                                    		}
                                    	</script>
                                    </div>
                                    <div class="desc">원</div>
                                </a>
                            </dd>
                        </dl>
                        <dl>
                            <dt>
                    			<a href="/_mng/ordr/rf01/list" class="block">
	                                <i><img src="/html/page/admin/assets/images/ico-dashboard-payment3.svg" alt=""></i>
	                                환불
	                       		</a>
                            </dt>
                            <dd>
                                <a href="/_mng/ordr/rf01/list" class="dashboard-number">
                                    <div class="numb">
										<jsp:include page="include/countTy.jsp">
											<jsp:param value="${dsbdCount.cntRf02}" name="countTy" />
										</jsp:include>
									</div>
                                </a>
                                <a href="/_mng/ordr/rf01/list" class="dashboard-number is-small">
                                    <div class="numb rf02">
                                       	<script>
                                    		var sum = "${dsbdCount.sumRf02}";
                                    		for(var i=0; i<(9-sum.length); i++){
                                    			var html = "";
                                    			if($(".span-view-ca").length == 3 || $(".span-view-ca").length == 6){
                                    				html += '<span class="space span-view-ca"></span>';
                                    			}else{
                                    				html += '<span class="span-view-ca"></span>';
                                    			}
                                    			$(".rf02").append(html);
                                    		}
                                    		for(var h=0; h < sum.length; h++){
                                    			var html = "";
                                       			if($(".span-view-ca").length == 3 || $(".span-view-ca").length == 6){
                                    				html += '<span class="space span-view-ca" data-num="'+sum.substring(h,h+1)+'">"'+sum.substring(h,h+1)+'"</span>';
                                    			}else{
                                    				html += '<span class="span-view-ca" data-num="'+sum.substring(h,h+1)+'">"'+sum.substring(h,h+1)+'"</span>';
                                    			}
                                    			$(".rf02").append(html);
                                    		}
                                    	</script>
                                    </div>
                                    <div class="desc">원</div>
                                </a>
                            </dd>
                        </dl>
                    </div>
                </div>
                <div class="dashboard-box1">
                    <h2>
                    	<a href="/_mng/ordr/all/list">
	                        order process
	                        <span class="desc">주문 과정</span>
                        </a>
                        <span class="date">최근 1개월 기준</span>
                    </h2>
                    <table class="dashboard-table">
                        <colgroup>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <tbody>
                            <tr>
                                <td>
                                    <a href="/_mng/ordr/or01/list" class="dashboard-number is-yellow">
                                        <p class="numb">
										<jsp:include page="include/countTy.jsp">
											<jsp:param value="${ordrCnt.or01}" name="ordrPc" />
										</jsp:include>
										</p>
                                        <p class="desc">승인대기</p>
                                    </a>
                                </td>
                                <td>
                                    <a href="/_mng/ordr/or02/list" class="dashboard-number">
                                        <p class="numb">
											<jsp:include page="include/countTy.jsp">
												<jsp:param value="${ordrCnt.or02}" name="ordrPc" />
											</jsp:include>
										</p>
                                        <p class="desc">승인완료</p>
                                    </a>
                                </td>
                                <td>
                                    <a href="/_mng/ordr/or03/list" class="dashboard-number">
										<p class="numb">
											<jsp:include page="include/countTy.jsp">
												<jsp:param value="${ordrCnt.or03}" name="ordrPc" />
											</jsp:include>
										</p>
										<p class="desc">승인반려</p>
                                    </a>
                                </td>
                                <td>
                                    <a href="/_mng/ordr/or04/list" class="dashboard-number">
                                        <p class="numb">
											<jsp:include page="include/countTy.jsp">
												<jsp:param value="${ordrCnt.or04}" name="ordrPc" />
											</jsp:include>
										</p>
                                        <p class="desc">결제대기</p>
                                    </a>
                                </td>
                                <td>
                                    <a href="/_mng/ordr/or05/list" class="dashboard-number is-yellow">
                                        <p class="numb">
											<jsp:include page="include/countTy.jsp">
												<jsp:param value="${ordrCnt.or05}" name="ordrPc" />
											</jsp:include>
										</p>
                                        <p class="desc">결제완료</p>
                                    </a>
                                </td>
                                <td>
                                    <a href="/_mng/ordr/or06/list?cntPerPage=10&sortBy=&srchSttsTy=OR06&srchOrdrYmdBgng=&srchOrdrYmdEnd=&srchOrdrrNm=&srchRecptrNm=&srchOrdrrId=&srchGdsCd=&srchOrdrrTelno=&srchOrdrTy=&srchStlmTy=&srchGdsNm=" class="dashboard-number">
										<p class="numb">
											<jsp:include page="include/countTy.jsp">
												<jsp:param value="${ordrCnt.or06}" name="ordrPc" />
											</jsp:include>
										</p>
										<p class="desc">배송준비중</p>
                                    </a>
                                </td>
                                <td>
                                    <a href="/_mng/ordr/or06/list?cntPerPage=10&sortBy=&srchSttsTy=OR07&srchOrdrYmdBgng=&srchOrdrYmdEnd=&srchOrdrrNm=&srchRecptrNm=&srchOrdrrId=&srchGdsCd=&srchOrdrrTelno=&srchOrdrTy=&srchStlmTy=&srchGdsNm=" class="dashboard-number">
                                        <p class="numb">
	                                     	<jsp:include page="include/countTy.jsp">
												<jsp:param value="${ordrCnt.or07}" name="ordrPc" />
											</jsp:include>
                                        </p>
                                        <p class="desc">배송중</p>
                                    </a>
                                </td>
                                <td>
                                    <a href="/_mng/ordr/or06/list?cntPerPage=10&sortBy=&srchSttsTy=OR08&srchOrdrYmdBgng=&srchOrdrYmdEnd=&srchOrdrrNm=&srchRecptrNm=&srchOrdrrId=&srchGdsCd=&srchOrdrrTelno=&srchOrdrTy=&srchStlmTy=&srchGdsNm=" class="dashboard-number">
                                        <p class="numb">
                                            <jsp:include page="include/countTy.jsp">
												<jsp:param value="${ordrCnt.or08}" name="ordrPc" />
											</jsp:include>
                                        </p>
                                        <p class="desc">배송완료</p>
                                    </a>
                                </td>
                                <td>
                                    <a href="/_mng/ordr/or09/list" class="dashboard-number is-green">
                                        <p class="numb">
											<jsp:include page="include/countTy.jsp">
												<jsp:param value="${ordrCnt.or09}" name="ordrPc" />
											</jsp:include>
										</p>
                                        <p class="desc">구매확정</p>
                                    </a>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="dashboard-cancel">
                <h2>
                    cancel
                    <span class="desc -ml-2">
	                    <a href="/_mng/ordr/ca01/list">취소</a> /
	                    <a href="/_mng/ordr/ex01/list">교환</a> /
	                    <a href="/_mng/ordr/re01/list">반품</a> /
	                    <a href="/_mng/ordr/rf01/list">환불</a>
					</span>
                </h2>
                <a href="/_mng/ordr/ca01/list" class="dashboard-number is-red">
                    <p class="desc">취소접수</p>
                    <p class="numb">
						<jsp:include page="include/countTy.jsp">
							<jsp:param value="${dsbdCount.cancleCa01}" name="ordrPc" />
						</jsp:include>
					</p>
                </a>
                <a href="/_mng/ordr/ex01/list" class="dashboard-number">
                    <p class="desc">교환접수</p>
                    <p class="numb">
						<jsp:include page="include/countTy.jsp">
							<jsp:param value="${dsbdCount.cancleEx01}" name="ordrPc" />
						</jsp:include>
					</p>
                </a>
                <a href="/_mng/ordr/re01/list" class="dashboard-number is-sky">
                    <p class="desc">반품접수</p>
                    <p class="numb">
						<jsp:include page="include/countTy.jsp">
							<jsp:param value="${dsbdCount.cancleRe01}" name="ordrPc" />
						</jsp:include>
					</p>
                </a>
                <a href="/_mng/ordr/rf01/list" class="dashboard-number is-red">
                    <p class="desc">환불접수</p>
                    <p class="numb">
						<jsp:include page="include/countTy.jsp">
							<jsp:param value="${dsbdCount.cancleRf01}" name="ordrPc" />
						</jsp:include>
					</p>
                </a>
            </div>
            <div class="dashboard-current1">
                <h2><a href="/_mng/gds/gds/list">상품 판매 현황</a></h2>
                <table class="dashboard-table">
                    <colgroup>
                        <col class="w-25">
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col"><p>판매중</p></th>
                            <th scope="col"><p>일시품절</p></th>
                            <th scope="col"><p>품절</p></th>
                            <th scope="col"><p>전체</p></th>
                        </tr>
                    </thead>
				<tbody>
					<tr>
						<th scope="row"><p>급여 판매</p></th>
						<td>
							<div class="dashboard-number is-small is-yellow">
								<a href="/_mng/gds/gds/list?srchGdsTy=R&amp;srchDspyYn=Y">
									<p class="numb">
										<jsp:include page="include/countTy.jsp">
											<jsp:param value="${dsbdCount.rSold}" name="countTy" />
										</jsp:include>
									</p>
								</a>
							</div>
						</td>
						<td>
							<div class="dashboard-number is-small">
								<p class="numb">
									<jsp:include page="include/countTy.jsp">
										<jsp:param value="${dsbdCount.rPause}" name="countTy" />
									</jsp:include>
								</p>
							</div>
						</td>
						<td>
							<div class="dashboard-number is-small">
								<p class="numb">
									<jsp:include page="include/countTy.jsp">
										<jsp:param value="${dsbdCount.rSoldout}" name="countTy" />
									</jsp:include>
								</p>
							</div>
						</td>
						<td>
							<div class="dashboard-number is-small">
								<p class="numb">
									<jsp:include page="include/countTy.jsp">
										<jsp:param value="${dsbdCount.rTotal}" name="countTy" />
									</jsp:include>
								</p>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><p>급여 대여</p></th>
						<td>
							<div class="dashboard-number is-small is-yellow">
								<a href="/_mng/gds/gds/list?srchGdsTy=L&amp;srchDspyYn=Y">
									<p class="numb">
										<jsp:include page="include/countTy.jsp">
											<jsp:param value="${dsbdCount.lSold}" name="countTy" />
										</jsp:include>
									</p>
								</a>
							</div>
						</td>
						<td>
							<div class="dashboard-number is-small">
								<p class="numb">
									<jsp:include page="include/countTy.jsp">
										<jsp:param value="${dsbdCount.lPause}" name="countTy" />
									</jsp:include>
								</p>
							</div>
						</td>
						<td>
							<div class="dashboard-number is-small">
								<p class="numb">
									<jsp:include page="include/countTy.jsp">
										<jsp:param value="${dsbdCount.lSoldout}" name="countTy" />
									</jsp:include>
								</p>
							</div>
						</td>
						<td>
							<div class="dashboard-number is-small">
								<p class="numb">
									<jsp:include page="include/countTy.jsp">
										<jsp:param value="${dsbdCount.lTotal}" name="countTy" />
									</jsp:include>
								</p>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><p>비급여</p></th>
						<td>
							<div class="dashboard-number is-small is-yellow">
								<a href="/_mng/gds/gds/list?srchGdsTy=N&amp;srchDspyYn=Y">
									<p class="numb">
										<jsp:include page="include/countTy.jsp">
											<jsp:param value="${dsbdCount.nSold}" name="countTy" />
										</jsp:include>
									</p>
								</a>
							</div>
						</td>
						<td>
							<div class="dashboard-number is-small">
								<p class="numb">
									<jsp:include page="include/countTy.jsp">
										<jsp:param value="${dsbdCount.nPause}" name="countTy" />
									</jsp:include>
								</p>
							</div>
						</td>
						<td>
							<div class="dashboard-number is-small">
								<p class="numb">
									<jsp:include page="include/countTy.jsp">
										<jsp:param value="${dsbdCount.nSoldout}" name="countTy" />
									</jsp:include>
								</p>
							</div>
						</td>
						<td>
							<div class="dashboard-number is-small">
								<p class="numb">
									<jsp:include page="include/countTy.jsp">
										<jsp:param value="${dsbdCount.nTotal}" name="countTy" />
									</jsp:include>
								</p>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
            </div>
            <div class="dashboard-current2">
                <h2><a href="/_mng/consult/gdsQa/list">고객상담 현황</a></h2>
                <table class="dashboard-table">
                    <colgroup>
                        <col class="w-25">
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col"><p>미처리</p></th>
                            <th scope="col"><p>처리완료</p></th>
                            <th scope="col"><p>누적미처리</p></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="row"><p>상품 Q&amp;A</p></th>
                            <td>
                                <div class="dashboard-number is-small is-yellow">
                                	<a href="/_mng/consult/gdsQa/list?srchAnsYn=N">
	                                    <p class="numb">
	                                       <jsp:include page="include/countTy.jsp">
		                                      	<jsp:param value="${dsbdCount.qaNoAns}" name="countTy" />
		                                    </jsp:include>
	                                    </p>
                                    </a>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                     	<jsp:include page="include/countTy.jsp">
	                                      	<jsp:param value="${dsbdCount.qaAns}" name="countTy" />
	                                    </jsp:include>
                                    </p>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                    	<jsp:include page="include/countTy.jsp">
	                                      	<jsp:param value="${dsbdCount.qaNoTotal}" name="countTy" />
	                                    </jsp:include>
                                    </p>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p>1:1 문의</p></th>
                            <td>
                                <div class="dashboard-number is-small is-yellow">
                                	<a href="/_mng/consult/mbrInqry/list?srchAns=N">
	                                    <p class="numb">
	                                    	<jsp:include page="include/countTy.jsp">
		                                      	<jsp:param value="${dsbdCount.inqryNoAns}" name="countTy" />
		                                    </jsp:include>
	                                    </p>
                                    </a>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                    	<jsp:include page="include/countTy.jsp">
	                                      	<jsp:param value="${dsbdCount.inqryAns}" name="countTy" />
	                                    </jsp:include>
                                    </p>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
	                                    <jsp:include page="include/countTy.jsp">
	                                      	<jsp:param value="${dsbdCount.inqryNoTotal}" name="countTy" />
	                                    </jsp:include>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="dashboard-current1">
                <h2><a href="/_mng/mbr/list">마켓 회원 현황</a></h2>
                <table class="dashboard-table">
                    <colgroup>
                        <col class="w-25">
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"></th>
                            <th scope="col"><p>일반</p></th>
                            <th scope="col"><p>수급자</p></th>
                            <th scope="col"><p>휴면</p></th>
                            <th scope="col"><p>탈퇴</p></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="row"><p>신규</p></th>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                        <jsp:include page="include/countTy.jsp">
	                                      	<jsp:param value="${dsbdCount.newNorMbr}" name="countTy" />
	                                    </jsp:include>
                                    </p>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                      <jsp:include page="include/countTy.jsp">
                                      	<jsp:param value="${dsbdCount.newRecipterMbr}" name="countTy" />
                                      </jsp:include>
                                    </p>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                       <jsp:include page="include/countTy.jsp">
                                      	<jsp:param value="${dsbdCount.newHumanMbr}" name="countTy" />
                                      </jsp:include>
                                    </p>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                       <jsp:include page="include/countTy.jsp">
                                      	<jsp:param value="${dsbdCount.newExitMbr}" name="countTy" />
                                      </jsp:include>
                                    </p>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row"><p>누적</p></th>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                          <jsp:include page="include/countTy.jsp">
                                      	<jsp:param value="${dsbdCount.norMbr}" name="countTy" />
                                      </jsp:include>
                                    </p>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                          <jsp:include page="include/countTy.jsp">
                                      	<jsp:param value="${dsbdCount.recipterMbr}" name="countTy" />
                                      </jsp:include>
                                    </p>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                        <jsp:include page="include/countTy.jsp">
                                      	<jsp:param value="${dsbdCount.humanMbr}" name="countTy" />
                                      </jsp:include>
                                    </p>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                    <p class="numb">
                                        <jsp:include page="include/countTy.jsp">
                                      	<jsp:param value="${dsbdCount.exitMbr}" name="countTy" />
                                      </jsp:include>
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="dashboard-current2">
                <h2><a href="/_mng/members/bplc/list">멤버스 현황</a></h2>
                <table class="dashboard-table">
                    <colgroup>
                        <col>
                        <col>
                        <col>
                        <col>
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col"><p>승인대기</p></th>
                            <th scope="col"><p>미승인</p></th>
                            <th scope="col"><p>사용</p></th>
                            <th scope="col"><p>미사용</p></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                <div class="dashboard-number is-small is-yellow">
                                    <a href="/_mng/members/bplcApp/list?srchAprvTy=W">
                                    <p class="numb">
									<jsp:include page="include/countTy.jsp">
										<jsp:param value="${dsbdCount.bplcWait}" name="countTy" />
									</jsp:include>
									</p>
									</a>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                	<a href="/_mng/members/bplcApp/list?srchAprvTy=R">
	                                    <p class="numb">
										<jsp:include page="include/countTy.jsp">
											<jsp:param value="${dsbdCount.bplcNon}" name="countTy" />
										</jsp:include>
										</p>
									</a>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                	<a href="/_mng/members/bplc/list">
	                                    <p class="numb">
										<jsp:include page="include/countTy.jsp">
											<jsp:param value="${dsbdCount.bplcUse}" name="countTy" />
										</jsp:include>
										</p>
									</a>
                                </div>
                            </td>
                            <td>
                                <div class="dashboard-number is-small">
                                	<a href="/_mng/members/bplc/list?srchUseYn=N">
	                                    <p class="numb">
										<jsp:include page="include/countTy.jsp">
											<jsp:param value="${dsbdCount.bplcNo}" name="countTy" />
										</jsp:include>
										</p>
									</a>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="dashboard-member">
                <h2>
                    market member
                    <span class="desc">일간 신규회원 수</span>
                </h2>
                <div class="member-container">
                    <div class="member-chart">
                        <div class="w-full">
                            <canvas id="chart" style="width: 100%; height: 250px;"></canvas>
                        </div>
                        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js" integrity="sha512-ElRFoEQdI5Ht6kZvyzXhYG9NqjtkmlkfYk0wr6wHxU9JEHakS7UJZNeml5ALk+8IKlU6jDgMabC3vkumRokgJA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
                        <script>
                        let day = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31];
                        const months = [1,2,3,4,5,6,7,8,9,10,11,12];
                        const plusmonths = [1,3,5,7,8,10,12];

	                      	var now = new Date();
	                    	var date = f_getToday();
	                    	var dd = now.getDate();
	                    	let idx = 0;

	                    	function f_date(now){
	                    		let nowMonth = now.getMonth() +1;
	                    		let dayIndex = 0;

	                    		if(plusmonths.indexOf(nowMonth) < 0){
                        			day = day;
                        		}else{
                        			day = day.filter((element) => element !== 31);
                        		}
                        		dayIndex = day.indexOf(now.getDate());
                        		idx = dayIndex;

                        		return idx;
                        	}
	                    	f_date(now);

	                    	function f_srchDate(idx){
	                    		var indx = 0;
	                    		if(idx < 0){
	                    			idx = day.indexOf((day.length+1) + idx);
	                    			return day[idx];
	                    		}else if(idx == 0){
	                    			return day[0];
	                    		}else {
	                    			indx = day.indexOf(idx);
	                    			return day[indx];
	                    		}
	                    	}

	                    	var mbrMap = new Map();

                        	/* 현재 날짜 중심 회원 데이터 카운팅 */
                        	function f_chartData(){
                	   			$.ajax({
                    				type : "post",
                    				url  : "/_mng/dashboard/chartData",
                    			})
                    			.done(function(data) {
                    				f_chartList(data);
                    			})
                    			.fail(function(data, status, err) {
                    				console.log('error forward : ' + data);
                    			});
                        	}

                        	f_chartData();

                        	function f_chartList(mbrMap) {

	                            var ctx         = document.getElementById("chart").getContext("2d"),
	                                gradient1   = ctx.createLinearGradient(0, 0, 0, 250),
	                                gradient2   = ctx.createLinearGradient(0, 0, 0, 250);

	                            gradient1.addColorStop(0, 'rgb(255, 92, 0)');
	                            gradient1.addColorStop(1, 'rgb(255, 29, 147)');
	                            gradient2.addColorStop(0, 'rgb(29, 185, 255)');
	                            gradient2.addColorStop(1, 'rgb(77, 52, 136)');

	                            var data = {
	                            		/* 현재 일자 중심으로 - 9일 */
	                                labels: [ f_srchDate(idx-8),  f_srchDate(idx-7),  f_srchDate(idx-6),  f_srchDate(idx-5),  f_srchDate(idx-4),  f_srchDate(idx-3), f_srchDate(idx-2), f_srchDate(idx-1) , f_srchDate(idx) , dd ],
	                                datasets: [
	                                        {
	                                        label: "Dataset #1",
	                                        borderColor: "rgba(0,0,0,0)",
	                                        borderWidth: 2,
	                                        borderRadius: 10,
	                                        barThickness: 8,
	                                        maxBarThickness: 8,
	                                        backgroundColor: gradient1,
	                                        data: [mbrMap.m9, mbrMap.m8, mbrMap.m7, mbrMap.m6, mbrMap.m5, mbrMap.m4, mbrMap.m3, mbrMap.m2, mbrMap.m1, mbrMap.m],
	                                    }, {
	                                        label: "Dataset #2",
	                                        borderColor: "rgba(0,0,0,0)",
	                                        borderWidth: 2,
	                                        borderRadius: 10,
	                                        barThickness: 8,
	                                        maxBarThickness: 8,
	                                        backgroundColor: gradient2,
	                                        data: [mbrMap.bm9, mbrMap.bm8, mbrMap.bm7, mbrMap.bm6, mbrMap.bm5, mbrMap.bm4, mbrMap.bm3, mbrMap.bm2, mbrMap.bm1, mbrMap.bm],
	                                    }
	                                ]
	                            };
	                            var options = {
	                                drawBorder: false,
	                                plugins: {
	                                    legend: {
	                                        display: false
	                                    },
	                                    tooltip: {
	                                        backgroundColor: gradient1,
	                                        xAlign: "center",
	                                        yAlign: "bottom",
	                                        titleAlign: "center",
	                                        titleFont: {
	                                            size: 14,
	                                            family: "Roboto"
	                                        },
	                                        bodyFont: {
	                                            size: 14,
	                                            family: "Roboto"
	                                        },
	                                        displayColors: false,
	                                        padding: 8,
	                                        callbacks: {
	                                            title: function() {},
	                                            label: function(tooltipItem) {
	                                                return tooltipItem.formattedValue + '명';
	                                            }
	                                        }
	                                    }
	                                },
	                                /* 차트 간격 설정 */
	                                scales: {
	                                    y: {
	                                        min: 0,
	                                        max: 10,
	                                        ticks: {
	                                            family: "roboto",
	                                            size: 20,
	                                            weight: 700,
	                                            color: 'white',
	                                            stepSize: 2
	                                        },
	                                        grid: {
	                                            display: true,
	                                            color: "rgba(216,216,216,0.2)"
	                                        }
	                                    },
	                                    x: {
	                                        ticks: {
	                                            drawBorder: false,
	                                            family: "roboto",
	                                            size: 20,
	                                            weight: 700,
	                                            color: 'white'
	                                        },
	                                        grid: {
	                                            display: true,
	                                            color: "rgba(216,216,216,0.2)"
	                                        }
	                                    }
	                                }
	                            };
	                            new Chart('chart', {
	                                type: 'bar',
	                                options: options,
	                                data: data
	                            });
                        	}

                        </script>
                    </div>
                    <div class="member-count">
                        <p class="text-white text-xs text-right font-bold">전체 회원 수</p>
                        <div class="dashboard-number is-large is-orange">
                            <div class="numb" >
								<c:set var="mber" value="${dsbdCount.mbrTotal}" />
								<c:forEach begin="0" end="7" varStatus="stts">
									<c:set var="mbers" value="${fn:substring(mber, stts.index, stts.index+1)}" />
									<c:choose>
										<c:when test="${mbers eq '_' }">
											<span class="totalNum ${(stts.index == 2 || stts.index == 5)?'space':''}"></span>
										</c:when>
										<c:otherwise>
											<span class="totalNum ${(stts.index == 2 || stts.index == 5)?'space':''}" data-num="${mbers}"></span>
										</c:otherwise>
									</c:choose>
								</c:forEach>
						</div>
                        </div>
                        <div class="dashboard-number is-large is-blue">
                            <div class="numb">
                            <c:set var="bplc" value="${dsbdCount.bplcTotal}" />
								<c:forEach begin="0" end="6" varStatus="status">
									<c:set var="bpl" value="${fn:substring(bplc, status.index, status.index+1)}" />
									<c:choose>
										<c:when test="${bpl eq '_' }">
											<span class="totalNum ${(status.index == 1 || status.index == 4)?'space':	''}"></span>
										</c:when>
										<c:otherwise>
											<span class="totalNum ${(status.index == 1 || status.index == 4)?'space':	''}" data-num="${bpl}"></span>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</div>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <p class="text-copyright">Copyright ⓒEroumMarket All righs reserved.</p>
    </div>
    <script src="/html/core/vendor/twelements/index.min.js"></script>
</body>
</html>