<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<script>
var item =
		{
	    "wear": {
	        "title": "의류",
	        "article": {
	            "material": ["제품소재","섬유의 조성 또는 혼용률을 백분율로 표시, 기능성인 경우 성적서 또는 허가서"],
	            "color": ["색상",""],
	            "size": ["치수",""],
	            "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
	            "caution": ["세탁방법 및 취급시 주의사항",""],
	            "manufacturing_ym": ["제조연월",""],
	            "warranty": ["품질보증기준",""],
	            "as": ["A/S 책임자와 전화번호",""]
	        }
	    },
	    "shoes": {
	        "title": "구두/신발",
	        "article": {
	            "material": ["제품소재", "운동화인 경우에는 겉감, 안감을 구분하여 표시"],
			    "color": ["색상",""],
			    "size": ["치수-발길이","해외사이즈 표기 시 국내사이즈 병행 표기 (mm)"],
	    		"height": ["치수-굽높이","굽 재료를 사용하는 여성화에 한함 (cm)"],
	    		"maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
	    		"madein": ["제조국",""],
	    		"caution": ["취급시 주의사항",""],
	    		"warranty": ["품질보증기준",""],
	    		"as": ["A/S 책임자와 전화번호", ""]
	    	}
	    },
	    "bag": {
		    "title": "가방",
		    "article": {
	    		"kind": ["종류",""],
	    		"material": ["소재",""],
	    		"color": ["색상",""],
	    		"size": ["크기",""],
	    		"maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
	    		"madein": ["제조국",""],
	    		"caution": ["취급시 주의사항",""],
	    		"warranty": ["품질보증기준",""],
	    		"as": ["A/S 책임자와 전화번호",""]
	    	}
	    },
	    "fashion": {
		    "title": "패션잡화(모자/벨트/액세서리)",
		    "article": {
		    	"kind": ["종류,",""],
			    "material": ["소재",""],
			    "size": ["치수",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "caution": ["취급시 주의사항",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
	    	}
	    },
	    "bedding": {
		    "title": "침구류/커튼",
		    "article": {
			    "material": ["제품소재","(섬유의 조성 또는 혼용률을 백분율로 표시) 충전재를 사용한 제품은 충전재를 함께 표기"],
			    "color": ["색상",""],
			    "size": ["치수",""],
			    "component": ["제품구성",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "caution": ["세탁방법 및 취급시 주의사항",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
			}
	    },
	    "furniture": {
		    "title": "가구(침대/소파/싱크대/DIY제품)",
		    "article": {
			    "product_name": ["품명",""],
			    "certification": ["KC 인증 필 유무","(품질경영 및 공산품안전관리법 상 안전·품질표시대상공산품에 한함)"],
			    "color": ["색상",""],
			    "component": ["구성품",""],
			    "material": ["주요소재",""],
	    		"maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)<br />구성품 별 제조자가 다른 경우 각 구성품의 제조자, 수입자"],
	    		"madein": ["제조국","구성품 별 제조국이 다른 경우 각 구성품의 제조국"],
	    		"size": ["크기",""],
	    		"delivery": ["배송·설치비용",""],
	    		"warranty": ["품질보증기준",""],
	    		"as": ["A/S 책임자와 전화번호",""]
	    	}
	    },
	    "image": {
		    "title": "영상가전 (TV류)",
		    "article": {
		    	"product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "certification": ["전기용품 안전인증 필 유무","전기용품안전관리법 상 안전인증대상전기용품, 자율안전확인대상전기용품,공급자적합성확인대상전기용품에 한함"],
			    "rated_voltage": ["정격전압","에너지이용합리화법 상 의무대상상품에 한함"],
			    "power_consumption": ["소비전력","에너지이용합리화법 상 의무대상상품에 한함"],
			    "energy_efficiency": ["에너지효율등급","에너지이용합리화법 상 의무대상상품에 한함"],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국","구성품 별 제조국이 다른 경우 각 구성품의 제조국"],
			    "size": ["크기","형태포함"],
			    "display_specification": ["화면사양", "크기,해상도, 화면비율 등"],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
		    }
	    },
	    "home": {
		    "title": "가정용전기제품(냉장고/세탁기/식기세척기/전자레인지)",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "certification": ["전기용품 안전인증 필 유무", "전기용품안전관리법 상 안전인증대상전기용품, 자율안전확인대상전기용품, 공급자적합성확인대상전기용품에 한함"],
			    "rated_voltage": ["정격전압","에너지이용합리화법 상 의무대상상품에 한함"],
			    "power_consumption": ["소비전력",
			    "에너지이용합리화법 상 의무대상상품에 한함"],
			    "energy_efficiency": ["에너지효율등급","에너지이용합리화법 상 의무대상상품에 한함"],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "size": ["크기","형태포함"							    ],
			    "display_specification": ["화면사양","크기,해상도, 화면비율 등"],
			    "warranty": ["품질보증기준",""],
	    		"as": ["A/S 책임자와 전화번호",""]
	    	}
	    },
	    "season": {
		    "title": "계절가전(에어컨/온풍기)",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "certification": ["전기용품 안전인증 필 유무", "전기용품안전관리법 상 안전인증대상전기용품, 자율안전확인대상전기용품, 공급자적합성확인대상전기용품에 한함"],
			    "rated_voltage": ["정격전압","에너지이용합리화법 상 의무대상상품에 한함"],
			    "power_consumption": ["소비전력","에너지이용합리화법 상 의무대상상품에 한함"],
			    "energy_efficiency": ["에너지효율등급","에너지이용합리화법 상 의무대상상품에 한함"],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "size": ["크기","형태 및 실외기 포함"],
			    "area": ["냉난방면적",""],
			    "installation_costs": ["추가설치비용",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
	    	}
	    },
	    "office": {
		    "title": "사무용기기(컴퓨터/노트북/프린터)",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "certification": ["KCC 인증 필 유무","전파법 상 인증대상상품에 한함, MIC 인증 필 혼용 가능"],
			    "rated_voltage": ["정격전압","에너지이용합리화법 상 의무대상상품에 한함"],
			    "power_consumption": ["소비전력","에너지이용합리화법 상 의무대상상품에 한함"],
			    "energy_efficiency": ["에너지효율등급","에너지이용합리화법 상 의무대상상품에 한함"],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국","구성품 별 제조국이 다른 경우 각 구성품의 제조국"],
			    "size": ["크기",""],
			    "weight": ["무게","무게는 노트북에 한함"],
			    "specification": ["주요사양","컴퓨터와 노트북의 경우 성능","용량, 운영체제 포함여부 등 / 프린터의 경우 인쇄 속도 등"],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
		    }
	    },
	    "optics": {
		    "title": "광학기기(디지털카메라/캠코더)",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "certification": ["KCC 인증 필 유무","전파법 상 인증대상상품에 한함, MIC 인증 필 혼용 가능"],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "size": ["크기",""],
			    "weight": ["무게",""],
			    "specification": ["주요사양",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
		    }
	    },
	    "micro": {
		    "title": "소형전자(MP3/전자사전등)",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "certification": ["KCC 인증 필 유무","전파법 상 인증대상상품에 한함, MIC 인증 필 혼용 가능"],
			    "rated_voltage": ["정격전압",""],
			    "power_consumption": ["소비전력",""],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "size": ["크기",""],
			    "weight": ["무게",""],
			    "specification": ["주요사양",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
			}
	    },
	    "mobile": {
		    "title": "휴대폰",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "certification": ["KCC 인증 필 유무","전파법 상 인증대상상품에 한함, MIC 인증 필 혼용 가능"],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자", "수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "size": ["크기",""],
			    "weight": ["무게",""],
			    "telecom": ["이동통신사",""],
			    "join_process": ["가입절차",""],
			    "extra_burden": ["소비자의 추가적인 부담사항","가입비, 유심카드 구입비 등 추가로 부담하여야 할 금액, 부가서비스, 의무사용기간, 위약금 등"],
			    "specification": ["주요사양",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
	    	}
	    },
	    "navigation": {
		    "title": "네비게이션",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "certification": ["KCC 인증 필 유무","전파법 상 인증대상상품에 한함, MIC 인증 필 혼용 가능"],
			    "rated_voltage": ["정격전압",""],
			    "power_consumption": ["소비전력",""],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "size": ["크기",""],
			    "weight": ["무게",""],
			    "specification": ["주요사양",""],
			    "update_cost": ["맵 업데이트 비용",""],
			    "freecost_period": ["무상기간",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
	    	}
	    },
	    "car": {
		    "title": "자동차용품(자동차부품/기타자동차용품)",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "released_date": ["동일모델의 출시년월",""],
			    "certification": ["자동차부품 자기인증 유무","자동차 관리법 상 인증 대상 자동차 부품에 한함"],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국","구성품 별 제조국이 다른 경우 각 구성품의 제조국"],
			    "size": ["크기",""],
			    "apply_model": ["적용차종",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
		    }
	    },
	    "medical": {
		    "title": "의료기기",
		    "article": {
	    	"product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "license_number": ["의료기기법상 허가·신고 번호","허가·신고 대상 의료기기에 한함"],
			    "advertising": ["광고사전심의필 유무",""],
			    "certification": ["전기용품안전관리법상 KC 인증 필 유무","안전인증 또는 자율안전확인 대상 전기용품에 한함"],
			    "rated_voltage": ["정격전압","전기용품에 한함"],
			    "power_consumption": ["소비전력","전기용품에 한함"],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "appliances_purpose": ["제품의 사용목적",""],
			    "appliances_usage": ["제품의 사용목적",""],
			    "display_specification": ["화면사양","(크기, 해상도, 화면비율 등)"],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
		    }
	    },
	    "kitchenware": {
		    "title": "주방용품",
		    "article": {
	    		"product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "material": ["재질",""],
			    "component": ["구성품",""],
			    "size": ["크기",""],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "import_declaration": ["식품위생법에 따른 수입 신고","식품위생법에 따른 수입 기구·용기의 경우 \"식품위생법에 따른 수입신고를 필함\"의 문구"],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
	   		}
	    },
	    "cosmetics": {
		    "title": "화장품",
		    "article": {
			    "capacity": ["용량 또는 중량",""],
			    "specification": ["제품 주요사양","피부타입, 색상(호, 번) 등"],
			    "expiration_date": ["사용기한 또는 개봉 후 사용기간","개봉 후 사용기간을 기재할 경우에는 제조연월일을 병행표기"],
			    "usage": ["사용방법",""],
			    "maker": ["제조자",""],
			    "distributor": ["제조판매업자",""],
			    "madein": ["제조국",""],
			    "mainingredient": ["주요성분","유기농 화장품의 경우 유기농 원료 함량 포함"],
			    "certification": ["식품의약품안전청 심사 필 유무","기능성 화장품의 경우 화장품법에 따른 식품의약품안전청 심사 필 유무 (미백, 주름개선, 자외선차단 등)"],
			    "caution": ["사용할 때 주의사항",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
	    	}
	    },
	    "jewelry": {
		    "title": "귀금속/보석/시계류",
		    "article": {
			    "material": ["소재",""],
			    "purity": ["순도",""],
			    "band": ["밴드재질","시계의 경우"],
			    "weight": ["중량",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국","원산지와 가공지 등이 다를 경우 함께 표기"],
			    "size": ["치수",""],
			    "caution": ["착용 시 주의사항",""],
			    "specification": ["주요사양","귀금속, 보석류는 등급, 시계는 기능, 방수 등"],
			    "provide_warranty": ["보증서 제공여부",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["A/S 책임자와 전화번호",""]
	    	}
	    },
	    "food": {
		    "title": "식품(농수산물)",
		    "article": {
			    "weight": ["포장단위별 용량(중량)",""],
			    "quantity": ["포장단위별 수량",""],
			    "size": ["포장단위별 크기",""],
			    "producer": ["생산자","수입품의 경우 수입자를 함께 표기"],
			    "origin": ["원산지","농수산물의 원산지 표시에 관한 법률에 따른 원산지"],
			    "manufacturing_ymd": ["제조연월일","포장일 또는 생산연도"],
			    "expiration_date": ["유통기한 또는 품질유지기한",""],
			    "law_content": ["관련법상 표시사항", "농산물 - 농산물품질관리법상 유전자변형농산물 표시, 지리적표시<br />축산물 - 축산법에 따른 등급 표시, 쇠고기의 경우 이력관리에 따른 표시 유무<br />수산물 - 수산물품질관리법상 유전자변형수산물 표시, 지리적표시<br />수입식품에 해당하는 경우  \"식품위생법에 따른 수입신고를 필함\"의 문구"],
			    "product_composition": ["상품구성",""],
			    "keep": ["보관방법 또는 취급방법",""],
			    "as": ["소비자상담 관련 전화번호",""]
	    	}
	    },
	    "general_food": {
		    "title": "가공식품",
		    "article": {
			    "food_type": ["식품의 유형",""],
			    "producer": ["생산자",""],
			    "location": ["소재지","수입품의 경우 수입자를 함께 표기"],
			    "manufacturing_ymd": ["제조연월일",""],
			    "expiration_date": ["유통기한 또는 품질유지기한",""],
			    "weight": ["포장단위별 용량(중량)", ""],
			    "quantity": ["포장단위별 수량",""],
			    "ingredients": ["원재료명 및 함량","농수산물의 원산지 표시에 관한 법률에 따른 원산지 표시 포함"],
			    "nutrition_component": ["영양성분","식품위생법에 따른 영양성분 표시대상 식품에 한함"],
			    "genetically_modified": ["유전자재조합식품에 해당하는 경우의 표시",""],
			    "baby_food": ["영유아식 또는 체중조절식품 등에 해당하는 경우 표시광고 사전심의필",""],
			    "imported_food": ["수입식품에 해당하는 경우 “식품위생법에 따른 수입신고를 필함”의 문구",""],
			    "as": ["소비자상담 관련 전화번호",""]
	    	}
	    },
	    "diet_food": {
		    "title": "건강기능식품",
		    "article": {
			    "food_type": ["식품의 유형",""],
			    "producer": ["생산자",""],
			    "location": ["소재지","수입품의 경우 수입자를 함께 표기"],
			    "manufacturing_ymd": ["제조연월일",""],
			    "expiration_date": ["유통기한 또는 품질유지기한",""],
			    "waight": ["포장단위별 용량(중량)", ""],
			    "quantity": ["포장단위별 수량",""],
			    "ingredients": ["원재료명 및 함량","농수산물의 원산지 표시에 관한 법률에 따른 원산지 표시 포함"],
			    "nutrition": ["영양정보",""],
			    "specification": ["기능정보",""],
			    "intake": ["섭취량,섭취방법 및 섭취 시 주의사항",""],
			    "disease": ["질병의 예방 및 치료를 위한 의약품이 아니라는 내용의 표현",""],
			    "genetically_modified": ["유전자재조합식품에 해당하는 경우의 표시",""],
			    "display_ad": ["표시광고 사전심의필",""],
			    "imported_food": ["수입식품에 해당하는 경우 \"건강기능식품에 관한 법률에 따른 수입신고를 필함\"의 문구",""],
			    "as": ["소비자상담 관련 전화번호",""]
		    }
	    },
	    "kids": {
		    "title": "영유아용품",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "certification": ["KC 인증 필","품질경영 및 공산품안전관리법 상 안전인증대상 또는 자율안전확인대상 공산품에 한함"],
			    "size": ["크기",""],
			    "weight": ["중량",""],
			    "color": ["색상",""],
			    "material": ["재질","섬유의 경우 혼용률"],
			    "age": ["사용연령",""],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "caution": ["취급방법 및 취급시 주의사항","안전표시 (주의, 경고 등)"],
			    "warranty": ["품질보증기준",""],
			    "as": ["소비자상담 관련 전화번호",""]
	    	}
	    },
	    "instrument": {
		    "title": "악기",
		    "article": {
			    "size": ["크기",""],
			    "color": ["색상",""],
			    "material": ["재질",""],
			    "components": ["제품구성",""],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "detailed_specifications": ["상품별 세부 사양",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["소비자상담 관련 전화번호",""]
	    	}
	    },
	    "sports": {
		    "title": "스포츠용품",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "size": ["크기",""],
			    "weight": ["중량",""],
			    "color": ["색상",""],
			    "material": ["재질",""],
			    "components": ["제품구성",""],
			    "released_date": ["동일모델의 출시년월",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "madein": ["제조국",""],
			    "detailed_specifications": ["상품별 세부 사양",""],
			    "warranty": ["품질보증기준",""],
			    "as": ["소비자상담 관련 전화번호",""]
	    	}
	    },
	    "books": {
		    "title": "서적",
		    "article": {
			    "product_name": ["도서명",""],
			    "author": ["저자",""],
			    "publisher": ["출판사",""],
			    "size": ["크기","전자책의 경우 파일의 용량"],
			    "pages": ["쪽수","전자책의 경우 제외"],
			    "components": ["제품구성","전집 또는 세트일 경우 낱권 구성, CD 등"],
			    "publish_date": ["출간일",""],
			    "description": ["목차 또는 책소개",""]
	    	}
	    },
	    "reserve": {
		    "title": "호텔/펜션예약",
		    "article": {
			    "location": ["국가 또는 지역명",""],
			    "lodgment_type": ["숙소형태",""],
			    "grade": ["등급",""],
			    "room_type": ["객실타입",""],
			    "room_capacity": ["사용가능인원",""],
			    "extra_person_charge": ["인원 추가시 비용",""],
			    "facilities": ["부대시설",""],
			    "provided_service": ["제공서비스","조식 등"],
			    "cancellation_policy": ["취소규정","환불 위약금 등"],
			    "booking_contacts": ["예약담당 연락처",""]
	    	}
	    },
	    "travel": {
		    "title": "여행패키지",
		    "article": {
			    "travel_agency": ["여행사",""],
			    "flight": ["이용항공편",""],
			    "travel_period": ["여행기간",""],
			    "schedule": ["일정",""],
			    "maximum_people": ["총예정인원",""],
			    "minimum_people": ["출발가능인원",""],
			    "accomodation_info": ["숙박정보",""],
			    "details": ["포함내역", "식사, 인솔자, 공연관람 등"],
			    "additional_charge": ["추가 경비 항목과 금액", "유류할증료, 공항이용료, 관광지 입장료, 안내원수수료, 식사비용, 선택사항 등"],
			    "cancellation_policy": ["취소규정", "환불, 위약금 등"],
			    "travel_warnings": ["해외여행의 경우 외교통상부가 지정하는 여행경보단계",""],
			    "booking_contacts": ["예약담당 연락처",""]
	    	}
	    },
	    "airline": {
		    "title": "항공권",
		    "article": {
			    "charge_condition": ["요금조건",""],
			    "round_trip": ["왕복·편도 여부",""],
			    "expiration_date": ["유효기간",""],
			    "restriction": ["제한사항","출발일, 귀국일 변경가능 여부 등"],
			    "ticket_delivery_mean": ["티켓수령방법",""],
			    "seat_type": ["좌석종류",""],
			    "additional_charge": ["추가 경비 항목과 금액","유류할증료, 공항이용료 등"],
			    "cancellation_policy": ["취소 규정","환불, 위약금 등"],
			    "booking_contacts": ["예약담당 연락처",""]
	    	}
	    },
	    "rent_car": {
		    "title": "자동차대여서비스(렌터카)",
		    "article": {
			    "model": ["차종",""],
			    "ownership_transfer": ["소유권 이전 조건","소유권이 이전되는 경우에 한함"],
			    "additional_charge": ["추가 선택 시 비용","자차면책제도, 내비게이션 등"],
			    "fuel_cost": ["차량 반환 시 연료대금 정산 방법",""],
			    "vehicle_breakdown": ["차량의 고장·훼손 시 소비자 책임",""],
			    "cancellation_policy": ["예약취소 또는 중도 해약 시 환불 기준",""],
			    "as": ["소비자상담 관련 전화번호",""]
	    	}
	    },
	    "rental_water": {
		    "title": "물품대여서비스(정수기,비데,공기청정기 등",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "transfer_of_ownership": ["소유권 이전 조건","소유권이 이전되는 경우에 한함"],
			    "maintenance": ["유지보수 조건","점검·필터교환 주기, 추가 비용 등"],
			    "consumer_responsibility": ["상품의 고장·분실·훼손 시 소비자 책임",""],
			    "refund": ["중도 해약 시 환불 기준",""],
			    "specification": ["제품 사양", "용량, 소비전력 등"],
			    "as": ["소비자상담 관련 전화번호",""]
	    	}
	    },
	    "rental_etc": {
		    "title": "물품대여서비스(서적,유아용품,행사용품 등)",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "transfer_of_ownership": ["소유권 이전 조건","소유권이 이전되는 경우에 한함"],
			    "consumer_responsibility": ["상품의 고장·분실·훼손 시 소비자 책임",""],
			    "refund": ["중도 해약 시 환불 기준",""],
			    "as": ["소비자상담 관련 전화번호",""]
	    	}
	    },
	    "digital": {
		    "title": "디지털콘텐츠(음원,게임,인터넷강의 등)",
		    "article": {
			    "producer": ["제작자 또는 공급자",""],
			    "terms_of_use": ["이용조건",""],
			    "use_period": ["이용기간",""],
			    "product_offers": ["상품 제공 방식","CD, 다운로드, 실시간 스트리밍 등"],
			    "minimum_system": ["최소 시스템 사양, 필수 소프트웨어",""],
			    "transfer_of_ownership": ["소유권 이전 조건","소유권이 이전되는 경우에 한함"],
			    "maintenance": ["청약철회 또는 계약의 해제·해지에 따른 효과",""],
			    "as": ["소비자상담 관련 전화번호",""]
	    	}
	    },
	    "gift_card": {
		    "title": "상품권/쿠폰",
		    "article": {
			    "isseur": ["발행자",""],
			    "expiration_date": ["유효기간",""],
			    "terms_of_use": ["이용조건","유효기간 경과 시 보상 기준, 사용제한품목 및 기간 등"],
			    "use_store": ["이용 가능 매장",""],
			    "refund_policy": ["잔액 환급 조건",""],
			    "as": ["소비자상담 관련 전화번호",""]
	    	}
	    },
	    "etc": {
		    "title": "기타",
		    "article": {
			    "product_name": ["품명",""],
			    "model_name": ["모델명",""],
			    "certified_by_law": ["법에 의한 인증·허가 등을 받았음을 확인할 수 있는 경우 그에 대한 사항",""],
			    "origin": ["제조국 또는 원산지",""],
			    "maker": ["제조자","수입품의 경우 수입자를 함께 표기 (병행수입의 경우 병행수입 여부로 대체 가능)"],
			    "as": ["A/S 책임자와 전화번호 또는 소비자상담 관련 전화번호",""]
	    	}
	    }
    }
</script>