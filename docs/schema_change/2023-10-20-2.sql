ALTER TABLE MBR_RECIPIENTS ADD DEL_YN CHAR(1) NULL DEFAULT NULL COMMENT '삭제 여부';
ALTER TABLE MBR_RECIPIENTS ADD DEL_DT DATETIME NULL DEFAULT NULL COMMENT '삭제 시간';
ALTER TABLE MBR_RECIPIENTS ADD DEL_MBR_UNIQUE_ID VARCHAR(12) NULL DEFAULT NULL COMMENT '삭제한 회원 unique ID';
ALTER TABLE MBR_RECIPIENTS ADD DEL_MNGR_UNIQUE_ID VARCHAR(12) NULL DEFAULT NULL COMMENT '삭제한 관리자 unique ID';