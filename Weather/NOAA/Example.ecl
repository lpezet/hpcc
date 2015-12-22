IMPORT Weather.NOAA.GHCN.FS.Datasets;
IMPORT Weather.NOAA.GHCN.FS.Tranxform;
IMPORT Weather.NOAA.GHCN.FS.Extract;
IMPORT Weather.NOAA.GHCN.FS.Setup;
IMPORT Weather.NOAA.GHCN.FS.Layouts;

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

	// Add geo point to station dataset and filter already on only Colorado stations
	oStations := Datasets.dsStations;
	oStationsGeo := TABLE(oStations, { STRING point := 'POINT(' + longitude + ' ' + latitude + ')'; STRING srid := Geometry.toSRID('POINT(' + longitude + ' ' + latitude + ')', WGS84_SRID,UTMZ16N_SRID); oStations; } );
	oColoradoStations := oStationsGeo(state = 'CO');

	// Define reference point to search from
	oCenterSRID := Geometry.toSRID('POINT(-104.8005 39.0276)', WGS84_SRID,UTMZ16N_SRID);

	// Calcuate distance from reference point in Colorado Stations dataset
	oStationsWithDistance := TABLE(oColoradoStations, { INTEGER4 distance := Geometry.distanceBetween(srid, oCenterSRID,UTMZ16N_SRID); oColoradoStations; } );

	// Grab station inventory for all Colorado stations with distance from reference point
	oStationsWithDistanceWithInventory := JOIN(oStationsWithDistance, Datasets.dsStationsInventory, LEFT.id = RIGHT.id);

	// Filter results on stations still having data in 2015
	X := oStationsWithDistanceWithInventory(last_year >= 2015);
	SORT(X, distance);

ENDMACRO;


// 1. Setup
//Setup.Basics();

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

oStations := Datasets.dsStations(state = 'TX');
oElements := JOIN(oStations, Datasets.dsStationsInventory, LEFT.id = RIGHT.id);

T := TABLE(oElements, { element; INTEGER stations := COUNT(GROUP); }, element );
X := JOIN(T, Datasets.dsElements, LEFT.element = RIGHT.name, LEFT OUTER);
SORT(X, -stations);

//Setup.Elements();
