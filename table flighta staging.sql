CREATE TABLE kdz_25_staging.flights (
    year int NOT NULL,
    quarter int NULL,
    month int NOT NULL,
    flight_date date NOT NULL,
    dep_time time NULL,
    crs_dep_time time NOT NULL,
    air_time float NULL,
    dep_delay_minutes float NULL,
    cancelled int NOT NULL,
    cancellation_code char(1) NULL,
    weather_delay float NULL,
    reporting_airline varchar(10) NULL,
    tail_number varchar(10) NULL,
    flight_number varchar(15) NOT NULL,
    distance float NULL,
    origin varchar(10) NULL,
    dest varchar(10) NULL,
    loaded_ts timestamp default(now()),
    CONSTRAINT flights_pkey PRIMARY KEY (flight_date, flight_number, origin, dest, crs_dep_time)
);