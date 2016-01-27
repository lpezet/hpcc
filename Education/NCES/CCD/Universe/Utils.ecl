IMPORT Std;

IMPORT Linux.Curl;
IMPORT Linux.BinUtils;





ParseLayout := MACRO

	oLayoutUrl := 'https://nces.ed.gov/ccd/Data/txt/sc131alay.txt';
	oLocalFile := '/var/lib/HPCCSystems/mydropzone/sc131alay.txt';

	// 1. Download file
	//Curl.download( oLayoutUrl, oLocalFile, true );
	
	oDS := BinUtils.cat( oLocalFile );
	oDS;
	oVariablesAndMore := oDS[32..];



	//Basic patterns:
	PATTERN var := PATTERN('[a-zA-Z0-9]')+;
	//all alphanumeric & certain special characters
	PATTERN ws := [' ','\t']+; //word separators (space & tab)
	PATTERN position := PATTERN('[0-9]')+; //numbers

	//extended patterns:
	PATTERN var_type := PATTERN('AN');
	PATTERN desc := PATTERN('.')+;
	//extended pattern to parse the actual text:
	PATTERN line_layout := OPT('+') var ws position ws var_type ws desc; // position ws var_type ws desc;

	layout := RECORD
		STRING var_t := 'STRING';
		STRING var_n := Std.Str.ToLowerCase( MATCHTEXT( var ) );
		STRING eol := '; //';
		STRING extra_pos := 'pos=' + MATCHTEXT(position);
		STRING extra_var_t := ', type=' + MATCHTEXT(var_type);
		STRING extra_desc := ', desc=' + MATCHTEXT(desc);
	END;



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
	 
	 
	//PARSE( oVariablesAndMore, line, line_layout, layout, FIRST);
 
ENDMACRO;


ParseLayout();