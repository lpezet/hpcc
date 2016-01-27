IMPORT Std;

IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;


EXPORT DirectoryInformation := MODULE

	SHARED mLandingZoneIP := 'localhost';
	SHARED mLocalPath := '/var/lib/HPCCSystems/mydropzone/NCES/IPEDS/DI/';
	
	SHARED localArchive(UNSIGNED pYear) := mLocalPath + 'HD' + pYear + '.zip';
	SHARED localDataFile(UNSIGNED pYear) := mLocalPath + 'hd' + pYear + '.csv';
	EXPORT logicalFilename(UNSIGNED pYear) := '~nces::ipeds::di::' + pYear;
	
	EXPORT extract(UNSIGNED pYear) := FUNCTION
		oLocalFile := localArchive( pYear );
		RETURN SEQUENTIAL(
			#OPTION('targetClusterType','hthor'),
			OUTPUT( BinUtils.mkdir( mLocalPath, true ), NAMED('CreatePath')),
			OUTPUT( Curl.download('http://nces.ed.gov/ipeds/datacenter/data/HD' + pYear + '.zip', oLocalFile, false), NAMED('Download')),
			OUTPUT( BinUtils.checksum( oLocalFile ), NAMED('Checksum')),
			OUTPUT( Zip.unzip(oLocalFile, mLocalPath, true), NAMED('Unzipping')),
		);
	END;
	
	EXPORT raw_layout := RECORD
		INTEGER8 unitid;
		STRING instnm;
		STRING addr;
		STRING city;
		STRING stabbr;
		STRING zip;
		INTEGER8 fips;
		INTEGER8 obereg;
		STRING chfnm;
		STRING chftitle;
		STRING gentele;
		STRING ein;
		STRING opeid;
		INTEGER8 opeflag;
		STRING webaddr;
		STRING adminurl;
		STRING faidurl;
		STRING applurl;
		STRING npricurl;
		STRING veturl;
		STRING athurl;
		INTEGER8 sector;
		INTEGER8 iclevel;
		INTEGER8 control;
		INTEGER8 hloffer;
		INTEGER8 ugoffer;
		INTEGER8 groffer;
		INTEGER8 hdegofr1;
		INTEGER8 deggrant;
		INTEGER8 hbcu;
		INTEGER8 hospital;
		INTEGER8 medical;
		INTEGER8 tribal;
		INTEGER8 locale;
		INTEGER8 openpubl;
		STRING act;
		INTEGER8 newid;
		INTEGER8 deathyr;
		STRING closedat;
		INTEGER8 cyactive;
		INTEGER8 postsec;
		INTEGER8 pseflag;
		INTEGER8 pset4flg;
		INTEGER8 rptmth;
		STRING ialias;
		INTEGER8 instcat;
		INTEGER8 ccbasic;
		INTEGER8 ccipug;
		INTEGER8 ccipgrad;
		INTEGER8 ccugprof;
		INTEGER8 ccenrprf;
		INTEGER8 ccsizset;
		INTEGER8 carnegie;
		INTEGER8 landgrnt;
		INTEGER8 instsize;
		INTEGER8 cbsa;
		INTEGER8 cbsatype;
		INTEGER8 csa;
		INTEGER8 necta;
		INTEGER8 f1systyp;
		STRING f1sysnam;
		STRING f1syscod;
		INTEGER8 countycd;
		STRING countynm;
		INTEGER8 cngdstcd;
		DECIMAL9_6 longitud;
		DECIMAL9_6 latitude;
		INTEGER8 dfrcgid;
		INTEGER8 dfrcuscg;
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