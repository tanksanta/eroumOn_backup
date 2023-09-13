module.exports = {
    content: [
        './html/core/*.{html,js}',
        './html/page/**/*.{html,js}',
        './node_modules/tw-elements/dist/js/**/*.js'
    ],

    theme: {
        extend: {
            colors: {
                'gray1'     : '#999',
                'gray2'     : '#eee',
                'gray3'     : '#ddd',
                'gray4'     : '#444',
                'gray5'     : '#7f7f7f',
                'gray6'     : '#666',
                'red1'      : '#DD3C3C',
                'red2'      : '#FFE6E6',
                'red3'      : '#FC2020',
                'blue1'     : '#3C80B7',
                'blue2'     : '#E4F1FF',
                'blue3'     : '#1477F8',
                'yellow1'   : '#F07F00',
                'yellow2'   : '#FFFAE6',
                'black1'    : '#1C1C1C',
                'black2'    : '#333',
                'indexKey1' : '#FF8120',
                'indexKey2' : '#3074FF',
                'indexKey3' : '#00399c',
            },
            fontFamily: {
                'sans'  : ['Noto Sans KR', 'system-ui', '-apple-system', 'BlinkMacSystemFont', 'Segoe UI', 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji'],
                'serif' : ['Roboto', 'ui-serif', 'Georgia', 'Cambria', 'Times New Roman', 'Times', 'Noto Sans KR'],
                'nanum' : ['NanumSquareNeo', 'Noto Sans KR']
            },
            screens: {
                'xs'       : '480px',
                'sm'       : '576px',
                'md'       : '768px',
                'lg'       : '1040px',
                'xl'       : '1280px',
                '2xl'      : '1560px',
                'xs-max'   : {'max': '479px'},
                'sm-max'   : {'max': '575px'},
                'md-max'   : {'max': '767px'},
                'lg-max'   : {'max': '1039px'},
                'xl-max'   : {'max': '1279px'},
                '2xl-max'  : {'max': '1559px'},
                'xs-range' : {'max': '480px'},
                'sm-range' : {'min': '480px', 'max': '575px'},
                'md-range' : {'min': '576px', 'max': '767px'},
                'lg-range' : {'min': '768px', 'max': '1039px'},
                'xl-range' : {'min': '1040px', 'max': '1279px'},
                '2xl-range': {'min': '1280px', 'max': '1559px'}
            },
            spacing: {
                px  : '1px',        //1
                0   : '0px',        //0
                0.5 : '0.125rem',   //2
                1   : '0.25rem',    //4
                1.5 : '0.375rem',   //6
                2   : '0.5rem',     //8
                2.5 : '0.625rem',   //10
                3   : '0.75rem',    //12
                3.5 : '0.875rem',   //14
                4   : '1rem',       //16
                4.5 : '1.125rem',   //18
                5   : '1.25rem',    //20
                5.5 : '1.375rem',   //22
                6   : '1.5rem',     //24
                6.5 : '1.625rem',   //26
                7   : '1.75rem',    //28
                7.5 : '1.875rem',   //30
                8   : '2rem',       //32
                8.5 : '2.125rem',   //34
                9   : '2.25rem',    //36
                9.5 : '2.375rem',   //38
                10  : '2.5rem',     //40
                11  : '2.75rem',
                12  : '3rem',
                13  : '3.25rem',
                14  : '3.5rem',
                15  : '3.75rem',
                16  : '4rem',
                17  : '4.25rem',
                18  : '4.5rem',
                19  : '4.75rem',
                20  : '5rem',
                21  : '5.25rem',
                22  : '5.5rem',
                23  : '5.75rem',
                24  : '6rem',
                25  : '6.25rem',
                26  : '6.5rem',
                27  : '6.75rem',
                28  : '7rem',
                29  : '7.25rem',
                30  : '7.5rem',
                31  : '7.75rem',
                32  : '8rem',
                33  : '8.25rem',
                34  : '8.5rem',
                35  : '8.75rem',
                36  : '9rem',
                37  : '9.25rem',
                38  : '9.5rem',
                39  : '9.75rem',
                40  : '10rem',
                41  : '10.25rem',
                42  : '10.5rem',
                43  : '10.75rem',
                44  : '11rem',
                45  : '11.25rem',
                46  : '11.5rem',
                47  : '11.75rem',
                48  : '12rem',
                49  : '12.25rem',
                50  : '12.5rem',
                51  : '12.75rem',
                52  : '13rem',
                53  : '13.25rem',
                54  : '13.5rem',
                55  : '13.75rem',
                56  : '14rem',
                57  : '14.25rem',
                58  : '14.5rem',
                59  : '14.75rem',
                60  : '15rem',
                61  : '15.25rem',
                62  : '15.5rem',
                63  : '15.75rem',
                64  : '16rem',
                65  : '16.25rem',
                66  : '16.5rem',
                67  : '16.75rem',
                68  : '17rem',
                69  : '17.25rem',
                70  : '17.5rem',
                71  : '17.75rem',
                72  : '18rem',
                73  : '18.25rem',
                74  : '18.5rem',
                75  : '18.75rem',
                76  : '19rem',
                77  : '19.25rem',
                78  :  '19.5rem',
                79  : '19.75rem',
                80  : '20rem',
                81  : '20.25rem',
                82  : '20.5rem',
                83  : '20.75rem',
                84  : '21rem',
                85  : '21.25rem',
                86  : '21.5rem',
                87  : '21.75rem',
                88  : '22rem',
                89  : '22.25rem',
                90  : '22.5rem',
                91  : '22.75rem',
                92  : '23rem',
                93  : '23.25rem',
                94  : '23.5rem',
                95  : '23.75rem',
                96  : '24rem',
                97  : '24.25rem',
                98  : '24.5rem',
                99  : '24.75rem',
                100 : '25rem'
            },
            fontSize: {
                'tiny': ['0.625rem'],  //10
                'xs'  : ['0.75rem'],   //12
                'sm'  : ['0.875rem'],  //14
                'base': ['1rem'],      //16
                'lg'  : ['1.125rem'],  //18
                'xl'  : ['1.25rem'],   //20
                '2xl' : ['1.5rem'],    //24
                '3xl' : ['1.75rem'],   //28
                '4xl' : ['2rem'],      //32
                '5xl' : ['2.25rem'],   //36
                '6xl' : ['2.5rem'],    //40
                '7xl' : ['3rem'],      //48
                '8xl' : ['3.5rem'],    //56
                '9xl' : ['4rem']       //64
            },
            zIndex: {
                '5'   : '5',
                '15'  : '15',
                '25'  : '25',
                '35'  : '35',
                '45'  : '45',
                '55'  : '55',
                '60'  : '60',
                '65'  : '65',
                '70'  : '70',
                '75'  : '75',
                '80'  : '80',
                '85'  : '85',
                '90'  : '90',
                '95'  : '95',
                '100' : '100'
            },
            backgroundPosition: {
                'left-center'  : 'left center',
                'right-center' : 'right center'
            },
            transitionDelay: {
                1500 : '1500ms',
                2000 : '2000ms',
                2500 : '2500ms',
                3000 : '3000ms'
            },
            transitionDuration: {
                1500 : '1500ms',
                2000 : '2000ms',
                2500 : '2500ms',
                3000 : '3000ms'
            },
            opacity: {
                15 : '0.15',
                35 : '0.35',
                45 : '0.45',
                55 : '0.55',
                65 : '0.65',
                85 : '0.85'
            },
            letterSpacing: {
                tightest : '-0.1em',
            },
            borderRadius: {
                xs      : '0.125rem',
                sm      : '0.25rem',
                DEFAULT : '0.375rem',
                md      : '0.5rem',
                lg      : '0.75rem',
                xl      : '0.875rem'
            },
            blur: {
                xs      : '4px',
                sm      : '8px',
                DEFAULT : '12px',
                md      : '16px',
                lg      : '20px',
                xl      : '28px'
            },
            willChange: {
                opacity   : 'opacity',
                animation : 'animation'
            },
            content: {
                empty : '""',
            },
            gridRowStart: {
                8  : '8',
                9  : '9',
                10 : '10',
                11 : '11'
            },
            gridRowEnd: {
                8  : '8',
                9  : '9',
                10 : '10',
                11 : '11'
            },
            objectPosition: {
                'left-center'  : 'left center',
                'right-center' : 'right center'
            },
            transformOrigin: {
                'top-center'    : 'top center',
                'bottom-center' : 'bottom center'
            },
            maxWidth: ({ theme }) => ({
                ...theme('spacing')
            }),
            minWidth: ({ theme }) => ({
                ...theme('spacing')
            }),
            maxHeight: ({ theme }) => ({
                ...theme('spacing')
            }),
            minHeight: ({ theme }) => ({
                ...theme('spacing')
            }),
            borderWidth: ({ theme }) => ({
                ...theme('spacing')
            }),
            outlineOffset: ({ theme }) => ({
                ...theme('spacing')
            }),
            outlineWidth: ({ theme }) => ({
                ...theme('spacing')
            }),
            ringOffsetWidth: ({ theme }) => ({
                ...theme('spacing')
            }),
            ringWidth: ({ theme }) => ({
                ...theme('spacing')
            }),
            textDecorationThickness: ({ theme }) => ({
                ...theme('spacing')
            }),
            textUnderlineOffset: ({ theme }) => ({
                ...theme('spacing')
            }),
            grayscale: {
                25  : '25%',
                50  : '50%',
                75  : '75%'
            },
            sepia: {
                25  : '25%',
                50  : '50%',
                75  : '75%'
            },
            invert: {
                25  : '25%',
                50  : '50%',
                75  : '75%'
            },
            saturate: {
                25  : '.25',
                75  : '.75',
                125 : '1.25',
                175 : '1.75'
            },
            contrast: {
                25  : '.25',
                175 : '1.75'
            },
            scale: {
                25  : '.25',
                175 : '1.75',
                200 : '2'
            },
            brightness: {
                25  : '.25',
                175 : '1.75'
            },
            hueRotate: {
                45  : '45deg',
                75  : '75deg',
                105 : '105deg',
                120 : '120deg',
                135 : '135deg',
                150 : '150deg',
                165 : '165deg'
            },
            rotate: {
                15  : '15deg',
                30  : '30deg',
                60  : '60deg',
                75  : '75deg',
                105 : '105deg',
                120 : '120deg',
                135 : '135deg',
                150 : '150deg',
                165 : '165deg'
            },
            skew: {
                15  : '15deg',
                30  : '30deg',
                45  : '45deg',
                60  : '60deg',
                75  : '75deg',
                90  : '90deg',
                105 : '105deg',
                120 : '120deg',
                135 : '135deg',
                150 : '150deg',
                165 : '165deg',
                180 : '180deg'
            },
            aspectRatio: {
                film: '4 / 3',
                gold: '16 / 10'
            }
        },
    },
    plugins: [
        require('tw-elements/dist/plugin')
    ]
}