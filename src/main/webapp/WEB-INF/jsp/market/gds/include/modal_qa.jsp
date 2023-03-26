<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

			<div class="modal fade" id="modal-request" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                	<form id="frmGdsQa" name="frmGdsQa" method="post" action="./action" enctype="multipart/form-data"  >
                	<input type="hidden" name="crud" value="CREATE">
                	<input type="hidden" name="qaNo" value="0">
                    <div class="modal-content">
                        <div class="modal-header">
                            <p class="text-title">상품문의</p>
                        </div>
                        <div class="modal-close">
                            <button type="button" data-bs-dismiss="modal">모달 닫기</button>
                        </div>
                        <div class="modal-body">
                            <p class="text-alert">
                                본 게시판과 관련이 없거나 광고성, 단순반복성, 저작권침해 등 불건전한 내용을 올리실 경우
                                통보 없이 임의로 삭제 처리될 수 있습니다.
                            </p>
                            <table class="table-detail mt-4">
                                <colgroup>
                                    <col class="w-20 md:w-22">
                                    <col>
                                </colgroup>
                                <tbody>
                                    <tr class="top-border">
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th scope="row"><p><label for="qestnCn">문의내용</label></p></th>
                                        <td>
                                            <textarea name="qestnCn" id="qestnCn" cols="30" rows="10" class="form-control w-full h-33 md:h-44"></textarea>
                                            <div class="flex items-center mt-3">
                                                <label for="secretYn" class="text-gray1 font-medium mr-2">공개여부</label>
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" id="secretYn" name="secretYn" value="Y">
                                                    <label class="form-check-label" for="secretYn">비공개</label>
                                                </div>
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
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary btn-submit">저장</button>
                            <button type="button" class="btn btn-outline-primary btn-cancel">닫기</button>
                        </div>
                    </div>
                    </form>
                </div>
            </div>
