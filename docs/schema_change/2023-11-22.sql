ALTER TABLE MBR_MLG ADD EXTINCT_MAIL_YN CHAR(1) NULL DEFAULT NULL COMMENT '만료 안내 이메일 발송 여부';
ALTER TABLE MBR_MLG ADD EXTINCT_YN CHAR(1) NULL DEFAULT NULL COMMENT '만료 처리 여부';

ALTER TABLE MBR ADD HUMAN_MAIL_YN CHAR(1) NULL DEFAULT NULL COMMENT '휴면계정대상 이메일 발송 여부';

-- 생일 축하 쿠폰
INSERT INTO eroumcare.COUPON(
    coupon_nm,
    coupon_ty,
    issu_bgng_dt,
    issu_end_dt,
    use_pd_ty,
    use_psblty_daycnt,
    dscnt_ty,
    dscnt_amt,
    mumm_ordr_amt,
    mxmm_dscnt_amt,
    issu_mbr,
    issu_mbr_ty,
    issu_gds,
    issu_qy,
    issu_ty,
    mngr_memo,
    stts_ty,
    reg_unique_id,
    reg_dt,
    reg_id,
    rgtr
)
VALUE(
    '생일축하 쿠폰',
    'BRDT',
    '2023-11-22 00:00:00',
    '9999-12-31 23:59:00',
    'ADAY',
    90,
    'PRCS',
    5,
    5000,
    50000,
    'D',
    'G,R',
    'A',
    9999,
    'AUTO',
    '생일축하 쿠폰',
    'USE',
    'MNG_00000001',
    '2023-11-22 14:40:00',
    'manager',
    '총괄관리자'
);

