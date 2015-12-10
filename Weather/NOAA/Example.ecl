IMPORT Weather.NOAA.Feed.Datasets;
IMPORT Weather.NOAA.Feed.Tranxform;
IMPORT Weather.NOAA.Feed.Extract;

IMPORT Weather.Util.GeometryLite as Geometry;

IMPORT Linux.Curl;

// ##########################
// Stations
// ##########################
Stations() := FUNCTION
	RETURN SEQUENTIAL(
			OUTPUT(Curl.download('http://www1.ncdc.noaa.gov/pub/data/ghcn/daily/ghcnd-stations.txt', '/var/lib/HPCCSystems/mydropzone/ghcnd-stations.txt', false), NAMED('Stations') ),
			Extract.stations.doIt(),
			Tranxform.stations.doIt()
		);
END;

// ##########################
// Stations Inventory
// ##########################
StationsInventory() := FUNCTION
	RETURN SEQUENTIAL(
			OUTPUT(Curl.download('http://www1.ncdc.noaa.gov/pub/data/ghcn/daily/ghcnd-inventory.txt', '/var/lib/HPCCSystems/mydropzone/ghcnd-inventory.txt', false), NAMED('StationsInventory') ),
			Extract.stations_inventory.doIt(),
			Tranxform.stations_inventory.doIt()
		);
END;

// ##########################
// Single Station
// ##########################
SingleStation() := FUNCTION
	RETURN SEQUENTIAL(
			OUTPUT(Curl.download('http://www1.ncdc.noaa.gov/pub/data/ghcn/daily/all/US1COEP0020.dly', '/var/lib/HPCCSystems/mydropzone/US1COEP0020.dly', false), NAMED('US1COEP0020') ),
			Extract.daily('US1COEP0020').doIt(),
			Tranxform.daily.doIt()
	);
END;

Setup := MACRO
	Stations();
	StationsInventory();
	SingleStation();
ENDMACRO;

Example1 := MACRO
	Datasets.dsStations(id = 'US1COEP0020');
	Datasets.dsStationsInventory(id = 'US1COEP0020');
	oDailyDS := Datasets.dsDaily;
	TABLE( oDailyDS, { id; year; element; INTEGER total_records := COUNT(GROUP); }, id, year, element );
ENDMACRO;

Example2 := MACRO

	A := Datasets.dsStationsInventory;
	B := TABLE(A, { INTEGER4 years := last_year - first_year; A; } );
	C := B( years > 10 );
	D := SORT(C, -years);
	OUTPUT(D, NAMED('LongestInServiceStations'));
	OUTPUT(D( last_year >= 2015 ), NAMED('LongestStillInService'));
ENDMACRO;

Example3 := MACRO

	// SRID = Spatial Reference System Identifier, and in this case correlates to the matching EPSG id (http://www.epsg.org/)
	// Universal Transverse Mercator (UTM) Zone 16 North... X,Y in meters, good for showing local distances
	UTMZ16N_SRID := 32616; 

	// World Geodetic System (WGS) ... Longitude,Latitude good for using as the base coordinate system
	WGS84_SRID := 4326; 

	oStations := Datasets.dsStations;
	oStationsGeo := TABLE(oStations, { STRING point := 'POINT(' + longitude + ' ' + latitude + ')'; STRING srid := Geometry.toSRID('POINT(' + longitude + ' ' + latitude + ')', WGS84_SRID,UTMZ16N_SRID); oStations; } );
	oColoradoStations := oStationsGeo(state = 'CO');

	oCenterSRID := Geometry.toSRID('POINT(-104.8005 39.0276)', WGS84_SRID,UTMZ16N_SRID);

	oStationsWithDistance := TABLE(oColoradoStations, { INTEGER4 distance := Geometry.distanceBetween(srid, oCenterSRID,UTMZ16N_SRID); oColoradoStations; } );

	oStationsWithDistanceWithInventory := JOIN(oStationsWithDistance, Datasets.dsStationsInventory, LEFT.id = RIGHT.id);
	X := oStationsWithDistanceWithInventory(last_year >= 2015);
	SORT(X, distance);

ENDMACRO;


// 1. Setup
//Setup();

// 2. Examples
//Example1();
//Example2();
Example3();