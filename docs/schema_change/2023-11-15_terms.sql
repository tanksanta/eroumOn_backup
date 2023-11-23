CREATE TABLE `TERMS_M1` (
	`TERMS_NO` INT(11) NOT NULL AUTO_INCREMENT,
	`TERMS_KIND` VARCHAR(20) NOT NULL COMMENT '약관종류(TERMS : 이용약관, PRIVACY:개인정보 처리방침, PROVISION : 개인정보 제공, THIRD_PARTIES : 개인정보 제3자 제공)' COLLATE 'utf8mb4_unicode_ci',
	`TERMS_DT` VARCHAR(10) NOT NULL COMMENT '약관 날짜' COLLATE 'utf8mb4_unicode_ci',
	`USE_YN` VARCHAR(10) NOT NULL COMMENT 'YN' COLLATE 'utf8mb4_unicode_ci',
	`PUBLIC_YN` VARCHAR(10) NOT NULL COMMENT 'YN' COLLATE 'utf8mb4_unicode_ci',
	`DEL_YN` VARCHAR(10) NOT NULL COMMENT 'YN' COLLATE 'utf8mb4_unicode_ci',
	`CONTENT_HEADER` LONGTEXT NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`CONTENT_BODY` LONGTEXT NOT NULL COMMENT '내용' COLLATE 'utf8mb4_unicode_ci',
	`REG_UNIQUE_ID` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`REG_DT` DATETIME NOT NULL DEFAULT current_timestamp(),
	`REG_ID` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`RGTR` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_unicode_ci',
	`MDFCN_UNIQUE_ID` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`MDFCN_DT` DATETIME NULL DEFAULT NULL,
	`MDFCN_ID` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`MDFR` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`DEL_UNIQUE_ID` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	`DEL_DT` DATETIME NULL DEFAULT NULL,
	`DEL_ID` VARCHAR(20) NULL DEFAULT NULL COLLATE 'utf8mb4_unicode_ci',
	PRIMARY KEY (`TERMS_NO`) USING BTREE,
	INDEX `TERMS_KIND` (`TERMS_KIND`) USING BTREE
)
COLLATE='utf8mb4_unicode_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

INSERT INTO `MNG_MENU` ( `UP_MENU_NO`, `MENU_NM`, `MENU_URL`              , `ICON`, `MENU_TY`, `LEVEL_NO`, `SORT_NO`, `USE_YN`)
VALUES
                        (9            , '약관관리', '#'                     , '' , '2'       , 1         , 2         , 'Y')
;

SET @upMenuNo := last_insert_id();

INSERT INTO `MNG_MENU` (`UP_MENU_NO`, `MENU_NM`, `MENU_URL`                                 , `ICON`, `MENU_TY`, `LEVEL_NO`, `SORT_NO`, `USE_YN`)
VALUES
                  (@upMenuNo        , '이용약관', '/_mng/sysmng/terms/terms/list'           , '' , '2'          , 1        , 1         , 'Y')
				  , (@upMenuNo      , '개인정보 처리방침', '/_mng/sysmng/terms/privacy/list', '' , '2'          , 1         , 2         , 'Y')
;
 
/*
INSERT INTO `MNG_AUTHRT_MENU` (`AUTHRT_NO`, `MENU_NO`, `AUTHRT_YN`, `INQ_YN`, `WRT_YN`) VALUES
                    	        (1      , 76         , 'Y'           , 'N'   , 'N')
                                ,(1      , 78         , 'Y'           , 'N'   , 'N')
                                ,(1      , 79         , 'Y'           , 'N'   , 'N')
;
*/