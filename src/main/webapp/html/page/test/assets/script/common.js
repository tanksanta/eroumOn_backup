// 위에 배너형 진행바 상태값 변경
function setPrograssBar(percent, curCount) {
	const percentText = percent + '%';
	$('.bubble').css('width', percentText);
	$('.percent').text(percentText);
	
	const countText = $('.bubble .font-bold').text();
	const counts = countText.split('/');
	$('.bubble .font-bold').text(curCount + "/" + counts[1]);
}

// 테스트 정보 저장 ajax
function saveTestResultAjax(requestJson, redirectUrl) {
	$.ajax({
		type: "post",
		url: "/test/result/save.json",
		data: requestJson,
		contentType: "application/json",
		dataType : 'json'
	})
	.done(function(res) {
		if (res.success) {
			location.href = redirectUrl;						
		} else {
			alert('테스트 결과 정보 저장 실패');
		}
	})
	.fail(function(data, status, err) {
		alert('통신중 오류가 발생하였습니다.');
	});
}

// 테스트 정보 조회 ajax
function getTestResultAjax() {
	var result = null;
	$.ajax({
		type: "get",
		url: "/test/result.json",
		dataType : 'json',
		async: false
	})
	.done(function(res) {
		if (res.success) {
			result = JSON.parse(res.mbrTestResult);
		} 
	})
	.fail(function(data, status, err) {
		alert('통신중 오류가 발생하였습니다.');
	});
	return result;
}


// 행동변화대응 수형분석도에 의한 행동변화대응 점수결과
function InspectBehaviorResult (
    physicalScore,     //신체영역 점수
    physicalScores,    //신체영역 선택 정보
    cognitiveScore,    //인지기능 점수
    behaviorScore,     //행동변화 점수
    behaviorScores,    //행동변화 선택 정보
) {
    //4 depth nodes
    const node13 = {
        score: 2.2,
        children: null,
        condition: () => (physicalScores[1] === 1 || physicalScores[1] === 2),   //세수하기(완전자립, 부분도움)
    };
    const node14 = {
        score: 3.2,
        children: null,
        condition: () => physicalScores[1] === 3,   //세수하기(완전도움)
    };
    
    //3 depth nodes
    const node7 = {
        score: 0.6,
        children: null,
        condition: () => physicalScore <= 17.71,
    };
    const node8 = {
        score: 0.8,
        children: null,
        condition: () => physicalScore > 17.71,
    };
    const node9 = {
        score: 0.9,
        children: null,
        condition: () => cognitiveScore <= 60.24,
    };
    const node10 = {
        score: 1.3,
        children: null,
        condition: () => cognitiveScore > 60.24,
    };
    const node11 = {
        score: 1.6,
        children: null,
        condition: () => behaviorScores[8] === 0,   //밖으로 나가려함(무)
    };
    const node12 = {
        score: 2.6,
        children: [node13, node14],
        condition: () => behaviorScores[8] === 1,   //밖으로 나가려함(유)
    };

    //2 depth nodes
    const node3 = {
        score: 0.7,
        children: [node7, node8],
        condition: () => behaviorScore <= 7.79,
    };
    const node4 = {
        score: 1.1,
        children: [node9, node10],
        condition: () => behaviorScore > 7.79,
    };
    const node5 = {
        score: 1.4,
        children: null,
        condition: () => behaviorScore <= 39.21,
    };
    const node6 = {
        score: 2.0,
        children: [node11, node12],
        condition: () => behaviorScore > 39.21,
    };

    //1 depth nodes
    const node1 = {
        score: 0.9,
        children: [node3, node4],
        condition: () => behaviorScore <= 34.69,
    };
    const node2 = {
        score: 1.9,
        children: [node5, node6],
        condition: () => behaviorScore > 34.69,
    };

    //최상위 노드
    const rootNode = {
        score: 1.3,
        children: [node1, node2],
        condition: () => true
    };

    //자식 노드가 없을 때까지 순회하여 결과 점수를 출력
    let searchNode = rootNode;
    while (true) {
        if (searchNode == undefined) {
            return 0;
        }

        if (searchNode.children == null) {
            return searchNode.score;
        } else {
            searchNode = searchNode.children.find(f => f.condition());
        }
    }
}

// 청결 수형분석도에 의한 청결 점수결과
function InspectCleanResult (
    physicalScore,     //신체영역 점수
    physicalScores,    //신체영역 선택 정보
    cognitiveScore,    //인지기능 점수
    cognitiveScores,   //인지기능 선택 정보
    rehabilitateScore, //재활영역 점수
    behaviorScore,     //행동변화 점수
) {
    //5 depth nodes
    const node23 = {
        score: 15.4,
        children: null,
        condition: () => behaviorScore <= 60.34,
    }
    const node24 = {
        score: 15.4,
        children: null,
        condition: () => behaviorScore > 60.34,
    }

    //4 depth nodes
    const node15 = {
        score: 1.2,
        children: null,
        condition: () => physicalScore <= 6.59,
    }
    const node16 = {
        score: 3.0,
        children: null,
        condition: () => physicalScore > 6.59,
    }
    const node17 = {
        score: 2.9,
        children: null,
        condition: () => cognitiveScore <= 39.21,
    }
    const node18 = {
        score: 4.1,
        children: null,
        condition: () => cognitiveScore > 39.21,
    }
    const node19 = {
        score: 9.0,
        children: null,
        condition: () => cognitiveScores[1] === 0,  //날짜 불인지 여부(무)
    }
    const node20 = {
        score: 13.0,
        children: null,
        condition: () => cognitiveScores[1] === 1,  //날짜 불인지 여부(유)
    }
    const node21 = {
        score: 16.4,
        children: [node23, node24],
        condition: () => rehabilitateScore <= 40.16,
    }
    const node22 = {
        score: 17.2,
        children: null,
        condition: () => rehabilitateScore > 40.16,
    }

    //3 depth nodes
    const node7 = {
        score: 1.7,
        children: [node15, node16],
        condition: () => cognitiveScore <= 9.86,
    }
    const node8 = {
        score: 3.4,
        children: [node17, node18],
        condition: () => cognitiveScore > 9.86,
    }
    const node9 = {
        score: 5.3,
        children: null,
        condition: () => cognitiveScores[3] === 0,  //나이,생년월일 불인지 여부(무)
    }
    const node10 = {
        score: 8.0,
        children: null,
        condition: () => cognitiveScores[3] === 1,  //나이,생년월일 불인지 여부(유)
    }
    const node11 = {
        score: 8.6,
        children: null,
        condition: () => physicalScores[9] === 1,  //화장실 사용하기(완전자립)
    }
    const node12 = {
        score: 11.9,
        children: [node19, node20],
        condition: () => (physicalScores[9] === 2 || physicalScores[9] === 3),  //화장실 사용하기(부분도움, 완전도움)
    }
    const node13 = {
        score: 11.6,
        children: null,
        condition: () => physicalScores[9] === 1,  //화장실 사용하기(완전자립)
    }
    const node14 = {
        score: 16.8,
        children: [node21, node22],
        condition: () => (physicalScores[9] === 2 || physicalScores[9] === 3),  //화장실 사용하기(부분도움, 완전도움)
    }

    //2 depth nodes
    const node3 = {
        score: 2.6,
        children: [node7, node8],
        condition: () => physicalScore <= 17.72,
    }
    const node4 = {
        score: 6.5,
        children: [node9, node10],
        condition: () => physicalScore > 17.72,
    }
    const node5 = {
        score: 11.2,
        children: [node11, node12],
        condition: () => (physicalScores[2] === 1 ||  physicalScores[2] === 2), //양치질하기(완전자립, 부분도움)
    }
    const node6 = {
        score: 16.4,
        children: [node13, node14],
        condition: () => (physicalScores[2] === 3), //양치질하기(완전도움)
    }

    //1 depth nodes
    const node1 = {
        score: 3.9,
        children: [node3, node4],
        condition: () => physicalScore <= 34.15,
    };
    const node2 = {
        score: 14.3,
        children: [node5, node6],
        condition: () => physicalScore > 34.15,
    };

    //최상위 노드
    const rootNode = {
        score: 9.4,
        children: [node1, node2],
        condition: () => true
    };

    //자식 노드가 없을 때까지 순회하여 결과 점수를 출력
    let searchNode = rootNode;
    while (true) {
        if (searchNode == undefined) {
            return 0;
        }

        if (searchNode.children == null) {
            return searchNode.score;
        } else {
            searchNode = searchNode.children.find(f => f.condition());
        }
    }
}

// 배설 수형분석도에 의한 배설 점수결과
function InspectExcretionResult (
    physicalScore,      //신체영역 점수
    physicalScores,     //신체영역 선택 정보
    cognitiveScores,    //인지기능 선택 정보
    behaviorScore,      //행동변화 점수
    behaviorScores,     //행동변화 선택 정보
    nurseScores,        //간호처치 선택 정보
    rehabilitateScores, //재활영역 선택 정보
) {
    //6 depth nodes
    const node30 = {
        score: 0.3,
        children: null,
        condition: () => behaviorScore <= 15.58,
    };
    const node31 = {
        score: 0.7,
        children: null,
        condition: () => behaviorScore > 15.58,
    };
    const node32 = {
        score: 1.2,
        children: null,
        condition: () => cognitiveScores[1] === 0,   //날짜 불인지(무)
    };
    const node33 = {
        score: 2.5,
        children: null,
        condition: () => cognitiveScores[1] === 1,   //날짜 불인지(유)
    };

    //5 depth nodes
    const node26 = {
        score: 0.4,
        children: [node30, node31],
        condition: () => cognitiveScores[5] === 0,  //상황 판단력 감퇴(무)
    };
    const node27 = {
        score: 1.2,
        children: null,
        condition: () => cognitiveScores[5] === 1,  //상황 판단력 감퇴(유)
    };
    const node28 = {
        score: 1.0,
        children: null,
        condition: () => rehabilitateScores[8] === 1,  //무릎 관절(제한없음)
    };
    const node29 = {
        score: 1.8,
        children: [node32, node33],
        condition: () => (rehabilitateScores[8] === 2 || rehabilitateScores[8] === 3),  //무릎 관절(한쪽관절제한, 양관절제한)
    };

    //4 depth nodes
    const node16 = {
        score: 0.5,
        children: [node26, node27],
        condition: () => physicalScore === 0,
    };
    const node17 = {
        score: 1.3,
        children: [node28, node29],
        condition: () => physicalScore > 0,
    };
    const node18 = {
        score: 2.9,
        children: null,
        condition: () => physicalScores[9] === 1,   //화장실 사용하기(완전자립)
    };
    const node19 = {
        score: 5.0,
        children: null,
        condition: () => (physicalScores[9] === 2 || physicalScores[9] === 3),   //화장실 사용하기(부분도움, 완전도움)
    };
    const node20 = {
        score: 5.3,
        children: null,
        condition: () => physicalScores[1] === 1,   //세수하기(완전자립)
    };
    const node21 = {
        score: 10.2,
        children: null,
        condition: () => (physicalScores[1] === 2 || physicalScores[1] === 3),   //세수하기(부분도움, 완전도움)
    };
    const node22 = {
        score: 8.8,
        children: null,
        condition: () => (physicalScores[10] === 1 || physicalScores[10] === 2),   //대변 조절하기(완전자립, 부분도움)
    };
    const node23 = {
        score: 12.5,
        children: null,
        condition: () => (physicalScores[10] === 3),   //대변 조절하기(완전도움)
    };
    const node24 = {
        score: 12.8,
        children: null,
        condition: () => (behaviorScores[2] === 0),   //슬픈상태, 울기도함(무)
    };
    const node25 = {
        score: 18.7,
        children: null,
        condition: () => (behaviorScores[2] === 1),   //슬픈상태, 울기도함(유)
    };

    //3 depth nodes
    const node8 = {
        score: 0.9,
        children: [node16, node17],
        condition: () => physicalScores[0] === 1,   //옷 벗고 입기(완전자립)
    };
    const node9 = {
        score: 2.6,
        children: null,
        condition: () => (physicalScores[0] === 2 || physicalScores[0] === 3),   //옷 벗고 입기(부분도움, 완전도움)
    };
    const node10 = {
        score: 3.8,
        children: [node18, node19],
        condition: () => physicalScores[7] === 1,   //옮겨앉기(완전자립)
    };
    const node11 = {
        score: 8.3,
        children: null,
        condition: () => (physicalScores[7] === 2 || physicalScores[7] === 3),   //옮겨앉기(부분도움, 완전도움)
    };
    const node12 = {
        score: 9.0,
        children: [node20, node21],
        condition: () => behaviorScores[8] === 0,   //밖으로 나가려함(무)
    };
    const node13 = {
        score: 15.0,
        children: null,
        condition: () => behaviorScores[8] === 1,   //밖으로 나가려함(유)
    };
    const node14 = {
        score: 11.8,
        children: [node22, node23],
        condition: () => nurseScores[3] === 0,   //욕창간호(무)
    };
    const node15 = {
        score: 15.8,
        children: [node24, node25],
        condition: () => nurseScores[3] === 1,   //욕창간호(유)
    };

    //2 depth nodes
    const node3 = {
        score: 1.2,
        children: [node8, node9],
        condition: () => physicalScores[11] === 1,   //소변조절하기(완전자립)
    };
    const node4 = {
        score: 4.8,
        children: [node10, node11],
        condition: () => physicalScores[11] === 2,   //소변조절하기(부분도움)
    };
    const node5 = {
        score: 10.8,
        children: [node12, node13],
        condition: () => physicalScores[11] === 3,   //소변조절하기(완전도움)
    };
    const node6 = {
        score: 6.8,
        children: null,
        condition: () => physicalScores[4] === 1,   //식사하기(완전자립)
    };
    const node7 = {
        score: 12.9,
        children: [node14, node15],
        condition: () => (physicalScores[4] === 2 || physicalScores[4] === 3),   //식사하기(부분도움, 완전도움)
    };

    //1 depth nodes
    const node1 = {
        score: 3.3,
        children: [node3, node4, node5],
        condition: () => physicalScores[5] === 1,   //체위변경하기(완전자립)
    };
    const node2 = {
        score: 11.9,
        children: [node6, node7],
        condition: () => (physicalScores[5] === 2 || physicalScores[5] === 3),   //체위변경하기(부분도움, 완전도움)
    };

    //최상위 노드
    const rootNode = {
        score: 5.6,
        children: [node1, node2],
        condition: () => true
    };

    //자식 노드가 없을 때까지 순회하여 결과 점수를 출력
    let searchNode = rootNode;
    while (true) {
        if (searchNode == undefined) {
            return 0;
        }

        if (searchNode.children == null) {
            return searchNode.score;
        } else {
            searchNode = searchNode.children.find(f => f.condition());
        }
    }
}

// 기능보조 수형분석도에 의한 기능보조 점수결과
function InspectFunctionalAidResult (
    physicalScore,      //신체영역 점수
    physicalScores,     //신체영역 선택 정보
    behaviorScore,      //행동변화 점수
    behaviorScores,     //행동변화 선택 정보
    nurseScores,        //간호처치 선택 정보
    rehabilitateScores, //재활영역 선택 정보
) {
    //5 depth nodes
    const node21 = {
        score: 3.6,
        children: null,
        condition: () => rehabilitateScores[1] === 1,   //우측하지(운동장애없음)
    };
    const node22 = {
        score: 6.0,
        children: null,
        condition: () => (rehabilitateScores[1] === 2 || rehabilitateScores[1] === 3),   //우측하지(불완전운동장애, 완전운동장애)
    };

    //4 depth nodes
    const node15 = {
        score: 4.3,
        children: [node21, node22],
        condition: () => (physicalScores[2] === 1 || physicalScores[2] === 2),   //양치질하기(완전자립, 부분도움)
    };
    const node16 = {
        score: 6.8,
        children: null,
        condition: () => physicalScores[2] === 3,   //양치질하기(완전도움)
    };
    const node17 = {
        score: 6.6,
        children: null,
        condition: () => behaviorScores[10] === 0,   //의미없거나 부적절한 행동(무)
    };
    const node18 = {
        score: 9.2,
        children: null,
        condition: () => behaviorScores[10] === 1,   //의미없거나 부적절한 행동(유)
    };
    const node19 = {
        score: 6.4,
        children: null,
        condition: () => behaviorScore <= 28.83,
    };
    const node20 = {
        score: 9.3,
        children: null,
        condition: () => behaviorScore > 28.83,
    };

    //3 depth nodes
    const node7 = {
        score: 1.2,
        children: null,
        condition: () => physicalScore <= 6.59,
    };
    const node8 = {
        score: 2.7,
        children: null,
        condition: () => physicalScore > 6.59,
    };
    const node9 = {
        score: 4.9,
        children: [node15, node16],
        condition: () => physicalScores[9] === 1,   //화장실 사용하기(완전 자립)
    };
    const node10 = {
        score: 7.8,
        children: [node17, node18],
        condition: () => (physicalScores[9] === 2 || physicalScores[9] === 3),   //화장실 사용하기(부분도움, 완전도움)
    };
    const node11 = {
        score: 7.9,
        children: [node19, node20],
        condition: () => (physicalScores[6] === 1 || physicalScores[6] === 2),   //일어나 앉기(완전자립, 부분도움)
    };
    const node12 = {
        score: 10.9,
        children: null,
        condition: () => physicalScores[6] === 3,   //일어나 앉기(완전도움)
    };
    const node13 = {
        score: 14.0,
        children: null,
        condition: () => nurseScores[3] === 0,   //욕창간호(무)
    };
    const node14 = {
        score: 18.7,
        children: null,
        condition: () => nurseScores[3] === 1,   //욕창간호(유)
    };

    //2 depth nodes
    const node3 = {
        score: 2.0,
        children: [node7, node8],
        condition: () => physicalScore <= 25.14,
    };
    const node4 = {
        score: 6.0,
        children: [node9, node10],
        condition: () => physicalScore > 25.14,
    };
    const node5 = {
        score: 8.6,
        children: [node11, node12],
        condition: () => (physicalScores[2] === 1 || physicalScores[2] === 2),   //양치질하기(완전자립, 부분도움)
    };
    const node6 = {
        score: 15.1,
        children: [node13, node14],
        condition: () => physicalScores[2] === 3,   //양치질하기(완전도움)
    };

    //1 depth nodes
    const node1 = {
        score: 3.5,
        children: [node3, node4],
        condition: () => physicalScore <= 47.64,
    };
    const node2 = {
        score: 13.3,
        children: [node5, node6],
        condition: () => physicalScore > 47.64,
    };

    //최상위 노드
    const rootNode = {
        score: 7.2,
        children: [node1, node2],
        condition: () => true
    };

    //자식 노드가 없을 때까지 순회하여 결과 점수를 출력
    let searchNode = rootNode;
    while (true) {
        if (searchNode == undefined) {
            return 0;
        }

        if (searchNode.children == null) {
            return searchNode.score;
        } else {
            searchNode = searchNode.children.find(f => f.condition());
        }
    }
}

// 간접지원 수형분석도에 의한 간접지원 점수결과
function InspectIndirectSupportResult (
    physicalScore,      //신체영역 점수
    physicalScores,     //신체영역 선택 정보
    behaviorScore,      //행동변화 점수
    behaviorScores,     //행동변화 선택 정보
) {
    //6 depth nodes
    const node15 = {
        score: 19.7,
        children: null,
        condition: () => behaviorScores[3] === 0,   //불규칙수면, 주야혼돈(무)
    };
    const node16 = {
        score: 23.6,
        children: null,
        condition: () => behaviorScores[3] === 1,   //불규칙수면, 주야혼돈(유)
    };

    //5 depth nodes
    const node13 = {
        score: 17.3,
        children: null,
        condition: () => physicalScores[4] === 1,   //식사하기(완전자립)
    };
    const node14 = {
        score: 21.0,
        children: [node15, node16],
        condition: () => (physicalScores[4] === 2 || physicalScores[4] === 3),   //식사하기(부분도움, 완전도움)
    };

    //4 depth nodes
    const node11 = {
        score: 19.8,
        children: [node13, node14],
        condition: () => behaviorScores[2] === 0,   //슬픈 상태, 울기도 함(무)
    };
    const node12 = {
        score: 23.0,
        children: null,
        condition: () => behaviorScores[2] === 1,   //슬픈 상태, 울기도 함(유)
    };

    //3 depth nodes
    const node7 = {
        score: 17.6,
        children: null,
        condition: () => physicalScores[11] === 1,   //소변 조절하기(완전자립)
    };
    const node8 = {
        score: 21.2,
        children: [node11, node12],
        condition: () => (physicalScores[11] === 2 || physicalScores[11] === 3),   //소변 조절하기(부분도움, 완전도움)
    };
    const node9 = {
        score: 21.7,
        children: null,
        condition: () => behaviorScore <= 56.0
    };
    const node10 = {
        score: 28.4,
        children: null,
        condition: () => behaviorScore > 56.0
    };

    //2 depth nodes
    const node3 = {
        score: 12.5,
        children: null,
        condition: () => physicalScore <= 6.59,
    };
    const node4 = {
        score: 16.9,
        children: null,
        condition: () => physicalScore > 6.59,
    };
    const node5 = {
        score: 20.3,
        children: [node7, node8],
        condition: () => behaviorScores[8] === 0,   //밖으로 나가려함(무)
    };
    const node6 = {
        score: 26.1,
        children: [node9, node10],
        condition: () => behaviorScores[8] === 1,   //밖으로 나가려함(유)
    };

    //1 depth nodes
    const node1 = {
        score: 14.7,
        children: [node3, node4],
        condition: () => physicalScore <= 25.14,
    };
    const node2 = {
        score: 21.5,
        children: [node5, node6],
        condition: () => physicalScore > 25.14,
    };

    //최상위 노드
    const rootNode = {
        score: 18.9,
        children: [node1, node2],
        condition: () => true
    };

    //자식 노드가 없을 때까지 순회하여 결과 점수를 출력
    let searchNode = rootNode;
    while (true) {
        if (searchNode == undefined) {
            return 0;
        }

        if (searchNode.children == null) {
            return searchNode.score;
        } else {
            searchNode = searchNode.children.find(f => f.condition());
        }
    }
}

// 식사 수형분석도에 의한 식사 점수결과
function InspectMealResult (
    physicalScore,      //신체영역 점수
    physicalScores,     //신체영역 선택 정보
    behaviorScores,     //행동변화 선택 정보
    rehabilitateScore,  //재활영역 점수
) {
    //5 depth nodes
    const node17 = {
        score: 11.5,
        children: null,
        condition: () => behaviorScores[8] === 0,   //밖으로 나가려함(무)
    };
    const node18 = {
        score: 14.3,
        children: null,
        condition: () => behaviorScores[8] === 1,   //밖으로 나가려함(유)
    };
    const node19 = {
        score: 17.5,
        children: null,
        condition: () => rehabilitateScore <= 30.77,
    };
    const node20 = {
        score: 21.4,
        children: null,
        condition: () => rehabilitateScore > 30.77,
    };

    //4 depth nodes
    const node11 = {
        score: 7.1,
        children: null,
        condition: () => physicalScore <= 6.59,
    };
    const node12 = {
        score: 9.4,
        children: null,
        condition: () => physicalScore > 6.59,
    };
    const node13 = {
        score: 12.2,
        children: [node17, node18],
        condition: () => physicalScores[6] === 1,   //일어나 앉기(완전자립)
    };
    const node14 = {
        score: 15.1,
        children: null,
        condition: () => (physicalScores[6] === 2 || physicalScores[6] === 3),   //일어나 앉기(부분도움, 완전도움)
    };
    const node15 = {
        score: 13.9,
        children: null,
        condition: () => physicalScores[10] === 1,   //대변조절하기(완전자립)
    };
    const node16 = {
        score: 18.7,
        children: [node19, node20],
        condition: () => (physicalScores[10] === 2 || physicalScores[10] === 3),   //대변조절하기(부분도움, 완전도움)
    };
    
    //3 depth nodes
    const node7 = {
        score: 8.3,
        children: [node11, node12],
        condition: () => physicalScores[2] === 1,   //양치질하기(완전자립)
    };
    const node8 = {
        score: 12.9,
        children: [node13, node14],
        condition: () => physicalScores[2] === 2,   //양치질하기(부분도움)
    };
    const node9 = {
        score: 16.1,
        children: [node15, node16],
        condition: () => (physicalScores[9] === 1 || physicalScores[9] === 2),   //화장실사용하기(완전자립, 부분도움)
    };
    const node10 = {
        score: 23.4,
        children: null,
        condition: () => physicalScores[9] === 3,   //화장실사용하기(완전도움)
    };

    //2 depth nodes
    const node3 = {
        score: 10.1,
        children: [node7, node8],
        condition: () => (physicalScores[2] === 1 || physicalScores[2] === 2),   //양치질하기(완전자립, 부분도움)
    };
    const node4 = {
        score: 20.1,
        children: [node9, node10],
        condition: () => physicalScores[2] === 3,   //양치질하기(완전도움)
    };
    const node5 = {
        score: 31.7,
        children: null,
        condition: () => rehabilitateScore <= 41.21,
    };
    const node6 = {
        score: 37.6,
        children: null,
        condition: () => rehabilitateScore > 41.21,
    };

    //1 depth nodes
    const node1 = {
        score: 12.7,
        children: [node3, node4],
        condition: () => (physicalScores[4] === 1 || physicalScores[4] === 2),   //식사하기(완전자립, 부분도움)
    };
    const node2 = {
        score: 35.6,
        children: [node5, node6],
        condition: () => physicalScores[4] === 3,   //식사하기(완전도움)
    };

    //최상위 노드
    const rootNode = {
        score: 15.2,
        children: [node1, node2],
        condition: () => true
    };

    //자식 노드가 없을 때까지 순회하여 결과 점수를 출력
    let searchNode = rootNode;
    while (true) {
        if (searchNode == undefined) {
            return 0;
        }

        if (searchNode.children == null) {
            return searchNode.score;
        } else {
            searchNode = searchNode.children.find(f => f.condition());
        }
    }
}

// 간호처치 수형분석도에 의한 간호처치 점수결과
function InspectNurseResult (
    physicalScores,      //신체영역 선택 정보
    behaviorScores,      //행동변화 선택 정보
    nurseScore,          //간호처치 점수
    nurseScores,         //간호처치 선택 정보
    rehabilitateScores,  //재활영역 선택 정보
) {
    //5 depth nodes
    const node14 = {
        score: 6.7,
        children: null,
        condition: () => behaviorScores[6] === 0,   //길을 잃음(무)
    };
    const node15 = {
        score: 8.1,
        children: null,
        condition: () => behaviorScores[6] === 1,   //길을 잃음(유)
    };
    const node16 = {
        score: 7.4,
        children: null,
        condition: () => (physicalScores[2] === 1 || physicalScores[2] === 2),   //양치질하기(완전자립, 부분도움)
    };
    const node17 = {
        score: 11.6,
        children: null,
        condition: () => physicalScores[2] === 3,   //양치질하기(완전도움)
    };

    //4 depth nodes
    const node12 = {
        score: 7.1,
        children: [node14, node15],
        condition: () => rehabilitateScores[2] === 1,   //좌측상지(운동장애없음)
    };
    const node13 = {
        score: 9.5,
        children: [node16, node17],
        condition: () => (rehabilitateScores[2] === 2 || rehabilitateScores[2] === 3),   //좌측상지(불완전운동장애, 완전운동장애)
    };

    //3 depth nodes
    const node8 = {
        score: 7.6,
        children: [node12, node13],
        condition: () => behaviorScores[3] === 0,   //불규칙수면, 주야혼돈(무)
    };
    const node9 = {
        score: 9.7,
        children: null,
        condition: () => behaviorScores[3] === 1,   //불규칙수면, 주야혼돈(유)
    };
    const node10 = {
        score: 9.6,
        children: null,
        condition: () => (physicalScores[2] === 1 || physicalScores[2] === 2),   //양치질하기(완전자립, 부분도움)
    };
    const node11 = {
        score: 14.7,
        children: null,
        condition: () => physicalScores[2] === 3,   //양치질하기(완전도움)
    };

    //2 depth nodes
    const node3 = {
        score: 8.3,
        children: [node8, node9],
        condition: () => nurseScore === 0,
    };
    const node4 = {
        score: 9.6,
        children: null,
        condition: () => nurseScore === 19.84,
    };
    const node5 = {
        score: 14.6,
        children: null,
        condition: () => nurseScore > 19.84,
    };
    const node6 = {
        score: 12.4,
        children: [node10, node11],
        condition: () => (physicalScores[4] === 1 || physicalScores[4] === 2),   //식사하기(완전자립, 부분도움)
    };
    const node7 = {
        score: 22.5,
        children: null,
        condition: () => physicalScores[4] === 3,   //식사하기(완전도움)
    };

    //1 depth nodes
    const node1 = {
        score: 8.7,
        children: [node3, node4, node5],
        condition: () => nurseScores[3] === 0,   //욕창간호(무)
    };
    const node2 = {
        score: 15.4,
        children: [node6, node7],
        condition: () => nurseScores[3] === 1,   //욕창간호(유)
    };

    //최상위 노드
    const rootNode = {
        score: 9.3,
        children: [node1, node2],
        condition: () => true
    };

    //자식 노드가 없을 때까지 순회하여 결과 점수를 출력
    let searchNode = rootNode;
    while (true) {
        if (searchNode == undefined) {
            return 0;
        }

        if (searchNode.children == null) {
            return searchNode.score;
        } else {
            searchNode = searchNode.children.find(f => f.condition());
        }
    }
}

// 재활훈련 수형분석도에 의한 재활훈련 점수결과
function InspectRehabilitateResult (
    physicalScores,    //신체영역 선택 정보
    cognitiveScores,   //인지기능 선택 정보
    behaviorScores,    //행동변화 선택 정보
    rehabilitateScore, //재활영역 점수
) {
    //5 depth nodes
    const node16 = {
        score: 4.0,
        children: null,
        condition: () => physicalScores[2] === 1,    //양치질하기(완전자립)
    };
    const node17 = {
        score: 5.7,
        children: null,
        condition: () => (physicalScores[2] === 2 || physicalScores[2] === 3),    //양치질하기(부분도움, 완전도움)
    };
    const node18 = {
        score: 3.8,
        children: null,
        condition: () => physicalScores[0] === 1,    //옷 벗고 입기(완전자립)
    };
    const node19 = {
        score: 2.7,
        children: null,
        condition: () => (physicalScores[0] === 2 || physicalScores[0] === 3),    //옷 벗고 입기(부분도움, 완전도움)
    };

    //4 depth nodes
    const node14 = {
        score: 4.5,
        children: [node16, node17],
        condition: () => cognitiveScores[2] === 0,    //장소불인지(무)
    };
    const node15 = {
        score: 3.2,
        children: [node18, node19],
        condition: () => cognitiveScores[2] === 1,    //장소불인지(유)
    };

    //3 depth nodes
    const node10 = {
        score: 4.1,
        children: [node14, node15],
        condition: () => physicalScores[7] === 1,    //옮겨 앉기(완전자립)
    };
    const node11 = {
        score: 6.3,
        children: null,
        condition: () => (physicalScores[7] === 2 || physicalScores[7] === 3),    //옮겨 앉기(부분도움, 완전도움)
    };
    const node12 = {
        score: 2.1,
        children: null,
        condition: () => (physicalScores[6] === 1 || physicalScores[6] === 2),    //일어나 앉기(완전자립, 부분도움)
    };
    const node13 = {
        score: 4.2,
        children: null,
        condition: () => physicalScores[6] === 3,    //일어나 앉기(완전도움)
    };

    //2 depth nodes
    const node4 = {
        score: 2.5,
        children: null,
        condition: () => behaviorScores[6] === 0,   //길을 잃음(무)
    };
    const node5 = {
        score: 3.7,
        children: null,
        condition: () => behaviorScores[6] === 1,   //길을 잃음(유)
    };
    const node6 = {
        score: 4.6,
        children: [node10, node11],
        condition: () => (physicalScores[1] === 1 || physicalScores[1] === 2),    //세수하기(완전자립, 부분도움)
    };
    const node7 = {
        score: 3.1,
        children: [node12, node13],
        condition: () => physicalScores[1] === 3,    //세수하기(완전도움)
    };
    const node8 = {
        score: 4.8,
        children: null,
        condition: () => behaviorScores[2] === 0,    //슬픈 상태, 울기도 함(무)
    };
    const node9 = {
        score: 6.3,
        children: null,
        condition: () => behaviorScores[2] === 1,    //슬픈 상태, 울기도 함(유)
    };

    //1 depth nodes
    const node1 = {
        score: 3.0,
        children: [node4, node5],
        condition: () => rehabilitateScore === 0,
    };
    const node2 = {
        score: 4.3,
        children: [node6, node7],
        condition: () => rehabilitateScore > 0 && rehabilitateScore <= 39.46,
    };
    const node3 = {
        score: 5.5,
        children: [node8, node9],
        condition: () => rehabilitateScore > 39.46,
    };

    //최상위 노드
    const rootNode = {
        score: 4.3,
        children: [node1, node2, node3],
        condition: () => true
    };

    //자식 노드가 없을 때까지 순회하여 결과 점수를 출력
    let searchNode = rootNode;
    while (true) {
        if (searchNode == undefined) {
            return 0;
        }

        if (searchNode.children == null) {
            return searchNode.score;
        } else {
            searchNode = searchNode.children.find(f => f.condition());
        }
    }
}