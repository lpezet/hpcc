IMPORT Weather.NOAA.Feed.Datasets;
IMPORT Weather.NOAA.Feed.Tranxform;
IMPORT Weather.NOAA.Feed.Extract;
IMPORT Weather.NOAA.Feed.Setup;
IMPORT Weather.NOAA.Feed.Layouts;

IMPORT Weather.Util.GeometryLite as Geometry;

IMPORT Linux.Curl;

IMPORT Std;

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
Setup.Basics();

// 1.b Setup daily files for certain stations
/*
oStations := DATASET([ 
	{'USW00014838' }, { 'USC00144559' } , { 'USC00043157' } , { 'USC00117391' } , { 'USW00093820' } 
	], Layouts.station_id_layout);
Setup.Daily( oStations );
*/

// 2. Examples
//Example1();
//Example2();
//Example3();
