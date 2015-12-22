EXPORT Layouts := MODULE

	EXPORT element_layout := RECORD
		STRING name;
		STRING description;
		STRING notes;
	END;
	
	EXPORT raw_element_layout := RECORD
		element_layout;
	END;
	
	EXPORT station_id_layout := RECORD
		STRING id;
	END;

	EXPORT state_layout := RECORD
		STRING2 code;
		STRING name;
	END;

	/*
	NB: even though the following layout is given, "NAME" is not fixed-length.
	------------------------------
	Variable   Columns   Type
	------------------------------
	CODE          1-2    Character
	NAME         4-50    Character
	------------------------------
	*/
	EXPORT raw_state_layout := RECORD
		STRING code_and_name;
	END;

	EXPORT country_layout := RECORD
		STRING2 code;
		STRING name;
	END;
	
	/*
	NB: even though the following layout is given, "NAME" is not fixed-length.
	------------------------------
	Variable   Columns   Type
	------------------------------
	CODE          1-2    Character
	NAME         4-50    Character
	------------------------------
	*/
	EXPORT raw_country_layout := RECORD
		STRING code_and_name;
	END;
	
	EXPORT station_inventory_layout := RECORD
		STRING11 id;
		DECIMAL9_6 latitude;
		DECIMAL9_6 longitude;
		STRING4 element;
		INTEGER4 first_year;
		INTEGER4 last_year;
	END;
	
	EXPORT station_layout := RECORD
		STRING11 id;
		DECIMAL9_6 latitude;
		DECIMAL9_6 longitude;
		DECIMAL4_1 elevation;
		STRING2 state;
		STRING name;
		STRING gsn_flag;
		STRING hcn_crn_flag;
		STRING wmo_id;
	END;
	
	EXPORT daily_layout := RECORD
		STRING id;
		INTEGER2 year;
		INTEGER1 month;
		STRING4 element;
		STRING5 value1;
		STRING1 mflag1;
		STRING1 qflag1;
		STRING1 sflag1;
		STRING5 value2;
		STRING1 mflag2;
		STRING1 qflag2;
		STRING1 sflag2;
		STRING5 value3;
		STRING1 mflag3;
		STRING1 qflag3;
		STRING1 sflag3;
		STRING5 value4;
		STRING1 mflag4;
		STRING1 qflag4;
		STRING1 sflag4;
		STRING5 value5;
		STRING1 mflag5;
		STRING1 qflag5;
		STRING1 sflag5;
		STRING5 value6;
		STRING1 mflag6;
		STRING1 qflag6;
		STRING1 sflag6;
		STRING5 value7;
		STRING1 mflag7;
		STRING1 qflag7;
		STRING1 sflag7;
		STRING5 value8;
		STRING1 mflag8;
		STRING1 qflag8;
		STRING1 sflag8;
		STRING5 value9;
		STRING1 mflag9;
		STRING1 qflag9;
		STRING1 sflag9;
		STRING5 value10;
		STRING1 mflag10;
		STRING1 qflag10;
		STRING1 sflag10;
		STRING5 value11;
		STRING1 mflag11;
		STRING1 qflag11;
		STRING1 sflag11;
		STRING5 value12;
		STRING1 mflag12;
		STRING1 qflag12;
		STRING1 sflag12;
		STRING5 value13;
		STRING1 mflag13;
		STRING1 qflag13;
		STRING1 sflag13;
		STRING5 value14;
		STRING1 mflag14;
		STRING1 qflag14;
		STRING1 sflag14;
		STRING5 value15;
		STRING1 mflag15;
		STRING1 qflag15;
		STRING1 sflag15;
		STRING5 value16;
		STRING1 mflag16;
		STRING1 qflag16;
		STRING1 sflag16;
		STRING5 value17;
		STRING1 mflag17;
		STRING1 qflag17;
		STRING1 sflag17;
		STRING5 value18;
		STRING1 mflag18;
		STRING1 qflag18;
		STRING1 sflag18;
		STRING5 value19;
		STRING1 mflag19;
		STRING1 qflag19;
		STRING1 sflag19;
		STRING5 value20;
		STRING1 mflag20;
		STRING1 qflag20;
		STRING1 sflag20;
		STRING5 value21;
		STRING1 mflag21;
		STRING1 qflag21;
		STRING1 sflag21;
		STRING5 value22;
		STRING1 mflag22;
		STRING1 qflag22;
		STRING1 sflag22;
		STRING5 value23;
		STRING1 mflag23;
		STRING1 qflag23;
		STRING1 sflag23;
		STRING5 value24;
		STRING1 mflag24;
		STRING1 qflag24;
		STRING1 sflag24;
		STRING5 value25;
		STRING1 mflag25;
		STRING1 qflag25;
		STRING1 sflag25;
		STRING5 value26;
		STRING1 mflag26;
		STRING1 qflag26;
		STRING1 sflag26;
		STRING5 value27;
		STRING1 mflag27;
		STRING1 qflag27;
		STRING1 sflag27;
		STRING5 value28;
		STRING1 mflag28;
		STRING1 qflag28;
		STRING1 sflag28;
		STRING5 value29;
		STRING1 mflag29;
		STRING1 qflag29;
		STRING1 sflag29;
		STRING5 value30;
		STRING1 mflag30;
		STRING1 qflag30;
		STRING1 sflag30;
		STRING5 value31;
		STRING1 mflag31;
		STRING1 qflag31;
		STRING1 sflag31;
	END;
	
	
	
	/*
	------------------------------
	Variable   Columns   Type
	------------------------------
	ID            1-11   Character
	LATITUDE     13-20   Real
	LONGITUDE    22-30   Real
	ELEMENT      32-35   Character
	FIRSTYEAR    37-40   Integer
	LASTYEAR     42-45   Integer
	------------------------------
	*/
	EXPORT raw_station_inventory_layout := RECORD
		STRING11 id;
		STRING9 latitude;
		STRING10 longitude;
		STRING5 element;
		STRING5 first_year;
		STRING5 last_year;
		STRING1 garbage;
	END;
	
	/*
	------------------------------
	Variable   Columns   Type
	------------------------------
	ID            1-11   Character
	LATITUDE     13-20   Real
	LONGITUDE    22-30   Real
	ELEVATION    32-37   Real
	STATE        39-40   Character
	NAME         42-71   Character
	GSN FLAG     73-75   Character
	HCN/CRN FLAG 77-79   Character
	WMO ID       81-85   Character
	------------------------------
	*/
	
	EXPORT raw_station_layout := RECORD
		STRING11 id;
		STRING10 latitude;
		STRING10 longitude;
		STRING7 elevation;
		STRING3 state;
		STRING30 name;
		STRING4 gsn_flag;
		STRING4 hcn_crn_flag;
		STRING6 wmo_id;
		STRING1 garbage;
	END;

	
	
	/*
	------------------------------
	Variable   Columns   Type
	------------------------------
	ID            1-11   Character
	YEAR         12-15   Integer
	MONTH        16-17   Integer
	ELEMENT      18-21   Character
	VALUE1       22-26   Integer
	MFLAG1       27-27   Character
	QFLAG1       28-28   Character
	SFLAG1       29-29   Character
	VALUE2       30-34   Integer
	MFLAG2       35-35   Character
	QFLAG2       36-36   Character
	SFLAG2       37-37   Character
	.           .          .
	.           .          .
	.           .          .
	VALUE31    262-266   Integer
	MFLAG31    267-267   Character
	QFLAG31    268-268   Character
	SFLAG31    269-269   Character
	------------------------------
	*/
	EXPORT raw_daily_layout := RECORD
		STRING11 id;
		STRING4 year;
		STRING2 month;
		STRING4 element;
		STRING5 value1;
		STRING1 mflag1;
		STRING1 qflag1;
		STRING1 sflag1;
		STRING5 value2;
		STRING1 mflag2;
		STRING1 qflag2;
		STRING1 sflag2;
		STRING5 value3;
		STRING1 mflag3;
		STRING1 qflag3;
		STRING1 sflag3;
		STRING5 value4;
		STRING1 mflag4;
		STRING1 qflag4;
		STRING1 sflag4;
		STRING5 value5;
		STRING1 mflag5;
		STRING1 qflag5;
		STRING1 sflag5;
		STRING5 value6;
		STRING1 mflag6;
		STRING1 qflag6;
		STRING1 sflag6;
		STRING5 value7;
		STRING1 mflag7;
		STRING1 qflag7;
		STRING1 sflag7;
		STRING5 value8;
		STRING1 mflag8;
		STRING1 qflag8;
		STRING1 sflag8;
		STRING5 value9;
		STRING1 mflag9;
		STRING1 qflag9;
		STRING1 sflag9;
		STRING5 value10;
		STRING1 mflag10;
		STRING1 qflag10;
		STRING1 sflag10;
		STRING5 value11;
		STRING1 mflag11;
		STRING1 qflag11;
		STRING1 sflag11;
		STRING5 value12;
		STRING1 mflag12;
		STRING1 qflag12;
		STRING1 sflag12;
		STRING5 value13;
		STRING1 mflag13;
		STRING1 qflag13;
		STRING1 sflag13;
		STRING5 value14;
		STRING1 mflag14;
		STRING1 qflag14;
		STRING1 sflag14;
		STRING5 value15;
		STRING1 mflag15;
		STRING1 qflag15;
		STRING1 sflag15;
		STRING5 value16;
		STRING1 mflag16;
		STRING1 qflag16;
		STRING1 sflag16;
		STRING5 value17;
		STRING1 mflag17;
		STRING1 qflag17;
		STRING1 sflag17;
		STRING5 value18;
		STRING1 mflag18;
		STRING1 qflag18;
		STRING1 sflag18;
		STRING5 value19;
		STRING1 mflag19;
		STRING1 qflag19;
		STRING1 sflag19;
		STRING5 value20;
		STRING1 mflag20;
		STRING1 qflag20;
		STRING1 sflag20;
		STRING5 value21;
		STRING1 mflag21;
		STRING1 qflag21;
		STRING1 sflag21;
		STRING5 value22;
		STRING1 mflag22;
		STRING1 qflag22;
		STRING1 sflag22;
		STRING5 value23;
		STRING1 mflag23;
		STRING1 qflag23;
		STRING1 sflag23;
		STRING5 value24;
		STRING1 mflag24;
		STRING1 qflag24;
		STRING1 sflag24;
		STRING5 value25;
		STRING1 mflag25;
		STRING1 qflag25;
		STRING1 sflag25;
		STRING5 value26;
		STRING1 mflag26;
		STRING1 qflag26;
		STRING1 sflag26;
		STRING5 value27;
		STRING1 mflag27;
		STRING1 qflag27;
		STRING1 sflag27;
		STRING5 value28;
		STRING1 mflag28;
		STRING1 qflag28;
		STRING1 sflag28;
		STRING5 value29;
		STRING1 mflag29;
		STRING1 qflag29;
		STRING1 sflag29;
		STRING5 value30;
		STRING1 mflag30;
		STRING1 qflag30;
		STRING1 sflag30;
		STRING5 value31;
		STRING1 mflag31;
		STRING1 qflag31;
		STRING1 sflag31;
		STRING1 garbage;
	END;
	


END;