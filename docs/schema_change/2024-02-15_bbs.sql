ALTER TABLE BBS_SETUP ADD BBS_CD VARCHAR(50) NOT NULL DEFAULT '' COMMENT '게시판 코드';

/*--매칭앱 공지사항을 반듯이 만들어야 한다.
INSERT INTO BBS_SETUP
BBS_CD = 'machingapp_notice'
*/