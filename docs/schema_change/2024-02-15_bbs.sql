ALTER TABLE BBS_SETUP ADD SRVC_CD VARCHAR(50) NOT NULL DEFAULT '' COMMENT '도메인';
ALTER TABLE BBS_SETUP ADD BBS_CD VARCHAR(50) NOT NULL DEFAULT '' COMMENT '게시판 코드';

/*--매칭앱 공지사항을 반듯이 만들어야 한다.
INSERT INTO BBS_SETUP
machingapp, ntce, 매칭앱 공지사항

1 , eroumon, ntce, 공지사항
2, eroumon, faq, FAQ 게시판
*/