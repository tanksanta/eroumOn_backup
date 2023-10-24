/*1:1상담(장기요양테스트) ==> 수급자 상담관리*/
UPDATE MNG_MENU
SET MENU_NM = '수급자 상담관리' 
WHERE MENU_NO = '74' AND MENU_URL = '/_mng/consult/recipter/list'


ALTER TABLE BPLC ADD COLUMN IF NOT EXISTS `mb_giup_matching` ENUM('Y','N') NOT NULL DEFAULT 'N' COMMENT '이로움온 매칭서비스 사용'
	
