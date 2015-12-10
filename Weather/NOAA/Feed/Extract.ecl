IMPORT Weather.NOAA.Feed.Layouts;
IMPORT Weather.NOAA.Feed.Datasets;
IMPORT Weather.Util.SFile;
IMPORT Std;

EXPORT Extract := MODULE
	SHARED LandingZone_IP := 'localhost'; //172.31.38.70';
	// 5. Set the folder containing the data files on the Landing Zone here:  (Should end in / )
	SHARED BaseDataDirectory := '/var/lib/HPCCSystems/mydropzone/';
	
	EXPORT stations := MODULE
		SHARED File_In := BaseDataDirectory + 'ghcnd-stations.txt';
		SHARED DS_In := DATASET(std.File.ExternalLogicalFilename(LandingZone_IP, File_In), Layouts.raw_station_layout,THOR,UNSORTED);//CSV(HEADING(0), SEPARATOR(['']), TERMINATOR(['\n','\r\n','\n\r'])));
		SHARED DS_Dist := DISTRIBUTE(DS_In, HASH(id));
		EXPORT doIt() := OUTPUT(DS_Dist,, Datasets.File_Raw_Stations, OVERWRITE);
	END;
	
	EXPORT stations_inventory := MODULE
		SHARED File_In := BaseDataDirectory + 'ghcnd-inventory.txt';
		SHARED DS_In := DATASET(std.File.ExternalLogicalFilename(LandingZone_IP, File_In), Layouts.raw_station_inventory_layout,THOR,UNSORTED);//CSV(HEADING(0), SEPARATOR(['']), TERMINATOR(['\n','\r\n','\n\r'])));
		SHARED DS_Dist := DISTRIBUTE(DS_In, HASH(id));
		EXPORT doIt() := OUTPUT(DS_Dist,, Datasets.File_Raw_Stations_Inventory, OVERWRITE);
	END;
	
	EXPORT daily(STRING pId) := MODULE
		SHARED RawDSS := Datasets.dsSingleRawDaily(pId);
		SHARED File_In := BaseDataDirectory + pId + '.dly';
		SHARED DS_In := DATASET(std.File.ExternalLogicalFilename(LandingZone_IP, File_In), Layouts.raw_daily_layout,THOR,UNSORTED);//CSV(HEADING(0), SEPARATOR(['']), TERMINATOR(['\n','\r\n','\n\r'])));
		SHARED DS_Dist := DISTRIBUTE(DS_In, HASH(id));
		EXPORT doIt() := SEQUENTIAL(
			SFile.Create(Datasets.File_Raw_Daily),
			SFile.RemoveSub(Datasets.File_Raw_Daily, Datasets.File_Single_Raw_Daily(pId)),
			OUTPUT(DS_Dist,, Datasets.File_Single_Raw_Daily(pId), OVERWRITE),
			SFile.AddSub(Datasets.File_Raw_Daily, Datasets.File_Single_Raw_Daily(pId))
		);
		
	END;		

END;
