IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;

IMPORT Education.NCES.IPEDS.DirectoryInformation AS DI;
IMPORT Education.NCES.IPEDS.Finance AS FI;
IMPORT Education.NCES.IPEDS.AdmissionsAndTestScores AS ADM;

y := 2014;

// ###########################
// Directory
// ###########################
// 1. Extract
//DI.extract( y );

// 2. Load
//DI.load( y );

// ###########################
// Admissions
// ###########################
// 1. Extract
//ADM.extract( y );

// 2. Load
//ADM.load( y );



// ###########################
// Finance
// ###########################
// 1. Extract
//FI.extract( y, 'F1A');

// 2. Load
//FI.load( y, 'F1A');

// ###########################
// Data Processing Time!!!
// ###########################
dsDI := DI.dsRaw(y);
dsDI;
dsDI(REGEXFIND('layne', instnm, NOCASE));

/*
dsFI := FI.dsRaw( y, 'F1A' );

A := JOIN(dsFI, dsDI, LEFT.unitid = RIGHT.unitid);
X := TABLE(A, { 
	instnm;
	stabbr;
	city;
	INTEGER total_net_assets := f1a18; 
	STRING total_net_assets_imputation := xf1a18; 
	UNSIGNED total_grants := f1e01 + f1e02 + f1e03 + f1e04 + f1e05 + f1e06;
});
SORT(X, -total_net_assets);
*/