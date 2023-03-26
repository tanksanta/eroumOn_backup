-- --------------------------------------------------------
-- 호스트:                          61.42.176.22
-- 서버 버전:                        10.6.8-MariaDB-log - MariaDB Server
-- 서버 OS:                        linux-systemd
-- HeidiSQL 버전:                  11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 테이블 eroumcare.ADVER_MNG 구조 내보내기
CREATE TABLE IF NOT EXISTS `ADVER_MNG` (
  `ADVER_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '광고_번호',
  `ADVER_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '광고명',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `ADVER_AREA` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '광고_영역',
  `LINK_TY` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '링크_유형',
  `LINK_URL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BGNG_DT` datetime DEFAULT NULL COMMENT '시작_일시',
  `END_DT` datetime DEFAULT NULL COMMENT '종료_일시',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`ADVER_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='광고_관리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.ATCHFILE 구조 내보내기
CREATE TABLE IF NOT EXISTS `ATCHFILE` (
  `SRVC_ID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '서비스_아이디',
  `UP_NO` int(11) NOT NULL COMMENT '상위_번호',
  `FILE_NO` int(11) NOT NULL COMMENT '파일_번호',
  `FILE_TY` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '파일_유형',
  `FLPTH` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일경로',
  `ORGNL_FILE_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '원본_파일명',
  `STRG_FILE_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '저장_파일명',
  `FILE_EXTN` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일_확장자',
  `FILE_SZ` int(11) DEFAULT NULL COMMENT '파일_크기',
  `FILE_DC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일_설명',
  `DWNLD_CNT` int(11) DEFAULT NULL COMMENT '다운로드_수',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  PRIMARY KEY (`SRVC_ID`,`UP_NO`,`FILE_NO`,`FILE_TY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='첨부파일(공통)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.BBS 구조 내보내기
CREATE TABLE IF NOT EXISTS `BBS` (
  `NTT_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시물_번호',
  `BBS_NO` int(11) DEFAULT NULL COMMENT '게시판_번호',
  `CTGRY_NO` int(11) DEFAULT NULL COMMENT '카테고리_번호',
  `NTT_GRP` int(11) DEFAULT NULL COMMENT '게시물_그룹',
  `NTT_ORDR` int(11) DEFAULT NULL COMMENT '게시물_순서',
  `NTT_LEVEL` int(11) DEFAULT NULL COMMENT '게시물_레벨',
  `TTL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제목',
  `CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '내용',
  `PSWD` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비밀번호',
  `WRTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작성자',
  `WRT_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작성_아이디',
  `WRT_YMD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작성_일자',
  `INQCNT` int(11) DEFAULT NULL COMMENT '조회수',
  `NTC_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공지_여부',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '삭제_여부',
  `SECRET_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비밀_여부',
  `IP` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '아이피',
  `ANS_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_유형',
  `ANS_TTL` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_제목',
  `ANS_CN` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_내용',
  `ANSWR` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변자',
  `ANS_ID` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_아이디',
  `ANS_YMD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_일자',
  `STTS_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상태_유형',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`NTT_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='게시판(공통)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.BBS_ATCHFILE 구조 내보내기
CREATE TABLE IF NOT EXISTS `BBS_ATCHFILE` (
  `NTT_NO` int(11) NOT NULL COMMENT '게시물_번호',
  `FILE_NO` int(11) NOT NULL COMMENT '파일_번호',
  `FILE_TY` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '파일_유형',
  `FLPTH` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일경로',
  `ORGNL_FILE_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '원본_파일명',
  `STRG_FILE_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '저장_파일명',
  `FILE_EXTN` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일_확장자',
  `FILE_SZ` int(11) DEFAULT NULL COMMENT '파일_크기',
  `FILE_DC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일_설명',
  `DWNLD_CNT` int(11) DEFAULT NULL COMMENT '다운로드 수',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  PRIMARY KEY (`NTT_NO`,`FILE_NO`,`FILE_TY`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='게시판 첨부파일';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.BBS_CTGRY 구조 내보내기
CREATE TABLE IF NOT EXISTS `BBS_CTGRY` (
  `BBS_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시판_번호',
  `CTGRY_NO` int(11) NOT NULL COMMENT '카테고리_번호',
  `CTGRY_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '카테고리_명',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  PRIMARY KEY (`BBS_NO`,`CTGRY_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='게시판 카테고리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.BBS_SETUP 구조 내보내기
CREATE TABLE IF NOT EXISTS `BBS_SETUP` (
  `BBS_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시판_번호',
  `BBS_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '게시판_명',
  `BBS_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '게시판_유형',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `SECRET_USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비밀_사용_여부',
  `EDITR_USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '에디터_사용_여부',
  `MBR_AUTHRT_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회원_권한_여부',
  `OTPT_CO` int(11) DEFAULT NULL COMMENT '출력_갯수',
  `CTGRY_USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '카테고리_사용_여부',
  `ATCHFILE_USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '첨부파일_사용_여부',
  `ATCHFILE_CNT` int(11) DEFAULT NULL COMMENT '첨부파일_수',
  `ATCHFILE_SZ` int(11) DEFAULT NULL COMMENT '첨부파일_크기',
  `ATCHFILE_PERM_EXTN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '첨부파일_허용_확장자',
  `THUMB_USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '썸네일_사용_여부',
  `PIC_SMS_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_SMS_여부',
  `PIC_SMS` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_SMS',
  `PIC_EML_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_이메일_여부',
  `PIC_EML` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_이메일',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`BBS_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='게시판 설정';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.BPLC 구조 내보내기
CREATE TABLE IF NOT EXISTS `BPLC` (
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '유일_아이디',
  `BPLC_ID` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '사업장_아이디',
  `BPLC_PSWD` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `BPLC_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업장_명',
  `TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전화번호',
  `FXNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '팩스번호',
  `PROFL_IMG` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표_이미지',
  `BSNM_CEREGRT` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자_등록증',
  `BSNM_OFFCS` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자_직인',
  `EML` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이메일',
  `RPRSV_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표자명',
  `BRNO` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자_번호',
  `RCPER_INST_NO` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '요양_기관_번호',
  `BIZCND` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업태',
  `IEM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목',
  `ZIP` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '우편번호',
  `ADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주소',
  `DADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상세주소',
  `LAT` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '위도',
  `LOT` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '경도',
  `LOC` point DEFAULT NULL COMMENT '공간좌표',
  `BPLC_URL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업소_URL',
  `DLVY_ZIP` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_우편번호',
  `DLVY_ADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_주소',
  `DLVY_DADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_상세주소',
  `PIC_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_명',
  `PIC_TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_전화번호',
  `PIC_EML` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_이메일',
  `CLCLN_BANK` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정산_은행',
  `CLCLN_ACTNO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정산_계좌번호',
  `CLCLN_DPSTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정산_예금주',
  `BSN_PIC` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업_담당자',
  `CNPT_CD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래처_코드',
  `TAXBIL_EML` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '세금계산서_이메일',
  `BSN_HR_BGNG` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업_시간_시작',
  `BSN_HR_END` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업_시간_종료',
  `HLDY` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '휴일',
  `HLDY_ETC` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '휴일_기타',
  `PARKNG_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주차_여부',
  `INTRCN` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '소개',
  `BUS_DRC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '버스_방향',
  `SUBWAY_DRC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지하철_방향',
  `CAR_DRC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자동차_방향',
  `APRV_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '승인타입',
  `APRV_DT` datetime DEFAULT NULL COMMENT '승인일시',
  `REJECT_RESN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '승인_거부_사유',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용 여부',
  `RCMDTN_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '추천_여부',
  `TRMS_AGRE_DT` datetime DEFAULT NULL COMMENT '약관동의일시',
  `JOIN_DT` datetime DEFAULT NULL COMMENT '가입_일시',
  `LGN_FAILR_CNT` int(11) DEFAULT NULL COMMENT '로그인_실패_수',
  `RECENT_CNTN_DT` datetime DEFAULT NULL COMMENT '최근_접속_일시',
  `TMPR_PSWD_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '임시_비밀번호_여부',
  `PSWD_CHG_DT` datetime DEFAULT NULL COMMENT '비밀번호_변경_일시',
  `JOIN_COURS` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '가입_경로',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`UNIQUE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사업장';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.BPLC_BBS 구조 내보내기
CREATE TABLE IF NOT EXISTS `BPLC_BBS` (
  `BPLC_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '사업장_유일_아이디',
  `NTT_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '게시물_번호',
  `TTL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제목',
  `CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '내용',
  `WRTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작성자',
  `WRT_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작성_아이디',
  `WRT_YMD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작성_일자',
  `INQCNT` int(11) DEFAULT NULL COMMENT '조회수',
  `NTC_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공지_여부',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `IP` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '아이피',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`NTT_NO`,`BPLC_UNIQUE_ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사업장_게시판';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.BPLC_BBS_ATCHFILE 구조 내보내기
CREATE TABLE IF NOT EXISTS `BPLC_BBS_ATCHFILE` (
  `BPLC_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '사업장_유일_아이디',
  `NTT_NO` int(11) NOT NULL COMMENT '게시물_번호',
  `FILE_NO` int(11) NOT NULL COMMENT '파일_번호',
  `FILE_TY` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '파일_유형',
  `FLPTH` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일경로',
  `ORGNL_FILE_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '원본_파일명',
  `STRG_FILE_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '저장_파일명',
  `FILE_EXTN` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일_확장자',
  `FILE_SZ` int(11) DEFAULT NULL COMMENT '파일_크기',
  `FILE_DC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일_설명',
  `DWNLD_CNT` int(11) DEFAULT NULL COMMENT '다운로드_수',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  PRIMARY KEY (`NTT_NO`,`FILE_NO`) USING BTREE,
  KEY `FK_BPLC_BBS_ATCHFILE_BPLC` (`BPLC_UNIQUE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사업장_게시판_첨부파일';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.BPLC_GDS 구조 내보내기
CREATE TABLE IF NOT EXISTS `BPLC_GDS` (
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '유일_아이디',
  `GDS_NO` int(11) NOT NULL COMMENT '상품_번호',
  PRIMARY KEY (`UNIQUE_ID`,`GDS_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사업장_상품';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.BPLC_NOTICE 구조 내보내기
CREATE TABLE IF NOT EXISTS `BPLC_NOTICE` (
  `NOTICE_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '공지_번호',
  `TTL` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제목',
  `CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '내용',
  `INQCNT` int(11) DEFAULT NULL,
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이용_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`NOTICE_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='사업장_공지사항';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.BRAND 구조 내보내기
CREATE TABLE IF NOT EXISTS `BRAND` (
  `BRAND_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '브랜드_번호',
  `BRAND_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '브랜드_명',
  `QLITY_GRNTE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '품질_보증',
  `TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전화번호',
  `INTRCN` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '소개',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`BRAND_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='브랜드';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.CART 구조 내보내기
CREATE TABLE IF NOT EXISTS `CART` (
  `CART_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '장바구니_번호',
  `CART_GRP_NO` int(11) DEFAULT NULL,
  `CART_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `GDS_NO` int(11) DEFAULT NULL COMMENT '상품_번호',
  `GDS_CD` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_코드',
  `BNEF_CD` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '급여_코드',
  `GDS_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_명',
  `GDS_PC` int(11) DEFAULT NULL,
  `ORDR_PC` int(11) DEFAULT NULL COMMENT '주문_가격',
  `ORDR_OPTN_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ORDR_OPTN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문_옵션',
  `ORDR_OPTN_PC` int(11) DEFAULT NULL COMMENT '주문_옵션_가격',
  `ORDR_QY` int(11) DEFAULT NULL COMMENT '주문_수량',
  `RECIPTER_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수급자_유일_아이디',
  `BPLC_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업장_유일_아이디',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  PRIMARY KEY (`CART_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='장바구니';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.CNTNTS 구조 내보내기
CREATE TABLE IF NOT EXISTS `CNTNTS` (
  `CNTNTS_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '콘텐츠_번호',
  `TTL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제목',
  `CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '내용',
  `TAG` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '태그',
  `STTS_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상태_유형',
  `INQCNT` int(11) DEFAULT NULL COMMENT '조회수',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`CNTNTS_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='콘텐츠';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.CODE_MNG 구조 내보내기
CREATE TABLE IF NOT EXISTS `CODE_MNG` (
  `CD_ID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '코드_아이디',
  `CD_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '코드_유형',
  `UP_CD_ID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '상위_코드_아이디',
  `CD_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '코드_명',
  `CD_DC` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '코드_설명',
  `LEVEL_NO` int(11) DEFAULT NULL COMMENT '레벨_번호',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬_번호',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`CD_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='코드(공통)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.COMM_SEQ 구조 내보내기
CREATE TABLE IF NOT EXISTS `COMM_SEQ` (
  `TABLE_NAME` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `NEXT_SEQ` decimal(30,0) DEFAULT NULL,
  PRIMARY KEY (`TABLE_NAME`) USING BTREE,
  UNIQUE KEY `TABLE_NAME` (`TABLE_NAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.COUPON 구조 내보내기
CREATE TABLE IF NOT EXISTS `COUPON` (
  `COUPON_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '쿠폰_번호',
  `COUPON_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '쿠폰_명',
  `COUPON_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '쿠폰_유형',
  `ISSU_BGNG_DT` datetime DEFAULT NULL COMMENT '발급_시작_일시',
  `ISSU_END_DT` datetime DEFAULT NULL COMMENT '발급_종료_일시',
  `USE_PD_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_기간_유형',
  `USE_PSBLTY_DAYCNT` int(11) DEFAULT NULL COMMENT '사용_가능_일수',
  `USE_BGNG_YMD` date DEFAULT NULL COMMENT '사용_시작_일자',
  `USE_END_YMD` date DEFAULT NULL COMMENT '사용_종료_일자',
  `DSCNT_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '할인_유형',
  `DSCNT_AMT` int(11) DEFAULT NULL COMMENT '할인_금액',
  `MUMM_ORDR_AMT` int(11) DEFAULT NULL COMMENT '최소_주문_금액',
  `MXMM_DSCNT_AMT` int(11) DEFAULT NULL COMMENT '최대_할인_금액',
  `ISSU_MBR` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발급_회원',
  `ISSU_MBR_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발급_회원_유형',
  `ISSU_MBR_GRAD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발급_회원_등급',
  `ISSU_GDS` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발급_상품',
  `ISSU_QY` int(11) DEFAULT NULL COMMENT '발급_수량',
  `ISSU_TY` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발급_유형',
  `MNGR_MEMO` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자_메모',
  `STTS_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상태_유형',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MDFCN_DT` datetime DEFAULT NULL,
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`COUPON_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='쿠폰';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.COUPON_APLCN_TRGT 구조 내보내기
CREATE TABLE IF NOT EXISTS `COUPON_APLCN_TRGT` (
  `APLCN_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '적용_번호',
  `COUPON_NO` int(11) NOT NULL COMMENT '쿠폰_번호',
  `APLCN_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '적용_유형',
  `GDS_NO` int(11) DEFAULT NULL COMMENT '상품_번호',
  `GDS_CD` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_코드',
  PRIMARY KEY (`APLCN_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='쿠폰_적용대상';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.COUPON_LST 구조 내보내기
CREATE TABLE IF NOT EXISTS `COUPON_LST` (
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유일_아이디',
  `COUPON_NO` int(11) DEFAULT NULL COMMENT '쿠폰_번호',
  `COUPON_CD` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '쿠폰_코드',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `ULT_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `USE_DT` datetime DEFAULT NULL COMMENT '사용_일시'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='쿠폰-발급목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.DLVY_CO_MNG 구조 내보내기
CREATE TABLE IF NOT EXISTS `DLVY_CO_MNG` (
  `CO_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '회사_번호',
  `DLVY_CO_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_회사_명',
  `TELNO_INFO` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전화번호_정보',
  `DLVY_URL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_URL',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `DLVY_CO_CD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_회사_코드',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`CO_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='배송회사_관리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.ENTRPS 구조 내보내기
CREATE TABLE IF NOT EXISTS `ENTRPS` (
  `ENTRPS_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '업체_번호',
  `ENTRPS_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업체_명',
  `BRNO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자등록번호',
  `RPRSV_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표자_명',
  `INDUTY` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종',
  `BIZCND` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업태',
  `ZIP` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '우편번호',
  `ADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주소',
  `DADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상세주소',
  `TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전화번호',
  `FXNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '팩스번호',
  `EML` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이메일',
  `TKCG_MD` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당_MD',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `DLVY_CT_CND` int(11) DEFAULT NULL COMMENT '배송_비용_조건',
  `CLCLN_CYCLE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정산_주기',
  `BANK_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '은행명',
  `ACTNO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계좌번호',
  `DPSTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '예금주',
  `CTRT_BGNG_YMD` date DEFAULT NULL COMMENT '계약_시작_일자',
  `CTRT_END_YMD` date DEFAULT NULL COMMENT '계약_종료_일자',
  `CTRT_YMD` date DEFAULT NULL COMMENT '계약일자',
  `FEE` int(11) DEFAULT NULL COMMENT '수수료',
  `PIC_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자명',
  `PIC_TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_전화번호',
  `PIC_TELNO_HP` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_연락처',
  `PIC_EML` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_이메일',
  `PIC_JOB` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당자_업무',
  `STTUS_TY` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상테_유형',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`ENTRPS_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='입점업체';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.EVENT 구조 내보내기
CREATE TABLE IF NOT EXISTS `EVENT` (
  `EVENT_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '이벤트_번호',
  `EVENT_TRGT` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이벤트_대상',
  `EVENT_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이벤트_유형',
  `EVENT_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이벤트_명',
  `EVENT_CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이벤트_내용',
  `BGNG_DT` datetime DEFAULT NULL COMMENT '시작_일시',
  `END_DT` datetime DEFAULT NULL COMMENT '종료_일시',
  `PRSNTN_YMD` date DEFAULT NULL COMMENT '발표_일자',
  `DSPY_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전시_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`EVENT_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='이벤트';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.EVENT_APPLCN 구조 내보내기
CREATE TABLE IF NOT EXISTS `EVENT_APPLCN` (
  `APPLCN_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '응모_번호',
  `EVENT_NO` int(11) DEFAULT NULL COMMENT '이벤트_번호',
  `CHC_IEM_NO` int(11) DEFAULT NULL COMMENT '선택_항목_번호',
  `APPLCT_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '응모자_아이디',
  `APPLCT_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '응모자_명',
  `APPLCT_UNIQUE_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '응모자_유일_아이디',
  `APPLCT_TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '응모자_전화번호',
  `IP` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '아이피',
  `APPLCT_DT` datetime DEFAULT NULL COMMENT '응모일 _새로추가',
  PRIMARY KEY (`APPLCN_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='이벤트_응모';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.EVENT_IEM 구조 내보내기
CREATE TABLE IF NOT EXISTS `EVENT_IEM` (
  `EVENT_NO` int(11) NOT NULL COMMENT '이벤트_번호',
  `IEM_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '항목_번호',
  `IEM_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '항목_유형',
  `IEM_IMG_NO` int(11) DEFAULT NULL COMMENT '이미지_항목_매핑',
  `IEM_CN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '항목_내용',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬_번호',
  PRIMARY KEY (`IEM_NO`,`EVENT_NO`),
  KEY `FK_EVENT_IEM_EVENT` (`EVENT_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='이벤트_항목';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.EVENT_PRZWIN 구조 내보내기
CREATE TABLE IF NOT EXISTS `EVENT_PRZWIN` (
  `PRZWIN_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '당첨_번호',
  `EVENT_NO` int(11) NOT NULL COMMENT '이벤트_번호',
  `CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '내용',
  `DSPY_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전시_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`PRZWIN_NO`,`EVENT_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='이벤트_당첨';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 함수 eroumcare.FN_HIERARCHY_GDS_CTGRY 구조 내보내기
DELIMITER //
CREATE FUNCTION `FN_HIERARCHY_GDS_CTGRY`() RETURNS int(11)
    READS SQL DATA
BEGIN
    DECLARE _ctgry_no INT;
    DECLARE _up_ctgry_no INT;
    DECLARE _sort_no INT;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET @ctgry_no = NULL;

    SET _up_ctgry_no = @ctgry_no;
    SET _ctgry_no = -1;
    SET _sort_no = 0;

    IF @ctgry_no IS NULL THEN
      RETURN NULL;
    END IF;

    LOOP
    	SELECT ctgry_no
		  INTO @ctgry_no
		  FROM GDS_CTGRY
		 WHERE up_ctgry_no = _up_ctgry_no
		   AND sort_no > _sort_no
			ORDER BY sort_no ASC, ctgry_no ASC
		   LIMIT 0, 1;

      IF @ctgry_no IS NOT NULL OR _up_ctgry_no = @start_with THEN
			SET @level_no = @level_no + 1;
			SET _sort_no = 0;
			RETURN @ctgry_no;
      END IF;

      SET @level_no := @level_no - 1;

      SELECT ctgry_no, up_ctgry_no, sort_no
          INTO _ctgry_no, _up_ctgry_no, _sort_no
      FROM GDS_CTGRY
      WHERE ctgry_no = _up_ctgry_no;
    END LOOP;
  END//
DELIMITER ;

-- 함수 eroumcare.FN_LAST_INDEX 구조 내보내기
DELIMITER //
CREATE FUNCTION `FN_LAST_INDEX`(`str` VARCHAR(100),
	`substr` VARCHAR(100)
) RETURNS int(11)
    DETERMINISTIC
BEGIN
	RETURN LENGTH(str) - INSTR(REVERSE(str), substr) + 1;
END//
DELIMITER ;

-- 함수 eroumcare.FN_NEXT_AUTO_SEQ 구조 내보내기
DELIMITER //
CREATE FUNCTION `FN_NEXT_AUTO_SEQ`(`_table_name` TINYTEXT
) RETURNS bigint(20)
    READS SQL DATA
BEGIN
	DECLARE _next_id INT;
	
	SELECT AUTO_INCREMENT FROM information_schema.TABLES
	    WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME=_table_name INTO _next_id;
	RETURN _next_id;
END//
DELIMITER ;

-- 함수 eroumcare.FN_NEXT_SEQ 구조 내보내기
DELIMITER //
CREATE FUNCTION `FN_NEXT_SEQ`(`_table_name` VARCHAR(100)
) RETURNS bigint(20)
BEGIN

	DECLARE _next_id INT;	

	UPDATE COMM_SEQ SET NEXT_SEQ = NEXT_SEQ + 1 WHERE TABLE_NAME = _table_name;
	SELECT NEXT_SEQ FROM COMM_SEQ WHERE TABLE_NAME = _table_name INTO _next_id;

	RETURN _next_id;
END//
DELIMITER ;


-- 함수 eroumcare.FN_ST_DISTANCE_SPHERE 구조 내보내기
DELIMITER //
CREATE FUNCTION `FN_ST_DISTANCE_SPHERE`(`pt1` POINT, `pt2` POINT) RETURNS decimal(10,2)
BEGIN
		RETURN 6371000 * 2 * ASIN(SQRT(POWER(SIN((ST_Y(pt2) - ST_Y(pt1)) * PI()/180 / 2), 2) + COS(ST_Y(pt1) * PI()/180 ) * COS(ST_Y(pt2) * PI()/180) * POWER(SIN((ST_X(pt2) - ST_X(pt1)) * PI()/180 / 2), 2) ));
    END//
DELIMITER ;

-- 테이블 eroumcare.GDS 구조 내보내기
CREATE TABLE IF NOT EXISTS `GDS` (
  `GDS_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '상품_번호',
  `GDS_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_유형',
  `CTGRY_NO` int(11) DEFAULT NULL COMMENT '카테고리_번호',
  `GDS_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_명',
  `GDS_CD` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_코드',
  `BNEF_CD` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '급여_코드',
  `WRHS_YMD_NTCN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '입고_일자_알림',
  `MNGR_MEMO` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자_메모',
  `BASS_DC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기본_설명',
  `MTRQLT` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재질',
  `WT` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '중량',
  `SIZE` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사이즈',
  `STNDRD` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '규격',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬_번호',
  `GDS_TAG` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_태그',
  `MKR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제조사',
  `PLOR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '원산지',
  `BRAND` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '브랜드',
  `MODL` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '모델',
  `MLG_USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '마일리지_사용_여부',
  `MLG_PVSN_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '마일리지_제공_여부',
  `COUPON_USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '쿠폰_사용_여부',
  `POINT_USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '포인트_사용_여부',
  `GDS_DC` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_설명',
  `PC` int(11) DEFAULT NULL COMMENT '가격',
  `DSCNT_RT` int(11) DEFAULT NULL COMMENT '할인_률',
  `DSCNT_PC` int(11) DEFAULT NULL COMMENT '할인_가격',
  `BNEF_PC` int(11) DEFAULT NULL COMMENT '급여_가격',
  `BNEF_PC_15` int(11) DEFAULT NULL COMMENT '급여_가격_15%',
  `BNEF_PC_9` int(11) DEFAULT NULL COMMENT '급여_가격_9%',
  `BNEF_PC_6` int(11) DEFAULT NULL COMMENT '급여_가격_6%',
  `LEND_PC` int(11) DEFAULT NULL COMMENT '대여_가격',
  `LEND_DURA_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대여_내구_여부',
  `USE_PSBLTY_TRM` int(11) DEFAULT NULL COMMENT '사용_가능_연한',
  `EXTN_LEND_TRM` int(11) DEFAULT NULL COMMENT '연장_대여_연한',
  `EXTN_LEND_PC` int(11) DEFAULT NULL COMMENT '연장_대여_가격',
  `STOCK_QY` int(11) DEFAULT NULL COMMENT '재고_수량',
  `STOCK_NTCN_QY` int(11) DEFAULT NULL COMMENT '재고_알림_수량',
  `SOLDOUT_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '품절_여부',
  `OPTN_TTL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '옵션명',
  `ADIT_OPTN_TTL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '추가옵션명',
  `NTSL_STTS_CD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '판매_상태_코드',
  `ANCMNT_TY` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ANCMNT_INFO` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `DLVY_QY` int(11) DEFAULT NULL COMMENT '배송_수량',
  `DLVY_AMT` int(11) DEFAULT NULL COMMENT '배송_금액',
  `DLVY_MUMM_QY` int(11) DEFAULT NULL COMMENT '배송_최소_수량',
  `DLVY_MUMM_AMT` int(11) DEFAULT NULL COMMENT '배송_최소_금액',
  `DLVY_CT_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_비용_유형',
  `DLVY_CT_STLM` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_비용_결제',
  `DLVY_BASS_AMT` int(11) DEFAULT NULL COMMENT '배송_기본_금액',
  `DLVY_ADIT_AMT` int(11) DEFAULT NULL COMMENT '배송_추가_금액',
  `YOUTUBE_URL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유튜브_URL',
  `ADIT_GDS_DC` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '추가_상품_설명',
  `SEO_AUTHOR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SEO_AUTHOR',
  `SEO_DESC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SEO_DESC',
  `SEO_KEYWORD` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SEO_KEYWORD',
  `MEMO` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '메모',
  `DSPY_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전시_여부',
  `INQCNT` int(11) DEFAULT NULL COMMENT '조회수',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`GDS_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상품';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.GDS_CTGRY 구조 내보내기
CREATE TABLE IF NOT EXISTS `GDS_CTGRY` (
  `CTGRY_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '카테고리_번호',
  `UP_CTGRY_NO` int(11) DEFAULT NULL COMMENT '상위_카테고리_번호',
  `CTGRY_IMG` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `CTGRY_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '카테고리_명',
  `TAG` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '태그',
  `LEVEL_NO` int(11) DEFAULT NULL COMMENT '레벨_번호',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬_번호',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  PRIMARY KEY (`CTGRY_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상품_카테고리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.GDS_IMG 구조 내보내기
CREATE TABLE IF NOT EXISTS `GDS_IMG` (
  `GDS_NO` int(11) NOT NULL COMMENT '상품_번호',
  `FILE_TY` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '파일_유형',
  `FILE_NO` int(11) NOT NULL COMMENT '파일_번호',
  `FLPTH` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일경로',
  `ORGNL_FILE_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '원본파일명',
  `STRG_FILE_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '저장파일명',
  `FILE_EXTN` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일확장자명',
  `FILE_SZ` int(11) DEFAULT NULL COMMENT '파일크기',
  `FILE_DC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일_설명',
  `DWNLD_CNT` int(11) DEFAULT NULL COMMENT '다운로드 수',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  PRIMARY KEY (`GDS_NO`,`FILE_NO`,`FILE_TY`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상품_이미지';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.GDS_OPTN 구조 내보내기
CREATE TABLE IF NOT EXISTS `GDS_OPTN` (
  `GDS_OPTN_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '상품_옵션_번호',
  `GDS_NO` int(11) DEFAULT NULL COMMENT '상품_번호',
  `OPTN_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '옵션_유형',
  `OPTN_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '옵션_명',
  `OPTN_PC` int(11) DEFAULT NULL COMMENT '옵션_가격',
  `OPTN_STOCK_QY` int(11) DEFAULT NULL COMMENT '옵션_재고_수량',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  PRIMARY KEY (`GDS_OPTN_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=259 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상품_옵션';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.GDS_QA 구조 내보내기
CREATE TABLE IF NOT EXISTS `GDS_QA` (
  `QA_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '번호',
  `GDS_NO` int(11) DEFAULT NULL COMMENT '상품_번호',
  `GDS_CD` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_코드',
  `QESTN_CN` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '질문_내용',
  `SECRET_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비밀_여부',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  `ANS_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_여부',
  `ANS_CN` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_내용',
  `ANS_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_유일_아이디',
  `ANS_DT` datetime DEFAULT NULL COMMENT '답변_일시',
  `ANS_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_아이디',
  `ANSWR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변자',
  PRIMARY KEY (`QA_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상품_Q&A';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.GDS_RCMD 구조 내보내기
CREATE TABLE IF NOT EXISTS `GDS_RCMD` (
  `RCMD_GDS_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '추천_상품_번호',
  `GDS_NO` int(11) NOT NULL COMMENT '상품_번호',
  `RCMD_SORT_NO` int(11) DEFAULT NULL COMMENT '정렬_번호',
  PRIMARY KEY (`RCMD_GDS_NO`,`GDS_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='추천 상품';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.GDS_REL 구조 내보내기
CREATE TABLE IF NOT EXISTS `GDS_REL` (
  `GDS_NO` int(11) NOT NULL COMMENT '상품_번호',
  `REL_GDS_NO` int(11) NOT NULL COMMENT '관계_상품_번호',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬_번호',
  PRIMARY KEY (`REL_GDS_NO`,`GDS_NO`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상품_관련상품';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.GDS_REVIEW 구조 내보내기
CREATE TABLE IF NOT EXISTS `GDS_REVIEW` (
  `GDS_REIVEW_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '상품_후기_번호',
  `GDS_NO` int(11) DEFAULT NULL COMMENT '상품_번호',
  `GDS_CD` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_코드',
  `ORDR_DTL_NO` int(11) unsigned zerofill DEFAULT NULL COMMENT '주문_상세_번호',
  `ORDR_CD` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문_코드',
  `ORDR_NO` int(11) unsigned zerofill DEFAULT NULL COMMENT '주문_번호',
  `TTL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제목',
  `CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '내용',
  `IMG_USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이미지_사용_여부',
  `DGSTFN` int(11) DEFAULT NULL COMMENT '만족도',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `DSPY_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '삭제_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`GDS_REIVEW_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상품_후기';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MBR 구조 내보내기
CREATE TABLE IF NOT EXISTS `MBR` (
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '유일_아이디',
  `MBR_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회원_아이디',
  `MBR_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회원_명',
  `PSWD` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비밀번호',
  `GENDER` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성별',
  `BRDT` date DEFAULT NULL COMMENT '생년월일',
  `TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전화번호',
  `MBL_TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '휴대전화번호',
  `EML` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이메일',
  `ZIP` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '우편번호',
  `ADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주소',
  `DADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상세주소',
  `DI_KEY` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RECIPTER_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수급자_여부',
  `BASS_STLM_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기본_결제_유형',
  `POINT_ACMTL` int(11) DEFAULT NULL COMMENT '포인트_누계',
  `MLG_ACMTL` int(11) DEFAULT NULL COMMENT '마일리지_누계',
  `MBER_STTUS` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회원_상태',
  `MBER_GRADE` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회원_등급',
  `RCMDTN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '추천_아이디',
  `PRVC_VLD_PD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '개인정보_유효_기간',
  `SMS_RCPTN_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '문자메시지_수신_여부',
  `EML_RCPTN_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이메일_수신_여부',
  `TEL_RECPTN_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전화_수신_여부',
  `EVENT_RECPTN_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이벤트_수신_여부',
  `PROFL_IMG` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '프로필_이미지',
  `TRMS_AGRE_DT` datetime DEFAULT NULL COMMENT '약관_동의_일시',
  `JOIN_COURS` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '가입_경로',
  `JOIN_DT` datetime DEFAULT NULL COMMENT '가입_일시',
  `LGN_FAILR_CNT` int(11) DEFAULT NULL COMMENT '로그인_실패_수',
  `RECENT_CNTN_DT` datetime DEFAULT NULL COMMENT '최근_접속_일시',
  `TMPR_PSWD_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '임시_비밀번호_여부',
  `PSWD_CHG_DT` datetime DEFAULT NULL COMMENT '비밀번호_변경_일시',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  `WHDWL_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '탈퇴_여부',
  `WHDWL_DT` datetime DEFAULT NULL COMMENT '탈퇴_일시',
  `WHDWL_RESN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '탈퇴_사유',
  `WHDWL_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '탈퇴_유형',
  `WHDWL_ETC` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '탈퇴_기타',
  PRIMARY KEY (`UNIQUE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='회원';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MBR_DLVY_MNG 구조 내보내기
CREATE TABLE IF NOT EXISTS `MBR_DLVY_MNG` (
  `DLVY_MNG_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '배송_관리_번호',
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유일_아이디',
  `DLVY_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_명',
  `NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이름',
  `ZIP` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '우편번호',
  `ADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주소',
  `DADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상세주소',
  `TELNO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전화번호',
  `MBL_TELNO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '휴대전화번호',
  `BASS_DLVY_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기본_배송_여부',
  `MEMO` varchar(250) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '메모',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  PRIMARY KEY (`DLVY_MNG_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='회원_배송지_관리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MBR_INQRY 구조 내보내기
CREATE TABLE IF NOT EXISTS `MBR_INQRY` (
  `INQRY_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '문의_번호',
  `INQRY_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '문의_유형',
  `INQRY_DTL_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '문의_상세_유형',
  `TTL` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제목',
  `CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '내용',
  `ORDR_CD` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문_코드',
  `SMS_ANS_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'SMS_답변_여부',
  `MBL_TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '휴대전화번호',
  `EML_ANS_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이메일_답변_여부',
  `EML` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이메일',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  `ANS_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_여부',
  `ANS_CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_내용',
  `ANS_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_유일_아이디',
  `ANS_DT` datetime DEFAULT NULL COMMENT '답변_일시',
  `ANS_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변_아이디',
  `ANSWR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '답변자',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  PRIMARY KEY (`INQRY_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='회원_문의(1:1)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MBR_ITRST 구조 내보내기
CREATE TABLE IF NOT EXISTS `MBR_ITRST` (
  `ITRST_NO` int(11) NOT NULL AUTO_INCREMENT,
  `ITRST_TY` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'B/C',
  `CTGRY_NO` int(11) DEFAULT NULL,
  `BPLC_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `REG_DT` datetime DEFAULT NULL,
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ITRST_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='관심 사업소 , 카테고리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MBR_MLG 구조 내보내기
CREATE TABLE IF NOT EXISTS `MBR_MLG` (
  `MLG_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '마일리지_번호',
  `MLG_MNG_NO` int(11) DEFAULT NULL COMMENT '마일리지_관리_번호',
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유일_아이디',
  `ORDR_NO` int(11) DEFAULT NULL COMMENT '주문_번호',
  `ORDR_CD` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문_코드',
  `ORDR_DTL_CD` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문_상세_코드',
  `MLG_SE` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '마일리지_구분',
  `MLG_CN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '마일리지_내용',
  `MLG` int(11) DEFAULT NULL COMMENT '마일리지',
  `USE_MLG` int(11) DEFAULT NULL COMMENT '마일리지_사용',
  `MLG_ACMTL` int(11) DEFAULT NULL COMMENT '마일리지_누계',
  `GIVE_MTHD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지급_방법',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  PRIMARY KEY (`MLG_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='회원-마일리지';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MBR_MNG_INFO 구조 내보내기
CREATE TABLE IF NOT EXISTS `MBR_MNG_INFO` (
  `MNG_INFO_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '관리_정보_번호',
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유일_아이디',
  `MNG_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리_유형',
  `MNG_SE` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리_구분',
  `STOP_BGNG_YMD` date DEFAULT NULL COMMENT '정지_시작_일자',
  `STOP_END_YMD` date DEFAULT NULL COMMENT '정지_종료_일자',
  `RESN_CD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사유_코드',
  `MNGR_MEMO` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자_메모',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  PRIMARY KEY (`MNG_INFO_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='회원_관리정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MBR_POINT 구조 내보내기
CREATE TABLE IF NOT EXISTS `MBR_POINT` (
  `POINT_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '포인트_번호',
  `POINT_MNG_NO` int(11) DEFAULT NULL COMMENT '포인트_관리_번호',
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유일_아이디',
  `ORDR_NO` int(11) DEFAULT NULL,
  `ORDR_CD` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ORDR_DTL_CD` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `POINT_SE` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '포인트_구분',
  `POINT_CN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '포인트_내용',
  `POINT` int(11) DEFAULT NULL COMMENT '포인트',
  `POINT_ACMTL` int(11) DEFAULT NULL COMMENT '포인트_누계',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `GIVE_MTHD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지급_방법',
  PRIMARY KEY (`POINT_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='회원_포인트';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MBR_PRTCR 구조 내보내기
CREATE TABLE IF NOT EXISTS `MBR_PRTCR` (
  `PRTCR_MBR_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '보호자_회원_번호',
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유일_아이디',
  `PRTCR_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보호자_유일_아이디',
  `DMND_DT` datetime DEFAULT NULL COMMENT '요청_일시',
  `APRV_DT` datetime DEFAULT NULL COMMENT '승인_일시',
  `REQ_TY` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신청_유형',
  `PRTCR_RLT` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보호자_관계',
  `RLT_ETC` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관계_기타',
  PRIMARY KEY (`PRTCR_MBR_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='회원_보호자';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MKR 구조 내보내기
CREATE TABLE IF NOT EXISTS `MKR` (
  `MKR_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '제조사_번호',
  `MKR_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제조사_명',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`MKR_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='제조사';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MLG_MNG 구조 내보내기
CREATE TABLE IF NOT EXISTS `MLG_MNG` (
  `MLG_MNG_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '마일리지_관리_번호',
  `MLG_SE` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '마일리지_구분',
  `MLG_CN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '마일리지_내용',
  `MLG` int(11) DEFAULT NULL COMMENT '마일리지',
  `MNGR_MEMO` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자_메모',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  PRIMARY KEY (`MLG_MNG_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='마일리지_관리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MNGR 구조 내보내기
CREATE TABLE IF NOT EXISTS `MNGR` (
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '유일_아이디',
  `MNGR_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자_아이디',
  `MNGR_PSWD` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자_비밀번호',
  `MNGR_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자_명',
  `TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전화번호',
  `EML` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이메일',
  `PROFL_IMG` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '프로필_이미지',
  `JOB_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업무_유형',
  `AUTHRT_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '권한_유형',
  `AUTHRT_NO` int(11) DEFAULT NULL COMMENT '권한_번호',
  `DPCN_IDNTY_CD` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '중복_확인_코드',
  `LGN_FAILR_CNT` int(11) DEFAULT NULL COMMENT '로그인_실패_수',
  `RECENT_LGN_DT` datetime DEFAULT NULL COMMENT '최근_로그인_일시',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`UNIQUE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='관리자';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MNGR_AUTHRT_LOG 구조 내보내기
CREATE TABLE IF NOT EXISTS `MNGR_AUTHRT_LOG` (
  `LOG_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '로그_번호',
  `UNIQUE_ID` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '유일_아이디',
  `MNGR_ID` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자_아이디',
  `MNGR_NM` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자_명',
  `LOG_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '로그_유형',
  `LOG_CN` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '로그_내용',
  `DMND_IP` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '요청_아이피',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  PRIMARY KEY (`LOG_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='관리자 권한 로그';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MNG_AUTHRT 구조 내보내기
CREATE TABLE IF NOT EXISTS `MNG_AUTHRT` (
  `AUTHRT_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '권한_번호',
  `AUTHRT_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '권한_명',
  `AUTHRT_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '권한_유형',
  `MEMO` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '메모',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  PRIMARY KEY (`AUTHRT_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='관리 권한';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MNG_AUTHRT_MENU 구조 내보내기
CREATE TABLE IF NOT EXISTS `MNG_AUTHRT_MENU` (
  `AUTHRT_NO` int(11) NOT NULL COMMENT '권한_번호',
  `MENU_NO` int(11) NOT NULL COMMENT '메뉴_번호',
  `AUTHRT_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '권한_여부',
  `INQ_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '조회_여부',
  `WRT_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '작성_여부',
  PRIMARY KEY (`AUTHRT_NO`,`MENU_NO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='관리 권한 메뉴';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.MNG_MENU 구조 내보내기
CREATE TABLE IF NOT EXISTS `MNG_MENU` (
  `MENU_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '메뉴_번호',
  `UP_MENU_NO` int(11) DEFAULT NULL COMMENT '상위_메뉴_번호',
  `MENU_NM` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '메뉴_명',
  `MENU_URL` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '메뉴_URL',
  `ICON` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '아이콘',
  `MENU_TY` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '메뉴_유형',
  `LEVEL_NO` int(11) NOT NULL COMMENT '레벨_번호',
  `SORT_NO` int(11) NOT NULL COMMENT '정렬_번호',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '사용_여부',
  PRIMARY KEY (`MENU_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='관리 메뉴';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.ORDR 구조 내보내기
CREATE TABLE IF NOT EXISTS `ORDR` (
  `ORDR_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '주문_번호',
  `ORDR_CD` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '주문_코드',
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유일_아이디',
  `ORDR_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문_유형',
  `ORDR_DT` datetime DEFAULT NULL COMMENT '주문_일시',
  `ORDRR_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ORDRR_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문자_명',
  `ORDRR_EML` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문자_이메일',
  `ORDRR_TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문자_전화번호',
  `ORDRR_MBL_TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문자_휴대전화번호',
  `ORDRR_ZIP` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문자_우편번호',
  `ORDRR_ADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문자_주소',
  `ORDRR_DADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문자_상세주소',
  `ORDRR_MEMO` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문자_메모',
  `RECPTR_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수령인_명',
  `RECPTR_TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수령인_전화번호',
  `RECPTR_MBL_TELNO` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수령인_휴대전화번호',
  `RECPTR_ZIP` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수령인_우편번호',
  `RECPTR_ADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수령인_주소',
  `RECPTR_DADDR` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수령인_상세주소',
  `USE_MLG` int(11) DEFAULT NULL COMMENT '사용_마일리지',
  `USE_POINT` int(11) DEFAULT NULL COMMENT '사용_포인트',
  `STLM_DEVICE` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결제_디바이스',
  `STLM_TY` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결제_유형',
  `STLM_AMT` int(11) DEFAULT NULL COMMENT '결제_금액',
  `STLM_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결제_여부',
  `STLM_DT` datetime DEFAULT NULL COMMENT '결제_일시',
  `DELNG_NO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래번호',
  `BILLING_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '빌링_여부',
  `BILLING_KEY` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '빌링_키',
  `BILLING_DAY` varchar(2) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '빌일_일자',
  `CARD_CO_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '카드_회사명',
  `CARD_NO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '카드_번호',
  `CARD_APRVNO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '카드_승인번호',
  `CARD_PRTC_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '부분취소_가능여부',
  `VR_ACTNO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '가상_계좌번호',
  `DPST_BANK_CD` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '입금_은행_코드',
  `DPST_BANK_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '입금_은행_명',
  `DPSTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '입금_예금주',
  `PYR_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '입금자_명',
  `DPST_TERM_DT` datetime DEFAULT NULL COMMENT '입금_기한_일시',
  `CASHRCIPT_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '현금영수증_여부',
  `CASHRCIPT_NO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '현금영수증_번호',
  PRIMARY KEY (`ORDR_NO`,`ORDR_CD`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='주문';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.ORDR_CHG_HIST 구조 내보내기
CREATE TABLE IF NOT EXISTS `ORDR_CHG_HIST` (
  `CHG_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '변경_번호',
  `ORDR_NO` int(11) DEFAULT NULL COMMENT '주문_번호',
  `ORDR_DTL_NO` int(11) DEFAULT NULL COMMENT '주문_상세_번호',
  `CHG_STTS` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '변경_상태',
  `RESN_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사유_타입',
  `RESN` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사유',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  PRIMARY KEY (`CHG_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=480 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='주문-변경내역';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.ORDR_DTL 구조 내보내기
CREATE TABLE IF NOT EXISTS `ORDR_DTL` (
  `ORDR_DTL_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '주문_상세_번호',
  `ORDR_NO` int(11) NOT NULL COMMENT '주문_번호',
  `ORDR_DTL_CD` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '주문_상세_코드',
  `ORDR_CD` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '주문_코드',
  `GDS_NO` int(11) DEFAULT NULL COMMENT '상품_번호',
  `GDS_CD` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_코드',
  `BNEF_CD` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '급여_코드',
  `GDS_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상품_명',
  `GDS_PC` int(11) DEFAULT NULL COMMENT '상품_가격',
  `ORDR_PC` int(11) DEFAULT NULL COMMENT '주문_가격',
  `ORDR_OPTN_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '옵션_유형',
  `ORDR_OPTN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문_옵션',
  `ORDR_OPTN_PC` int(11) DEFAULT NULL COMMENT '주문_옵션_가격',
  `ORDR_QY` int(11) DEFAULT NULL COMMENT '주문_수량',
  `ACCML_MLG` int(11) DEFAULT NULL COMMENT '적립_마일리지',
  `COUPON_NO` int(11) DEFAULT NULL COMMENT '쿠폰_번호',
  `COUPON_CD` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '쿠폰_코드',
  `COUPON_AMT` int(11) DEFAULT NULL COMMENT '쿠폰_금액',
  `REFUND_APRVNO` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '승인번호',
  `RECIPTER_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수급자_유일_아이디',
  `BPLC_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업장_유일_아이디',
  `STTS_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상태_유형',
  `SNDNG_DT` datetime DEFAULT NULL COMMENT '발송_일시',
  `DLVY_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_유형',
  `DLVY_HOPE_YMD` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_희망_일자',
  `DLVY_STLM_TY` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_결제_유형',
  `DLVY_BASS_AMT` int(11) DEFAULT NULL COMMENT '배송_금액',
  `DLVY_ADIT_AMT` int(11) DEFAULT NULL COMMENT '배송_추가_금액',
  `DLVY_STTS` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_상태',
  `DLVY_CO_NO` int(11) DEFAULT NULL COMMENT '배송_회사_번호',
  `DLVY_CO_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_회사',
  `DLVY_DT` datetime DEFAULT NULL COMMENT '배송_일시',
  `DLVY_INVC_NO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '배송_송장_번호',
  `RFND_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RFND_BANK` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RFND_ACTNO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `RFND_AMT` int(11) DEFAULT NULL,
  `RFND_DT` datetime DEFAULT NULL,
  `RFND_DPSTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`ORDR_DTL_NO`,`ORDR_NO`,`ORDR_DTL_CD`,`ORDR_CD`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='주문-상품상세';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.ORDR_REBILL 구조 내보내기
CREATE TABLE IF NOT EXISTS `ORDR_REBILL` (
  `REBILL_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '번호',
  `ORDR_NO` int(11) DEFAULT NULL COMMENT '주문번호',
  `ORDR_CD` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주문코드',
  `ORDR_CNT` int(11) DEFAULT NULL COMMENT '주문수',
  `STLM_AMT` int(11) DEFAULT NULL COMMENT '결제_금액',
  `STLM_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결제_여부',
  `STLM_DT` datetime DEFAULT NULL COMMENT '결제_일시',
  `DELNG_NO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '승인_번호',
  `CARD_CO_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '카드회사명',
  `CARD_NO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '카드번호',
  `CARD_APRVNO` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '카드_승인번호',
  `MEMO` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`REBILL_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='주문_정기결제';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.PLANNG_DSPY 구조 내보내기
CREATE TABLE IF NOT EXISTS `PLANNG_DSPY` (
  `PLANNG_DSPY_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '기획_전시_번호',
  `PLANNG_DSPY_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기획_전시_명',
  `CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '내용',
  `BGNG_DT` datetime DEFAULT NULL COMMENT '시작_일시',
  `END_DT` datetime DEFAULT NULL COMMENT '종료_일시',
  `DSPY_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전시_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`PLANNG_DSPY_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기획전시';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.PLANNG_DSPY_GRP 구조 내보내기
CREATE TABLE IF NOT EXISTS `PLANNG_DSPY_GRP` (
  `GRP_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '그룹_번호',
  `PLANNG_DSPY_NO` int(11) NOT NULL COMMENT '기획_전시_번호',
  `GRP_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '그룹_명',
  `EXHIBI_CO` int(11) DEFAULT NULL COMMENT '진열_갯수',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬_번호',
  PRIMARY KEY (`GRP_NO`,`PLANNG_DSPY_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기획전시_그룹';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.PLANNG_DSPY_GRP_GDS 구조 내보내기
CREATE TABLE IF NOT EXISTS `PLANNG_DSPY_GRP_GDS` (
  `PLANNG_DSPY_NO` int(11) NOT NULL COMMENT '기획_전시_번호',
  `GRP_NO` int(11) NOT NULL COMMENT '그룹_번호',
  `GDS_NO` int(11) DEFAULT NULL COMMENT '상품_번호',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬_번호',
  `GDS_CD` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  KEY `PLANNG_DSPY_NO` (`PLANNG_DSPY_NO`,`GRP_NO`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기획전시_그룹_상품';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.POINT_MNG 구조 내보내기
CREATE TABLE IF NOT EXISTS `POINT_MNG` (
  `POINT_MNG_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '포인트_관리_번호',
  `POINT_SE` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '포인트_구분',
  `POINT_CN` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '포인트_내용',
  `POINT` int(11) DEFAULT NULL COMMENT '포인트',
  `MNGR_MEMO` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리자_메모',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  PRIMARY KEY (`POINT_MNG_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='포인트_관리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.POPUP 구조 내보내기
CREATE TABLE IF NOT EXISTS `POPUP` (
  `POP_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '팝업_번호',
  `POP_SJ` varchar(200) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '팝업_제목',
  `BGNG_DT` datetime DEFAULT NULL COMMENT '시작_일시',
  `END_DT` datetime DEFAULT NULL COMMENT '종료_일시',
  `POP_HEIGHT` int(11) DEFAULT NULL COMMENT '높이',
  `POP_WIDTH` int(11) DEFAULT NULL COMMENT '넓이',
  `POP_LEFT` int(11) DEFAULT NULL COMMENT '좌측',
  `POP_TOP` int(11) DEFAULT NULL COMMENT '상단',
  `POP_TY` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '팝업_유형',
  `ONE_VIEW_TY` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '하루_열기_옵션',
  `LINK_URL` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '링크',
  `LINK_TY` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '링크_유형',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '팝업_상태',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`POP_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.PRHIBT_WRD_MNG 구조 내보내기
CREATE TABLE IF NOT EXISTS `PRHIBT_WRD_MNG` (
  `WRD_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '단어_번호',
  `PRHIBT_WRD` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '금지_단어',
  `USE_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사용_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`WRD_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='금지어_관리';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.RECIPTER_INFO 구조 내보내기
CREATE TABLE IF NOT EXISTS `RECIPTER_INFO` (
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '유일_아이디',
  `RCPER_RCOGN_NO` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '요양_인정_번호',
  `RCOGN_GRAD` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '인정_등급',
  `SELF_BND_RT` int(11) DEFAULT NULL COMMENT '본인_부담_율',
  `SELF_BND_MEMO` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '본인_부담_설명',
  `VLD_BGNG_YMD` date DEFAULT NULL COMMENT '유효_시작_일자',
  `VLD_END_YMD` date DEFAULT NULL COMMENT '유효_종료_일자',
  `APLCN_BGNG_YMD` date DEFAULT NULL COMMENT '적용_시작_일자',
  `APLCN_END_YMD` date DEFAULT NULL COMMENT '적용_종료_일자',
  `SPRT_AMT` int(11) DEFAULT NULL COMMENT '지원금액',
  `BNEF_BLCE` int(11) DEFAULT NULL COMMENT '급여_잔액',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  PRIMARY KEY (`UNIQUE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='수급자_정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.SAMPLE 구조 내보내기
CREATE TABLE IF NOT EXISTS `SAMPLE` (
  `NO` int(11) NOT NULL AUTO_INCREMENT,
  `TTL` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `CN` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `REG_DT` datetime NOT NULL,
  PRIMARY KEY (`NO`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='샘플';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 프로시저 eroumcare.SP_NEXT_SEQ 구조 내보내기
DELIMITER //
//
DELIMITER ;

-- 테이블 eroumcare.STDG_CD 구조 내보내기
CREATE TABLE IF NOT EXISTS `STDG_CD` (
  `STDG_CD` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '법정동코드',
  `CTPV_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '시도명',
  `SGG_NM` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '시군구명',
  `LEVEL_NO` int(11) DEFAULT NULL COMMENT '레벨',
  PRIMARY KEY (`STDG_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='법정동코드';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.THEME_DSPY 구조 내보내기
CREATE TABLE IF NOT EXISTS `THEME_DSPY` (
  `THEME_DSPY_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '테마_전시_번호',
  `THEME_DSPY_NM` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '테마명',
  `CN` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '내용',
  `DSPY_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전시_여부',
  `REL_YN` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '연관상품_여부',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  `MDFCN_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_유일_아이디',
  `MDFCN_DT` datetime DEFAULT NULL COMMENT '수정_일시',
  `MDFCN_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정_아이디',
  `MDFR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수정자',
  PRIMARY KEY (`THEME_DSPY_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='테마전시';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.THEME_DSPY_GDS 구조 내보내기
CREATE TABLE IF NOT EXISTS `THEME_DSPY_GDS` (
  `THEME_GDS_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '그룹_번호',
  `THEME_DSPY_NO` int(11) NOT NULL COMMENT '테마_전시_번호',
  `GDS_NO` int(11) DEFAULT NULL COMMENT '상품_번호',
  `SORT_NO` int(11) DEFAULT NULL COMMENT '정렬_번호',
  PRIMARY KEY (`THEME_GDS_NO`,`THEME_DSPY_NO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='테마전시_상품';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 eroumcare.WISHLIST 구조 내보내기
CREATE TABLE IF NOT EXISTS `WISHLIST` (
  `WISHLIST_NO` int(11) NOT NULL AUTO_INCREMENT COMMENT '번호',
  `GDS_NO` int(11) DEFAULT NULL COMMENT '상품_번호',
  `UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유일_아이디',
  `REG_UNIQUE_ID` varchar(12) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_유일_아이디',
  `REG_DT` datetime DEFAULT NULL COMMENT '등록_일시',
  `REG_ID` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록_아이디',
  `RGTR` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등록자',
  PRIMARY KEY (`WISHLIST_NO`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='위시리스트';

-- 내보낼 데이터가 선택되어 있지 않습니다.

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
