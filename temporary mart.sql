create or replace temp view data_mart_25 as (
select distinct on (flight_dep_scheduled_ts,flight_number, tail_number) airport_origin_dk,
airport_dest_dk as airport_destination_dk,
weather_type_dk,
flight_dep_scheduled_ts as flight_scheduled_ts,
flight_dep_actual_ts as flight_actual_time,
flight_number,
distance,
coalesce(tail_number,''),
reporting_airline as airline,
dep_delay_minutes as dep_delay_min,
cancelled,
cancellation_code,
t,
max_gws,
w_speed,
air_time,
25 as author,
now() as loaded_ts
from data_flights_dds flights
	inner join data_weather_dds as weather on flights.airport_origin_dk=weather.airport_dk and (flights.flight_dep_scheduled_ts::timestamp between weather.date_start::timestamp and weather.date_start::timestamp+ interval '1 minute'*59)
)
