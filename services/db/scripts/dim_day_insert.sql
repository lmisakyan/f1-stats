INSERT INTO `stats`.`dim_day`
(`DAY_ID`,
`DAY_DATE`,
`DAY_OF_WEEK_NAME`,
`LAST_DAY_IN_WEEK_INDICATOR`,
`LAST_DAY_IN_MONTH_INDICATOR`,
`LAST_DAY_IN_QUARTER_INDICATOR`,
`LAST_DAY_IN_YEAR_INDICATOR`,
`DAY_IN_MONTH_NUMBER`,
`DAY_IN_YEAR_NUMBER`,
`WEEK_IN_MONTH_NUMBER`,
`WEEK_IN_YEAR_NUMBER`,
`MONTH_IN_QUARTER_NUMBER`,
`MONTH_NAME`,
`QUARTER_IN_YEAR_NUMBER`,
`HALF_IN_YEAR_NUMBER`,
`YEAR_MONTH_NAME`,
`YEAR_QUARTER_NAME`,
`YEAR_HALF_NAME`,
`SEASON_NAME`,
`WEEKEND_INDICATOR`,
`MONTH_IN_YEAR_NUMBER`,
`YEAR_NUMBER`,
`QUARTER_NAME`,
`ISO_YEAR_NUMBER`,
`ISO_WEEK_IN_YEAR_NUMBER`,
`ISO_YEAR_WEEK_NAME`,
`YEAR_DAY_NAME`,
`DAY_IN_WEEK_NUMBER`) 
SELECT 
    `dim_day`.`DAY_ID`,
    `dim_day`.`DAY_DTE`,
    DATE_FORMAT(DAY_DTE, '%W'),
    case DATE_FORMAT(DAY_DTE, '%W')
        when 'Sunday' then 'Yes'
        else 'No'
    end,
    `dim_day`.`LST_DAY_IN_MTH_IDC`,
    `dim_day`.`LST_DAY_IN_QRT_IDC`,
    `dim_day`.`LST_DAY_IN_YEA_IDC`,
    DATE_FORMAT(DAY_DTE, '%e'),
    DATE_FORMAT(DAY_DTE, '%j'),
    null,
    DATE_FORMAT(DAY_DTE, '%v'),
    null,
    DATE_FORMAT(DAY_DTE, '%M'),
    `dim_day`.`QRT_IN_YEA_NBR`,
    null,
    concat(DATE_FORMAT(DAY_DTE, '%Y'),
            '-',
            DATE_FORMAT(DAY_DTE, '%m')),
    null,
    null,
    case
        when DATE_FORMAT(DAY_DTE, '%m') in ('01' , '02', '12') then 'Winter'
        when DATE_FORMAT(DAY_DTE, '%m') in ('03' , '04', '05') then 'Spring'
        when DATE_FORMAT(DAY_DTE, '%m') in ('06' , '07', '08') then 'Summer'
        else 'Autumn'
    end,
    case DATE_FORMAT(DAY_DTE, '%W')
        when 'Sunday' then 'Yes'
        when 'Saturday' then 'Yes'
        else 'No'
    end,
    DATE_FORMAT(DAY_DTE, '%m'),
    DATE_FORMAT(DAY_DTE, '%Y'),
    null, -- `dim_day`.`QRT_NAM`,
    null,-- `dim_day`.`ISO_YEA_NBR`,
    null,-- `dim_day`.`ISO_WEK_IN_YEA_NBR`,
    null,-- `dim_day`.`ISO_YEA_WEK_NAM`,
     concat(DATE_FORMAT(DAY_DTE, '%Y'),
            '-',
            DATE_FORMAT(DAY_DTE, '%j')),
   DATE_FORMAT(DAY_DTE, '%w') + 2
FROM
    `staging`.`dim_day`;

