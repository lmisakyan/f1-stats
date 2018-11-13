
CREATE TABLE `stats`.`dim_constructor` (
  `CONSTRUCTOR_ID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Суррогатный ключ.',
  `NAME` varchar(64) NOT NULL COMMENT 'Наименование',
  `INFO` varchar(256) DEFAULT NULL COMMENT 'Дополнительная информация',
  PRIMARY KEY (`CONSTRUCTOR_ID`),
  UNIQUE KEY `CONSTRUCTOR_NAME_UK` (`NAME`)
) ENGINE=InnoDB AUTO_INCREMENT=176 DEFAULT CHARSET=utf8 COMMENT='Организация конструктор гоночного автомобиля (шасси)';

