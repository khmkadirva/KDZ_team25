insert into kdz_25_dds.flights("year",quarter,"month",flight_scheduled_date,flight_actual_date,flight_dep_scheduled_ts,flight_dep_actual_ts,report_airline,tail_number,flight_number_reporting_airline ,airport_origin_dk,origin_code,airport_dest_dk,dest_code,dep_delay_minutes,cancelled,cancellation_code,weather_delay,air_time,distance,loaded_ts)
select * from data_flights_dds
on conflict do nothing
