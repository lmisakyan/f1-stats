CREATE SCHEMA IF NOT EXISTS analytic;

ALTER SCHEMA analytic
  OWNER TO f1;

SET search_path TO analytic;

CREATE TABLE analytic.dim_chassis
(
  chassis_id  SERIAL      NOT NULL
    CONSTRAINT dim_chassis_pkey
    PRIMARY KEY,
  name        VARCHAR(64) NOT NULL,
  constructor VARCHAR(64) NOT NULL,
  year_start  SMALLINT    NOT NULL,
  year_end    SMALLINT    NOT NULL,
  info        VARCHAR(256)
);

COMMENT ON TABLE analytic.dim_chassis
IS 'CHASSIS - шасси гоночного автомобиля';

COMMENT ON COLUMN analytic.dim_chassis.chassis_id
IS 'CHASSIS_ID - шасси, на котором выступает гонщик';

COMMENT ON COLUMN analytic.dim_chassis.name
IS 'Наименование';

COMMENT ON COLUMN analytic.dim_chassis.constructor
IS 'CONSTRUCTOR - команда (как правило) или организация разработчик шасси';

COMMENT ON COLUMN analytic.dim_chassis.year_start
IS 'Дата (год) начала использования';

COMMENT ON COLUMN analytic.dim_chassis.year_end
IS 'Дата (год) окончания использования';

COMMENT ON COLUMN analytic.dim_chassis.info
IS 'INFO - дополнительная информация';

ALTER TABLE analytic.dim_chassis
  OWNER TO f1;

CREATE UNIQUE INDEX dim_chassis_chassis_name_uk
  ON analytic.dim_chassis (name, year_start);

CREATE TABLE analytic.dim_constructor
(
  constructor_id SERIAL      NOT NULL
    CONSTRAINT dim_constructor_pkey
    PRIMARY KEY,
  name           VARCHAR(64) NOT NULL,
  info           VARCHAR(256)
);

COMMENT ON TABLE analytic.dim_constructor
IS 'Организация конструктор гоночного автомобиля (шасси)';

COMMENT ON COLUMN analytic.dim_constructor.constructor_id
IS 'Суррогатный ключ.';

COMMENT ON COLUMN analytic.dim_constructor.name
IS 'Наименование';

COMMENT ON COLUMN analytic.dim_constructor.info
IS 'Дополнительная информация';

ALTER TABLE analytic.dim_constructor
  OWNER TO f1;

CREATE UNIQUE INDEX dim_constructor_constructor_name_uk
  ON analytic.dim_constructor (name);

CREATE TABLE analytic.dim_country
(
  country_id        SERIAL                   NOT NULL
    CONSTRAINT dim_country_pkey
    PRIMARY KEY,
  scd_start         TIMESTAMP WITH TIME ZONE NOT NULL,
  scd_end           TIMESTAMP WITH TIME ZONE NOT NULL,
  scd_active        NUMERIC DEFAULT 1        NOT NULL,
  scd_version       SMALLINT                 NOT NULL,
  numeric_code      VARCHAR(3)               NOT NULL,
  alpha_code        VARCHAR(3)               NOT NULL,
  country_name      VARCHAR(256),
  short_name        VARCHAR(256),
  un_region_name    VARCHAR(256),
  un_continent_name VARCHAR(256)
);

COMMENT ON TABLE analytic.dim_country
IS 'COUNTRY - страна';

COMMENT ON COLUMN analytic.dim_country.country_id
IS 'COUNTRY_ID - страна, на территории которой расположена трасса';

COMMENT ON COLUMN analytic.dim_country.scd_start
IS 'SCD_START';

COMMENT ON COLUMN analytic.dim_country.scd_end
IS 'SCD_END';

COMMENT ON COLUMN analytic.dim_country.scd_active
IS 'SCD_ACTIVE';

COMMENT ON COLUMN analytic.dim_country.scd_version
IS 'SCD_VERSION';

COMMENT ON COLUMN analytic.dim_country.numeric_code
IS 'NUMERIC_CODE - код страны (3-х значный код по стандарту ISO 3166). Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.';

COMMENT ON COLUMN analytic.dim_country.alpha_code
IS 'ALPHA_CODE - код страны (3-x буквенный код по стандарту ISO 3166). Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.';

COMMENT ON COLUMN analytic.dim_country.country_name
IS 'COUNTRY_NAME - название страны. Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.';

COMMENT ON COLUMN analytic.dim_country.short_name
IS 'SHORT_NAME - короткое название страны. Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.';

COMMENT ON COLUMN analytic.dim_country.un_region_name
IS 'REGION_NAME - регион в котором расположена страна (классификатор M49 ООН). Источник: http://unstats.un.org/unsd/methods/m49/m49regin.htm.';

COMMENT ON COLUMN analytic.dim_country.un_continent_name
IS 'CONTINENT_NAME - континент на котором расположена страна (классификатор M49 ООН). Источник: http://unstats.un.org/unsd/methods/m49/m49regin.htm.';

ALTER TABLE analytic.dim_country
  OWNER TO f1;

CREATE UNIQUE INDEX dim_country_country_code_uk
  ON analytic.dim_country (numeric_code, scd_version);

CREATE TABLE analytic.dim_day
(
  day_id                        SERIAL      NOT NULL
    CONSTRAINT dim_day_pkey
    PRIMARY KEY,
  day_date                      DATE        NOT NULL,
  day_of_week_name              VARCHAR(16) NOT NULL,
  last_day_in_week_indicator    VARCHAR(3)  NOT NULL,
  last_day_in_month_indicator   VARCHAR(3),
  last_day_in_quarter_indicator VARCHAR(3),
  last_day_in_year_indicator    VARCHAR(3),
  day_in_month_number           SMALLINT    NOT NULL,
  day_in_year_number            SMALLINT    NOT NULL,
  week_in_month_number          SMALLINT,
  week_in_year_number           SMALLINT,
  month_in_quarter_number       SMALLINT,
  month_name                    VARCHAR(16) NOT NULL,
  quarter_in_year_number        SMALLINT,
  half_in_year_number           SMALLINT,
  year_month_name               VARCHAR(16) NOT NULL,
  year_quarter_name             VARCHAR(16),
  year_half_name                VARCHAR(16),
  season_name                   VARCHAR(16) NOT NULL,
  weekend_indicator             VARCHAR(16) NOT NULL,
  month_in_year_number          SMALLINT    NOT NULL,
  year_number                   SMALLINT    NOT NULL,
  quarter_name                  VARCHAR(16),
  iso_year_number               SMALLINT,
  iso_week_in_year_number       SMALLINT,
  iso_year_week_name            VARCHAR(45),
  year_day_name                 VARCHAR(45) NOT NULL,
  day_in_week_number            SMALLINT    NOT NULL
);

COMMENT ON TABLE analytic.dim_day
IS 'DAY - день';

COMMENT ON COLUMN analytic.dim_day.day_id
IS 'DAY_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.dim_day.day_date
IS 'DAY_DATE - календарная дата';

COMMENT ON COLUMN analytic.dim_day.day_of_week_name
IS 'DAY_OF_WEEK_NAME - день недели';

COMMENT ON COLUMN analytic.dim_day.last_day_in_week_indicator
IS 'LAST_DAY_IN_WEEK_INDICATOR - признак последнего дня в неделе';

COMMENT ON COLUMN analytic.dim_day.last_day_in_month_indicator
IS 'LAST_DAY_IN_MONTH_INDICATOR - признак последнего дня в месяце';

COMMENT ON COLUMN analytic.dim_day.last_day_in_quarter_indicator
IS 'LAST_DAY_IN_QUARTER_INDICATOR - признак последнего дня в квартале';

COMMENT ON COLUMN analytic.dim_day.last_day_in_year_indicator
IS 'LAST_DAY_IN_YEAR_INDICATOR - признак последнего дня в году';

COMMENT ON COLUMN analytic.dim_day.day_in_month_number
IS 'DAY_IN_MONTH_NUMBER - день в месяце';

COMMENT ON COLUMN analytic.dim_day.day_in_year_number
IS 'DAY_IN_YEAR_NUMBER - день в году';

COMMENT ON COLUMN analytic.dim_day.week_in_month_number
IS 'WEEK_IN_MONTH_NUMBER - неделя в месяце';

COMMENT ON COLUMN analytic.dim_day.week_in_year_number
IS 'WEEK_IN_YEAR_NUMBER - неделя в году';

COMMENT ON COLUMN analytic.dim_day.month_in_quarter_number
IS 'MONTH_IN_QUARTER_NUMBER - месяц в квартале';

COMMENT ON COLUMN analytic.dim_day.month_name
IS 'MONTH_NAME - месяц';

COMMENT ON COLUMN analytic.dim_day.quarter_in_year_number
IS 'QUARTER_IN_YEAR_NUMBER - квартал в году';

COMMENT ON COLUMN analytic.dim_day.half_in_year_number
IS 'HALF_IN_YEAR_NUMBER - половина года';

COMMENT ON COLUMN analytic.dim_day.year_month_name
IS 'YEAR_MONTH_NAME - год и месяц в формате "YYYY-MM"';

COMMENT ON COLUMN analytic.dim_day.year_quarter_name
IS 'YEAR_QUARTER_NAME - год и квартал в формате "YYYY-Q"';

COMMENT ON COLUMN analytic.dim_day.year_half_name
IS 'YEAR_AND_HALF - год и половина года в формате "YYYY-H"';

COMMENT ON COLUMN analytic.dim_day.season_name
IS 'SEASON_NAME - время года';

COMMENT ON COLUMN analytic.dim_day.weekend_indicator
IS 'WEEKEND_INDICATOR - признак выходного дня';

ALTER TABLE analytic.dim_day
  OWNER TO f1;

CREATE UNIQUE INDEX dim_day_day_date_uk
  ON analytic.dim_day (day_date);

CREATE TABLE analytic.dim_driver
(
  driver_id      SERIAL       NOT NULL
    CONSTRAINT dim_driver_pkey
    PRIMARY KEY,
  name           VARCHAR(64)  NOT NULL,
  full_name      VARCHAR(256) NOT NULL,
  birthday_place VARCHAR(256) NOT NULL,
  info           TEXT,
  death_place    VARCHAR(256),
  birthday_id    INTEGER      NOT NULL
    CONSTRAINT driver_birthday_fk
    REFERENCES dim_day,
  country_id     INTEGER      NOT NULL
    CONSTRAINT driver_country_fk
    REFERENCES dim_country,
  death_day_id   INTEGER
    CONSTRAINT driver_death_day_fk
    REFERENCES dim_day,
  photo          BYTEA
);

COMMENT ON TABLE analytic.dim_driver
IS 'DRIVER - гонщик (пилот)';

COMMENT ON COLUMN analytic.dim_driver.driver_id
IS 'DRIVER_ID - гонщик';

COMMENT ON COLUMN analytic.dim_driver.name
IS 'NAME - наименование';

COMMENT ON COLUMN analytic.dim_driver.full_name
IS 'FULL_NAME - Полное официальное наименование команды';

COMMENT ON COLUMN analytic.dim_driver.birthday_place
IS 'BIRTHDAY_PLACE - место рождения';

COMMENT ON COLUMN analytic.dim_driver.info
IS 'INFO - дополнительная информация';

COMMENT ON COLUMN analytic.dim_driver.death_place
IS 'DEATH_PLACE - место смерти';

COMMENT ON COLUMN analytic.dim_driver.birthday_id
IS 'BIRTHDAY_ID - дата рождения';

COMMENT ON COLUMN analytic.dim_driver.country_id
IS 'COUNTRY_ID - страна, на территории которой расположена трасса';

COMMENT ON COLUMN analytic.dim_driver.death_day_id
IS 'DEATH_DAY_ID - дата смерти (гибели)';

COMMENT ON COLUMN analytic.dim_driver.photo
IS 'PHOTO - фотография пилота';

ALTER TABLE analytic.dim_driver
  OWNER TO f1;

CREATE UNIQUE INDEX dim_driver_driver_name_uk
  ON analytic.dim_driver (name);

CREATE INDEX dim_driver_driver_birthday_ix
  ON analytic.dim_driver (birthday_id);

CREATE INDEX dim_driver_driver_country_ix
  ON analytic.dim_driver (country_id);

CREATE INDEX dim_driver_driver_death_day_ix
  ON analytic.dim_driver (death_day_id);

CREATE TABLE analytic.dim_engine
(
  engine_id        SERIAL       NOT NULL
    CONSTRAINT dim_engine_pkey
    PRIMARY KEY,
  code             VARCHAR(64)  NOT NULL,
  manufacturer     VARCHAR(256) NOT NULL,
  develop_year     SMALLINT     NOT NULL,
  displacement     NUMERIC      NOT NULL,
  cilinder_format  VARCHAR(32)  NOT NULL,
  charge_indicator VARCHAR(3)   NOT NULL,
  info             VARCHAR(256)
);

COMMENT ON TABLE analytic.dim_engine
IS 'ENGINE - двигатель гоночного автомобиля';

COMMENT ON COLUMN analytic.dim_engine.engine_id
IS 'ENGINE_ID - двигатель гоночного автомобиля';

COMMENT ON COLUMN analytic.dim_engine.code
IS 'CODE - кодовое обозначение';

COMMENT ON COLUMN analytic.dim_engine.manufacturer
IS 'MANUFACTURER - фирма изготовитель шин';

COMMENT ON COLUMN analytic.dim_engine.develop_year
IS 'DEVELOP_DATE - дата (год) разработки';

COMMENT ON COLUMN analytic.dim_engine.displacement
IS 'DISPLACEMENT - объем двигателя';

COMMENT ON COLUMN analytic.dim_engine.cilinder_format
IS 'FORMAT - формат двигателя (число и расположение цилиндров)';

COMMENT ON COLUMN analytic.dim_engine.charge_indicator
IS 'CHARGE_INDICATOR - признак наддувного двигателя';

COMMENT ON COLUMN analytic.dim_engine.info
IS 'INFO - дополнительная информация';

ALTER TABLE analytic.dim_engine
  OWNER TO f1;

CREATE UNIQUE INDEX dim_engine_engine_code_uk
  ON analytic.dim_engine (code, develop_year);

CREATE TABLE analytic.dim_grand_prix
(
  grand_prix_id SERIAL       NOT NULL
    CONSTRAINT dim_grand_prix_pkey
    PRIMARY KEY,
  code          VARCHAR(3)   NOT NULL,
  name          VARCHAR(256) NOT NULL,
  official_name VARCHAR(256) NOT NULL,
  year          SMALLINT     NOT NULL,
  round         SMALLINT     NOT NULL,
  time          TIME         NULL,
  day_id        INTEGER
    CONSTRAINT driver_death_day_fk
    REFERENCES dim_day,
  title_sponsor VARCHAR(256),
  url           VARCHAR(512) NOT NULL
);

COMMENT ON TABLE analytic.dim_grand_prix
IS 'GRAND_PRIX - гран при (гоночный уикенд)';

COMMENT ON COLUMN analytic.dim_grand_prix.grand_prix_id
IS 'GRAND_PRIX_ID - гран при';

COMMENT ON COLUMN analytic.dim_grand_prix.code
IS 'CODE - кодовое обозначение';

COMMENT ON COLUMN analytic.dim_grand_prix.name
IS 'NAME - наименование';

COMMENT ON COLUMN analytic.dim_grand_prix.official_name
IS 'OFFICIAL_NAME - официальное наименование гран при';

COMMENT ON COLUMN analytic.dim_grand_prix.year
IS 'YEAR - год проведения';

COMMENT ON COLUMN analytic.dim_grand_prix.round
IS 'ROUND - номер по порядку в году';

COMMENT ON COLUMN analytic.dim_grand_prix.time
IS 'TIME - время старта UTC';

COMMENT ON COLUMN analytic.dim_grand_prix.day_id
IS 'DAY_ID - день проведения';

COMMENT ON COLUMN analytic.dim_grand_prix.title_sponsor
IS 'TITLE_SPONSOR - титульный спонсор гран при';

COMMENT ON COLUMN analytic.dim_grand_prix.url
IS 'URL - страница в википедии';

ALTER TABLE analytic.dim_grand_prix
  OWNER TO f1;

CREATE UNIQUE INDEX dim_grand_prix_grand_prix_code_uk
  ON analytic.dim_grand_prix (name, year);

CREATE TABLE analytic.dim_lubricant
(
  lubricant_id SERIAL      NOT NULL
    CONSTRAINT dim_lubricant_pkey
    PRIMARY KEY,
  name         VARCHAR(64) NOT NULL,
  info         VARCHAR(255)
);

ALTER TABLE analytic.dim_lubricant
  OWNER TO f1;

CREATE UNIQUE INDEX dim_lubricant_lubricant_name_uk
  ON analytic.dim_lubricant (name);

CREATE TABLE analytic.dim_position_attributes
(
  position_attributes_id SERIAL   NOT NULL
    CONSTRAINT dim_position_attributes_pkey
    PRIMARY KEY,
  result                 VARCHAR(32),
  position               SMALLINT,
  points                 SMALLINT,
  year_start             SMALLINT NOT NULL,
  year_end               SMALLINT NOT NULL
);

COMMENT ON TABLE analytic.dim_position_attributes
IS 'POSITION_ATTRIBUTES - атрибуты, связанные с позицией пилота на финише гонки';

COMMENT ON COLUMN analytic.dim_position_attributes.position_attributes_id
IS 'POSITION_ATTRIBUTES_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.dim_position_attributes.result
IS 'RESULT - результат гонки';

COMMENT ON COLUMN analytic.dim_position_attributes.position
IS 'POSITION - позиция классифицированного пилота на финише';

COMMENT ON COLUMN analytic.dim_position_attributes.points
IS 'POINTS - количество начисленных очков';

COMMENT ON COLUMN analytic.dim_position_attributes.year_start
IS 'YEAR_START - с какого года (сезона) трасса в данной конфигурации';

COMMENT ON COLUMN analytic.dim_position_attributes.year_end
IS 'YEAR_END - по какой год(сезон) трасса в данной конфигурации';

ALTER TABLE analytic.dim_position_attributes
  OWNER TO f1;

CREATE UNIQUE INDEX dim_position_attributes_position_attributes_uk
  ON analytic.dim_position_attributes (result, year_start);

CREATE TABLE analytic.dim_race_attributes
(
  race_attributes_id  SERIAL       NOT NULL
    CONSTRAINT dim_race_attributes_pkey
    PRIMARY KEY,
  grid_penalty_reason VARCHAR(32)  NOT NULL,
  race_penalty_reason VARCHAR(32)  NOT NULL,
  retire_reason       VARCHAR(32)  NOT NULL,
  info                VARCHAR(256) NOT NULL
);

COMMENT ON TABLE analytic.dim_race_attributes
IS 'RACE_ATTRIBUTES - различные дополнительные гоночные характеристики';

COMMENT ON COLUMN analytic.dim_race_attributes.race_attributes_id
IS 'RACE_ATTRIBUTES_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.dim_race_attributes.grid_penalty_reason
IS 'GRID_PENALTY - причина потери мест на старте';

COMMENT ON COLUMN analytic.dim_race_attributes.race_penalty_reason
IS 'RACE_PENALTY_REASON - причина потери мест на финише';

COMMENT ON COLUMN analytic.dim_race_attributes.retire_reason
IS 'RETIRE_REASON - причина схода';

COMMENT ON COLUMN analytic.dim_race_attributes.info
IS 'INFO - дополнительная информация';

ALTER TABLE analytic.dim_race_attributes
  OWNER TO f1;

CREATE UNIQUE INDEX dim_race_attributes_race_attributes_uk
  ON analytic.dim_race_attributes (grid_penalty_reason, race_penalty_reason, retire_reason);

CREATE TABLE analytic.dim_season
(
  season_id           SERIAL       NOT NULL
    CONSTRAINT dim_season_pkey
    PRIMARY KEY,
  year_number         SMALLINT     NOT NULL,
  leap_year_indicator VARCHAR(3)   NOT NULL,
  decade              VARCHAR(256) NOT NULL,
  century             SMALLINT     NOT NULL,
  era                 VARCHAR(256)
);

COMMENT ON TABLE analytic.dim_season
IS 'SEASON - сезон (год) чемпионата';

COMMENT ON COLUMN analytic.dim_season.season_id
IS 'SEASON_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.dim_season.year_number
IS 'YEAR_NUMBER - номер года';

COMMENT ON COLUMN analytic.dim_season.leap_year_indicator
IS 'LEAP_YEAR_INDICATOR - признак високосного года';

COMMENT ON COLUMN analytic.dim_season.decade
IS 'DECADE - десятилетие';

COMMENT ON COLUMN analytic.dim_season.century
IS 'CENTURY - век';

COMMENT ON COLUMN analytic.dim_season.era
IS 'ERA - так называемая эра (эпоха) в гонках. Определяется доминирующей технологией';

ALTER TABLE analytic.dim_season
  OWNER TO f1;

CREATE UNIQUE INDEX dim_season_season_year_uk
  ON analytic.dim_season (year_number);

CREATE TABLE analytic.dim_team
(
  team_id        SERIAL      NOT NULL
    CONSTRAINT dim_team_pkey
    PRIMARY KEY,
  name           VARCHAR(64) NOT NULL,
  full_name      VARCHAR(64) NOT NULL,
  year_start     SMALLINT    NOT NULL,
  year_end       SMALLINT    NOT NULL,
  info           VARCHAR(256),
  title_sponsor  VARCHAR(256),
  country_id     INTEGER
    CONSTRAINT team_country_fk
    REFERENCES dim_country,
  manager        VARCHAR(64),
  base           VARCHAR(64),
  is_constructor VARCHAR(3)  NOT NULL
);

COMMENT ON TABLE analytic.dim_team
IS 'TEAM - команда (entrant по официальной терминологии)';

COMMENT ON COLUMN analytic.dim_team.team_id
IS 'TEAM_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.dim_team.name
IS 'NAME - наименование';

COMMENT ON COLUMN analytic.dim_team.full_name
IS 'FULL_NAME - Полное официальное наименование команды (Entry name)';

COMMENT ON COLUMN analytic.dim_team.year_start
IS 'YEAR_START - с какого года (сезона) высткпает команда';

COMMENT ON COLUMN analytic.dim_team.year_end
IS 'YEAR_END - по какой год(сезон) выступала команда';

COMMENT ON COLUMN analytic.dim_team.info
IS 'INFO - дополнительная информация';

COMMENT ON COLUMN analytic.dim_team.title_sponsor
IS 'TITLE_SPONSOR - титульный спонсор команды';

COMMENT ON COLUMN analytic.dim_team.country_id
IS 'COUNTRY_ID - страна, которую представляет команда';

COMMENT ON COLUMN analytic.dim_team.manager
IS 'MANAGER - руководитель команды';

COMMENT ON COLUMN analytic.dim_team.base
IS 'BASE - месторасположение базы команды';

COMMENT ON COLUMN analytic.dim_team.is_constructor
IS 'Является ли команда конструктором (разработчиком шасси).';

ALTER TABLE analytic.dim_team
  OWNER TO f1;

CREATE UNIQUE INDEX dim_team_team_name_uk
  ON analytic.dim_team (name, full_name, year_start);

CREATE INDEX dim_team_team_country_fk
  ON analytic.dim_team (country_id);

CREATE TABLE analytic.dim_track
(
  track_id     SERIAL      NOT NULL
    CONSTRAINT dim_track_pkey
    PRIMARY KEY,
  name         VARCHAR(64) NOT NULL,
  year_start   SMALLINT    NOT NULL,
  year_end     SMALLINT    NOT NULL,
  turns        SMALLINT,
  length       NUMERIC     NOT NULL,
  country_id   INTEGER     NOT NULL
    CONSTRAINT track_country_fk
    REFERENCES dim_country,
  city         VARCHAR(256),
  region       VARCHAR(256),
  info         VARCHAR(4000),
  track_schema BYTEA
);

COMMENT ON TABLE analytic.dim_track
IS 'TRACK - трасса';

COMMENT ON COLUMN analytic.dim_track.track_id
IS 'TRACK_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.dim_track.name
IS 'NAME - наименование';

COMMENT ON COLUMN analytic.dim_track.year_start
IS 'YEAR_START - с какого года (сезона) трасса в данной конфигурации';

COMMENT ON COLUMN analytic.dim_track.year_end
IS 'YEAR_END - по какой год(сезон) трасса в данной конфигурации';

COMMENT ON COLUMN analytic.dim_track.turns
IS 'TURNS - количество поворотов';

COMMENT ON COLUMN analytic.dim_track.length
IS 'LENGTH - длина трассы в конфигурации гран при (метры)';

COMMENT ON COLUMN analytic.dim_track.country_id
IS 'COUNTRY_ID - страна, на территории которой расположена трасса';

COMMENT ON COLUMN analytic.dim_track.city
IS 'CITY - город, в котором находится трасса';

COMMENT ON COLUMN analytic.dim_track.region
IS 'REGION - регион в котором находится трасса ';

COMMENT ON COLUMN analytic.dim_track.info
IS 'INFO - дополнительная информация';

COMMENT ON COLUMN analytic.dim_track.track_schema
IS 'SCHEMA - схема трассы';

ALTER TABLE analytic.dim_track
  OWNER TO f1;

CREATE UNIQUE INDEX dim_track_track_name_uk
  ON analytic.dim_track (name, year_start);

CREATE INDEX dim_track_track_country_fk
  ON analytic.dim_track (country_id);

CREATE TABLE analytic.dim_tyres
(
  tyres_id     SERIAL       NOT NULL
    CONSTRAINT dim_tyres_pkey
    PRIMARY KEY,
  name         VARCHAR(64)  NOT NULL,
  info         VARCHAR(256),
  manufacturer VARCHAR(256) NOT NULL,
  tread        VARCHAR(32)  NOT NULL
);

COMMENT ON TABLE analytic.dim_tyres
IS 'TYRES - шины, устанавливаемые на гоночный автомобиль';

COMMENT ON COLUMN analytic.dim_tyres.tyres_id
IS 'TYRES_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.dim_tyres.name
IS 'Наименование';

COMMENT ON COLUMN analytic.dim_tyres.info
IS 'INFO - дополнительная информация';

COMMENT ON COLUMN analytic.dim_tyres.manufacturer
IS 'MANUFACTURER - фирма изготовитель шин';

COMMENT ON COLUMN analytic.dim_tyres.tread
IS 'TREAD - тип протектора';

ALTER TABLE analytic.dim_tyres
  OWNER TO f1;

CREATE UNIQUE INDEX dim_tyres_tyres_name_uk
  ON analytic.dim_tyres (name);

CREATE TABLE analytic.fact_grand_prix_results
(
  driver_number          SMALLINT NOT NULL,
  start_position         SMALLINT,
  qualifying_position    SMALLINT,
  finish_time            TIMESTAMP WITH TIME ZONE,
  average_speed          NUMERIC,
  fastest_lap_time       TIMESTAMP WITH TIME ZONE,
  laps_in_race           SMALLINT,
  laps_passed            SMALLINT,
  half_points_indicator  SMALLINT NOT NULL,
  race_day_id            INTEGER  NOT NULL
    CONSTRAINT gp_results_day_fk
    REFERENCES dim_day,
  driver_id              INTEGER  NOT NULL
    CONSTRAINT gp_results_driver_fk
    REFERENCES dim_driver,
  team_id                INTEGER  NOT NULL
    CONSTRAINT gp_results_team_fk
    REFERENCES dim_team,
  track_id               INTEGER  NOT NULL
    CONSTRAINT gp_results_track_fk
    REFERENCES dim_track,
  chassis_id             INTEGER  NOT NULL
    CONSTRAINT gp_results_chassis_fk
    REFERENCES dim_chassis,
  engine_id              INTEGER  NOT NULL
    CONSTRAINT gp_results_engine_fk
    REFERENCES dim_engine,
  season_id              INTEGER  NOT NULL
    CONSTRAINT gp_results_season_fk
    REFERENCES dim_season,
  grand_prix_id          INTEGER  NOT NULL
    CONSTRAINT gp_results_grand_prix_fk
    REFERENCES dim_grand_prix,
  race_attributes_id     INTEGER  NOT NULL
    CONSTRAINT gp_results_race_attributes_fk
    REFERENCES dim_race_attributes,
  tyres_id               INTEGER  NOT NULL
    CONSTRAINT gp_results_tyres_fk
    REFERENCES dim_tyres,
  position_attributes_id INTEGER  NOT NULL
    CONSTRAINT gp_results_position_attributes_fk
    REFERENCES dim_position_attributes,
  constructor_id         INTEGER  NOT NULL
    CONSTRAINT gp_results_constructor_fk
    REFERENCES dim_constructor,
  lubricant_id           INTEGER  NOT NULL
    CONSTRAINT gp_results_lubricant_fk
    REFERENCES dim_lubricant,
  CONSTRAINT fact_grand_prix_results_pkey
  PRIMARY KEY (driver_id, season_id, grand_prix_id)
);

COMMENT ON TABLE analytic.fact_grand_prix_results
IS 'GRAND_PRIX_RESULTS - результаты гран при с детализацией до гонщика';

COMMENT ON COLUMN analytic.fact_grand_prix_results.driver_number
IS 'DRIVER_NUMBER - номер гонщика в чемпионате';

COMMENT ON COLUMN analytic.fact_grand_prix_results.start_position
IS 'START_POSITION - стартовая позиция гонщика';

COMMENT ON COLUMN analytic.fact_grand_prix_results.qualifying_position
IS 'QUALIFYING_POSITION - позиция гонщика, показанная в квалификации';

COMMENT ON COLUMN analytic.fact_grand_prix_results.finish_time
IS 'FINISH_TIME - время на финише';

COMMENT ON COLUMN analytic.fact_grand_prix_results.average_speed
IS 'AVERAGE_SPEED - средняя скорость';

COMMENT ON COLUMN analytic.fact_grand_prix_results.fastest_lap_time
IS 'FASTEST_LAP_TIME - время бысрейшего круга в гонке';

COMMENT ON COLUMN analytic.fact_grand_prix_results.laps_in_race
IS 'LAPS_IN_RACE - запланированное количество кругов в гонке';

COMMENT ON COLUMN analytic.fact_grand_prix_results.laps_passed
IS 'LAPS_PASSED - количество пройденных пилотом кругов';

COMMENT ON COLUMN analytic.fact_grand_prix_results.half_points_indicator
IS 'HALF_POINTS_INDICATOR - признак того, что за гонку начислили половину очков';

COMMENT ON COLUMN analytic.fact_grand_prix_results.race_day_id
IS 'RACE_DAY_ID - дата гонки';

COMMENT ON COLUMN analytic.fact_grand_prix_results.driver_id
IS 'DRIVER_ID - гонщик';

COMMENT ON COLUMN analytic.fact_grand_prix_results.team_id
IS 'TEAM_ID - команда, за которую выступает гонщик';

COMMENT ON COLUMN analytic.fact_grand_prix_results.track_id
IS 'TRACK_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.fact_grand_prix_results.chassis_id
IS 'CHASSIS_ID - шасси, на котором выступает гонщик';

COMMENT ON COLUMN analytic.fact_grand_prix_results.engine_id
IS 'ENGINE_ID - двигатель гоночного автомобиля';

COMMENT ON COLUMN analytic.fact_grand_prix_results.season_id
IS 'SEASON_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.fact_grand_prix_results.grand_prix_id
IS 'GRAND_PRIX_ID - гран при';

COMMENT ON COLUMN analytic.fact_grand_prix_results.race_attributes_id
IS 'RACE_ATTRIBUTES_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.fact_grand_prix_results.tyres_id
IS 'TYRES_ID - суррогатный ключ';

COMMENT ON COLUMN analytic.fact_grand_prix_results.position_attributes_id
IS 'POSITION_ATTRIBUTES_ID - суррогатный ключ';

ALTER TABLE analytic.fact_grand_prix_results
  OWNER TO f1;

CREATE UNIQUE INDEX fact_grand_prix_results_gp_results_uk
  ON analytic.fact_grand_prix_results (driver_id, season_id, grand_prix_id);

CREATE INDEX fact_grand_prix_results_gp_results_tyres_fk
  ON analytic.fact_grand_prix_results (tyres_id);

CREATE INDEX fact_grand_prix_results_gp_results_chassis_fk
  ON analytic.fact_grand_prix_results (chassis_id);

CREATE INDEX fact_grand_prix_results_gp_results_day_fk
  ON analytic.fact_grand_prix_results (race_day_id);

CREATE INDEX fact_grand_prix_results_gp_results_engine_fk
  ON analytic.fact_grand_prix_results (engine_id);

CREATE INDEX fact_grand_prix_results_gp_results_grand_prix_fk
  ON analytic.fact_grand_prix_results (grand_prix_id);

CREATE INDEX fact_grand_prix_results_gp_results_position_attributes_fk
  ON analytic.fact_grand_prix_results (position_attributes_id);

CREATE INDEX fact_grand_prix_results_gp_results_race_attributes_fk
  ON analytic.fact_grand_prix_results (race_attributes_id);

CREATE INDEX fact_grand_prix_results_gp_results_season_fk
  ON analytic.fact_grand_prix_results (season_id);

CREATE INDEX fact_grand_prix_results_gp_results_track_fk
  ON analytic.fact_grand_prix_results (track_id);

CREATE INDEX fact_grand_prix_results_gp_results_team_fk
  ON analytic.fact_grand_prix_results (team_id);

CREATE INDEX fact_grand_prix_results_gp_results_constructor_fk
  ON analytic.fact_grand_prix_results (constructor_id);

CREATE INDEX fact_grand_prix_results_gp_results_driver_fk
  ON analytic.fact_grand_prix_results (driver_id);

CREATE INDEX fact_grand_prix_results_gp_results_lubricant_fk
  ON analytic.fact_grand_prix_results (lubricant_id);

