insert into kdz_25_dds.airport_weather(airport_dk,weather_type_dk,cold,rain,snow,thunderstorm,drizzle,fog_mist,t,max_gws,w_speed,date_start,date_end,loaded_ts)
select * from data_weather_dds
on conflict do nothing
