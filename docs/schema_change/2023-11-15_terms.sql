INSERT INTO `MNG_MENU` (`MENU_NO`, `UP_MENU_NO`, `MENU_NM`, `MENU_URL`              , `ICON`, `MENU_TY`, `LEVEL_NO`, `SORT_NO`, `USE_YN`) VALUES
                        (76      , 9            , '약관관리', '#', '' , '2'       , 1         , 1         , 'Y')
                        , (78      , 76            , '개인정보 처리방침', '/_mng/sysmng/terms/privacy/list', '' , '2'       , 1         , 1         , 'Y')
                        , (79      , 76            , '개인정보 제공', '/_mng/sysmng/terms/provision/list', '' , '2'       , 1         , 1         , 'Y')
;

INSERT INTO `MNG_AUTHRT_MENU` (`AUTHRT_NO`, `MENU_NO`, `AUTHRT_YN`, `INQ_YN`, `WRT_YN`) VALUES
                    	        (1      , 76         , 'Y'           , 'N'   , 'N')
                                ,(1      , 78         , 'Y'           , 'N'   , 'N')
                                ,(1      , 79         , 'Y'           , 'N'   , 'N')
;
