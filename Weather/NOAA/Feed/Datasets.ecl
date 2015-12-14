// WEATHER
// Source: http://www1.ncdc.noaa.gov/pub/data/ghcn/daily/



IMPORT Weather.NOAA.Feed.Layouts;


EXPORT Datasets := MODULE

	EXPORT File_Single_Raw_Daily(STRING pId) := '~weather::raw::daily::' + pId;
	EXPORT File_Raw_Daily := '~weather::raw::daily';
	EXPORT File_Daily := '~weather::daily';
	EXPORT File_Raw_Stations := '~weather::raw::stations';
	EXPORT File_Stations := '~weather::stations';
	EXPORT File_Raw_Stations_Inventory := '~weather::raw::stations_inventory';
	EXPORT File_Stations_Inventory := '~weather::stations_inventory';
	EXPORT File_Raw_Countries := '~weather::raw::countries';
	EXPORT File_Countries := '~weather::countries';
	EXPORT File_Raw_States := '~weather::raw::states';
	EXPORT File_States := '~weather::states';
	
	
	EXPORT dsSingleRawDaily(STRING pId) := DATASET(File_Single_Raw_Daily(pId), Layouts.raw_daily_layout, THOR);
	EXPORT dsRawDaily := DATASET(File_Raw_Daily, Layouts.raw_daily_layout, THOR);
	EXPORT dsDaily := DATASET(File_Daily, Layouts.daily_layout, THOR);
	EXPORT dsRawStations := DATASET(File_Raw_Stations, Layouts.raw_station_layout, THOR);
	EXPORT dsStations := DATASET(File_Stations, Layouts.station_layout, THOR);
	EXPORT dsRawStationsInventory := DATASET(File_Raw_Stations_Inventory, Layouts.raw_station_inventory_layout, THOR);
	EXPORT dsStationsInventory := DATASET(File_Stations_Inventory, Layouts.station_inventory_layout, THOR);
	EXPORT dsRawCountries := DATASET(File_Raw_Countries, Layouts.raw_country_layout, THOR);
	EXPORT dsCountries := DATASET(File_Countries, Layouts.country_layout, THOR);
	EXPORT dsRawStates := DATASET(File_Raw_States, Layouts.raw_state_layout, THOR);
	EXPORT dsStates := DATASET(File_States, Layouts.state_layout, THOR);
	
END;