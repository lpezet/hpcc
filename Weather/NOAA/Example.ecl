IMPORT Weather.NOAA.Feed.Datasets;
IMPORT Weather.NOAA.Feed.Tranxform;
IMPORT Weather.NOAA.Feed.Extract;

//Util.Reset_SuperFile(Datasets.File_Raw_Daily);
//Extract('US').daily.doIt();
//Extract('AS').daily.doIt();
//Extract('CA').daily.doIt();
//Tranxform.daily.doIt();

oExt := Extract;

//oExt.stations.doIt();

oTx := Tranxform;
//oTx.stations.doIt();

A := Datasets.dsStations;
A;
//TABLE(A, { STRING id := A.id, STRING geohash := Util.Geohash.encode(A.latitude, A.longitude, 5); });
//A := Datasets.dsDaily;
//TABLE(A, { A.element, COUNT(GROUP) }, element);
//oRawDSS := RawDatasets('US1WIPC0011');
//oRawDaily := oRawDSS.dsDaily;
//A := TABLE(oRawDaily, { INTEGER2
/*
A := PROJECT(oRawDaily, Layouts.daily_layout, TRANSFORM(Layouts.daily_layout,
	SELF.year := (INTEGER2) LEFT.year;
	SELF.month := (INTEGER1) LEFT.month;
	SELF := LEFT;
));
A;
*/