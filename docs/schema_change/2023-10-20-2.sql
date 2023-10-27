ALTER TABLE MBR_RECIPIENTS ADD DEL_YN CHAR(1) NULL DEFAULT NULL COMMENT '삭제 여부';
ALTER TABLE MBR_RECIPIENTS ADD DEL_DT DATETIME NULL DEFAULT NULL COMMENT '삭제 시간';
ALTER TABLE MBR_RECIPIENTS ADD DEL_MBR_UNIQUE_ID VARCHAR(12) NULL DEFAULT NULL COMMENT '삭제한 회원 unique ID';
ALTER TABLE MBR_RECIPIENTS ADD DEL_MNGR_UNIQUE_ID VARCHAR(12) NULL DEFAULT NULL COMMENT '삭제한 관리자 unique ID';


ALTER TABLE MBR_CONSLT ADD MDFCN_DT DATETIME NULL DEFAULT NULL COMMENT '수정 시간';
ALTER TABLE MBR_CONSLT ADD MDFCN_MNGR_UNIQUE_ID VARCHAR(12) NULL DEFAULT NULL COMMENT '수정한 관리자 unique ID';
ALTER TABLE MBR_CONSLT ADD MDFCN_MNGR_ID VARCHAR(100) NULL DEFAULT NULL COMMENT '수정한 관리자 ID';
ALTER TABLE MBR_CONSLT ADD MDFCN_MNGR_NM VARCHAR(100) NULL DEFAULT NULL COMMENT '수정한 관리자명';


ALTER TABLE MBR_CONSLT ADD CUR_CONSLT_RESULT_NO INT(11) NULL DEFAULT NULL COMMENT '현재 매칭된 사업소 상담 번호';