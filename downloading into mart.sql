insert into mart.fact_departure(airport_origin_dk,airport_destination_dk,weather_type_dk,flight_scheduled_ts,flight_actual_time,flight_number,distance,tail_number,airline,dep_delay_min,cancelled,cancellation_code,t,max_gws,w_speed,air_time,author,loaded_ts)
select * from data_mart_25
on conflict do nothing
