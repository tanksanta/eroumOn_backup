<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="wrapper">
	
    <!-- 상단 뒤로가기 버튼 추가 -->
    <jsp:include page="/WEB-INF/jsp/app/matching/common/topButton.jsp">
        <jsp:param value="" name="addButton" />
    </jsp:include>

    <main>
        <section class="intro">
            care_intro
            가나다라
        </section>
        

    </main>
    
		<footer class="page-footer">

            <div class="relative">
                <a class="waves-effect btn-large btn_primary w100p" onclick="fn_next_click()">다음</a>
            </div>

        </footer>
</div>

<script>
    async function fn_next_click(){
        var recipientsCnt = "${recipientsCnt}";

        if (parseInt(recipientsCnt) == 0){
            const asyncConfirm = await showConfirmPopup('어르신을 등록해 주세요', '혜택을 받으려면 정확한 어르신 정보가 필요해요.', '등록하기');
            if (asyncConfirm != 'confirm'){
                return;
            }
        }else{
            var url = 'start';
            location.href = url;
        }
    }
</script>