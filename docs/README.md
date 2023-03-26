# 이로움 프로젝트
---
## 프로젝트 구조
eroum project
<pre>
 |- brnad 브랜드
 |- common 공통
    |-api 틸코+부트페이+복지24,1.0시스템 연계
 |- manage 관리자
 |- market 마켓
 |- membership 회원
 |- partner 멤버스 -> members로 변경 예정
    |-bplc 사업소
 |- schedule 스케줄러(정기작업)
<pre>

---

## 서버 profiles
로컬 : -Dspring.profiles.active=local
개발 : export JAVA_OPTS=" ${JAVA_OPTS} -Dspring.profiles.active=dev"
운영 : export JAVA_OPTS=" ${JAVA_OPTS} -Dspring.profiles.active=dev"


# 서버 접근 정보
116.125.120.22
root / ~eroum1.5#thkc#221209!~

---

## 부트페이계정(결제연동)
https://admin.bootpay.co.kr/login
devpay@thkc.co.kr / ~thkc1301@~


## 이니시스(결제) > 2차 인증필요
https://iniweb.inicis.com/security/login.do
BTPeroumca / ~thkc1301@~


## 다날(본인인증) > 2차 인증필요
https://partner.danalpay.com/account/login
thkc1301 / ~thkc1301@~


## 네이버(메일, 통계 등)
thkc1300 / ~6thgkfossmkc!~


## 카카오(개발 계정 사용중)
