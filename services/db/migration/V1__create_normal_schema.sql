CREATE SCHEMA if NOT EXISTS normal;

ALTER SCHEMA normal owner TO f1;

CREATE TABLE normal.circuits (
	id BIGINT PRIMARY KEY NOT NULL,
	circuit_ref VARCHAR NOT NULL,
	name VARCHAR NOT NULL,
	location VARCHAR NOT NULL,
	country VARCHAR NOT NULL,
	lat DECIMAL NOT NULL,
	lng DECIMAL NOT NULL,
	alt INTEGER,
	url VARCHAR NOT NULL
);
CREATE TABLE normal.constructor_results (
	id BIGINT PRIMARY KEY NOT NULL,
	race_id BIGINT NOT NULL,
	constructor_id BIGINT NOT NULL,
	points DECIMAL NOT NULL,
	status VARCHAR
);
CREATE TABLE normal.constructor_standings (
	 id BIGINT PRIMARY KEY NOT NULL,
	race_id BIGINT NOT NULL,
	constructor_id BIGINT NOT NULL,
	points DECIMAL NOT NULL,
	position DECIMAL NOT NULL,
	position_text VARCHAR NOT NULL,
	wins DECIMAL NOT NULL
);
CREATE TABLE normal.constructors (
	id BIGINT PRIMARY KEY NOT NULL,
	constructor_ref VARCHAR NOT NULL,
	name VARCHAR NOT NULL,
	nationality VARCHAR NOT NULL,
	url VARCHAR NOT NULL
);
CREATE TABLE normal.driver_standings (
	id BIGINT PRIMARY KEY NOT NULL,
	race_id BIGINT NOT NULL,
	driver_id BIGINT NOT NULL,
	points DECIMAL NOT NULL,
	position DECIMAL NOT NULL,
	position_text VARCHAR NOT NULL,
	wins DECIMAL NOT NULL
);
CREATE TABLE normal.drivers (
	id BIGINT PRIMARY KEY NOT NULL,
	driver_ref VARCHAR NOT NULL,
	number VARCHAR,
	code VARCHAR,
	forename VARCHAR NOT NULL,
	surname VARCHAR NOT NULL,
	dob VARCHAR NOT NULL,
	nationality VARCHAR NOT NULL,
	url VARCHAR
);
CREATE TABLE normal.drivers_standings (
	id BIGINT PRIMARY KEY NOT NULL,
	race_id BIGINT NOT NULL,
	driver_id BIGINT NOT NULL,
	points DECIMAL NOT NULL,
	position DECIMAL NOT NULL,
	position_text VARCHAR NOT NULL,
	wins DECIMAL NOT NULL
);
CREATE TABLE normal.lap_times (
	race_id BIGINT NOT NULL,
	driver_id BIGINT NOT NULL,
	lap DECIMAL NOT NULL,
	position DECIMAL NOT NULL,
	time INTERVAL NOT NULL,
	milliseconds DECIMAL NOT NULL
);
CREATE TABLE normal.pit_stops (
	race_id BIGINT NOT NULL,
	driver_id BIGINT NOT NULL,
	stop DECIMAL NOT NULL,
	lap DECIMAL NOT NULL,
	time INTERVAL NOT NULL,
	duration VARCHAR NOT NULL,
	milliseconds DECIMAL NOT NULL
);
CREATE TABLE normal.qualifying (
	id BIGINT PRIMARY KEY NOT NULL,
	race_id BIGINT NOT NULL,
	driver_id BIGINT NOT NULL,
	constructor_id BIGINT NOT NULL,
	number DECIMAL NOT NULL,
	position DECIMAL NOT NULL,
	q1 VARCHAR,
	q2 VARCHAR,
	q3 VARCHAR
);
CREATE TABLE normal.races (
	id BIGINT PRIMARY KEY NOT NULL,
	year DECIMAL NOT NULL,
	round DECIMAL NOT NULL,
	circuit_id BIGINT NOT NULL,
	name VARCHAR NOT NULL,
	date DATE NOT NULL,
	time TIME,
	url VARCHAR NOT NULL
);
CREATE TABLE normal.results (
	id BIGINT PRIMARY KEY NOT NULL,
	race_id BIGINT NOT NULL,
	driver_id BIGINT NOT NULL,
	constructor_id BIGINT NOT NULL,
	number INTEGER,
	grid INTEGER NOT NULL,
	position INTEGER,
	position_text VARCHAR NOT NULL,
	position_order INTEGER NOT NULL,
	points INTEGER NOT NULL,
	laps INTEGER NOT NULL,
	time VARCHAR,
	milliseconds VARCHAR,
	fastest_lap VARCHAR,
	rank VARCHAR,
	fastest_lap_time VARCHAR,
	fastest_lap_speed VARCHAR,
	status_id BIGINT NOT NULL
);
CREATE TABLE normal.seasons (
	year DECIMAL NOT NULL,
	url VARCHAR NOT NULL
);
CREATE TABLE normal.statuses (
	id BIGINT PRIMARY KEY NOT NULL,
	status VARCHAR NOT NULL
);
