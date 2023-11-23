<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script>
    var jsCommon = new JsCommon();

</script>
    <form id="searchFrm" name="searchFrm" method="get" action="./list">
    
        <fieldset>
            <legend class="text-title2">[${termsKindCode[termsKind]}] 검색</legend>
            <table class="table-detail">
                <colgroup>
                    <col class="w-43">
                    <col>
                    <col class="w-48">
                    <col>
                </colgroup>
                <tbody>
                    <tr>
                        <th scope="row"><label for="search-item1">업데이트 날짜</label></th>
                        <td colspan="3">
                            <div class="form-group">
                                <input type="date" class="form-control w-39 calendar" id="srchWrtYmdBgng" name="srchWrtYmdBgng" value="${param.srchWrtYmdBgng}">
                                <i>~</i>
                                <input type="date" class="form-control w-39 calendar" id="srchWrtYmdEnd" name="srchWrtYmdEnd" value="${param.srchWrtYmdEnd}">
                                <button type="button" class="btn shadow" onclick="jsCommon.fn_srchBtwnYmdSet('m','-1');">1개월</button>
                                <button type="button" class="btn shadow" onclick="jsCommon.fn_srchBtwnYmdSet('m','-6');">6개월</button>
                                <button type="button" class="btn shadow" onclick="jsCommon.fn_srchBtwnYmdSet('y','-1');">1년</button>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="search-item1">사용여부</label></th>
                        <td>
                            <div class="form-check-group">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="srchUseYn" id="search-item-srchUseYn-99" value="" ${empty param.srchUseYn ?'checked':''}>
                                    <label class="form-check-label" for="search-item-srchUseYn-99">전체</label>
                                </div>

                                <c:forEach items="${useYnCode}" var="iem" varStatus="status">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="srchUseYn" id="search-item-srchUseYn-${status.index}" value="${iem.key}" ${param.srchUseYn eq iem.key?'checked':''}>
                                        <label class="form-check-label" for="search-item-srchUseYn-${status.index}">${iem.value}</label>
                                    </div>

                                </c:forEach>

                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row"><label for="search-item2">공개여부</label></th>
                        <td>
                            <div class="form-check-group">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="srchPublicYn" id="search-item-srchPublicYn-99" value="" ${empty param.srchPublicYn ?'checked':''}>
                                    <label class="form-check-label" for="search-item-srchPublicYn-99">전체</label>
                                </div>

                                <c:forEach items="${publicYnCode}" var="iem" varStatus="status">
                                    <div class="form-check">
                                        <input class="form-check-input" type="radio" name="srchPublicYn" id="search-item-srchPublicYn-${status.index}" value="${iem.key}" ${param.srchPublicYn eq iem.key?'checked':''}>
                                        <label class="form-check-label" for="search-item-srchPublicYn-${status.index}">${iem.value}</label>
                                    </div>
                                </c:forEach>
                            </div>
                        </td>
                    </tr>

                </tbody>
            </table>
        </fieldset>

        <div class="btn-group mt-5">
            <button type="submit" class="btn-primary large shadow w-52">검색</button>
        </div>
    </form>

    <p class="text-title2 mt-13">[${termsKindCode[termsKind]}] 목록</p>

    <table class="table-list">
        <colgroup>
            <col class="w-50">
            <col>
            <col class="w-70">
            <col class="w-70">
            <col class="w-70">
        </colgroup>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">업데이트 날짜</th>
                <th scope="col">관리</th>
                <th scope="col">사용여부</th>
                <th scope="col">공개여부</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="resultList" items="${listVO}" varStatus="status">

                <tr>
                    <td>${status.count}</td>
                    <td>
                        ${resultList.termsDt}
                    </td>
                    <td><a href="./form?termsKind=${resultList.termsKind}&termsNo=${resultList.termsNo}" class="btn-primary w-30">수정</a></td>
                    <td>
                        ${useYnCode[resultList.useYn]}
                    </td>
                    <td>
                        ${publicYnCode[resultList.publicYn]}
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty listVO}">
                <tr>
                    <td class="noresult" colspan="5">검색조건을 만족하는 결과가 없습니다.</td>
                </tr>
            </c:if>
        </tbody>
    </table>

    <div class="btn-group mt-8">
        <a href="./form?termsKind=${termsKind}&termsNo=0" class="btn-primary large shadow">등록</a>
    </div>