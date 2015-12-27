// Reference
// http://www.nws.noaa.gov/ndfd/access_http.htm
IMPORT Weather.NOAA.NDFD.FS.Datasets;
IMPORT Linux.Curl;
IMPORT Linux.BinUtils;
IMPORT Weather.NOAA.NDFD.FS.WGrib2;
/*

	Example:
	Load Alaska (experimental) forecast data for days 1 to 3.
	SEQUENTIAL( // or just execute one at a time
		Extract.download( Datasets.area.Alaska, Datasets.valid_period.Days_001_003, true ),
		Extract.to_csv( Datasets.area.Alaska, Datasets.valid_period.Days_001_003, true)
	);

	This will 1. download the files from NOAA public repository and 2. convert Grib2 .bin files to .csv (to be loaded by Load module).


	TODO:
		Combine download() and to_csv() maybe? Macro? function?
		Name of macro/function: .extract( ... ) ? .run( ... ) ? .install( ... ) ? .setup( ... ) ?
	
*/
EXPORT Extract := MODULE

	EXPORT filename_layout := RECORD
		STRING filename;
	END;
	
	SHARED area_to_path(INTEGER area) := CASE( area,
		Datasets.area.Conus => 'AR.conus/',
		Datasets.area.Alaska => 'AR.alaska/',
		Datasets.area.Puerto_Rico => 'AR.puertori/',
		Datasets.area.Hawaii => 'AR.hawaii/',
		Datasets.area.Guam => 'AR.guam/',
		Datasets.area.North_America_Tropical => 'AR.nhemi/',
		Datasets.area.North_Pacific_Ocean_Tropical => 'AR.npacocn/',
		Datasets.area.Pacific_North_West => 'AR.pacnwest/',
		Datasets.area.Pacific_South_West => 'AR.pacswest/',
		Datasets.area.Northern_Rockies => 'AR.nrockies/',
		Datasets.area.Central_Rockies => 'AR.crrocks/',
		Datasets.area.Southern_Rockies => 'AR.srockies/', 
		Datasets.area.Northern_Plains => 'AR.nplains/',
		Datasets.area.Central_Plains => 'AR.crplains/',
		Datasets.area.Southern_Plains => 'AR.splains/',
		Datasets.area.Upper_Mississippi_Valley => 'AR.umissvly/',
		Datasets.area.Central_Mississippi_Valley => 'AR.crmissvy/',
		Datasets.area.Southern_Mississippi_Valley => 'AR.smissvly/',
		Datasets.area.Central_Great_Lakes => 'AR.crgrlake/',
		Datasets.area.Estern_Great_Lakes => 'AR.ergrlake/',
		Datasets.area.North_East => 'AR.neast/',
		Datasets.area.South_East => 'AR.seast/',
		Datasets.area.Mid_Atlantic => 'AR.midatlan/',
		''
	);
	
	EXPORT Base_Local_Uri := '/var/lib/HPCCSystems/mydropzone/NOAA/NDFD/';
	EXPORT Base_Url := 'http://weather.noaa.gov/';
	EXPORT Base_Path := 'pub/SL.us008001/';
	EXPORT Experimental_Path := 'ST.expr/';
	EXPORT Operational_Path := 'ST.opnl/';
	EXPORT Grib2_Path := 'DF.gr2/';
	EXPORT NDFD_Path := 'DC.ndfd/';
	
	// Validity Periods
	EXPORT valid_period_to_path(INTEGER period) := CASE(period,
		Datasets.valid_period.Days_001_003 => 'VP.001-003/',
		Datasets.valid_period.Days_004_007 => 'VP.004-007/',
		Datasets.valid_period.Days_008_450 => 'VP.008-450/',
		''
	);
	
	// Files
	EXPORT File_Convective_Hazard_Outlook := 'ds.conhazo.bin';
	EXPORT File_Probability_of_Tornadoes := 'ds.ptornado.bin';
	EXPORT File_Probability_of_Damaging_Thunderstorm_Winds := 'ds.ptstmwinds.bin';
	EXPORT File_Probability_of_Extreme_Hail := 'ds.pxhail.bin';
	EXPORT File_Probability_of_Extreme_Tornadoes := 'ds.pxtornado.bin';
	EXPORT File_Probability_of_Extreme_Thunderstorm_Winds := 'ds.pxtstmwinds.bin';
	EXPORT File_Probability_of_Hail := 'ds.phail.bin';
	EXPORT File_Wind_Gust_Speed := 'ds.wgust.bin';
	EXPORT File_Significant_Wave_Height := 'ds.waveh.bin';
	EXPORT File_Sky_Cover := 'ds.sky.bin';
	EXPORT File_Hazards := 'ds.wwa.bin';
	EXPORT File_Apparent_Temperature := 'ds.apt.bin';
	EXPORT File_Dewpoint := 'ds.td.bin';
	EXPORT File_Temperature := 'ds.temp.bin';
	EXPORT File_Wind_Speed := 'ds.wspd.bin';
	EXPORT File_Relative_Humidity := 'ds.rhm.bin';
	EXPORT File_Wind_Direction := 'ds.wdir.bin';
	EXPORT File_Weather := 'ds.wx.bin';
	EXPORT File_Quantitative_Precipitation_Forecast := 'ds.qpf.bin';
	EXPORT File_Minimum_Relative_Humidity := 'ds.minrh.bin';
	//EXPORT File_ := 'ds.tcsst.bin';
	//EXPORT File_ := 'ds.tctt.bin';
	//EXPORT File_ := 'ds.tcwt.bin';
	EXPORT File_Snow_Amount := 'ds.snow.bin';
	EXPORT File_Maximum_Relative_Humidity := 'ds.maxrh.bin';
	EXPORT File_Ice_Accumulation := 'ds.iceaccum.bin';
	EXPORT File_12_hour_Probability_of_Precipitation := 'ds.pop12.bin';
	//EXPORT File_ := 'ds.tcfrt.bin';
	EXPORT File_Maximum_Temperature := 'ds.maxt.bin';
	EXPORT File_Minimum_Temperature := 'ds.mint.bin';
	EXPORT File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_50kts_cumulative := 'ds.tcwspdabv50c.bin';
	EXPORT File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_64kts_cumulative := 'ds.tcwspdabv64c.bin';
	EXPORT File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_34kts_incremental := 'ds.tcwspdabv34i.bin';
	EXPORT File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_64kts_incremental := 'ds.tcwspdabv64i.bin';
	EXPORT File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_50kts_incremental := 'ds.tcwspdabv50i.bin';
	EXPORT File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_34kts_cumulative := 'ds.tcwspdabv34c.bin';
	EXPORT File_Critical_Extreme_Critical_Risk_Fire_Weather_Outlook := 'ds.critfireo.bin';
	EXPORT File_Total_Probability_of_Extreme_Severe_Thunderstorms := 'ds.ptotxsvrtstm.bin';
	EXPORT File_Dry_Lightning_Thunderstorm_Risk_Fire_Weather_Outlook := 'ds.dryfireo.bin';
	EXPORT File_Total_Probability_of_Severe_Thunderstorms := 'ds.ptotsvrtstm.bin';

	/*
	EXPORT pre_requisites() := FUNCTION
		RETURN SEQUENTIAL(
			OUTPUT(BinUtils.mkdir(Base_Local_Uri, false)
		);
	END:
	*/
	
	EXPORT dsFiles := DATASET([
			{ File_Convective_Hazard_Outlook },
			{ File_Probability_of_Tornadoes },
			{ File_Probability_of_Damaging_Thunderstorm_Winds },
			{ File_Probability_of_Extreme_Hail },
			{ File_Probability_of_Extreme_Tornadoes },
			{ File_Probability_of_Extreme_Thunderstorm_Winds },
			{ File_Probability_of_Hail },
			{ File_Wind_Gust_Speed },
			{ File_Significant_Wave_Height },
			{ File_Sky_Cover },
			{ File_Hazards },
			{ File_Apparent_Temperature },
			{ File_Dewpoint },
			{ File_Temperature },
			{ File_Wind_Speed },
			{ File_Relative_Humidity },
			{ File_Wind_Direction },
			{ File_Weather },
			{ File_Quantitative_Precipitation_Forecast },
			{ File_Minimum_Relative_Humidity },
			{ File_Snow_Amount },
			{ File_Maximum_Relative_Humidity },
			{ File_Ice_Accumulation },
			{ File_12_hour_Probability_of_Precipitation },
			{ File_Maximum_Temperature },
			{ File_Minimum_Temperature },
			{ File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_50kts_cumulative },
			{ File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_64kts_cumulative },
			{ File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_34kts_incremental },
			{ File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_64kts_incremental },
			{ File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_50kts_incremental },
			{ File_Probabilistic_Tropical_Cyclone_Surface_Wind_Speeds_Gt_34kts_cumulative },
			{ File_Critical_Extreme_Critical_Risk_Fire_Weather_Outlook },
			{ File_Total_Probability_of_Extreme_Severe_Thunderstorms },
			{ File_Dry_Lightning_Thunderstorm_Risk_Fire_Weather_Outlook },
			{ File_Total_Probability_of_Severe_Thunderstorms }
			], filename_layout);

	EXPORT STRING get_path(Datasets.area pArea, Datasets.valid_period pPeriod, BOOLEAN pExperimental) := FUNCTION
		oPath_1 := Base_Path + IF(pExperimental, Experimental_Path, Operational_Path);
		oPath_2 := oPath_1 + Grib2_Path + NDFD_Path;
		oPath_3 := oPath_2 + TRIM(area_to_path( pArea )); // Not sure why we need the TRIM here...
		oPath_4 := oPath_3 + TRIM(valid_period_to_path( pPeriod )); // Not sure why we need the TRIM here...
		
		oPath := oPath_4;
		return oPath;
	END;
	
	EXPORT STRING get_logical_path(Datasets.area pArea, Datasets.valid_period pPeriod, BOOLEAN pExperimental) := FUNCTION
		oPath := get_path( pArea, pPeriod, pExperimental);
		return REGEXREPLACE('/', oPath, '::');
	END;
	
	EXPORT to_csv(Datasets.area pArea, Datasets.valid_period pPeriod, BOOLEAN pExperimental = false) := FUNCTION
		oPath := get_path( pArea, pPeriod, pExperimental );
		oLocalUri := Base_Local_Uri + oPath;
		
		batch := PROJECT( dsFiles, TRANSFORM(WGrib2.batch_layout,
			SELF.sourceUri := oLocalUri + LEFT.filename;
			SELF.targetUri := oLocalUri + LEFT.filename + '.csv';
		));
		
		RETURN OUTPUT( WGrib2.batch_to_csv( batch ) );
	END;
	
	EXPORT download(Datasets.area pArea, Datasets.valid_period pPeriod, BOOLEAN pExperimental = false) := FUNCTION
		oPath := get_path( pArea, pPeriod, pExperimental );
		oLocalUri := Base_Local_Uri + oPath;
		oRemoteUri := Base_Url + oPath;
		
		batch := PROJECT( dsFiles, TRANSFORM(Curl.batch_layout,
			SELF.remoteUri := oRemoteUri + LEFT.filename;
			SELF.localUri := oLocalUri + LEFT.filename;
			SELF.ssl := false;
		));
		
		batch_results := Curl.batch_download( batch ) : STORED('batch');
		
		removed_404 := NORMALIZE(batch_results(http_code != '200'), 1, TRANSFORM(BinUtils.line_layout,
			SELF := BinUtils.rm( LEFT.localuri )[1];
		));
		RETURN SEQUENTIAL(
			OUTPUT( BinUtils.mkdir(oLocalUri, true) ),
			OUTPUT( batch_results ),
			OUTPUT( removed_404 )
		);
	END;
	

END;