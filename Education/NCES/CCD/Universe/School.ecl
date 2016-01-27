IMPORT Std;

IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;

IMPORT Education.NCES.CCD.Universe.Layouts;


EXPORT School := MODULE

	SHARED mLandingZoneIP := 'localhost';
	SHARED mLocalPath := '/var/lib/HPCCSystems/mydropzone/NCES/CCD/Universe/School/';
	
	EXPORT logicalFilename(UNSIGNED pYear) := '~nces::ccd::univ::school::' + pYear;
	
	SHARED downloadFile(UNSIGNED pYear) := CASE(pYear,
		2013 => 'sc131a_supp_txt.zip',
		2012 => 'sc121a_supp_txt.zip',
		2011 => 'sc111a_supp_txt.zip',
		2010 => 'sc102a_txt.zip',
		'');
	
	SHARED downloadUrl(INTEGER pYear) := CASE(pYear,
		2013 => 'https://nces.ed.gov/ccd/Data/zip/',
		2012 => 'https://nces.ed.gov/ccd/Data/zip/',
		2011 => 'https://nces.ed.gov/ccd/Data/zip/',
		2010 => 'https://nces.ed.gov/ccd/Data/zip/',
		// NOT SUPPORTED
		//2009 => 'https://nces.ed.gov/ccd/data/zip/sc092a_txt.zip',
		//2008 => 'https://nces.ed.gov/ccd/data/zip/sc081b_txt.zip',
		//2007 => 'https://nces.ed.gov/ccd/data/zip/sc071b_txt.zip',
		'');
		
	SHARED localDataFile(INTEGER pYear) := CASE(pYear,
		2013 => mLocalPath + 'sc131a_supp.txt',
		2012 => mLocalPath + 'sc121a_supp.txt',
		2011 => mLocalPath + 'sc111a_supp.txt',
		2010 => mLocalPath + 'sc102a.txt',
		// NOT SUPPORTED
		//2009 => mLocalPath + 'sc092a_txt.txt',
		//2008 => mLocalPath + 'sc081b_txt.txt',
		//2007 => mLocalPath + 'sc071b_txt.txt',
		'');
		
	EXPORT extract(UNSIGNED pYear) := FUNCTION
		oDownloadFile := downloadFile( pYear );
		oLocalFile := mLocalPath + oDownloadFile;
		oUrl := downloadUrl( pYear ) + oDownloadFile;
		RETURN SEQUENTIAL(
			#OPTION('targetClusterType','hthor'),
			OUTPUT( BinUtils.mkdir( mLocalPath, true ), NAMED('CreatePath')),
			OUTPUT( Curl.download( oUrl, oLocalFile, true ), NAMED('Download')),
			OUTPUT( BinUtils.checksum( oLocalFile ), NAMED('Checksum')),
			OUTPUT( Zip.unzip(oLocalFile, mLocalPath, true), NAMED('Unzipping')),
		);
	END;
	
	EXPORT load(UNSIGNED pYear) := FUNCTION
		File_In := localDataFile( pYear );
		File_Out := logicalFilename( pYear );
		DS_In := DATASET(std.File.ExternalLogicalFilename(mLandingZoneIP, File_In), Layouts.school_raw_layout( pYear ), CSV(HEADING(1), SEPARATOR(['\t']), QUOTE(['"']), TERMINATOR(['\n','\r\n','\n\r'])));
		DS_Dist := DISTRIBUTE(DS_In, HASH(ncessch));
		RETURN OUTPUT(DS_Dist,, File_Out, OVERWRITE);
	END;



	EXPORT dsRaw(UNSIGNED pYear) := DATASET( logicalFilename( pYear ), Layouts.school_raw_layout( pYear ), THOR, OPT );
	
END;