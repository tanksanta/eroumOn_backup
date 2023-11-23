<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script src="/html/page/admin/assets/script/_mng/sysmng/terms/JsHouseMngTermsForm.js?v=<spring:eval expression="@version['assets.version']"/>"></script>

<form:form name="frm" id="frm" modelAttribute="termsVO" method="post" action="./action" enctype="multipart/form-data" class="form-horizontal">
    <form:hidden path="crud" />
    <input type="hidden" name="termsKind" id="termsKind" value="${termsKind}" />
    <input type="hidden" name="termsNo" id="termsNo" value="${termsVO.termsNo}" />
    <input type="hidden" name="oldUseYn" id="oldUseYn" value="${termsVO.crud eq 'CREATE' ? 'N' : termsVO.useYn }" />
    <input type="hidden" name="returnUrl" id="returnUrl" value="${header.referer}" />

    <p class="text-title2 mt-13">[${termsKindCode[termsKind]}]
        <c:choose>
            <c:when test="${termsVO.crud eq 'CREATE'}">등록</c:when>
            <c:when test="${termsVO.crud eq 'UPDATE'}">수정</c:when>
        </c:choose>
        <span class="absolute left-full top-0.5 ml-1 whitespace-nowrap text-sm">
            (<span class="badge-require ml-1 mr-0.5 -translate-y-0.5"></span> 는 필수입력사항입니다.)
        </span>
    </p>

    <fieldset>
        <table class="table-detail">
            <colgroup>
                <col class="w-43">
                <col>
            </colgroup>
            <tbody>
                <tr>
                    <th scope="row"><label for="contents" class="require">업데이트 날짜</label></th>
                    <td>
                        <form:input type="date" class="form-control calendar" path="termsDt" />
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="contents" class="require">사용여부</label></th>
                    <td>
                        <div class="form-group">
                            <div class="form-check-group">
                                <c:forEach var="sttus" items="${useYnCode}">
                                    <div class="form-check">
                                        <form:radiobutton path="useYn" class="form-check-input" id="form-check-input-useYn-${sttus.key}" value="${sttus.key}" />
                                        <label class="form-check-label" for="form-check-input-useYn-${sttus.key}">${sttus.value}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="contents" class="require">공개/비공개</label></th>
                    <td>
                        <div class="form-group">
                            <div class="form-check-group">
                                <c:forEach var="sttus" items="${publicYnCode}">
                                    <div class="form-check">
                                        <form:radiobutton path="publicYn" class="form-check-input" id="form-check-input-publicYn-${sttus.key}" value="${sttus.key}" />
                                        <label class="form-check-label" for="form-check-input-publicYn-${sttus.key}">${sttus.value}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th scope="row"><label for="contents" class="require">내용</label></th>
                    <td>
                        <form:textarea path="contents" class="form-control w-full" title="내용" cols="30" rows="4" />
                    </td>
                </tr>
            </tbody>
        </table>
    </fieldset>

    <div class="btn-group mt-8 right">
        <button type="action.confirm.save" class="btn-primary large shadow btn save">${termsVO.crud eq 'CREATE'?'저장':'적용' }</button>
        <button type="button" class="btn-secondary large shadow btn list">목록</button>
        
    </div>
</form:form>

<script>
    var ctlMaster;
	$(document).ready(function(){
		ctlMaster = new JsHouseMngTermsForm();
		ctlMaster.fn_page_init();
	});
</script>