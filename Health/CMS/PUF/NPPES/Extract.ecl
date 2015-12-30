// http://download.cms.gov/nppes/NPI_Files.html
// File changes every ???.
// Right now: http://download.cms.gov/nppes/NPPES_Data_Dissemination_Dec_2015.zip
IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;

IMPORT Std;

EXPORT Extract := MODULE

	SHARED mLocalPath := '/var/lib/HPCCSystems/mydropzone/CMS/NPPES/';
	
	EXPORT extract_full() := FUNCTION
		oLocalFile := mLocalPath + 'NPPES_Data_Dissemination_Dec_2015.zip';

		RETURN SEQUENTIAL(
			#OPTION('targetClusterType','hthor'),
			OUTPUT( BinUtils.mkdir( mLocalPath, true ), NAMED('CreatePath')),
			OUTPUT( Curl.download('http://download.cms.gov/nppes/NPPES_Data_Dissemination_Dec_2015.zip', oLocalFile, false), NAMED('Download')),
			OUTPUT( BinUtils.checksum( oLocalFile ), NAMED('Checksum')),
			OUTPUT( Zip.unzip(oLocalFile, mLocalPath, true), NAMED('Unzipping')),
		);
	END;
	
	EXPORT extract_weekly() := FUNCTION
		oLocalFile := mLocalPath + 'NPPES_Data_Dissemination_121415_122015_Weekly.zip';

		RETURN SEQUENTIAL(
			#OPTION('targetClusterType','hthor'),
			OUTPUT( BinUtils.mkdir( mLocalPath, true ), NAMED('CreatePath')),
			OUTPUT( Curl.download('http://download.cms.gov/nppes/NPPES_Data_Dissemination_121415_122015_Weekly.zip', oLocalFile, false), NAMED('Download')),
			OUTPUT( BinUtils.checksum( oLocalFile ), NAMED('Checksum')),
			OUTPUT( Zip.unzip(oLocalFile, mLocalPath, true), NAMED('Unzipping')),
		);
	END;
	
	EXPORT extract_deactivation() := FUNCTION
		oLocalFile := mLocalPath + 'NPPES_Deactivated_NPI_Report_121515.zip';

		RETURN SEQUENTIAL(
			#OPTION('targetClusterType','hthor'),
			OUTPUT( BinUtils.mkdir( mLocalPath, true ), NAMED('CreatePath')),
			OUTPUT( Curl.download('http://download.cms.gov/nppes/NPPES_Deactivated_NPI_Report_121515.zip', oLocalFile, false), NAMED('Download')),
			OUTPUT( BinUtils.checksum( oLocalFile ), NAMED('Checksum')),
			OUTPUT( Zip.unzip(oLocalFile, mLocalPath, true), NAMED('Unzipping')),
		);
	END;
	

END;