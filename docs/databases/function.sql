//거리계산 return meter(m)
DELIMITER $$
CREATE
    FUNCTION `FN_ST_DISTANCE_SPHERE`(`pt1` POINT, `pt2` POINT)
    RETURNS DECIMAL(10,2)
    BEGIN
		RETURN 6371000 * 2 * ASIN(SQRT(POWER(SIN((ST_Y(pt2) - ST_Y(pt1)) * PI()/180 / 2), 2) + COS(ST_Y(pt1) * PI()/180 ) * COS(ST_Y(pt2) * PI()/180) * POWER(SIN((ST_X(pt2) - ST_X(pt1)) * PI()/180 / 2), 2) ));
    END$$

DELIMITER ;