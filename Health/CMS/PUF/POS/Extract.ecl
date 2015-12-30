// https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/Provider-of-Services/index.html
// File changes every ???.
// Right now: http://download.cms.gov/nppes/NPPES_Data_Dissemination_Dec_2015.zip
IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;

IMPORT Std;

EXPORT Extract := MODULE

	SHARED mLocalPath := '/var/lib/HPCCSystems/mydropzone/CMS/POS/';
	
	EXPORT extract_other_csv() := FUNCTION
		oLocalFile := mLocalPath + 'SEP15_OTHER_CSV.zip';
		oRemoteFile := 'https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/Provider-of-Services/Downloads/SEP15_OTHER_CSV.zip';
		RETURN SEQUENTIAL(
			#OPTION('targetClusterType','hthor'),
			OUTPUT( BinUtils.mkdir( mLocalPath, true ), NAMED('CreatePath')),
			OUTPUT( Curl.download(oRemoteFile, oLocalFile, true), NAMED('Download')),
			OUTPUT( BinUtils.checksum( oLocalFile ), NAMED('Checksum')),
			OUTPUT( Zip.unzip(oLocalFile, mLocalPath, true), NAMED('Unzipping')),
		);
	END;
	
	EXPORT extract_other_flat() := FUNCTION
		oLocalFile := mLocalPath + 'SEP15_OTHER_FLAT.zip';
		oRemoteFile := 'https://www.cms.gov/Research-Statistics-Data-and-Systems/Downloadable-Public-Use-Files/Provider-of-Services/Downloads/SEP15_OTHER_FLAT.zip';
		RETURN SEQUENTIAL(
			#OPTION('targetClusterType','hthor'),
			OUTPUT( BinUtils.mkdir( mLocalPath, true ), NAMED('CreatePath')),
			OUTPUT( Curl.download(oRemoteFile, oLocalFile, true), NAMED('Download')),
			OUTPUT( BinUtils.checksum( oLocalFile ), NAMED('Checksum')),
			OUTPUT( Zip.unzip(oLocalFile, mLocalPath, true), NAMED('Unzipping')),
		);
	END;


END;