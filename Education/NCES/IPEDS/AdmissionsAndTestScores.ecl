IMPORT Std;

IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;


EXPORT AdmissionsAndTestScores := MODULE

	SHARED mLandingZoneIP := 'localhost';
	SHARED mLocalPath := '/var/lib/HPCCSystems/mydropzone/NCES/IPEDS/ADM/';
	
	SHARED localArchive(UNSIGNED pYear) := mLocalPath + 'ADM' + pYear + '.zip';
	SHARED localDataFile(UNSIGNED pYear) := mLocalPath + 'adm' + pYear + '.csv';
	EXPORT logicalFilename(UNSIGNED pYear) := '~nces::ipeds::adm::' + pYear;
	
	EXPORT extract(UNSIGNED pYear) := FUNCTION
		oLocalFile := localArchive( pYear );
		RETURN SEQUENTIAL(
			#OPTION('targetClusterType','hthor'),
			OUTPUT( BinUtils.mkdir( mLocalPath, true ), NAMED('CreatePath')),
			OUTPUT( Curl.download('http://nces.ed.gov/ipeds/datacenter/data/ADM' + pYear + '.zip', oLocalFile, false), NAMED('Download')),
			OUTPUT( BinUtils.checksum( oLocalFile ), NAMED('Checksum')),
			OUTPUT( Zip.unzip(oLocalFile, mLocalPath, true), NAMED('Unzipping')),
		);
	END;
	
	EXPORT raw_layout := RECORD
		INTEGER8 unitid;	// size=6, type=cont, imputationVar=, unique identification number of the institution
		INTEGER8 admcon1;	// size=2, type=disc, imputationVar=, secondary school gpa
		INTEGER8 admcon2;	// size=2, type=disc, imputationVar=, secondary school rank
		INTEGER8 admcon3;	// size=2, type=disc, imputationVar=, secondary school record
		INTEGER8 admcon4;	// size=2, type=disc, imputationVar=, completion of college-preparatory program
		INTEGER8 admcon5;	// size=2, type=disc, imputationVar=, recommendations
		INTEGER8 admcon6;	// size=2, type=disc, imputationVar=, formal demonstration of competencies
		INTEGER8 admcon7;	// size=2, type=disc, imputationVar=, admission test scores
		INTEGER8 admcon8;	// size=2, type=disc, imputationVar=, toefl (test of english as a foreign language
		INTEGER8 admcon9;	// size=2, type=disc, imputationVar=, other test (wonderlic, wisc-iii, etc.)
		STRING xapplcn;
		INTEGER8 applcn;	// size=6, type=cont, imputationVar=xapplcn, applicants total
		STRING xapplcnm;
		INTEGER8 applcnm;	// size=6, type=cont, imputationVar=xapplcnm, applicants men
		STRING xapplcnw;
		INTEGER8 applcnw;	// size=6, type=cont, imputationVar=xapplcnw, applicants women
		STRING xadmssn;
		INTEGER8 admssn;	// size=6, type=cont, imputationVar=xadmssn, admissions total
		STRING xadmssnm;
		INTEGER8 admssnm;	// size=6, type=cont, imputationVar=xadmssnm, admissions men
		STRING xadmssnw;
		INTEGER8 admssnw;	// size=6, type=cont, imputationVar=xadmssnw, admissions women
		STRING xenrlt;
		INTEGER8 enrlt;	// size=6, type=cont, imputationVar=xenrlt, enrolled total
		STRING xenrlm;
		INTEGER8 enrlm;	// size=6, type=cont, imputationVar=xenrlm, enrolled  men
		STRING xenrlw;
		INTEGER8 enrlw;	// size=6, type=cont, imputationVar=xenrlw, enrolled  women
		STRING xenrlft;
		INTEGER8 enrlft;	// size=6, type=cont, imputationVar=xenrlft, enrolled full time total
		STRING xenrlftm;
		INTEGER8 enrlftm;	// size=6, type=cont, imputationVar=xenrlftm, enrolled full time men
		STRING xenrlftw;
		INTEGER8 enrlftw;	// size=6, type=cont, imputationVar=xenrlftw, enrolled full time women
		STRING xenrlpt;
		INTEGER8 enrlpt;	// size=6, type=cont, imputationVar=xenrlpt, enrolled part time total
		STRING xenrlptm;
		INTEGER8 enrlptm;	// size=6, type=cont, imputationVar=xenrlptm, enrolled part time men
		STRING xenrlptw;
		INTEGER8 enrlptw;	// size=6, type=cont, imputationVar=xenrlptw, enrolled part time women
		STRING xsatnum;
		INTEGER8 satnum;	// size=6, type=cont, imputationVar=xsatnum, number of first-time degree/certificate-seeking students submitting sat scores
		STRING xsatpct;
		INTEGER8 satpct;	// size=3, type=cont, imputationVar=xsatpct, percent of first-time degree/certificate-seeking students submitting sat scores
		STRING xactnum;
		INTEGER8 actnum;	// size=6, type=cont, imputationVar=xactnum, number of first-time degree/certificate-seeking students submitting act scores
		STRING xactpct;
		INTEGER8 actpct;	// size=3, type=cont, imputationVar=xactpct, percent of first-time degree/certificate-seeking students submitting act scores
		STRING xsatvr25;
		INTEGER8 satvr25;	// size=3, type=cont, imputationVar=xsatvr25, sat critical reading 25th percentile score
		STRING xsatvr75;
		INTEGER8 satvr75;	// size=3, type=cont, imputationVar=xsatvr75, sat critical reading 75th percentile score
		STRING xsatmt25;
		INTEGER8 satmt25;	// size=3, type=cont, imputationVar=xsatmt25, sat math 25th percentile score
		STRING xsatmt75;
		INTEGER8 satmt75;	// size=3, type=cont, imputationVar=xsatmt75, sat math 75th percentile score
		STRING xsatwr25;
		INTEGER8 satwr25;	// size=3, type=cont, imputationVar=xsatwr25, sat writing 25th percentile score
		STRING xsatwr75;
		INTEGER8 satwr75;	// size=3, type=cont, imputationVar=xsatwr75, sat writing 75th percentile score
		STRING xactcm25;
		INTEGER8 actcm25;	// size=3, type=cont, imputationVar=xactcm25, act composite 25th percentile score
		STRING xactcm75;
		INTEGER8 actcm75;	// size=3, type=cont, imputationVar=xactcm75, act composite 75th percentile score
		STRING xacten25;
		INTEGER8 acten25;	// size=3, type=cont, imputationVar=xacten25, act english 25th percentile score
		STRING xacten75;
		INTEGER8 acten75;	// size=3, type=cont, imputationVar=xacten75, act english 75th percentile score
		STRING xactmt25;
		INTEGER8 actmt25;	// size=3, type=cont, imputationVar=xactmt25, act math 25th percentile score
		STRING xactmt75;
		INTEGER8 actmt75;	// size=3, type=cont, imputationVar=xactmt75, act math 75th percentile score
		STRING xactwr25;
		INTEGER8 actwr25;	// size=3, type=cont, imputationVar=xactwr25, act writing 25th percentile score
		STRING xactwr75;
		INTEGER8 actwr75;	// size=3, type=cont, imputationVar=xactwr75, act writing 75th percentile score
	END;
	
	EXPORT load(UNSIGNED pYear) := FUNCTION
		File_In := localDataFile( pYear );
		File_Out := logicalFilename( pYear );
		DS_In := DATASET(std.File.ExternalLogicalFilename(mLandingZoneIP, File_In), raw_layout, CSV(HEADING(1), SEPARATOR([',']), QUOTE(['"']), TERMINATOR(['\n','\r\n','\n\r'])));
		DS_Dist := DISTRIBUTE(DS_In, HASH(unitid));
		RETURN OUTPUT(DS_Dist,, File_Out, OVERWRITE);
	END;



	EXPORT dsRaw(UNSIGNED pYear) := DATASET( logicalFilename( pYear ), raw_layout, THOR, OPT );
	
END;