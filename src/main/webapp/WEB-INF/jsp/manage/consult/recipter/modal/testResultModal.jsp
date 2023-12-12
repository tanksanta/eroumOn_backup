<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

    <div class="modal fade" id="grade-test-result" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <p>인정등급 예상 테스트 결과</p>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
                </div>
                <div class="modal-body">
                    <iframe  src="/test/result.html?recipientsNo=${mbrConsltVO.recipientsNo}" onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
                </div>
           </div>
        </div>
	</div>