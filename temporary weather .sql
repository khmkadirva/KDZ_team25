create or replace temp view data_weather_dds as
select
	airport.airport_dk,
	concat(prepared_data.cold, prepared_data.rain, prepared_data.snow, prepared_data.thunderstorm, prepared_data.drizzle, prepared_data.fog_mist) as weather_type_dk,
	prepared_data.cold,
	prepared_data.rain,
	prepared_data.snow,
	prepared_data.thunderstorm,
	prepared_data.drizzle,
	prepared_data.fog_mist,
	weather.t_air_temperature as t,
	weather.ff10_max_gust_value as max_gws,
	weather.ff_wind_speed as w_speed,
	weather.local_datetime::timestamp as date_start,
	COALESCE((lead(weather.local_datetime) over (order by weather.local_datetime))::timestamp,weather.local_datetime::timestamp+interval '1 hour') as date_end,
	now() as loaded_ts
from kdz_25_staging.weather weather
inner join dds.airport airport on weather.icao_code = airport.icao_code
inner join (SELECT
icao_code,
local_datetime,
COALESCE((position('rain' in ww_present) != 0 OR position('rain' in ww_recent) != 0)::int, 0) AS rain,
COALESCE((position('snow' in ww_present) != 0 OR position('snow' in ww_recent) != 0)::int, 0) AS snow,
COALESCE((position('thunderstorm' in ww_present) != 0 OR position('thunderstorm' in ww_recent) != 0)::int, 0) AS thunderstorm,
COALESCE((position('fog' in ww_present) != 0 OR position('fog' in ww_recent) != 0 OR position('mist' in ww_present) != 0 OR position('mist' in ww_recent) != 0)::int, 0) AS fog_mist,
COALESCE((position('drizzle' in ww_present) != 0 OR position('drizzle' in ww_recent) != 0)::int, 0) AS drizzle,
COALESCE((t_air_temperature < 0)::int, 0) AS cold
FROM kdz_25_staging.weather) as prepared_data on weather.icao_code = prepared_data.icao_code and weather.local_datetime = prepared_data.local_datetime
