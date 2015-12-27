IMPORT Std;
IMPORT Weather.NOAA.NDFD.FS.Extract;
IMPORT Weather.NOAA.NDFD.FS.Datasets;
IMPORT Weather.NOAA.NDFD.FS.Layouts;

EXPORT Load := MODULE
	EXPORT LandingZone_IP := 'localhost';
	// Set the folder containing the data files on the Landing Zone here:  (Should end in / )
	//SHARED BaseDataDirectory := '/var/lib/HPCCSystems/mydropzone/';
	
	
	// Reference
	// http://www.cpc.ncep.noaa.gov/products/wesley/wgrib2/csv.html
	EXPORT raw_layout := RECORD
		STRING time0;
		STRING time1;
		STRING field;
		STRING level;
		DECIMAL6_3 longitude;
		DECIMAL6_4 latitude;
		STRING grid_value;
	END;
	
	SHARED load_it(STRING pInputFilename, STRING pOutputFilename) := FUNCTION
		oDS := DATASET(std.File.ExternalLogicalFilename(LandingZone_IP, pInputFilename), raw_layout, CSV(HEADING(0), SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r'])));
		//DS_Dist := DISTRIBUTE(DS_In, HASH(name));
		RETURN OUTPUT(oDS,, pOutputFilename, OVERWRITE);
	END;
	
	SHARED get_logical_path(Datasets.area pArea, Datasets.valid_period pPeriod, BOOLEAN pExperimental = false) :=
		'~noaa::ndfd::' + Extract.get_logical_path( pArea, pPeriod, pExperimental );
	
	EXPORT load_one(Datasets.area pArea, Datasets.valid_period pPeriod, Datasets.element pElement, BOOLEAN pExperimental = false) := FUNCTION
		path := Extract.get_path( pArea, pPeriod, pExperimental );
		logical_path := get_logical_path( pArea, pPeriod, pExperimental );
		localUri := Extract.Base_Local_Uri + path;
		oFilename := localUri + 'ds.' + pElement + '.bin.csv';
		oLogicalFilename := logical_path + pElement;
		/*
		oDS := DATASET(std.File.ExternalLogicalFilename(Load.LandingZone_IP, oFilename), Weather.NOAA.NDFD.FS.Load.raw_layout, CSV(HEADING(0), SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r'])), OPT);
			// TODO: WARNING: are we here loading the file content twice? one for the COUNT and one for the OUTPUT to file???
			IF(COUNT(oDS) > 0, 
				OUTPUT(oDS,,oLogicalFilename,OVERWRITE),
				OUTPUT(oFilename + ' does not exist. Skipped.')
			);
		*/
		RETURN OUTPUT(DATASET([{ pElement, oFilename, oLogicalFilename }], { STRING el; STRING file; STRING logical; }));
	END;
	
	EXPORT load_all(pArea, pPeriod, pExperimental = false) := MACRO
		IMPORT Weather;
		IMPORT Std;
		path := Extract.get_path( pArea, pPeriod, pExperimental );
		logical_path := Weather.NOAA.NDFD.FS.Load.get_logical_path( pArea, pPeriod, pExperimental );
		localUri := Extract.Base_Local_Uri + path;
		
		LOADXML(Datasets.elements_xml);
		
		#FOR(element)
			#UNIQUENAME(oEl)
			%oEl% := %''%;
			#UNIQUENAME(oLocalUri)
			%oLocalUri% := localUri + 'ds.' + %oEl% + '.bin.csv';
			#UNIQUENAME(oLogical)
			%oLogical% := logical_path + %oEl%;
			
			#UNIQUENAME(oDS)
			%oDS% := DATASET(std.File.ExternalLogicalFilename(Load.LandingZone_IP, %oLocalUri%), Weather.NOAA.NDFD.FS.Load.raw_layout, CSV(HEADING(0), SEPARATOR([',']), TERMINATOR(['\n','\r\n','\n\r'])), OPT);
			// TODO: WARNING: are we here loading the file content twice? one for the COUNT and one for the OUTPUT to file???
			IF(COUNT(%oDS%) > 0, 
				OUTPUT(%oDS%,,%oLogical%,OVERWRITE),
				OUTPUT(%oLocalUri% + ' does not exist. Skipped.')
			);			
		#END
		
	ENDMACRO;


END;