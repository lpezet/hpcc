IMPORT Std;

IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;


EXPORT Finance := MODULE

	SHARED mLandingZoneIP := 'localhost';
	SHARED mLocalPath := '/var/lib/HPCCSystems/mydropzone/NCES/IPEDS/FI/';
	
	SHARED from_date(UNSIGNED y) := INTFORMAT((y-1) - ((y - 1) DIV 100) * 100, 2, 1);
	SHARED to_date(UNSIGNED y) := INTFORMAT(y - (y DIV 100) * 100, 2, 1);

	SHARED filename(UNSIGNED pYear, STRING pType) := 'F' + from_date( pYear ) + to_date( pYear ) + '_' + pType;
	
	SHARED localArchive(UNSIGNED pYear, STRING pType) := mLocalPath + filename( pYear, pType ) + '.zip';
	SHARED localDataFile(UNSIGNED pYear, STRING pType) := mLocalPath + Std.Str.ToLowerCase( filename( pYear, pType ) ) + '.csv';
	EXPORT logicalFilename(UNSIGNED pYear, STRING pType) := '~nces::ipeds::fi::' + pYear + '::' + pType;
	
	EXPORT extract(UNSIGNED pYear, STRING pType) := FUNCTION
		oLocalFile := localArchive( pYear, pType );
		RETURN SEQUENTIAL(
			#OPTION('targetClusterType','hthor'),
			OUTPUT( BinUtils.mkdir( mLocalPath, true ), NAMED('CreatePath')),
			OUTPUT( Curl.download('http://nces.ed.gov/ipeds/datacenter/data/' + filename( pYear, pType ) + '.zip', oLocalFile, false), NAMED('Download')),
			OUTPUT( BinUtils.checksum( oLocalFile ), NAMED('Checksum')),
			OUTPUT( Zip.unzip(oLocalFile, mLocalPath, true), NAMED('Unzipping')),
		);
	END;

	// Regex
	// ^(.*)\tn\t([0-9]+)\t([^\t]+)\t([^\t]*)\t(.*)
	// STRING $4;\nINTEGER8 $1;\t// size=$2, type=$3, imputationVar=$4, $5
	
	EXPORT raw_layout := RECORD
		INTEGER8 unitid;	// size=6, type=cont, imputationVar=, unique identification number of the institution
		STRING xf1a01;
		INTEGER8 f1a01;		// size=12, type=cont, imputationVar=xf1a01, total current assets
		STRING xf1a31;
		INTEGER8 f1a31;		// size=12, type=cont, imputationVar=xf1a31, depreciable capital assets, net of depreciation
		STRING xf1a04;
		INTEGER8 f1a04;		// size=12, type=cont, imputationVar=xf1a04, other noncurrent assets
		STRING xf1a05;
		INTEGER8 f1a05;		// size=12, type=cont, imputationVar=xf1a05, total noncurrent assets
		STRING xf1a06;
		INTEGER8 f1a06;		// size=12, type=cont, imputationVar=xf1a06, total assets
		STRING xf1a07;
		INTEGER8 f1a07;		// size=12, type=cont, imputationVar=xf1a07, long-term debt, current portion
		STRING xf1a08;
		INTEGER8 f1a08;		// size=12, type=cont, imputationVar=xf1a08, other current liabilities
		STRING xf1a09;
		INTEGER8 f1a09;		// size=12, type=cont, imputationVar=xf1a09, total current liabilities
		STRING xf1a10;
		INTEGER8 f1a10;		// size=12, type=cont, imputationVar=xf1a10, long-term debt
		STRING xf1a11;
		INTEGER8 f1a11;		// size=12, type=cont, imputationVar=xf1a11, other noncurrent liabilities
		STRING xf1a12;
		INTEGER8 f1a12;		// size=12, type=cont, imputationVar=xf1a12, total noncurrent liabilities
		STRING xf1a13;
		INTEGER8 f1a13;		// size=12, type=cont, imputationVar=xf1a13, total liabilities
		STRING xf1a14;
		INTEGER8 f1a14;		// size=12, type=cont, imputationVar=xf1a14, invested in capital assets, net of related debt
		STRING xf1a15;
		INTEGER8 f1a15;		// size=12, type=cont, imputationVar=xf1a15, restricted-expendable
		STRING xf1a16;
		INTEGER8 f1a16;		// size=12, type=cont, imputationVar=xf1a16, restricted-nonexpendable
		STRING xf1a17;
		INTEGER8 f1a17;		// size=12, type=cont, imputationVar=xf1a17, unrestricted
		STRING xf1a18;
		INTEGER8 f1a18;		// size=12, type=cont, imputationVar=xf1a18, total net assets
		STRING xf1a214;
		INTEGER8 f1a214;	// size=12, type=cont, imputationVar=xf1a214, land  improvements - ending balance
		STRING xf1a224;
		INTEGER8 f1a224;	// size=12, type=cont, imputationVar=xf1a224, infrastructure - ending balance
		STRING xf1a234;
		INTEGER8 f1a234;	// size=12, type=cont, imputationVar=xf1a234, buildings - ending balance
		STRING xf1a324;
		INTEGER8 f1a324;	// size=12, type=cont, imputationVar=xf1a324, equipment, including art and library collections - ending balance
		STRING xf1a274;
		INTEGER8 f1a274;	// size=12, type=cont, imputationVar=xf1a274, construction in progress - ending balance
		STRING xf1a27t4;
		INTEGER8 f1a27t4;	// size=12, type=cont, imputationVar=xf1a27t4, total for plant, property and equipment - ending balance
		STRING xf1a284;
		INTEGER8 f1a284;	// size=12, type=cont, imputationVar=xf1a284, accumulated depreciation - ending balance
		STRING xf1a334;
		INTEGER8 f1a334;	// size=12, type=cont, imputationVar=xf1a334, intangible assets , net of accumulated amortization - ending balance
		STRING xf1a344;
		INTEGER8 f1a344;	// size=12, type=cont, imputationVar=xf1a344, other capital assets - ending balance (new aligned)
		STRING xf1b01;
		INTEGER8 f1b01;		// size=12, type=cont, imputationVar=xf1b01, tuition and fees, after deducting discounts and allowances
		STRING xf1b02;
		INTEGER8 f1b02;		// size=12, type=cont, imputationVar=xf1b02, federal operating grants and contracts
		STRING xf1b03;
		INTEGER8 f1b03;		// size=12, type=cont, imputationVar=xf1b03, state operating grants and contracts
		STRING xf1b04;
		INTEGER8 f1b04;		// size=12, type=cont, imputationVar=xf1b04, local/private operating grants and contracts
		STRING xf1b04a;
		INTEGER8 f1b04a;	// size=12, type=cont, imputationVar=xf1b04a, local operating grants and contracts
		STRING xf1b04b;
		INTEGER8 f1b04b;	// size=12, type=cont, imputationVar=xf1b04b, private operating grants and contracts
		STRING xf1b05;
		INTEGER8 f1b05;		// size=12, type=cont, imputationVar=xf1b05, sales and services of auxiliary enterprises
		STRING xf1b06;
		INTEGER8 f1b06;		// size=12, type=cont, imputationVar=xf1b06, sales and services of hospitals
		STRING xf1b26;
		INTEGER8 f1b26;		// size=12, type=cont, imputationVar=xf1b26, sales and services of educational activities
		STRING xf1b07;
		INTEGER8 f1b07;		// size=12, type=cont, imputationVar=xf1b07, independent operations
		STRING xf1b08;
		INTEGER8 f1b08;		// size=12, type=cont, imputationVar=xf1b08, other sources - operating
		STRING xf1b09;
		INTEGER8 f1b09;		// size=12, type=cont, imputationVar=xf1b09, total operating revenues
		STRING xf1b10;
		INTEGER8 f1b10;		// size=12, type=cont, imputationVar=xf1b10, federal appropriations
		STRING xf1b11;
		INTEGER8 f1b11;		// size=12, type=cont, imputationVar=xf1b11, state appropriations
		STRING xf1b12;
		INTEGER8 f1b12;		// size=12, type=cont, imputationVar=xf1b12, local appropriations, education district taxes, and similar support
		STRING xf1b13;
		INTEGER8 f1b13;		// size=12, type=cont, imputationVar=xf1b13, federal nonoperating grants
		STRING xf1b14;
		INTEGER8 f1b14;		// size=12, type=cont, imputationVar=xf1b14, state nonoperating grants
		STRING xf1b15;
		INTEGER8 f1b15;		// size=12, type=cont, imputationVar=xf1b15, local nonoperating grants
		STRING xf1b16;
		INTEGER8 f1b16;		// size=12, type=cont, imputationVar=xf1b16, gifts, including contributions from affiliated organizations
		STRING xf1b17;
		INTEGER8 f1b17;		// size=12, type=cont, imputationVar=xf1b17, investment income
		STRING xf1b18;
		INTEGER8 f1b18;		// size=12, type=cont, imputationVar=xf1b18, other nonoperating revenues
		STRING xf1b19;
		INTEGER8 f1b19;		// size=12, type=cont, imputationVar=xf1b19, total nonoperating revenues
		STRING xf1b27;
		INTEGER8 f1b27;		// size=12, type=cont, imputationVar=xf1b27, total operating and nonoperating revenues
		STRING xf1b20;
		INTEGER8 f1b20;		// size=12, type=cont, imputationVar=xf1b20, capital appropriations
		STRING xf1b21;
		INTEGER8 f1b21;		// size=12, type=cont, imputationVar=xf1b21, capital grants and gifts
		STRING xf1b22;
		INTEGER8 f1b22;		// size=12, type=cont, imputationVar=xf1b22, additions to permanent endowments
		STRING xf1b23;
		INTEGER8 f1b23;		// size=12, type=cont, imputationVar=xf1b23, other revenues and additions
		STRING xf1b24;
		INTEGER8 f1b24;		// size=12, type=cont, imputationVar=xf1b24, total other revenues and additions
		STRING xf1b25;
		INTEGER8 f1b25;		// size=12, type=cont, imputationVar=xf1b25, total all revenues and other additions
		STRING xf1c011;
		INTEGER8 f1c011;	// size=12, type=cont, imputationVar=xf1c011, instruction - current year total
		STRING xf1c012;
		INTEGER8 f1c012;	// size=12, type=cont, imputationVar=xf1c012, instruction - salaries and wages
		STRING xf1c013;
		INTEGER8 f1c013;	// size=12, type=cont, imputationVar=xf1c013, instruction - employee fringe benefits
		STRING xf1c016;
		INTEGER8 f1c016;	// size=12, type=cont, imputationVar=xf1c016, instruction - operations and maintenance of plant
		STRING xf1c014;
		INTEGER8 f1c014;	// size=12, type=cont, imputationVar=xf1c014, instruction - depreciation
		STRING xf1c017;
		INTEGER8 f1c017;	// size=12, type=cont, imputationVar=xf1c017, instruction - interest
		STRING xf1c015;
		INTEGER8 f1c015;	// size=12, type=cont, imputationVar=xf1c015, instruction - all other
		STRING xf1c021;
		INTEGER8 f1c021;	// size=12, type=cont, imputationVar=xf1c021, research - current year total
		STRING xf1c022;
		INTEGER8 f1c022;	// size=12, type=cont, imputationVar=xf1c022, research - salaries and wages
		STRING xf1c023;
		INTEGER8 f1c023;	// size=12, type=cont, imputationVar=xf1c023, research - employee fringe benefits
		STRING xf1c026;
		INTEGER8 f1c026;	// size=12, type=cont, imputationVar=xf1c026, research - operations and maintenance of plant
		STRING xf1c024;
		INTEGER8 f1c024;	// size=12, type=cont, imputationVar=xf1c024, research - depreciation
		STRING xf1c027;
		INTEGER8 f1c027;	// size=12, type=cont, imputationVar=xf1c027, research - interest
		STRING xf1c025;
		INTEGER8 f1c025;	// size=12, type=cont, imputationVar=xf1c025, research - all other
		STRING xf1c031;
		INTEGER8 f1c031;	// size=12, type=cont, imputationVar=xf1c031, public service - current year total
		STRING xf1c032;
		INTEGER8 f1c032;	// size=12, type=cont, imputationVar=xf1c032, public service - salaries and wages
		STRING xf1c033;
		INTEGER8 f1c033;	// size=12, type=cont, imputationVar=xf1c033, public service - employee fringe benefits
		STRING xf1c036;
		INTEGER8 f1c036;	// size=12, type=cont, imputationVar=xf1c036, public service - operations and maintenance of plant
		STRING xf1c034;
		INTEGER8 f1c034;	// size=12, type=cont, imputationVar=xf1c034, public service - depreciation
		STRING xf1c037;
		INTEGER8 f1c037;	// size=12, type=cont, imputationVar=xf1c037, public service - interest
		STRING xf1c035;
		INTEGER8 f1c035;	// size=12, type=cont, imputationVar=xf1c035, public service - all other
		STRING xf1c051;
		INTEGER8 f1c051;	// size=12, type=cont, imputationVar=xf1c051, academic support - current year total
		STRING xf1c052;
		INTEGER8 f1c052;	// size=12, type=cont, imputationVar=xf1c052, academic support - salaries and wages
		STRING xf1c053;
		INTEGER8 f1c053;	// size=12, type=cont, imputationVar=xf1c053, academic support - employee fringe benefits
		STRING xf1c056;
		INTEGER8 f1c056;	// size=12, type=cont, imputationVar=xf1c056, academic support - operations and maintenance of plant
		STRING xf1c054;
		INTEGER8 f1c054;	// size=12, type=cont, imputationVar=xf1c054, academic support - depreciation
		STRING xf1c057;
		INTEGER8 f1c057;	// size=12, type=cont, imputationVar=xf1c057, academic support - interest
		STRING xf1c055;
		INTEGER8 f1c055;	// size=12, type=cont, imputationVar=xf1c055, academic support - all other
		STRING xf1c061;
		INTEGER8 f1c061;	// size=12, type=cont, imputationVar=xf1c061, student services - current year total
		STRING xf1c062;
		INTEGER8 f1c062;	// size=12, type=cont, imputationVar=xf1c062, student services - salaries and wages
		STRING xf1c063;
		INTEGER8 f1c063;	// size=12, type=cont, imputationVar=xf1c063, student services - employee fringe benefits
		STRING xf1c066;
		INTEGER8 f1c066;	// size=12, type=cont, imputationVar=xf1c066, student services - operations and maintenance of plant
		STRING xf1c064;
		INTEGER8 f1c064;	// size=12, type=cont, imputationVar=xf1c064, student services - depreciation
		STRING xf1c067;
		INTEGER8 f1c067;	// size=12, type=cont, imputationVar=xf1c067, student services - interest
		STRING xf1c065;
		INTEGER8 f1c065;	// size=12, type=cont, imputationVar=xf1c065, student services - all other
		STRING xf1c071;
		INTEGER8 f1c071;	// size=12, type=cont, imputationVar=xf1c071, institutional support - current year total
		STRING xf1c072;
		INTEGER8 f1c072;	// size=12, type=cont, imputationVar=xf1c072, institutional support - salaries and wages
		STRING xf1c073;
		INTEGER8 f1c073;	// size=12, type=cont, imputationVar=xf1c073, institutional support - employee fringe benefits
		STRING xf1c076;
		INTEGER8 f1c076;	// size=12, type=cont, imputationVar=xf1c076, institutional support - operations and maintenance of plant
		STRING xf1c074;
		INTEGER8 f1c074;	// size=12, type=cont, imputationVar=xf1c074, institutional support - depreciation
		STRING xf1c077;
		INTEGER8 f1c077;	// size=12, type=cont, imputationVar=xf1c077, institutional support - interest
		STRING xf1c075;
		INTEGER8 f1c075;	// size=12, type=cont, imputationVar=xf1c075, institutional support - all other
		STRING xf1c081;
		INTEGER8 f1c081;	// size=12, type=cont, imputationVar=xf1c081, operation  maintenance of plant - current year total
		STRING xf1c082;
		INTEGER8 f1c082;	// size=12, type=cont, imputationVar=xf1c082, operation  maintenance of plant - salaries and wages
		STRING xf1c083;
		INTEGER8 f1c083;	// size=12, type=cont, imputationVar=xf1c083, operation  maintenance of plant - employee fringe benefits
		STRING xf1c086;
		INTEGER8 f1c086;	// size=12, type=cont, imputationVar=xf1c086, operation maintenance of plant - operation and maintenance of plant
		STRING xf1c084;
		INTEGER8 f1c084;	// size=12, type=cont, imputationVar=xf1c084, operation  maintenance of plant - depreciation
		STRING xf1c087;
		INTEGER8 f1c087;	// size=12, type=cont, imputationVar=xf1c087, operation maintenance of plant - interest
		STRING xf1c085;
		INTEGER8 f1c085;	// size=12, type=cont, imputationVar=xf1c085, operation  maintenance of plant - all other
		STRING xf1c101;
		INTEGER8 f1c101;	// size=12, type=cont, imputationVar=xf1c101, scholarships and fellowships expenses -- current year total
		STRING xf1c105;
		INTEGER8 f1c105;	// size=12, type=cont, imputationVar=xf1c105, scholarships and fellowships expenses -- all other
		STRING xf1c111;
		INTEGER8 f1c111;	// size=12, type=cont, imputationVar=xf1c111, auxiliary enterprises -- current year total
		STRING xf1c112;
		INTEGER8 f1c112;	// size=12, type=cont, imputationVar=xf1c112, auxiliary enterprises -- salaries and wages
		STRING xf1c113;
		INTEGER8 f1c113;	// size=12, type=cont, imputationVar=xf1c113, auxiliary enterprises -- employee fringe benefits
		STRING xf1c116;
		INTEGER8 f1c116;	// size=12, type=cont, imputationVar=xf1c116, auxiliary enterprises -  operations and maintenance of plant
		STRING xf1c114;
		INTEGER8 f1c114;	// size=12, type=cont, imputationVar=xf1c114, auxiliary enterprises -- depreciation
		STRING xf1c117;
		INTEGER8 f1c117;	// size=12, type=cont, imputationVar=xf1c117, auxiliary enterprises - interest
		STRING xf1c115;
		INTEGER8 f1c115;	// size=12, type=cont, imputationVar=xf1c115, auxiliary enterprises -- all other
		STRING xf1c121;
		INTEGER8 f1c121;	// size=12, type=cont, imputationVar=xf1c121, hospital services - current year total
		STRING xf1c122;
		INTEGER8 f1c122;	// size=12, type=cont, imputationVar=xf1c122, hospital services - salaries and wages
		STRING xf1c123;
		INTEGER8 f1c123;	// size=12, type=cont, imputationVar=xf1c123, hospital services - employee fringe benefits
		STRING xf1c126;
		INTEGER8 f1c126;	// size=12, type=cont, imputationVar=xf1c126, hospital services -  operations and maintenance of plant
		STRING xf1c124;
		INTEGER8 f1c124;	// size=12, type=cont, imputationVar=xf1c124, hospital services - depreciation
		STRING xf1c127;
		INTEGER8 f1c127;	// size=12, type=cont, imputationVar=xf1c127, hospital services - interest
		STRING xf1c125;
		INTEGER8 f1c125;	// size=12, type=cont, imputationVar=xf1c125, hospital services - all other
		STRING xf1c131;
		INTEGER8 f1c131;	// size=12, type=cont, imputationVar=xf1c131, independent operations - current year total
		STRING xf1c132;
		INTEGER8 f1c132;	// size=12, type=cont, imputationVar=xf1c132, independent operations - salaries and wages
		STRING xf1c133;
		INTEGER8 f1c133;	// size=12, type=cont, imputationVar=xf1c133, independent operations - employee fringe benefits
		STRING xf1c136;
		INTEGER8 f1c136;	// size=12, type=cont, imputationVar=xf1c136, independent operations -  operations and maintenance of plant
		STRING xf1c134;
		INTEGER8 f1c134;	// size=12, type=cont, imputationVar=xf1c134, independent operations - depreciation
		STRING xf1c137;
		INTEGER8 f1c137;	// size=12, type=cont, imputationVar=xf1c137, independent operations - interest
		STRING xf1c135;
		INTEGER8 f1c135;	// size=12, type=cont, imputationVar=xf1c135, independent operations - all other
		STRING xf1c141;
		INTEGER8 f1c141;	// size=12, type=cont, imputationVar=xf1c141, other expenses  deductions - current year total
		STRING xf1c142;
		INTEGER8 f1c142;	// size=12, type=cont, imputationVar=xf1c142, other expenses  deductions - salaries and wages
		STRING xf1c143;
		INTEGER8 f1c143;	// size=12, type=cont, imputationVar=xf1c143, other expenses  deductions - employee fringe benefits
		STRING xf1c146;
		INTEGER8 f1c146;	// size=12, type=cont, imputationVar=xf1c146, other expenses deductions -  operations and maintenance of plant
		STRING xf1c144;
		INTEGER8 f1c144;	// size=12, type=cont, imputationVar=xf1c144, other expenses  deductions - depreciation
		STRING xf1c147;
		INTEGER8 f1c147;	// size=12, type=cont, imputationVar=xf1c147, other expenses deductions - interest
		STRING xf1c145;
		INTEGER8 f1c145;	// size=12, type=cont, imputationVar=xf1c145, other expenses  deductions - all other
		STRING xf1c191;
		INTEGER8 f1c191;	// size=12, type=cont, imputationVar=xf1c191, total expenses  deductions - current year total
		STRING xf1c192;
		INTEGER8 f1c192;	// size=12, type=cont, imputationVar=xf1c192, total expenses  deductions - salaries and wages
		STRING xf1c193;
		INTEGER8 f1c193;	// size=12, type=cont, imputationVar=xf1c193, total expenses  deductions - employee fringe benefits
		STRING xf1c196;
		INTEGER8 f1c196;	// size=12, type=cont, imputationVar=xf1c196, total expenses deductions - operations and maintenance of plant
		STRING xf1c194;
		INTEGER8 f1c194;	// size=12, type=cont, imputationVar=xf1c194, total expenses  deductions - depreciation
		STRING xf1c197;
		INTEGER8 f1c197;	// size=12, type=cont, imputationVar=xf1c197, total expenses deductions - interest
		STRING xf1c195;
		INTEGER8 f1c195;	// size=12, type=cont, imputationVar=xf1c195, total expenses  deductions - all other
		STRING xf1d01;
		INTEGER8 f1d01;		// size=12, type=cont, imputationVar=xf1d01, total revenues and other additions
		STRING xf1d02;
		INTEGER8 f1d02;		// size=12, type=cont, imputationVar=xf1d02, total expenses and other deductions
		STRING xf1d03;
		INTEGER8 f1d03;		// size=12, type=cont, imputationVar=xf1d03, change in net position during the year
		STRING xf1d04;
		INTEGER8 f1d04;		// size=12, type=cont, imputationVar=xf1d04, net position beginning of year
		STRING xf1d05;
		INTEGER8 f1d05;		// size=12, type=cont, imputationVar=xf1d05, adjustments to beginning net position
		STRING xf1d06;
		INTEGER8 f1d06;		// size=12, type=cont, imputationVar=xf1d06, net position end of year
		STRING xf1e01;
		INTEGER8 f1e01;		// size=12, type=cont, imputationVar=xf1e01, pell grants (federal)
		STRING xf1e02;
		INTEGER8 f1e02;		// size=12, type=cont, imputationVar=xf1e02, other federal grants
		STRING xf1e03;
		INTEGER8 f1e03;		// size=12, type=cont, imputationVar=xf1e03, grants by state government
		STRING xf1e04;
		INTEGER8 f1e04;		// size=12, type=cont, imputationVar=xf1e04, grants by local government
		STRING xf1e05;
		INTEGER8 f1e05;		// size=12, type=cont, imputationVar=xf1e05, institutional grants from restricted resources
		STRING xf1e06;
		INTEGER8 f1e06;		// size=12, type=cont, imputationVar=xf1e06, institutional grants from unrestricted resources
		STRING xf1e07;
		INTEGER8 f1e07;		// size=12, type=cont, imputationVar=xf1e07, total gross scholarships and fellowships
		STRING xf1e08;
		INTEGER8 f1e08;		// size=12, type=cont, imputationVar=xf1e08, discounts and allowances applied to tuition and fees
		STRING xf1e09;
		INTEGER8 f1e09;		// size=12, type=cont, imputationVar=xf1e09, discounts and allowances applied to sales & services of auxiliary enterprises
		STRING xf1e10;
		INTEGER8 f1e10;		// size=12, type=cont, imputationVar=xf1e10, total discounts and allowances
		STRING xf1e11;
		INTEGER8 f1e11;		// size=12, type=cont, imputationVar=xf1e11, net scholarships and fellowship expenses
		INTEGER8 f1fha;		// size=2, type=disc, imputationVar=, does this institution or any of its foundations or other affiliated organizations own endowment assets ?
		INTEGER8 f1h01;		// size=12, type=cont, imputationVar=xf1h01, value of endowment assets at the beginning of the fiscal year
		INTEGER8 f1h02;		// size=12, type=cont, imputationVar=xf1h02, value of endowment assets at the end of the fiscal year
	END;
	
	EXPORT load(UNSIGNED pYear, STRING pType) := FUNCTION
		File_In := localDataFile( pYear, pType );
		File_Out := logicalFilename( pYear, pType );
		DS_In := DATASET(std.File.ExternalLogicalFilename(mLandingZoneIP, File_In), raw_layout, CSV(HEADING(1), SEPARATOR([',']), QUOTE(['"']), TERMINATOR(['\n','\r\n','\n\r'])));
		DS_Dist := DISTRIBUTE(DS_In, HASH(unitid));
		RETURN OUTPUT(DS_Dist,, File_Out, OVERWRITE);
	END;


	EXPORT dsRaw(UNSIGNED pYear, STRING pType) := DATASET( logicalFilename( pYear, pType ), raw_layout, THOR, OPT);

END;