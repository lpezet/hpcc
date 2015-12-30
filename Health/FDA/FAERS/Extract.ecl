// http://www.fda.gov/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm082193.htm
// Extract quaterly file, then look at ascii/ASC_NTS.pdf doc, for definition of fields for each file.
IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;

IMPORT Std;

EXPORT Extract := MODULE

	SHARED mLocalPath := '/var/lib/HPCCSystems/mydropzone/FAERS/';
	
	EXPORT extract() := FUNCTION
		oLocalFile := mLocalPath + 'UCM477190.zip';

		RETURN SEQUENTIAL(
			OUTPUT( BinUtils.mkdir( mLocalPath, false ), NAMED('CreatePath')),
			OUTPUT( Curl.download('http://www.fda.gov/downloads/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/UCM477190.zip', oLocalFile, false), NAMED('Download')),
			OUTPUT( Zip.unzip(oLocalFile, mLocalPath), NAMED('Unzipping')),
		);
	END;
	

END;