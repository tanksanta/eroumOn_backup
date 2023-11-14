/* Z_BAK_MLG_MNG_231114 */

/* Z_BAK_POINT_MNG_231114 */

/*
INSERT INTO Z_BAK_COUPON_LST_231114
SELECT *
FROM COUPON_LST 
WHERE coupon_no IN (
					SELECT coupon_no
					from COUPON
					WHERE coupon_no NOT IN (1, 28)
					)
;
INSERT INTO Z_BAK_COUPON_APLCN_TRGT_231114
SELECT *
FROM COUPON_APLCN_TRGT
WHERE coupon_no IN  (
						SELECT coupon_no
						from COUPON
						WHERE coupon_no NOT IN (1, 28)
						)
;
INSERT INTO Z_BAK_COUPON_231114
SELECT *
from COUPON
WHERE coupon_no NOT IN (1, 28)
*/
/*
START TRANSACTION
;

DELETE 
FROM COUPON_LST 
WHERE coupon_no IN (
					SELECT coupon_no
					from COUPON
					WHERE coupon_no NOT IN (1, 28)
					)
;

DELETE 
FROM COUPON_APLCN_TRGT
WHERE coupon_no IN  (
						SELECT coupon_no
						from COUPON
						WHERE coupon_no NOT IN (1, 28)
						)
;

DELETE 
from COUPON
WHERE coupon_no NOT IN (1, 28)
*/