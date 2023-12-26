create schema if not exists kdz_25_etl;




--код создания таблицы weather уровня etl
CREATE TABLE if not EXISTS kdz_25_etl.weather AS
SELECT DISTINCT
    icao_code,
    CAST(local_datetime AS TIMESTAMP) AS local_datetime,
    CAST(t_air_temperature AS INT) AS  t_air_temperature,
    p0_sea_lvl,
    p_station_lvl,
    u_humidity,
    dd_wind_direction,
    ff_wind_speed,
    ff10_max_gust_value,
    ww_present,
    ww_recent,
    c_total_clouds,
    CAST(vv_horizontal_visibility AS INT) AS  vv_horizontal_visibility,
    CAST(td_temperature_dewpoint AS INT) AS  td_temperature_dewpoint
    from kdz_25_src.weather
;
