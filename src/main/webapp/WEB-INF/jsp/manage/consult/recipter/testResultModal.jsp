<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="modal fade" id="grade-test-result" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered  modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <p>결과 상세보기</p>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="close"></button>
            </div>
            <div class="modal-body">
                <iframe  src="/test/result.html?recipientsNo=2" onload="this.before((this.contentDocument.body||this.contentDocument).children[0]);this.remove()"></iframe>
            </div>
        </div>
    </div>
</div>

