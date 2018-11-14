INSERT INTO `stats`.`dim_driver`
(driver_id,
`NAME`,
`FULL_NAME`,
`BIRTHDAY_PLACE`,
`INFO`,
`DEATH_PLACE`,
`BIRTHDAY_ID`,
`COUNTRY_ID`,
`DEATH_DAY_ID`,
`PHOTO`)
SELECT 
    null,
    `drivers`.`name`,
    `drivers`.`full_name`,
    concat(`drivers`.`place_birthday`,
            ', ',
            `drivers`.`region_birthday_unit`,
            ' ',
            `drivers`.`region_birthday`),
    `drivers`.`info`,
    `drivers`.`place_died`,
    (select 
            da.DAY_ID
        from
            stats.dim_day da
        where
            da.day_date = drivers.birthday) birthdAY,
    (select 
            dc.COUNTRY_ID
        from
            stats.dim_country dc
        where
            dc.SHORT_NAME = c.country_name),
    (select 
            da.DAY_ID
        from
            stats.dim_day da
        where
            da.day_date = drivers.died),
    null
FROM
    `staging`.`drivers`
        join
    `staging`.`country` c ON drivers.id_country = c.id_country
