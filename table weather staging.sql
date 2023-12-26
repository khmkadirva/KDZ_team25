create schema if not exists kdz_25_staging;


--код создания таблицы weather уровня staging
CREATE TABLE kdz_25_staging.weather (
    icao_code varchar(10) NOT NULL,
    local_datetime varchar(25) NOT NULL,
    t_air_temperature numeric(3, 1)  NULL,
    p0_sea_lvl numeric(4, 1)  NULL,
    p_station_lvl numeric(4, 1) NOT NULL,
    u_humidity int4  NULL,
    dd_wind_direction varchar(100) NULL,
    ff_wind_speed int4 NULL,
    ff10_max_gust_value int4 NULL,
    ww_present varchar(100) NULL,
    ww_recent varchar(50) NULL,
    c_total_clouds varchar(200) NULL,
    vv_horizontal_visibility numeric(3, 1) NULL,
    td_temperature_dewpoint numeric(3, 1)  NULL,
    loaded_ts timestamp NOT NULL DEFAULT now(),
    PRIMARY KEY (icao_code, local_datetime)
);
