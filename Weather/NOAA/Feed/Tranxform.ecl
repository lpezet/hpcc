IMPORT Weather.NOAA.Feed.Datasets;
IMPORT Weather.NOAA.Feed.Layouts;

EXPORT Tranxform := MODULE

	EXPORT stations := MODULE
		SHARED Final_1 := Datasets.dsRawStations;
		SHARED Final_2 := TABLE(Final_1, { DECIMAL9_6 latitude := (DECIMAL9_6) latitude; DECIMAL9_6 longitude := (DECIMAL9_6) longitude; DECIMAL4_1 elevation := (DECIMAL4_1) elevation; Final_1; });
		SHARED Final_3 := PROJECT(Final_2, Layouts.station_layout);
		SHARED Final_4 := SORT(Final_3, id);
		SHARED Final_5 := DEDUP(Final_4, id);
		SHARED Final_6 := DISTRIBUTE(Final_5, HASH(id));
		EXPORT doIt() := OUTPUT(Final_6,, Datasets.File_Stations, OVERWRITE);
	END;
	
	EXPORT stations_inventory := MODULE
		SHARED Final_1 := Datasets.dsRawStationsInventory;
		SHARED Final_2 := TABLE(Final_1, { DECIMAL9_6 latitude := (DECIMAL9_6) latitude; DECIMAL9_6 longitude := (DECIMAL9_6) longitude; INTEGER2 first_year := (INTEGER2) first_year; INTEGER2 last_year := (INTEGER2) last_year; Final_1; });
		SHARED Final_3 := PROJECT(Final_2, Layouts.station_inventory_layout);
		SHARED Final_4 := SORT(Final_3, id);
		SHARED Final_5 := DEDUP(Final_4, id);
		SHARED Final_6 := DISTRIBUTE(Final_5, HASH(id));
		EXPORT doIt() := OUTPUT(Final_6,, Datasets.File_Stations_Inventory, OVERWRITE);
	END;

	EXPORT daily := MODULE
		SHARED Final_1 := Datasets.dsRawDaily;
		SHARED Final_2 := TABLE(Final_1, { INTEGER2 year := (INTEGER2) year; INTEGER1 month := (INTEGER1) month; Final_1 });
		SHARED Final_3 := PROJECT(Final_2, Layouts.daily_layout);
		SHARED Final_4 := SORT(Final_3, id, year, month, element);
		SHARED Final_5 := DEDUP(Final_4, id, year, month, element);
		SHARED Final_6 := DISTRIBUTE(Final_5, HASH(id));
		EXPORT doIt() := OUTPUT(Final_6,, Datasets.File_Daily, OVERWRITE);
	END;

END;
