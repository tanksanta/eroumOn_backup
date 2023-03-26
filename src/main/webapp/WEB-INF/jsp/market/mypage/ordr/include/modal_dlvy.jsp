<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
	<%--배송지--%>

 		<!-- 배송지 -->
        <div class="modal fade" id="deliModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="text-title">배송지 목록</p>
                    </div>
                    <div class="modal-close">
                        <button data-bs-dismiss="modal">모달 닫기</button>
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs tabs is-small" id="tabs-tab" role="tablist">
                            <li class="nav-item" role="presentation"><a href="#tabs-delicont1" class="nav-link tabs-link active" data-bs-toggle="pill" data-bs-target="#tabs-delicont1" role="tab" aria-selected="true">최근 배송지</a></li>
                            <li class="nav-item" role="presentation"><a href="#tabs-delicont2" class="nav-link tabs-link" data-bs-toggle="pill" data-bs-target="#tabs-delicont2" role="tab" aria-selected="false">나의 주소록</a></li>
                            <li class="nav-item" role="presentation"><a href="#tabs-delicont3" class="nav-link tabs-link" data-bs-toggle="pill" data-bs-target="#tabs-delicont3" role="tab" aria-selected="false">새로운 주소</a></li>
                        </ul>
                        <div class="tab-content mt-3 md:mt-4">
                            <div class="tab-pane fade show active" id="tabs-delicont1" role="tabpanel">
                                <p class="text-alert">최근 배송지 중 주문에 사용할 배송지 정보를 선택해 주세요 (최대 5개까지 제공)</p>
                                <div class="order-delivery mt-3 md:mt-4">
                                    <dl class="order-name">
                                        <dt>받는사람</dt>
                                        <dd>이로미</dd>
                                    </dl>
                                    <div class="order-addr">
                                        <dl>
                                            <dt>연락처</dt>
                                            <dd>
                                                <strong>010-2732-9721</strong>
                                            </dd>
                                        </dl>
                                        <dl>
                                            <dt>주소</dt>
                                            <dd>
                                                <address>
                                                    <strong>42858</strong>
                                                    <p>서울특별시 금천구 서부샛길 606 대성디폴리스 B동 1401호</p>
                                                </address>
                                            </dd>
                                        </dl>
                                    </div>
                                    <label class="order-select">
                                        <input type="radio" name="">
                                        <span>선택</span>
                                    </label>
                                </div>
                                <div class="order-delivery mt-3 md:mt-4">
                                    <dl class="order-name">
                                        <dt>받는사람</dt>
                                        <dd>이로미</dd>
                                    </dl>
                                    <div class="order-addr">
                                        <dl>
                                            <dt>연락처</dt>
                                            <dd>
                                                <strong>010-2732-9721</strong>
                                            </dd>
                                        </dl>
                                        <dl>
                                            <dt>주소</dt>
                                            <dd>
                                                <address>
                                                    <strong>42858</strong>
                                                    <p>서울특별시 금천구 서부샛길 606 대성디폴리스 B동 1401호</p>
                                                </address>
                                            </dd>
                                        </dl>
                                    </div>
                                    <label class="order-select">
                                        <input type="radio" name="">
                                        <span>선택</span>
                                    </label>
                                </div>
                                <p class="box-result mt-3 md:mt-4">최근 배송지가 없습니다.</p>
                            </div>
                            <div class="tab-pane fade" id="tabs-delicont2" role="tabpanel">
                                <p class="text-alert">최근 배송지 중 주문에 사용할 배송지 정보를 선택해 주세요 (최대 5개까지 제공)</p>
                                <div class="order-delivery mt-3 md:mt-4">
                                    <dl class="order-name">
                                        <dt>받는사람</dt>
                                        <dd>
                                            이로미
                                            <span class="label-outline-primary">
                                                <span>기본배송지</span>
                                                <i></i>
                                            </span>
                                        </dd>
                                    </dl>
                                    <div class="order-addr">
                                        <dl>
                                            <dt>연락처</dt>
                                            <dd>
                                                <strong>010-2732-9721</strong>
                                            </dd>
                                        </dl>
                                        <dl>
                                            <dt>주소</dt>
                                            <dd>
                                                <address>
                                                    <strong>42858</strong>
                                                    <p>서울특별시 금천구 서부샛길 606 대성디폴리스 B동 1401호</p>
                                                </address>
                                            </dd>
                                        </dl>
                                    </div>
                                    <label class="order-select">
                                        <input type="radio" name="">
                                        <span>선택</span>
                                    </label>
                                </div>
                                <div class="order-delivery mt-3 md:mt-4">
                                    <dl class="order-name">
                                        <dt>받는사람</dt>
                                        <dd>이로미</dd>
                                    </dl>
                                    <div class="order-addr">
                                        <dl>
                                            <dt>연락처</dt>
                                            <dd>
                                                <strong>010-2732-9721</strong>
                                            </dd>
                                        </dl>
                                        <dl>
                                            <dt>주소</dt>
                                            <dd>
                                                <address>
                                                    <strong>42858</strong>
                                                    <p>서울특별시 금천구 서부샛길 606 대성디폴리스 B동 1401호</p>
                                                </address>
                                            </dd>
                                        </dl>
                                    </div>
                                    <label class="order-select">
                                        <input type="radio" name="">
                                        <span>선택</span>
                                    </label>
                                </div>
                                <p class="box-result mt-3 md:mt-4">나의 배송지가 없습니다.</p>
                            </div>
                            <div class="tab-pane fade" id="tabs-delicont3" role="tabpanel">
                                <table class="table-detail">
                                    <colgroup>
                                        <col class="w-22 md:w-40">
                                        <col>
                                    </colgroup>
                                    <tbody>
                                        <tr class="top-border">
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="deli-layer-item1"></label>받는 사람</p></th>
                                            <td>
                                                <input type="text" class="form-control w-57" id="deli-layer-item1">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="deli-layer-item2"></label>배송지 명</p></th>
                                            <td>
                                                <input type="text" class="form-control w-57" id="deli-layer-item2">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="deli-layer-item3"></label>연락처</p></th>
                                            <td>
                                                <div class="form-group-tel w-76">
                                                    <input type="text" class="form-control" id="deli-layer-item3">
                                                    <i>-</i>
                                                    <input type="text" class="form-control">
                                                    <i>-</i>
                                                    <input type="text" class="form-control">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="deli-layer-item4"></label>추가 연락처</p></th>
                                            <td>
                                                <div class="form-group-tel w-76">
                                                    <select name="" id="" class="form-control" id="deli-layer-item4">
                                                        <option value="선택"></option>
                                                    </select>
                                                    <i>-</i>
                                                    <input type="text" class="form-control">
                                                    <i>-</i>
                                                    <input type="text" class="form-control">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="deli-layer-item5"></label>주소</p></th>
                                            <td>
                                                <div class="form-group w-76">
                                                    <input type="text" class="form-control">
                                                    <button type="button" class="btn btn-primary" id="deli-layer-item5">우편번호 검색</button>
                                                </div>
                                                <input type="text" class="form-control mt-1.5 w-full md:mt-2">
                                                <input type="text" class="form-control mt-1.5 w-full md:mt-2">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th scope="row"><p><label for="deli-item7"></label>배송 메시지</p></th>
                                            <td>
                                                <div class="flex flex-wrap">
                                                    <select name="" id="deli-item7" class="form-control w-full sm:w-50">
                                                        <option value="">배송 메시지</option>
                                                    </select>
                                                    <input type="text" class="form-control w-full sm:flex-1 mt-1.5 sm:mt-0 sm:ml-2 sm:w-auto">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="bot-border">
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary btn-submit">확인</button>
                        <button type="button" class="btn btn-outline-primary btn-cancel" data-bs-dismiss="modal">닫기</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- //배송지 -->