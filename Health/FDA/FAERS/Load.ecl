// http://www.fda.gov/Drugs/GuidanceComplianceRegulatoryInformation/Surveillance/AdverseDrugEffects/ucm082193.htm
// Extract quaterly file, then look at ascii/ASC_NTS.pdf doc, for definition of fields for each file.
IMPORT Std;

EXPORT Load := MODULE

	SHARED raw_demo_layout := RECORD
		STRING primary_id;					// Unique number for identifying a FAERS report. This is the primary link field (primary key) between data files (example: 31234561). This is a concatenated key of Case ID and Case Version Number. It is the Identifier for the case sequence (version) number as reported by the manufacturer.
		STRING case_id; 						// Number for identifying a FAERS case.
		STRING case_version; 			// Safety Report Version Number.  The Initial Case will be version 1;   follow-ups to the case will have sequentially incremented version   numbers (for example, 2, 3, 4, etc.).
		STRING i_f_cod; 					// Code for initial or follow-up status of report, as reported by manufacturer: I=Initial, F=Follow-up
		STRING event_dt;					// Date the adverse event occurred or began. (YYYYMMDD format) – If a complete date is not available, a partial date is provided. See the   NOTE on dates at the end of this section.
		STRING mfr_dt; 						// Date manufacturer first received initial information. In subsequent   versions of a case, the latest manufacturer received date will be   provided (YYYYMMDD format). If a complete date is not available, a   partial date will be provided. See the NOTE on dates at the end of   this section.
    STRING init_fda_dt; 			// Date FDA received first version (Initial) of Case (YYYYMMDD format)
    STRING fda_dt; 						// Date FDA received Case. In subsequent versions of a case, the latest   manufacturer received date will be provided (YYYYMMDD format).
    STRING rept_cod;					// Code for the type of report submitted (See table below) Also, see Section E, End Note below. EXP=Expedited (15-Day), PER=Periodic (Non-Expedited), DIR=Direct
		STRING auth_num;					// Regulatory Authority’s case report number, when available. + New tag added in 2014Q3 extract.
		STRING mfr_num;						// Manufacturer's unique report identifier.
    STRING mrf_sndr;					// Coded name of manufacturer sending report; if not found, then verbatim name of organization sending report.
    STRING lit_ref;						// Literature Reference information, when available; populatedwith last 500 characters if >500 characters are available. + New tag added in 2014Q3 extract.
		STRING age;								// Numeric value of patient's age at event.
    STRING age_cod;						// Unit abbreviation for patient's age: DEC=DECADE, YR=YEAR, MON=MONTH, WK=WEEK, DY=DAY, HR=HOUR
		STRING age_grp;						// Patient Age Group code as follows, when available: N=Neonate, I=Infant, C=Child, T=Adolescent, A=Adult, E=Elderly. + New tag added in 2014Q3 extract.
		STRING sex; 							// Code for patient's sex: UNK=Unknown, M=Male, F=Female
		STRING e_sub;							// Whether (Y/N) this report was submitted under the electronic submissions procedure for manufacturers.
		STRING wt;								// Numeric value of patient's weight.
		STRING wt_cod;						// Unit abbreviation for patient's weight: KG=Kilograms, LBS=Pounds, GMS=Grams
		STRING rept_dt;					// Date report was sent (YYYYMMDD format). If a complete date is not   available, a partial date is provided. See the NOTE on dates at the   end of this section.
		STRING to_mfr;						// Whether (Y/N) voluntary reporter also notified manufacturer (blank   for manufacturer reports).
		STRING occp_cod;					// Abbreviation for the reporter's type of occupation in the latest    version of a case. MD=Physician, PH=Pharmacist, OT=Other health-professional, LW=Lawyer, CN=Consumer
		STRING reporter_country;	// The country of the reporter in the latest version of a case: NOTE:  Country codes are available per the links below. http://estri.ich.org/icsr/ICH_ICSR_Specification_V2-3.pdf http://www.iso.org/iso/home/standards/country_codes/iso-3166- 1_decoding_table.htm
		STRING occr_country;			// The country where the event occurred.
	END;

	SHARED LandingZone_IP := 'localhost';
	// Set the folder containing the data files on the Landing Zone here:  (Should end in / )
	SHARED BaseDataDirectory := '/var/lib/HPCCSystems/mydropzone/';
	
	EXPORT demographic(STRING pFile) := FUNCTION
		File_In := BaseDataDirectory + pFile;
		DS_In := DATASET(std.File.ExternalLogicalFilename(LandingZone_IP, File_In), raw_demo_layout, CSV(HEADING(1), SEPARATOR(['$']), TERMINATOR(['\n','\r\n','\n\r'])));
		DS_Dist := DISTRIBUTE(DS_In, HASH(primary_id));
		//RETURN OUTPUT(DS_Dist,, Datasets.File_Raw_Stations, OVERWRITE);
		RETURN DS_In;
	END;


END;