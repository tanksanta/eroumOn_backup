// 위에 배너형 진행바 상태값 변경
function setPrograssBar(percent, curCount) {
	const percentText = percent + '%';
	$('.bubble').css('width', percentText);
	$('.percent').text(percentText);
	
	const countText = $('.bubble .font-bold').text();
	const counts = countText.split('/');
	$('.bubble .font-bold').text(curCount + "/" + counts[1]);
}