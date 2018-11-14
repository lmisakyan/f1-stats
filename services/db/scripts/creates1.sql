CREATE TABLE DIM_CHASSIS
(
CHASSIS_ID INTEGER  NOT NULL  COMMENT 'CHASSIS_ID - шасси, на котором выступает гонщик',
CODE VARCHAR (32)  NOT NULL  COMMENT 'CODE - кодовое обозначение',
CONSTRUCTOR VARCHAR (256)  COMMENT 'CONSTRUCTOR - команда (как правило) или организация разработчик шасси',
DEVELOP_DATE DATE  COMMENT 'DEVELOP_DATE - дата (год) разработки',
INFO VARCHAR (256) COMMENT 'INFO - дополнительная информация'
)
COMMENT 'CHASSIS - шасси гоночного автомобиля';
CREATE TABLE DIM_COUNTRY
(
COUNTRY_ID INTEGER  NOT NULL  COMMENT 'COUNTRY_ID - страна, на территории которой расположена трасса',
SCD_START DATE  NOT NULL  COMMENT 'SCD_START',
SCD_END DATE  NOT NULL  COMMENT 'SCD_END',
SCD_ACTIVE NUMERIC DEFAULT 1  NOT NULL  COMMENT 'SCD_ACTIVE',
SCD_VERSION SMALLINT  NOT NULL  COMMENT 'SCD_VERSION',
NUMERIC_CODE VARCHAR (3)  NOT NULL  COMMENT 'NUMERIC_CODE - код страны (3-х значный код по стандарту ISO 3166). Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.',
ALPHA_CODE VARCHAR (3)  COMMENT 'ALPHA_CODE - код страны (3-x буквенный код по стандарту ISO 3166). Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.',
COUNTRY_NAME VARCHAR (256)  COMMENT 'COUNTRY_NAME - название страны. Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.',
SHORT_NAME VARCHAR (256)  COMMENT 'SHORT_NAME - короткое название страны. Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.',
UN_REGION_NAME VARCHAR (256)  COMMENT 'REGION_NAME - регион в котором расположена страна (классификатор M49 ООН). Источник: http://unstats.un.org/unsd/methods/m49/m49regin.htm.',
UN_CONTINENT_NAME VARCHAR (256) COMMENT 'CONTINENT_NAME - континент на котором расположена страна (классификатор M49 ООН). Источник: http://unstats.un.org/unsd/methods/m49/m49regin.htm.'
)
COMMENT 'COUNTRY - страна';
CREATE TABLE DIM_DAY
(
DAY_ID INTEGER  NOT NULL  COMMENT 'DAY_ID - суррогатный ключ',
DAY_DATE DATE  NOT NULL  COMMENT 'DAY_DATE - календарная дата',
DAY_OF_WEEK_NAME VARCHAR (16)  NOT NULL  COMMENT 'DAY_OF_WEEK_NAME - день недели',
LAST_DAY_IN_WEEK_INDICATOR VARCHAR (3)  NOT NULL CHECK ( LAST_DAY_IN_WEEK_INDICATOR IN ('No', 'Yes'))  COMMENT 'LAST_DAY_IN_WEEK_INDICATOR - признак последнего дня в неделе',
LAST_DAY_IN_MONTH_INDICATOR VARCHAR (3)  NOT NULL CHECK ( LAST_DAY_IN_MONTH_INDICATOR IN ('No', 'Yes'))  COMMENT 'LAST_DAY_IN_MONTH_INDICATOR - признак последнего дня в месяце',
LAST_DAY_IN_QUARTER_INDICATOR VARCHAR (3)  NOT NULL CHECK ( LAST_DAY_IN_QUARTER_INDICATOR IN ('No', 'Yes'))  COMMENT 'LAST_DAY_IN_QUARTER_INDICATOR - признак последнего дня в квартале',
LAST_DAY_IN_YEAR_INDICATOR VARCHAR (3)  NOT NULL CHECK ( LAST_DAY_IN_YEAR_INDICATOR IN ('No', 'Yes'))  COMMENT 'LAST_DAY_IN_YEAR_INDICATOR - признак последнего дня в году',
DAY_IN_MONTH_NUMBER SMALLINT  NOT NULL  COMMENT 'DAY_IN_MONTH_NUMBER - день в месяце',
DAY_IN_YEAR_NUMBER SMALLINT  NOT NULL  COMMENT 'DAY_IN_YEAR_NUMBER - день в году',
WEEK_IN_MONTH_NUMBER SMALLINT  NOT NULL  COMMENT 'WEEK_IN_MONTH_NUMBER - неделя в месяце',
WEEK_IN_YEAR_NUMBER SMALLINT  NOT NULL  COMMENT 'WEEK_IN_YEAR_NUMBER - неделя в году',
MONTH_IN_QUARTER_NUMBER SMALLINT  NOT NULL  COMMENT 'MONTH_IN_QUARTER_NUMBER - месяц в квартале',
MONTH_NAME VARCHAR (16)  NOT NULL  COMMENT 'MONTH_NAME - месяц',
QUARTER_IN_YEAR_NUMBER SMALLINT  NOT NULL  COMMENT 'QUARTER_IN_YEAR_NUMBER - квартал в году',
HALF_IN_YEAR_NUMBER SMALLINT  NOT NULL  COMMENT 'HALF_IN_YEAR_NUMBER - половина года',
YEAR_MONTH_NAME VARCHAR (16)  NOT NULL  COMMENT 'YEAR_MONTH_NAME - год и месяц в формате ''YYYY-MM''',
YEAR_QUARTER_NAME VARCHAR (16)  NOT NULL  COMMENT 'YEAR_QUARTER_NAME - год и квартал в формате ''YYYY-Q''',
YEAR_HALF_NAME VARCHAR (16)  NOT NULL  COMMENT 'YEAR_AND_HALF - год и половина года в формате ''YYYY-H''',
SEASON_NAME VARCHAR (16)  NOT NULL  COMMENT 'SEASON_NAME - время года',
WEEKEND_INDICATOR VARCHAR (16)  NOT NULL COMMENT 'WEEKEND_INDICATOR - признак выходного дня'
)
COMMENT 'DAY - день';
CREATE TABLE DIM_DRIVER
(
DRIVER_ID INTEGER  NOT NULL  COMMENT 'DRIVER_ID - гонщик',
NAME VARCHAR (256)  NOT NULL  COMMENT 'NAME - наименование',
FULL_NAME VARCHAR (256)  NOT NULL  COMMENT 'FULL_NAME - Полное официальное наименование команды',
BIRTHDAY_PLACE VARCHAR (256)  NOT NULL  COMMENT 'BIRTHDAY_PLACE - место рождения',
INFO VARCHAR (4000)  COMMENT 'INFO - дополнительная информация',
DEATH_PLACE VARCHAR (256)  COMMENT 'DEATH_PLACE - место смерти',
BIRTHDAY_ID INTEGER  NOT NULL  COMMENT 'BIRTHDAY_ID - дата рождения',
COUNTRY_ID INTEGER  NOT NULL  COMMENT 'COUNTRY_ID - страна, на территории которой расположена трасса',
DEATH_DAY_ID INTEGER  COMMENT 'DEATH_DAY_ID - дата смерти (гибели)',
PHOTO BLOB COMMENT 'PHOTO - фотография пилота'
)
COMMENT 'DRIVER - гонщик (пилот)';
CREATE TABLE DIM_ENGINE
(
ENGINE_ID INTEGER  NOT NULL  COMMENT 'ENGINE_ID - двигатель гоночного автомобиля',
CODE VARCHAR (32)  NOT NULL  COMMENT 'CODE - кодовое обозначение',
MANUFACTURER VARCHAR (256)  NOT NULL  COMMENT 'MANUFACTURER - фирма изготовитель шин',
DEVELOP_DATE DATE  NOT NULL  COMMENT 'DEVELOP_DATE - дата (год) разработки',
DISPLACEMENT NUMERIC  NOT NULL  COMMENT 'DISPLACEMENT - объем двигателя',
CILINDER_FORMAT VARCHAR (32)  NOT NULL  COMMENT 'FORMAT - формат двигателя (число и расположение цилиндров)',
CHARGE_INDICATOR VARCHAR (3)  NOT NULL CHECK ( CHARGE_INDICATOR IN ('No', 'Yes'))  COMMENT 'CHARGE_INDICATOR - признак наддувного двигателя',
INFO VARCHAR (256) COMMENT 'INFO - дополнительная информация'
)
COMMENT 'ENGINE - двигатель гоночного автомобиля';
CREATE TABLE DIM_GRAND_PRIX
(
GRAND_PRIX_ID INTEGER  NOT NULL  COMMENT 'GRAND_PRIX_ID - гран при',
CODE VARCHAR (32)  NOT NULL  COMMENT 'CODE - кодовое обозначение',
NAME VARCHAR (256)  NOT NULL  COMMENT 'NAME - наименование',
OFFICIAL_NAME VARCHAR (256)  NOT NULL  COMMENT 'OFFICIAL_NAME - официальное наименование гран при',
YEAR_START SMALLINT  NOT NULL  COMMENT 'YEAR_START - с какого года (сезона) трасса в данной конфигурации',
YEAR_END SMALLINT  NOT NULL  COMMENT 'YEAR_END - по какой год(сезон) трасса в данной конфигурации',
TITLE_SPONSOR VARCHAR (256) COMMENT 'TITLE_SPONSOR - титульный спонсор команды'
)
COMMENT 'GRAND_PRIX - гран при (гоночный уикенд)';
CREATE TABLE DIM_POSITION_ATTRIBUTES
(
POSITION_ATTRIBUTES_ID INTEGER  NOT NULL  COMMENT 'POSITION_ATTRIBUTES_ID - суррогатный ключ',
RESULT VARCHAR (32)  COMMENT 'RESULT - результат гонки',
POSITION SMALLINT  COMMENT 'POSITION - позиция финишировавшего и классифицированного пилота на финише',
POINTS SMALLINT  COMMENT 'POINTS - количество начисленных очков',
YEAR_START SMALLINT  NOT NULL  COMMENT 'YEAR_START - с какого года (сезона) трасса в данной конфигурации',
YEAR_END SMALLINT  NOT NULL COMMENT 'YEAR_END - по какой год(сезон) трасса в данной конфигурации'
)
COMMENT 'POSITION_ATTRIBUTES - атрибуты, связанные с позицией пилота на финише гонки';
CREATE TABLE DIM_RACE_ATTRIBUTES
(
RACE_ATTRIBUTES_ID INTEGER  NOT NULL  COMMENT 'RACE_ATTRIBUTES_ID - суррогатный ключ',
GRID_PENALTY_REASON VARCHAR (256)  NOT NULL  COMMENT 'GRID_PENALTY - причина потери мест на старте',
RACE_PENALTY_REASON VARCHAR (32)  NOT NULL  COMMENT 'RACE_PENALTY_REASON - причина потери мест на финише',
RETIRE_REASON VARCHAR (32)  NOT NULL COMMENT 'RETIRE_REASON - причина схода'
)
COMMENT 'RACE_ATTRIBUTES - различные дополнительные гоночные характеристики';
CREATE TABLE DIM_SEASON
(
SEASON_ID INTEGER  NOT NULL  COMMENT 'SEASON_ID - суррогатный ключ',
YEAR_NUMBER SMALLINT  NOT NULL  COMMENT 'YEAR_NUMBER - номер года',
LEAP_YEAR_INDICATOR VARCHAR (3)  NOT NULL CHECK ( LEAP_YEAR_INDICATOR IN ('No', 'Yes'))  COMMENT 'LEAP_YEAR_INDICATOR - признак високосного года',
DECADE VARCHAR (256)  NOT NULL  COMMENT 'DECADE - десятилетие',
CENTURY SMALLINT  NOT NULL  COMMENT 'CENTURY - век',
ERA VARCHAR (256) COMMENT 'ERA - так называемая эра (эпоха) в гонках. Определяется доминирующей технологией'
)
COMMENT 'SEASON - сезон (год) чемпионата';
CREATE TABLE DIM_TEAM
(
TEAM_ID INTEGER  NOT NULL  COMMENT 'TEAM_ID - суррогатный ключ',
NAME VARCHAR (256)  NOT NULL  COMMENT 'NAME - наименование',
FULL_NAME VARCHAR (256)  NOT NULL  COMMENT 'FULL_NAME - Полное официальное наименование команды',
YEAR_START SMALLINT  NOT NULL  COMMENT 'YEAR_START - с какого года (сезона) трасса в данной конфигурации',
YEAR_END SMALLINT  NOT NULL  COMMENT 'YEAR_END - по какой год(сезон) трасса в данной конфигурации',
INFO VARCHAR (256)  COMMENT 'INFO - дополнительная информация',
TITLE_SPONSOR VARCHAR (256)  COMMENT 'TITLE_SPONSOR - титульный спонсор команды',
COUNTRY_ID INTEGER  NOT NULL COMMENT 'COUNTRY_ID - страна, на территории которой расположена трасса'
)
COMMENT 'TEAM - команда';
CREATE TABLE DIM_TRACK
(
TRACK_ID INTEGER  NOT NULL  COMMENT 'TRACK_ID - суррогатный ключ',
NAME VARCHAR (256)  NOT NULL  COMMENT 'NAME - наименование',
YEAR_START SMALLINT  NOT NULL  COMMENT 'YEAR_START - с какого года (сезона) трасса в данной конфигурации',
YEAR_END SMALLINT  NOT NULL  COMMENT 'YEAR_END - по какой год(сезон) трасса в данной конфигурации',
TURNS SMALLINT  NOT NULL  COMMENT 'TURNS - количество поворотов',
LENGTH NUMERIC  NOT NULL  COMMENT 'LENGTH - длина трассы в конфигурации гран при',
COUNTRY_ID INTEGER  NOT NULL  COMMENT 'COUNTRY_ID - страна, на территории которой расположена трасса',
CITY VARCHAR (256)  NOT NULL  COMMENT 'CITY - город, в котором находится трасса',
REGION VARCHAR (256)  COMMENT 'REGION - регион в котором находится трасса ',
INFO VARCHAR (4000)  COMMENT 'INFO - дополнительная информация',
SCHEMA BLOB COMMENT 'SCHEMA - схема трассы'
)
COMMENT 'TRACK - трасса';
CREATE TABLE DIM_TYRES
(
TYRES_ID INTEGER  NOT NULL  COMMENT 'TYRES_ID - суррогатный ключ',
CODE VARCHAR (32)  NOT NULL  COMMENT 'CODE - кодовое обозначение',
INFO VARCHAR (256)  COMMENT 'INFO - дополнительная информация',
MANUFACTURER VARCHAR (256)  NOT NULL  COMMENT 'MANUFACTURER - фирма изготовитель шин',
TREAD VARCHAR (32)  NOT NULL COMMENT 'TREAD - тип протектора'
)
COMMENT 'TYRES - шины, устанавливаемые на гоночный автомобиль';
CREATE TABLE FACT_GRAND_PRIX_RESULTS
(
DRIVER_NUMBER SMALLINT  COMMENT 'DRIVER_NUMBER - номер гонщика в чемпионате',
START_POSITION SMALLINT  COMMENT 'START_POSITION - стартовая позиция гонщика',
QUALIFYING_POSITION SMALLINT  COMMENT 'QUALIFYING_POSITION - позиция гонщика, показанная в квалификации',
FINISH_TIME TIMESTAMP  COMMENT 'FINISH_TIME - время на финише',
AVERAGE_SPEED NUMERIC  COMMENT 'AVERAGE_SPEED - средняя скорость',
FASTEST_LAP_TIME TIMESTAMP  COMMENT 'FASTEST_LAP_TIME - время бысрейшего круга в гонке',
LAPS_IN_RACE SMALLINT  COMMENT 'LAPS_IN_RACE - запланированное количество кругов в гонке',
LAPS_PASSED SMALLINT  COMMENT 'LAPS_PASSED - количество пройденных пилотом кругов',
HALF_POINTS_INDICATOR NUMERIC  COMMENT 'HALF_POINTS_INDICATOR - признак того, что за гонку начислили половину очков',
RACE_DAY_ID INTEGER  NOT NULL  COMMENT 'RACE_DAY_ID - дата гонки',
DRIVER_ID INTEGER  NOT NULL  COMMENT 'DRIVER_ID - гонщик',
EAM_ID INTEGER  NOT NULL  COMMENT 'TEAM_ID - команда, за которую выступает гонщик',
TRACK_ID INTEGER  NOT NULL  COMMENT 'TRACK_ID - суррогатный ключ',
CHASSIS_ID INTEGER  NOT NULL  COMMENT 'CHASSIS_ID - шасси, на котором выступает гонщик',
ENGINE_ID INTEGER  NOT NULL  COMMENT 'ENGINE_ID - двигатель гоночного автомобиля',
SEASON_ID INTEGER  NOT NULL  COMMENT 'SEASON_ID - суррогатный ключ',
GRAND_PRIX_ID INTEGER  NOT NULL  COMMENT 'GRAND_PRIX_ID - гран при',
RACE_ATTRIBUTES_ID INTEGER  NOT NULL  COMMENT 'RACE_ATTRIBUTES_ID - суррогатный ключ',
TYRES_ID INTEGER  NOT NULL  COMMENT 'TYRES_ID - суррогатный ключ',
POSITION_ATTRIBUTES_ID INTEGER  NOT NULL COMMENT 'POSITION_ATTRIBUTES_ID - суррогатный ключ'
)
COMMENT 'GRAND_PRIX_RESULTS - результаты гран при с детализацией до гонщика';
