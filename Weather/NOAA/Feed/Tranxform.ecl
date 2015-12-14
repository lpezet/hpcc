IMPORT Weather.NOAA.Feed.Datasets;
IMPORT Weather.NOAA.Feed.Layouts;

EXPORT Tranxform := MODULE

	EXPORT stations() := FUNCTION
		Final_1 := Datasets.dsRawStations;
		Final_2 := TABLE(Final_1, { DECIMAL9_6 latitude := (DECIMAL9_6) latitude; DECIMAL9_6 longitude := (DECIMAL9_6) longitude; DECIMAL4_1 elevation := (DECIMAL4_1) elevation; Final_1; });
		Final_3 := PROJECT(Final_2, Layouts.station_layout);
		Final_4 := SORT(Final_3, id);
		Final_5 := DEDUP(Final_4, id);
		Final_6 := DISTRIBUTE(Final_5, HASH(id));
		RETURN OUTPUT(Final_6,, Datasets.File_Stations, OVERWRITE);
	END;
	
	EXPORT countries() := FUNCTION
		Final_1 := Datasets.dsRawCountries;
		Final_2 := PROJECT(Final_1, TRANSFORM(Layouts.country_layout,
			SELF.code := TRIM(LEFT.code_and_name[1..2], LEFT, RIGHT);
			SELF.name := TRIM(LEFT.code_and_name[4..], LEFT, RIGHT);
		));
		Final_4 := SORT(Final_2, code);
		Final_5 := DEDUP(Final_4, code);
		Final_6 := DISTRIBUTE(Final_5, HASH(code));
		RETURN OUTPUT(Final_6,, Datasets.File_Countries, OVERWRITE);
	END;
	
	EXPORT states() := FUNCTION
		Final_1 := Datasets.dsRawStates;
		Final_2 := PROJECT(Final_1, TRANSFORM(Layouts.state_layout,
			SELF.code := TRIM(LEFT.code_and_name[1..2], LEFT, RIGHT);
			SELF.name := TRIM(LEFT.code_and_name[4..], LEFT, RIGHT);
		));
		
		Final_4 := SORT(Final_2, code);
		Final_5 := DEDUP(Final_4, code);
		Final_6 := DISTRIBUTE(Final_5, HASH(code));
		RETURN OUTPUT(Final_6,, Datasets.File_States, OVERWRITE);
	END;
	
	EXPORT stations_inventory() := FUNCTION
		Final_1 := Datasets.dsRawStationsInventory;
		Final_2 := TABLE(Final_1, { STRING element := TRIM(element, LEFT, RIGHT); DECIMAL9_6 latitude := (DECIMAL9_6) latitude; DECIMAL9_6 longitude := (DECIMAL9_6) longitude; INTEGER2 first_year := (INTEGER2) first_year; INTEGER2 last_year := (INTEGER2) last_year; Final_1; });
		Final_3 := PROJECT(Final_2, Layouts.station_inventory_layout);
		//SHARED Final_4 := SORT(Final_3, id, element);
		//SHARED Final_5 := DEDUP(Final_4, id, element);
		Final_6 := DISTRIBUTE(Final_3, HASH(id));
		RETURN OUTPUT(Final_6,, Datasets.File_Stations_Inventory, OVERWRITE);
	END;

	EXPORT daily() := FUNCTION
		Final_1 := Datasets.dsRawDaily;
		Final_2 := TABLE(Final_1, { INTEGER2 year := (INTEGER2) year; INTEGER1 month := (INTEGER1) month; Final_1 });
		Final_3 := PROJECT(Final_2, Layouts.daily_layout);
		Final_4 := SORT(Final_3, id, year, month, element);
		Final_5 := DEDUP(Final_4, id, year, month, element);
		Final_6 := DISTRIBUTE(Final_5, HASH(id));
		RETURN OUTPUT(Final_6,, Datasets.File_Daily, OVERWRITE);
	END;

END;
