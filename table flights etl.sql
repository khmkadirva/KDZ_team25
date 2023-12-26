CREATE TABLE if not EXISTS kdz_25_etl.flights AS
SELECT DISTINCT
    year,
    quarter,
    month,
    (to_timestamp(flight_date, 'MM.DD.YYYY HH24:MI'))::date as flight_date,
    reporting_airline,
    tail_number,
    flight_number,
    origin,
    dest,
    dep_delay_minutes,
    cancelled,
    cancellation_code,  
    (TO_CHAR(to_timestamp(Lpad(dep_time,4,'0'), 'HH24MI'), 'HH24:MI'))::time AS dep_time,
    air_time,  
    (TO_CHAR(to_timestamp(Lpad(crs_dep_time,4,'0'), 'HH24MI'), 'HH24:MI'))::time AS crs_dep_time,
    distance,
    weather_delay
    from kdz_25_src.flights;
