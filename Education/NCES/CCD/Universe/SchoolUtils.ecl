IMPORT Std;


IMPORT Linux.Curl;
IMPORT Linux.BinUtils;


EXPORT SchoolUtils := MODULE

	SHARED mLandingZoneIP := 'localhost';
	SHARED mLocalPath := '/var/lib/HPCCSystems/mydropzone/NCES/CCD/Layouts/';
	
	SHARED downloadUrl(UNSIGNED pYear) := CASE(pYear,
		2013 => 'https://nces.ed.gov/ccd/Data/txt/',
		2012 => 'https://nces.ed.gov/ccd/Data/txt/',
		2011 => 'https://nces.ed.gov/ccd/Data/txt/',
		2010 => 'https://nces.ed.gov/ccd/Data/txt/',
		2009 => 'https://nces.ed.gov/ccd/data/txt/',
		2008 => 'https://nces.ed.gov/ccd/data/txt/',
		2007 => 'https://nces.ed.gov/ccd/data/txt/',
		'');
	
	EXPORT downloadFile(UNSIGNED pYear) := CASE(pYear,
		2013 => 'sc131alay.txt',
		2012 => 'sc121alay_2.txt',
		2011 => 'sc111alay.txt',
		2010 => 'psu102alay.txt',
		2009 => 'psu092alay.txt',
		2008 => 'psu081blay.txt',
		2007 => 'psu071blay.txt',
		'');


	EXPORT downloadLayout(UNSIGNED pYear) := FUNCTION
		oLocalFile := mLocalPath + downloadFile( pYear );
		oDownloadUrl := downloadUrl( pYear ) + downloadFile( pYear );
		//RETURN oDownloadUrl;
		RETURN SEQUENTIAL(
			#OPTION('targetClusterType','hthor'),
			OUTPUT( BinUtils.mkdir( mLocalPath, true ), NAMED('CreatePath')),
			OUTPUT(Curl.download( oDownloadUrl, oLocalFile, true ), NAMED('Download')),
			OUTPUT(BinUtils.cat( oLocalFile ), NAMED('Content'))
		);
	END;
	
	
	EXPORT parseLayout(UNSIGNED pYear, UNSIGNED pSkipLines) := FUNCTION
		oLocalFile := mLocalPath + downloadFile( pYear );
		oDS := BinUtils.cat( oLocalFile )[pSkipLines..];
		
		//Basic patterns:
		PATTERN var := PATTERN('[_a-zA-Z0-9]')+;
		//all alphanumeric & certain special characters
		PATTERN ws := [' ','\t']+; //word separators (space & tab)
		PATTERN position := PATTERN('[0-9]')+; //numbers

		//extended patterns:
		PATTERN var_type := ['AN', 'N']; //OPT('A') PATTERN('N');
		PATTERN desc := PATTERN('.')+;
		//extended pattern to parse the actual text:
		PATTERN line_layout := OPT('+') var ws position OPT(['*','^']) ws var_type ws desc ws;
		
		layout := RECORD
			STRING var_t := 'STRING';
			STRING var_n := Std.Str.ToLowerCase( MATCHTEXT( var ) );
			STRING eol := '; //';
			STRING extra_pos := 'pos=' + MATCHTEXT(position);
			STRING extra_var_t := ', type=' + MATCHTEXT(var_type);
			STRING extra_desc := ', desc=' + MATCHTEXT(desc);
		END;
		
		/*
		input_layout := RECORD
			STRING10000 line;
		END;
		oTestDS := DATASET([
			{'SURVYEAR      1	     AN	    Year corresponding to survey record.'},
			{''},
			{'NCESSCH       2      AN     Unique NCES public school ID (7-digit NCES agency ID (LEAID) + 5-digit NCES school ID (SCHNO).' },
			{''},
			{'+FIPST        3      AN     American National Standards Institute (ANSI) state code.'}
			], input_layout);
		//PARSE( oTestDS, line, line_layout, layout, FIRST);
		*/ 
		 
		RETURN PARSE( oDS, line, line_layout, layout, FIRST);
		//RETURN oDS;
	END;
	
END;