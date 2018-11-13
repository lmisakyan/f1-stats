SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `stats` DEFAULT CHARACTER SET utf8 ;
USE `stats` ;

-- -----------------------------------------------------
-- Table `stats`.`dim_chassis`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_chassis` (
  `CHASSIS_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'CHASSIS_ID - шасси, на котором выступает гонщик' ,
  `CODE` VARCHAR(32) NOT NULL COMMENT 'CODE - кодовое обозначение' ,
  `CONSTRUCTOR` VARCHAR(256) NULL DEFAULT NULL COMMENT 'CONSTRUCTOR - команда (как правило) или организация разработчик шасси' ,
  `DEVELOP_DATE` DATE NULL DEFAULT NULL COMMENT 'DEVELOP_DATE - дата (год) разработки' ,
  `INFO` VARCHAR(256) NULL DEFAULT NULL COMMENT 'INFO - дополнительная информация' ,
  PRIMARY KEY (`CHASSIS_ID`) ,
  UNIQUE INDEX `CHASSIS_CODE_UK` (`CODE` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'CHASSIS - шасси гоночного автомобиля';


-- -----------------------------------------------------
-- Table `stats`.`dim_country`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_country` (
  `COUNTRY_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'COUNTRY_ID - страна, на территории которой расположена трасса' ,
  `SCD_START` DATETIME NOT NULL COMMENT 'SCD_START' ,
  `SCD_END` DATETIME NOT NULL COMMENT 'SCD_END' ,
  `SCD_ACTIVE` DECIMAL(10,0) NOT NULL DEFAULT '1' COMMENT 'SCD_ACTIVE' ,
  `SCD_VERSION` SMALLINT(6) NOT NULL COMMENT 'SCD_VERSION' ,
  `NUMERIC_CODE` VARCHAR(3) NOT NULL COMMENT 'NUMERIC_CODE - код страны (3-х значный код по стандарту ISO 3166). Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.' ,
  `ALPHA_CODE` VARCHAR(3) NULL DEFAULT NULL COMMENT 'ALPHA_CODE - код страны (3-x буквенный код по стандарту ISO 3166). Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.' ,
  `COUNTRY_NAME` VARCHAR(256) NULL DEFAULT NULL COMMENT 'COUNTRY_NAME - название страны. Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.' ,
  `SHORT_NAME` VARCHAR(256) NULL DEFAULT NULL COMMENT 'SHORT_NAME - короткое название страны. Источник: http://base.consultant.ru/cons/cgi/online.cgi?req=doc;base=LAW;n=94405;fld=134;dst=4294967295.' ,
  `UN_REGION_NAME` VARCHAR(256) NULL DEFAULT NULL COMMENT 'REGION_NAME - регион в котором расположена страна (классификатор M49 ООН). Источник: http://unstats.un.org/unsd/methods/m49/m49regin.htm.' ,
  `UN_CONTINENT_NAME` VARCHAR(256) NULL DEFAULT NULL COMMENT 'CONTINENT_NAME - континент на котором расположена страна (классификатор M49 ООН). Источник: http://unstats.un.org/unsd/methods/m49/m49regin.htm.' ,
  PRIMARY KEY (`COUNTRY_ID`) ,
  UNIQUE INDEX `COUNTRY_CODE_UK` (`NUMERIC_CODE` ASC, `SCD_VERSION` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'COUNTRY - страна';


-- -----------------------------------------------------
-- Table `stats`.`dim_day`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_day` (
  `DAY_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'DAY_ID - суррогатный ключ' ,
  `DAY_DATE` DATE NOT NULL COMMENT 'DAY_DATE - календарная дата' ,
  `DAY_OF_WEEK_NAME` VARCHAR(16) NOT NULL COMMENT 'DAY_OF_WEEK_NAME - день недели' ,
  `LAST_DAY_IN_WEEK_INDICATOR` VARCHAR(3) NOT NULL COMMENT 'LAST_DAY_IN_WEEK_INDICATOR - признак последнего дня в неделе' ,
  `LAST_DAY_IN_MONTH_INDICATOR` VARCHAR(3) NOT NULL COMMENT 'LAST_DAY_IN_MONTH_INDICATOR - признак последнего дня в месяце' ,
  `LAST_DAY_IN_QUARTER_INDICATOR` VARCHAR(3) NOT NULL COMMENT 'LAST_DAY_IN_QUARTER_INDICATOR - признак последнего дня в квартале' ,
  `LAST_DAY_IN_YEAR_INDICATOR` VARCHAR(3) NOT NULL COMMENT 'LAST_DAY_IN_YEAR_INDICATOR - признак последнего дня в году' ,
  `DAY_IN_MONTH_NUMBER` TINYINT(2) UNSIGNED NOT NULL COMMENT 'DAY_IN_MONTH_NUMBER - день в месяце' ,
  `DAY_IN_YEAR_NUMBER` SMALLINT(3) UNSIGNED NOT NULL COMMENT 'DAY_IN_YEAR_NUMBER - день в году' ,
  `WEEK_IN_MONTH_NUMBER` TINYINT(1) UNSIGNED NULL COMMENT 'WEEK_IN_MONTH_NUMBER - неделя в месяце' ,
  `WEEK_IN_YEAR_NUMBER` TINYINT(2) UNSIGNED NULL COMMENT 'WEEK_IN_YEAR_NUMBER - неделя в году' ,
  `MONTH_IN_QUARTER_NUMBER` TINYINT(1) UNSIGNED NOT NULL COMMENT 'MONTH_IN_QUARTER_NUMBER - месяц в квартале' ,
  `MONTH_NAME` VARCHAR(16) NOT NULL COMMENT 'MONTH_NAME - месяц' ,
  `QUARTER_IN_YEAR_NUMBER` TINYINT(1) UNSIGNED NOT NULL COMMENT 'QUARTER_IN_YEAR_NUMBER - квартал в году' ,
  `HALF_IN_YEAR_NUMBER` TINYINT(1) UNSIGNED NULL COMMENT 'HALF_IN_YEAR_NUMBER - половина года' ,
  `YEAR_MONTH_NAME` VARCHAR(16) NOT NULL COMMENT 'YEAR_MONTH_NAME - год и месяц в формате \'YYYY-MM\'' ,
  `YEAR_QUARTER_NAME` VARCHAR(16) NOT NULL COMMENT 'YEAR_QUARTER_NAME - год и квартал в формате \'YYYY-Q\'' ,
  `YEAR_HALF_NAME` VARCHAR(16) NOT NULL COMMENT 'YEAR_AND_HALF - год и половина года в формате \'YYYY-H\'' ,
  `SEASON_NAME` VARCHAR(16) NOT NULL COMMENT 'SEASON_NAME - время года' ,
  `WEEKEND_INDICATOR` VARCHAR(16) NOT NULL COMMENT 'WEEKEND_INDICATOR - признак выходного дня' ,
  `MONTH_IN_YEAR_NUMBER` TINYINT(2) UNSIGNED NOT NULL ,
  `YEAR_NUMBER` SMALLINT(4) UNSIGNED NOT NULL ,
  `QUARTER_NAME` VARCHAR(16) NOT NULL ,
  `ISO_YEAR_NUMBER` SMALLINT(4) UNSIGNED NOT NULL ,
  `ISO_WEEK_IN_YEAR_NUMBER` TINYINT(2) UNSIGNED NOT NULL ,
  `ISO_YEAR_WEEK_NAME` VARCHAR(45) NOT NULL ,
  `YEAR_DAY_NAME` VARCHAR(45) NOT NULL ,
  `DAY_IN_WEEK_NUMBER` TINYINT(1) UNSIGNED NOT NULL ,
  PRIMARY KEY (`DAY_ID`) ,
  UNIQUE INDEX `DAY_DATE_UK` (`DAY_DATE` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'DAY - день';


-- -----------------------------------------------------
-- Table `stats`.`dim_driver`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_driver` (
  `DRIVER_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'DRIVER_ID - гонщик' ,
  `NAME` VARCHAR(64) NOT NULL COMMENT 'NAME - наименование' ,
  `FULL_NAME` VARCHAR(256) NOT NULL COMMENT 'FULL_NAME - Полное официальное наименование команды' ,
  `BIRTHDAY_PLACE` VARCHAR(256) NOT NULL COMMENT 'BIRTHDAY_PLACE - место рождения' ,
  `INFO` TEXT NULL DEFAULT NULL COMMENT 'INFO - дополнительная информация' ,
  `DEATH_PLACE` VARCHAR(256) NULL DEFAULT NULL COMMENT 'DEATH_PLACE - место смерти' ,
  `BIRTHDAY_ID` INT(11) UNSIGNED NOT NULL COMMENT 'BIRTHDAY_ID - дата рождения' ,
  `COUNTRY_ID` INT(11) UNSIGNED NOT NULL COMMENT 'COUNTRY_ID - страна, на территории которой расположена трасса' ,
  `DEATH_DAY_ID` INT(11) UNSIGNED NULL DEFAULT NULL COMMENT 'DEATH_DAY_ID - дата смерти (гибели)' ,
  `PHOTO` BLOB NULL DEFAULT NULL COMMENT 'PHOTO - фотография пилота' ,
  PRIMARY KEY (`DRIVER_ID`) ,
  UNIQUE INDEX `DRIVER_NAME_UK` (`NAME` ASC) ,
  CONSTRAINT `DRIVER_DEATH_DAY_FK`
    FOREIGN KEY (`DEATH_DAY_ID` )
    REFERENCES `stats`.`dim_day` (`DAY_ID` ),
  CONSTRAINT `DRIVER_BIRTHDAY_FK`
    FOREIGN KEY (`BIRTHDAY_ID` )
    REFERENCES `stats`.`dim_day` (`DAY_ID` ),
  CONSTRAINT `DRIVER_COUNTRY_FK`
    FOREIGN KEY (`COUNTRY_ID` )
    REFERENCES `stats`.`dim_country` (`COUNTRY_ID` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'DRIVER - гонщик (пилот)';


-- -----------------------------------------------------
-- Table `stats`.`dim_engine`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_engine` (
  `ENGINE_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ENGINE_ID - двигатель гоночного автомобиля' ,
  `CODE` VARCHAR(32) NOT NULL COMMENT 'CODE - кодовое обозначение' ,
  `MANUFACTURER` VARCHAR(256) NOT NULL COMMENT 'MANUFACTURER - фирма изготовитель шин' ,
  `DEVELOP_DATE` DATE NOT NULL COMMENT 'DEVELOP_DATE - дата (год) разработки' ,
  `DISPLACEMENT` DECIMAL(10,0) NOT NULL COMMENT 'DISPLACEMENT - объем двигателя' ,
  `CILINDER_FORMAT` VARCHAR(32) NOT NULL COMMENT 'FORMAT - формат двигателя (число и расположение цилиндров)' ,
  `CHARGE_INDICATOR` VARCHAR(3) NOT NULL COMMENT 'CHARGE_INDICATOR - признак наддувного двигателя' ,
  `INFO` VARCHAR(256) NULL DEFAULT NULL COMMENT 'INFO - дополнительная информация' ,
  PRIMARY KEY (`ENGINE_ID`) ,
  UNIQUE INDEX `ENGINE_CODE_UK` (`CODE` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'ENGINE - двигатель гоночного автомобиля';


-- -----------------------------------------------------
-- Table `stats`.`dim_grand_prix`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_grand_prix` (
  `GRAND_PRIX_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'GRAND_PRIX_ID - гран при' ,
  `CODE` VARCHAR(32) NOT NULL COMMENT 'CODE - кодовое обозначение' ,
  `NAME` VARCHAR(256) NOT NULL COMMENT 'NAME - наименование' ,
  `OFFICIAL_NAME` VARCHAR(256) NOT NULL COMMENT 'OFFICIAL_NAME - официальное наименование гран при' ,
  `YEAR_START` SMALLINT(6) NOT NULL COMMENT 'YEAR_START - с какого года (сезона) трасса в данной конфигурации' ,
  `YEAR_END` SMALLINT(6) NOT NULL COMMENT 'YEAR_END - по какой год(сезон) трасса в данной конфигурации' ,
  `TITLE_SPONSOR` VARCHAR(256) NULL DEFAULT NULL COMMENT 'TITLE_SPONSOR - титульный спонсор команды' ,
  PRIMARY KEY (`GRAND_PRIX_ID`) ,
  UNIQUE INDEX `GRAND_PRIX_CODE_PK` (`CODE` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'GRAND_PRIX - гран при (гоночный уикенд)';


-- -----------------------------------------------------
-- Table `stats`.`dim_position_attributes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_position_attributes` (
  `POSITION_ATTRIBUTES_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'POSITION_ATTRIBUTES_ID - суррогатный ключ' ,
  `RESULT` VARCHAR(32) NULL COMMENT 'RESULT - результат гонки' ,
  `POSITION` SMALLINT(6) NULL DEFAULT NULL COMMENT 'POSITION - позиция классифицированного пилота на финише' ,
  `POINTS` SMALLINT(6) NULL DEFAULT NULL COMMENT 'POINTS - количество начисленных очков' ,
  `YEAR_START` SMALLINT(6) NOT NULL COMMENT 'YEAR_START - с какого года (сезона) трасса в данной конфигурации' ,
  `YEAR_END` SMALLINT(6) NOT NULL COMMENT 'YEAR_END - по какой год(сезон) трасса в данной конфигурации' ,
  PRIMARY KEY (`POSITION_ATTRIBUTES_ID`) ,
  UNIQUE INDEX `POSITION_ATTRIBUTES_UK` (`RESULT` ASC, `YEAR_START` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'POSITION_ATTRIBUTES - атрибуты, связанные с позицией пилота  /* comment truncated */ /*на финише гонки*/';


-- -----------------------------------------------------
-- Table `stats`.`dim_race_attributes`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_race_attributes` (
  `RACE_ATTRIBUTES_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'RACE_ATTRIBUTES_ID - суррогатный ключ' ,
  `GRID_PENALTY_REASON` VARCHAR(32) NOT NULL COMMENT 'GRID_PENALTY - причина потери мест на старте' ,
  `RACE_PENALTY_REASON` VARCHAR(32) NOT NULL COMMENT 'RACE_PENALTY_REASON - причина потери мест на финише' ,
  `RETIRE_REASON` VARCHAR(32) NOT NULL COMMENT 'RETIRE_REASON - причина схода' ,
  PRIMARY KEY (`RACE_ATTRIBUTES_ID`) ,
  UNIQUE INDEX `RACE_ATTRIBUTES_UK` (`GRID_PENALTY_REASON` ASC, `RACE_PENALTY_REASON` ASC, `RETIRE_REASON` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'RACE_ATTRIBUTES - различные дополнительные гоночные характер /* comment truncated */ /*истики*/';


-- -----------------------------------------------------
-- Table `stats`.`dim_season`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_season` (
  `SEASON_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'SEASON_ID - суррогатный ключ' ,
  `YEAR_NUMBER` SMALLINT(6) NOT NULL COMMENT 'YEAR_NUMBER - номер года' ,
  `LEAP_YEAR_INDICATOR` VARCHAR(3) NOT NULL COMMENT 'LEAP_YEAR_INDICATOR - признак високосного года' ,
  `DECADE` VARCHAR(256) NOT NULL COMMENT 'DECADE - десятилетие' ,
  `CENTURY` SMALLINT(6) NOT NULL COMMENT 'CENTURY - век' ,
  `ERA` VARCHAR(256) NULL DEFAULT NULL COMMENT 'ERA - так называемая эра (эпоха) в гонках. Определяется доминирующей технологией' ,
  PRIMARY KEY (`SEASON_ID`) ,
  UNIQUE INDEX `SEASON_YEAR_UK` (`YEAR_NUMBER` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'SEASON - сезон (год) чемпионата';


-- -----------------------------------------------------
-- Table `stats`.`dim_team`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_team` (
  `TEAM_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'TEAM_ID - суррогатный ключ' ,
  `NAME` VARCHAR(64) NOT NULL COMMENT 'NAME - наименование' ,
  `FULL_NAME` VARCHAR(256) NOT NULL COMMENT 'FULL_NAME - Полное официальное наименование команды' ,
  `YEAR_START` SMALLINT(6) NOT NULL COMMENT 'YEAR_START - с какого года (сезона) трасса в данной конфигурации' ,
  `YEAR_END` SMALLINT(6) NOT NULL COMMENT 'YEAR_END - по какой год(сезон) трасса в данной конфигурации' ,
  `INFO` VARCHAR(256) NULL DEFAULT NULL COMMENT 'INFO - дополнительная информация' ,
  `TITLE_SPONSOR` VARCHAR(256) NULL DEFAULT NULL COMMENT 'TITLE_SPONSOR - титульный спонсор команды' ,
  `COUNTRY_ID` INT(11) UNSIGNED NOT NULL COMMENT 'COUNTRY_ID - страна, на территории которой расположена трасса' ,
  PRIMARY KEY (`TEAM_ID`) ,
  UNIQUE INDEX `TEAM_NAME_UK` (`NAME` ASC) ,
  CONSTRAINT `TEAM_COUNTRY_FK`
    FOREIGN KEY (`COUNTRY_ID` )
    REFERENCES `stats`.`dim_country` (`COUNTRY_ID` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'TEAM - команда';


-- -----------------------------------------------------
-- Table `stats`.`dim_track`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_track` (
  `TRACK_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'TRACK_ID - суррогатный ключ' ,
  `NAME` VARCHAR(64) NOT NULL COMMENT 'NAME - наименование' ,
  `YEAR_START` SMALLINT(6) NOT NULL COMMENT 'YEAR_START - с какого года (сезона) трасса в данной конфигурации' ,
  `YEAR_END` SMALLINT(6) NOT NULL COMMENT 'YEAR_END - по какой год(сезон) трасса в данной конфигурации' ,
  `TURNS` SMALLINT(6) NOT NULL COMMENT 'TURNS - количество поворотов' ,
  `LENGTH` DECIMAL(10,0) NOT NULL COMMENT 'LENGTH - длина трассы в конфигурации гран при' ,
  `COUNTRY_ID` INT(11) UNSIGNED NOT NULL COMMENT 'COUNTRY_ID - страна, на территории которой расположена трасса' ,
  `CITY` VARCHAR(256) NOT NULL COMMENT 'CITY - город, в котором находится трасса' ,
  `REGION` VARCHAR(256) NULL DEFAULT NULL COMMENT 'REGION - регион в котором находится трасса ' ,
  `INFO` VARCHAR(4000) NULL DEFAULT NULL COMMENT 'INFO - дополнительная информация' ,
  `TRACK_SCHEMA` BLOB NULL DEFAULT NULL COMMENT 'SCHEMA - схема трассы' ,
  PRIMARY KEY (`TRACK_ID`) ,
  UNIQUE INDEX `TRACK_NAME_UK` (`NAME` ASC, `YEAR_START` ASC) ,
  CONSTRAINT `TRACK_COUNTRY_FK`
    FOREIGN KEY (`COUNTRY_ID` )
    REFERENCES `stats`.`dim_country` (`COUNTRY_ID` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'TRACK - трасса';


-- -----------------------------------------------------
-- Table `stats`.`dim_tyres`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`dim_tyres` (
  `TYRES_ID` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'TYRES_ID - суррогатный ключ' ,
  `CODE` VARCHAR(32) NOT NULL COMMENT 'CODE - кодовое обозначение' ,
  `INFO` VARCHAR(256) NULL DEFAULT NULL COMMENT 'INFO - дополнительная информация' ,
  `MANUFACTURER` VARCHAR(256) NOT NULL COMMENT 'MANUFACTURER - фирма изготовитель шин' ,
  `TREAD` VARCHAR(32) NOT NULL COMMENT 'TREAD - тип протектора' ,
  PRIMARY KEY (`TYRES_ID`) ,
  UNIQUE INDEX `TYRES_CODE_UK` (`CODE` ASC) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'TYRES - шины, устанавливаемые на гоночный автомобиль';


-- -----------------------------------------------------
-- Table `stats`.`fact_grand_prix_results`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `stats`.`fact_grand_prix_results` (
  `DRIVER_NUMBER` SMALLINT(6) UNSIGNED NOT NULL COMMENT 'DRIVER_NUMBER - номер гонщика в чемпионате' ,
  `START_POSITION` TINYINT(2) UNSIGNED NULL COMMENT 'START_POSITION - стартовая позиция гонщика' ,
  `QUALIFYING_POSITION` TINYINT(2) UNSIGNED NULL COMMENT 'QUALIFYING_POSITION - позиция гонщика, показанная в квалификации' ,
  `FINISH_TIME` TIMESTAMP NULL COMMENT 'FINISH_TIME - время на финише' ,
  `AVERAGE_SPEED` DECIMAL(10,0) NULL COMMENT 'AVERAGE_SPEED - средняя скорость' ,
  `FASTEST_LAP_TIME` TIMESTAMP NULL COMMENT 'FASTEST_LAP_TIME - время бысрейшего круга в гонке' ,
  `LAPS_IN_RACE` TINYINT(2) NULL COMMENT 'LAPS_IN_RACE - запланированное количество кругов в гонке' ,
  `LAPS_PASSED` TINYINT(2) NULL COMMENT 'LAPS_PASSED - количество пройденных пилотом кругов' ,
  `HALF_POINTS_INDICATOR` TINYINT(1) NOT NULL COMMENT 'HALF_POINTS_INDICATOR - признак того, что за гонку начислили половину очков' ,
  `RACE_DAY_ID` INT(11) UNSIGNED NOT NULL COMMENT 'RACE_DAY_ID - дата гонки' ,
  `DRIVER_ID` INT(11) UNSIGNED NOT NULL COMMENT 'DRIVER_ID - гонщик' ,
  `TEAM_ID` INT(11) UNSIGNED NOT NULL COMMENT 'TEAM_ID - команда, за которую выступает гонщик' ,
  `TRACK_ID` INT(11) UNSIGNED NOT NULL COMMENT 'TRACK_ID - суррогатный ключ' ,
  `CHASSIS_ID` INT(11) UNSIGNED NOT NULL COMMENT 'CHASSIS_ID - шасси, на котором выступает гонщик' ,
  `ENGINE_ID` INT(11) UNSIGNED NOT NULL COMMENT 'ENGINE_ID - двигатель гоночного автомобиля' ,
  `SEASON_ID` INT(11) UNSIGNED NOT NULL COMMENT 'SEASON_ID - суррогатный ключ' ,
  `GRAND_PRIX_ID` INT(11) UNSIGNED NOT NULL COMMENT 'GRAND_PRIX_ID - гран при' ,
  `RACE_ATTRIBUTES_ID` INT(11) UNSIGNED NOT NULL COMMENT 'RACE_ATTRIBUTES_ID - суррогатный ключ' ,
  `TYRES_ID` INT(11) UNSIGNED NOT NULL COMMENT 'TYRES_ID - суррогатный ключ' ,
  `POSITION_ATTRIBUTES_ID` INT(11) UNSIGNED NOT NULL COMMENT 'POSITION_ATTRIBUTES_ID - суррогатный ключ' ,
  CONSTRAINT `GP_RESULTS_TYRES_FK`
    FOREIGN KEY (`TYRES_ID` )
    REFERENCES `stats`.`dim_tyres` (`TYRES_ID` ),
  CONSTRAINT `GP_RESULTS_CHASSIS_FK`
    FOREIGN KEY (`CHASSIS_ID` )
    REFERENCES `stats`.`dim_chassis` (`CHASSIS_ID` ),
  CONSTRAINT `GP_RESULTS_DAY_FK`
    FOREIGN KEY (`RACE_DAY_ID` )
    REFERENCES `stats`.`dim_day` (`DAY_ID` ),
  CONSTRAINT `GP_RESULTS_DRIVER_FK`
    FOREIGN KEY (`DRIVER_ID` )
    REFERENCES `stats`.`dim_driver` (`DRIVER_ID` ),
  CONSTRAINT `GP_RESULTS_ENGINE_FK`
    FOREIGN KEY (`ENGINE_ID` )
    REFERENCES `stats`.`dim_engine` (`ENGINE_ID` ),
  CONSTRAINT `GP_RESULTS_GRAND_PRIX_FK`
    FOREIGN KEY (`GRAND_PRIX_ID` )
    REFERENCES `stats`.`dim_grand_prix` (`GRAND_PRIX_ID` ),
  CONSTRAINT `GP_RESULTS_POSITION_ATTRIBUTES_FK`
    FOREIGN KEY (`POSITION_ATTRIBUTES_ID` )
    REFERENCES `stats`.`dim_position_attributes` (`POSITION_ATTRIBUTES_ID` ),
  CONSTRAINT `GP_RESULTS_RACE_ATTRIBUTES_FK`
    FOREIGN KEY (`RACE_ATTRIBUTES_ID` )
    REFERENCES `stats`.`dim_race_attributes` (`RACE_ATTRIBUTES_ID` ),
  CONSTRAINT `GP_RESULTS_SEASON_FK`
    FOREIGN KEY (`SEASON_ID` )
    REFERENCES `stats`.`dim_season` (`SEASON_ID` ),
  CONSTRAINT `GP_RESULTS_TEAM_FK`
    FOREIGN KEY (`TEAM_ID` )
    REFERENCES `stats`.`dim_team` (`TEAM_ID` ),
  CONSTRAINT `GP_RESULTS_TRACK_FK`
    FOREIGN KEY (`TRACK_ID` )
    REFERENCES `stats`.`dim_track` (`TRACK_ID` ))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'GRAND_PRIX_RESULTS - результаты гран при с детализацией до г /* comment truncated */ /*онщика*/';

USE `stats` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
