/* 담당자 핸드폰 번호 업데이트
    ==>사업소 매칭에서 받은 담당자 연락처로 업데이트
UPDATE BPLC aa
INNER JOIN Z_TEMP_BPLC_MAPPING_231107 bb ON aa.BPLC_ID = bb.mb_id
SET aa.PIC_TELNO = bb.phone
	, aa.remark = '담당자 폰 업데이트'
WHERE aa.PIC_TELNO != bb.phone
	AND bb.phone LIKE '010%'
	AND aa.bplc_id NOT IN ('hula1202', 'thkc_platform')
;

SELECT aa.*, aa.PIC_NM, bb.*
FROM BPLC aa
INNER JOIN Z_TEMP_BPLC_MAPPING_231107 bb ON aa.BPLC_ID = bb.mb_id
WHERE aa.PIC_NM != bb.mb_giup_boss_name

	AND aa.BPLC_ID NOT IN ('dglee94', 'hula1202', 'thkc_platform')
;
*/