//localStorage 모듈
function saveInLocalStorage(key, str) {
	sessionStorage.setItem(key, str);
}

function saveInLocalStorageForObj(key, obj) {
	saveInLocalStorage(key, JSON.stringify(obj));
}

function getInLocalStorage(key) {
	return sessionStorage.getItem(key);
}

function getInLocalStorageForObj(key) {
	var str = getInLocalStorage(key);
	if (!str) {
		return;
	}

	return JSON.parse(str);
}

var historyKey = 'historyStack';
var historyStackSize = 100;
function getHistoryStack() {
	var historyStack = getInLocalStorageForObj(historyKey);
	if (historyStack) {
		return historyStack;
	} else {
		return [];
	}
}

function setHistoryStack(stack) {
	saveInLocalStorageForObj(historyKey, stack);
}

//prevCnt 몇단계 페이지를 반환할 것인지 0:현재페이지, -1:이전페이지, -2:전전페이지
function popHistoryStack(prevCnt) {
	var historyStack = getInLocalStorageForObj(historyKey);
	if (!historyStack) {
		return;
	}

	var history = null;
	if (prevCnt && prevCnt < 0) {
		var absNum = Math.abs(prevCnt);
		var deletedArr = historyStack.splice((historyStack.length - 1) + prevCnt, (absNum + 1));
		history = deletedArr[0];
	} else {
		history = historyStack.pop();
	}
	setHistoryStack(historyStack);
	return history;
}

function pushHistoryStack(history) {
	var historyStack = getInLocalStorageForObj(historyKey);
	if (!historyStack) {
		historyStack = [];
	}

	if (historyStack.length > 0 && historyStack[historyStack.length - 1] == history){
		return;
	}

	historyStack.push(history);
	if(historyStack.length > historyStackSize) {
		historyStack.shift();
	}
	setHistoryStack(historyStack);
}

function clearHistoryStack() {
	setHistoryStack([]);
}