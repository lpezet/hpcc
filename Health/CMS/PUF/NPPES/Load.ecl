// https://www.cms.gov/Regulations-and-Guidance/HIPAA-Administrative-Simplification/NationalProvIdentStand/DataDissemination.html
// https://www.cms.gov/Regulations-and-Guidance/HIPAA-Administrative-Simplification/NationalProvIdentStand/Downloads/Data_Dissemination_File-Readme.pdf
// https://www.cms.gov/Regulations-and-Guidance/HIPAA-Administrative-Simplification/NationalProvIdentStand/Downloads/Data_Dissemination_File-Code_Values.pdf
IMPORT Std;

EXPORT Load := MODULE

	// Regex:
	// ^(.+(?=( [0-9]+))) ([0-9]+) ([^ \n]+)( (.+))?$
	// STRING $1; // $4\($3\) , $5
	
	SHARED raw_nppes_layout := RECORD
		STRING npi; // number(10) ,  npi
		STRING entity_type_code; // number(1) ,  entity type code
		STRING replacement_npi; // number(10) ,  replacement npi
		STRING employer_identification_number; // varchar(9) , (ein) employer identification number (ein)
		STRING provider_organization_name; // varchar(70) , (legal business name) provider organization name (legal business name)
		STRING provider_last_name; // varchar(35) , (legal name) provider last name (legal name)
		STRING provider_first_name; // varchar(20) ,  provider first name
		STRING provider_middle_name; // varchar(20) ,  provider middle name
		STRING provider_name_prefix_text; // varchar(5) ,  provider name prefix text
		STRING provider_name_suffix_text; // varchar(5) ,  provider name suffix text
		STRING provider_credential_text; // varchar(20) ,  provider credential text
		STRING provider_other_organization_name; // varchar(70) ,  provider other organization name
		STRING provider_other_organization_name_type_code; // varchar(1) ,  provider other organization name type code
		STRING provider_other_last_name; // varchar(35) ,  provider other last name
		STRING provider_other_first_name; // varchar(20) ,  provider other first name
		STRING provider_other_middle_name; // varchar(20) ,  provider other middle name
		STRING provider_other_name_prefix_text; // varchar(5) ,  provider other name prefix text
		STRING provider_other_name_suffix_text; // varchar(5) ,  provider other name suffix text
		STRING provider_other_credential_text; // varchar(20) ,  provider other name credential text
		STRING provider_other_last_name_type_code; // number(1) ,  provider other last name type code
		STRING provider_first_line_business_mailing_address; // varchar(55) ,  provider first line business mailing address
		STRING provider_second_line_business_mailing_address; // varchar(55) ,  provider second line business mailing address
		STRING provider_business_mailing_address_city_name; // varchar(40) ,  provider business mailing address city name
		STRING provider_business_mailing_address_state_name; // varchar(40) ,  provider business mailing address state name
		STRING provider_business_mailing_address_postal_code; // varchar(20) ,  provider business mailing address postal code
		STRING provider_business_mailing_address_country_code; // varchar(2) ,  (if outside u.s.) provider business mailing address country code (if outside u.s.)
		STRING provider_business_mailing_address_telephone_number; // varchar(20) ,  provider business mailing address telephone number
		STRING provider_business_mailing_address_fax_number; // varchar(20) ,  provider business mailing address fax number
		STRING provider_first_line_business_practice_location_address; // varchar(55) ,  provider first line business location address
		STRING provider_second_line_business_practice_location_address; // varchar(55) ,  provider second line business location address
		STRING provider_business_practice_location_address_city_name; // varchar(40) ,  provider business location address city name
		STRING provider_business_practice_location_address_state_name; // varchar(40) ,  provider business location address state name
		STRING provider_business_practice_location_address_postal_code; // varchar(20) ,  provider business location address postal code
		STRING provider_business_practice_location_address_country_code; // varchar(2) , (if outside u.s.) provider business location address country code (if outside u.s.)
		STRING provider_business_practice_location_address_telephone_number; // varchar(20) ,  provider business location address telephone number
		STRING provider_business_practice_location_address_fax_number; // varchar(20) ,  provider business location address fax number
		STRING provider_enumeration_date; // (mm/dd/yyyy)(10) ,  date provider enumeration date
		STRING last_update_date; // (mm/dd/yyyy)(10) ,  date last update date
		STRING npi_deactivation_reason_code; // varchar(2) ,  npi deactivation reason code
		STRING npi_deactivation_date; // (mm/dd/yyyy)(10) ,  date npi deactivation date
		STRING npi_reactivation_date; // (mm/dd/yyyy)(10) ,  date npi reactivation date
		STRING provider_gender_code; // varchar(1) ,  provider gender code
		STRING authorized_official_last_name; // varchar(35) ,  authorized official last name
		STRING authorized_official_first_name; // varchar(20) ,  authorized official first name
		STRING authorized_official_middle_name; // varchar(20) ,  authorized official middle name
		STRING authorized_official_title_or_position; // varchar(35) ,  authorized official title or position
		STRING authorized_official_telephone_number; // varchar(20) ,  authorized official telephone number
		STRING healthcare_provider_taxonomy_code_1; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_1; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_1; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_1; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_2; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_2; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_2; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_2; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_3; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_3; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_3; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_3; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_4; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_4; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_4; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_4; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_5; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_5; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_5; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_5; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_6; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_6; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_6; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_6; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_7; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_7; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_7; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_7; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_8; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_8; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_8; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_8; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_9; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_9; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_9; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_9; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_10; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_10; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_10; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_10; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_11; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_11; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_11; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_11; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_12; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_12; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_12; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_12; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_13; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_13; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_13; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_13; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_14; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_14; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_14; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_14; // varchar(1) , 
		STRING healthcare_provider_taxonomy_code_15; // varchar(10) ,  healthcare provider taxonomy code
		STRING provider_license_number_15; // varchar(20) ,  provider license number
		STRING provider_license_number_state_code_15; // varchar(2) ,  provider license number state code
		STRING healthcare_provider_primary_taxonomy_switch_15; // varchar(1) , 
		STRING other_provider_identifier_1; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_1; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_1; // varchar(2) , 
		STRING other_provider_identifier_issuer_1; // varchar(80) , 
		STRING other_provider_identifier_2; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_2; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_2; // varchar(2) , 
		STRING other_provider_identifier_issuer_2; // varchar(80) , 
		STRING other_provider_identifier_3; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_3; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_3; // varchar(2) , 
		STRING other_provider_identifier_issuer_3; // varchar(80) , 
		STRING other_provider_identifier_4; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_4; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_4; // varchar(2) , 
		STRING other_provider_identifier_issuer_4; // varchar(80) , 
		STRING other_provider_identifier_5; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_5; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_5; // varchar(2) , 
		STRING other_provider_identifier_issuer_5; // varchar(80) , 
		STRING other_provider_identifier_6; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_6; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_6; // varchar(2) , 
		STRING other_provider_identifier_issuer_6; // varchar(80) , 
		STRING other_provider_identifier_7; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_7; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_7; // varchar(2) , 
		STRING other_provider_identifier_issuer_7; // varchar(80) , 
		STRING other_provider_identifier_8; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_8; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_8; // varchar(2) , 
		STRING other_provider_identifier_issuer_8; // varchar(80) , 
		STRING other_provider_identifier_9; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_9; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_9; // varchar(2) , 
		STRING other_provider_identifier_issuer_9; // varchar(80) , 
		STRING other_provider_identifier_10; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_10; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_10; // varchar(2) , 
		STRING other_provider_identifier_issuer_10; // varchar(80) , 
		STRING other_provider_identifier_11; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_11; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_11; // varchar(2) , 
		STRING other_provider_identifier_issuer_11; // varchar(80) , 
		STRING other_provider_identifier_12; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_12; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_12; // varchar(2) , 
		STRING other_provider_identifier_issuer_12; // varchar(80) , 
		STRING other_provider_identifier_13; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_13; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_13; // varchar(2) , 
		STRING other_provider_identifier_issuer_13; // varchar(80) , 
		STRING other_provider_identifier_14; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_14; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_14; // varchar(2) , 
		STRING other_provider_identifier_issuer_14; // varchar(80) , 
		STRING other_provider_identifier_15; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_15; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_15; // varchar(2) , 
		STRING other_provider_identifier_issuer_15; // varchar(80) , 
		STRING other_provider_identifier_16; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_16; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_16; // varchar(2) , 
		STRING other_provider_identifier_issuer_16; // varchar(80) , 
		STRING other_provider_identifier_17; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_17; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_17; // varchar(2) , 
		STRING other_provider_identifier_issuer_17; // varchar(80) , 
		STRING other_provider_identifier_18; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_18; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_18; // varchar(2) , 
		STRING other_provider_identifier_issuer_18; // varchar(80) , 
		STRING other_provider_identifier_19; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_19; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_19; // varchar(2) , 
		STRING other_provider_identifier_issuer_19; // varchar(80) , 
		STRING other_provider_identifier_20; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_20; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_20; // varchar(2) , 
		STRING other_provider_identifier_issuer_20; // varchar(80) , 
		STRING other_provider_identifier_21; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_21; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_21; // varchar(2) , 
		STRING other_provider_identifier_issuer_21; // varchar(80) , 
		STRING other_provider_identifier_22; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_22; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_22; // varchar(2) , 
		STRING other_provider_identifier_issuer_22; // varchar(80) , 
		STRING other_provider_identifier_23; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_23; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_23; // varchar(2) , 
		STRING other_provider_identifier_issuer_23; // varchar(80) , 
		STRING other_provider_identifier_24; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_24; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_24; // varchar(2) , 
		STRING other_provider_identifier_issuer_24; // varchar(80) , 
		STRING other_provider_identifier_25; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_25; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_25; // varchar(2) , 
		STRING other_provider_identifier_issuer_25; // varchar(80) , 
		STRING other_provider_identifier_26; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_26; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_26; // varchar(2) , 
		STRING other_provider_identifier_issuer_26; // varchar(80) , 
		STRING other_provider_identifier_27; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_27; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_27; // varchar(2) , 
		STRING other_provider_identifier_issuer_27; // varchar(80) , 
		STRING other_provider_identifier_28; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_28; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_28; // varchar(2) , 
		STRING other_provider_identifier_issuer_28; // varchar(80) , 
		STRING other_provider_identifier_29; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_29; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_29; // varchar(2) , 
		STRING other_provider_identifier_issuer_29; // varchar(80) , 
		STRING other_provider_identifier_30; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_30; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_30; // varchar(2) , 
		STRING other_provider_identifier_issuer_30; // varchar(80) , 
		STRING other_provider_identifier_31; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_31; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_31; // varchar(2) , 
		STRING other_provider_identifier_issuer_31; // varchar(80) , 
		STRING other_provider_identifier_32; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_32; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_32; // varchar(2) , 
		STRING other_provider_identifier_issuer_32; // varchar(80) , 
		STRING other_provider_identifier_33; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_33; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_33; // varchar(2) , 
		STRING other_provider_identifier_issuer_33; // varchar(80) , 
		STRING other_provider_identifier_34; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_34; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_34; // varchar(2) , 
		STRING other_provider_identifier_issuer_34; // varchar(80) , 
		STRING other_provider_identifier_35; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_35; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_35; // varchar(2) , 
		STRING other_provider_identifier_issuer_35; // varchar(80) , 
		STRING other_provider_identifier_36; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_36; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_36; // varchar(2) , 
		STRING other_provider_identifier_issuer_36; // varchar(80) , 
		STRING other_provider_identifier_37; // varchar(20) ,  other provider identifier
		STRING other_provider_identifiervtype_code_37; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_37; // varchar(2) , 
		STRING other_provider_identifier_issuer_37; // varchar(80) , 
		STRING other_provider_identifier_38; // varchar(20) ,  other provider identifier
		STRING other_provider_identifiervtype_code_38; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_38; // varchar(2) , 
		STRING other_provider_identifier_issuer_38; // varchar(80) , 
		STRING other_provider_identifier_39; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_39; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_39; // varchar(2) , 
		STRING other_provider_identifier_issuer_39; // varchar(80) , 
		STRING other_provider_identifier_40; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_40; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_40; // varchar(2) , 
		STRING other_provider_identifier_issuer_40; // varchar(80) , 
		STRING other_provider_identifier_41; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_41; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_41; // varchar(2) , 
		STRING other_provider_identifier_issuer_41; // varchar(80) , 
		STRING other_provider_identifier_42; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_42; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_42; // varchar(2) , 
		STRING other_provider_identifier_issuer_42; // varchar(80) , 
		STRING other_provider_identifier_43; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_43; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_43; // varchar(2) , 
		STRING other_provider_identifier_issuer_43; // varchar(80) , 
		STRING other_provider_identifier_44; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_44; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_44; // varchar(2) , 
		STRING other_provider_identifier_issuer_44; // varchar(80) , 
		STRING other_provider_identifier_45; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_45; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_45; // varchar(2) , 
		STRING other_provider_identifier_issuer_45; // varchar(80) , 
		STRING other_provider_identifier_46; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_46; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_46; // varchar(2) , 
		STRING other_provider_identifier_issuer_46; // varchar(80) , 
		STRING other_provider_identifier_47; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_47; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_47; // varchar(2) , 
		STRING other_provider_identifier_issuer_47; // varchar(80) , 
		STRING other_provider_identifier_48; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_48; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_48; // varchar(2) , 
		STRING other_provider_identifier_issuer_48; // varchar(80) , 
		STRING other_provider_identifier_49; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_49; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_49; // varchar(2) , 
		STRING other_provider_identifier_issuer_49; // varchar(80) , 
		STRING other_provider_identifier_50; // varchar(20) ,  other provider identifier
		STRING other_provider_identifier_type_code_50; // varchar(2) ,  other provider identifier type code
		STRING other_provider_identifier_state_50; // varchar(2) , 
		STRING other_provider_identifier_issuer_50; // varchar(80) , 
		STRING is_sole_proprietor; // varchar(1) ,  provider sole proprietor flag
		STRING is_organization_subpart; // varchar(1) ,  provider organization subpart flag
		STRING parent_organization_lbn; // varchar(70) ,  provider organization subpart legal business name
		STRING parent_organization_tin; // varchar(9) ,  provider organization subpart tin
		STRING authorized_official_name_prefix_text; // varchar(5) ,  authorized official name prefix text
		STRING authorized_official_name_suffix_text; // varchar(5) ,  authorized official name suffix text
		STRING authorized_official_credential_text; // varchar(20) ,  authorized official credential text
		STRING healthcare_provider_taxonomy_group_1; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_2; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_3; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_4; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_5; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_6; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_7; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_8; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_9; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_10; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_11; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_12; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_13; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_14; // varchar(70) ,  healthcare provider taxonomy group
		STRING healthcare_provider_taxonomy_group_15; // varchar(70) ,  healthcare provider taxonomy group
	END;

	SHARED LandingZone_IP := 'localhost';
	// Set the folder containing the data files on the Landing Zone here:  (Should end in / )
	SHARED BaseDataDirectory := '/var/lib/HPCCSystems/mydropzone/';
	
	EXPORT load(STRING pInFile, STRING pLogicalFile) := FUNCTION
		File_In := BaseDataDirectory + pInFile;
		DS_In := DATASET(std.File.ExternalLogicalFilename(LandingZone_IP, File_In), raw_nppes_layout, CSV(HEADING(1), SEPARATOR([',']), QUOTE(['"']), TERMINATOR(['\n','\r\n','\n\r'])));
		DS_Dist := DISTRIBUTE(DS_In, HASH(npi));
		RETURN OUTPUT(DS_Dist,, pLogicalFile, OVERWRITE);
	END;


END;