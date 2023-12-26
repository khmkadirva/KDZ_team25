create or replace temp view data_flights_dds as
(select flights."year",
flights.quarter ,
flights."month" ,
time_data.flight_scheduled_date,
time_data.flight_actual_date,
time_data.flight_dep_scheduled as flight_dep_scheduled_ts,
time_data.flight_dep_actual as flight_dep_actual_ts,
flights.reporting_airline ,
coalesce (flights.tail_number,'') as tail_number,
flights.flight_number,
(select airport_dk from dds.airport airport where airport.iata_code = flights.origin) as airport_origin_dk,
flights.origin as origin_code,
(select airport_dk from dds.airport airport where airport.iata_code = flights.dest) as airport_dest_dk,
flights.dest as dest_code,
flights.dep_delay_minutes ,
flights.cancelled,
flights.cancellation_code ,
flights.weather_delay,
flights.air_time,
flights.distance ,
flights.loaded_ts
from kdz_25_staging.flights flights
inner join (select flight_date, flight_number, crs_dep_time, origin, dest, tail_number,
		concat(flight_date,' ',crs_dep_time)::timestamp as flight_dep_scheduled,
		concat(flight_date,' ',crs_dep_time)::date as flight_scheduled_date,
		concat(flight_date,' ',crs_dep_time)::timestamp + interval '1 minute'*dep_delay_minutes as flight_dep_actual,
		(concat(flight_date,' ',crs_dep_time)::timestamp + interval '1 minute'*dep_delay_minutes)::date as flight_actual_date
		from kdz_25_staging.flights) as time_data on flights.flight_date = time_data.flight_date and flights.flight_number = time_data.flight_number and flights.crs_dep_time = time_data.crs_dep_time and flights.origin = time_data.origin and flights.dest = time_data.dest and flights.tail_number=time_data.tail_number
)
