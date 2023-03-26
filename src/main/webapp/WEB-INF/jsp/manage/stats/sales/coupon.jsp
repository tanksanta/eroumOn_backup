<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<!-- page content -->
            <div id="page-content">
                <jsp:include page="./include/tab.jsp" />

                <form action="#" class="mt-7.5">
                    <fieldset>
                        <legend class="text-title2">검색</legend>
                        <table class="table-detail">
                            <colgroup>
                                <col class="w-43">
                                <col>
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="row"><label for="search-item1">조회기간</label></th>
                                    <td>
                                        <div class="form-group">
                                            <input type="date" class="form-control w-39 calendar" id="search-item1">
                                            <i>~</i>
                                            <input type="date" class="form-control w-39 calendar">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="search-item2">쿠폰번호</label></th>
                                    <td><input type="text" class="form-control w-84" id="search-item1"></td>
                                </tr>
                                <tr>
                                    <th scope="row"><label for="search-item1">쿠폰종류</label></th>
                                    <td>
                                        <select name="" class="form-control w-84">
                                            <option value="">전체</option>
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

                <div class="mt-13 text-right mb-2">
                    <button type="button" class="btn-primary">엑셀 다운로드</button>
                </div>

                <p class="text-title2 mt-13">조회결과</p>
                <div class="scroll-table">
                    <table class="table-list">
                        <colgroup>
                            <col class="min-w-30">
                            <col class="min-w-50">
                            <col class="min-w-25">
                            <col class="min-w-22 w-22">
                            <col class="min-w-25">
                            <col class="min-w-25">
                            <col class="min-w-25">
                            <col class="min-w-25">
                            <col class="min-w-25">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">쿠폰번호</th>
                                <th scope="col">쿠폰명</th>
                                <th scope="col">할인금액/율</th>
                                <th scope="col">할인구분</th>
                                <th scope="col">부여수량</th>
                                <th scope="col">사용수량</th>
                                <th scope="col">사용율</th>
                                <th scope="col">할인금액</th>
                                <th scope="col">매출금액</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="noresult" colspan="9">검색조건을 선택 하신 후, 검색해 주세요.</td>
                            </tr>
                            <tr>
                                <td class="noresult" colspan="9">검색조건을 만족하는 결과가 없습니다.</td>
                            </tr>
                            <tr>
                                <td>abcd12038</td>
                                <td class="text-left"><a href="#" data-bs-toggle="modal" data-bs-target="#modal1">[PLATINUM] 생일 축하 10% 할인쿠폰</a></td>
                                <td>1,000/10%</td>
                                <td>정율</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">33.3333%</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">11,999,999</td>
                            </tr>
                            <tr>
                                <td>abcd12038</td>
                                <td class="text-left"><a href="#" data-bs-toggle="modal" data-bs-target="#modal1">[PLATINUM] 생일 축하 10% 할인쿠폰</a></td>
                                <td>1,000/10%</td>
                                <td>정율</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">33.3333%</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">11,999,999</td>
                            </tr>
                            <tr>
                                <td>abcd12038</td>
                                <td class="text-left"><a href="#" data-bs-toggle="modal" data-bs-target="#modal1">[PLATINUM] 생일 축하 10% 할인쿠폰</a></td>
                                <td>1,000/10%</td>
                                <td>정율</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">33.3333%</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">11,999,999</td>
                            </tr>
                            <tr>
                                <td>abcd12038</td>
                                <td class="text-left"><a href="#" data-bs-toggle="modal" data-bs-target="#modal1">[PLATINUM] 생일 축하 10% 할인쿠폰</a></td>
                                <td>1,000/10%</td>
                                <td>정율</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">33.3333%</td>
                                <td class="text-right">11,999,999</td>
                                <td class="text-right">11,999,999</td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <!-- 쿠폰사용 주문내역 -->
                <div class="modal fade" id="modal1" tabindex="-1">
                    <div class="modal-dialog modal-xl modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <p>쿠폰사용 주문내역보기</p>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                            </div>
                            <div class="modal-body">

                                <table class="table-list">
                                    <colgroup>
                                        <col class="w-25">
                                        <col>
                                        <col class="w-25">
                                        <col class="w-20">
                                        <col class="w-20">
                                        <col class="w-20">
                                        <col class="w-17">
                                        <col class="w-21">
                                        <col class="w-21">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">쿠폰번호</th>
                                            <th scope="col">쿠폰명</th>
                                            <th scope="col">할인금액/율</th>
                                            <th scope="col">할인구분</th>
                                            <th scope="col">부여수량</th>
                                            <th scope="col">사용수량</th>
                                            <th scope="col">사용율</th>
                                            <th scope="col">할인금액</th>
                                            <th scope="col">매출금액</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>abcd12132</td>
                                            <td class="text-left">회원가입 7% 할인쿠폰</td>
                                            <td>10,000/7%</td>
                                            <td>정율</td>
                                            <td>12345</td>
                                            <td>12345</td>
                                            <td>100%</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                        </tr>
                                    </tbody>
                                </table>

                                <div class="text-right mt-10 mb-3">
                                    <button type="button" class="btn-primary">엑셀 다운로드</button>
                                </div>

                                <table class="table-list">
                                    <colgroup>
                                        <col class="w-14">
                                        <col class="w-24">
                                        <col class="w-24">
                                        <col class="w-24">
                                        <col>
                                        <col class="w-22">
                                        <col class="w-13">
                                        <col class="w-21">
                                        <col class="w-21">
                                        <col class="w-21">
                                        <col class="w-19">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">NO</th>
                                            <th scope="col">주문일</th>
                                            <th scope="col">주문번호</th>
                                            <th scope="col">상품코드</th>
                                            <th scope="col">상품명</th>
                                            <th scope="col">상품가격</th>
                                            <th scope="col">수량</th>
                                            <th scope="col">주문금액</th>
                                            <th scope="col">할인금액</th>
                                            <th scope="col">결제금액</th>
                                            <th scope="col">주문상태</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                        <tr>
                                            <td>12113</td>
                                            <td>2022-02-02<br>12:34:56</td>
                                            <td>10378347</td>
                                            <td>10378347</td>
                                            <td class="text-left">주문상품명</td>
                                            <td>1,999,999</td>
                                            <td>12</td>
                                            <td>1,999,999</td>
                                            <td>1,999,999</td>
                                            <td>11,999,999</td>
                                            <td>배송완료</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- //쿠폰사용 주문내역 -->
            </div>
            <!-- //page content -->