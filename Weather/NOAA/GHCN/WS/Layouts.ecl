// Based on NodeJS proxy translating JSON to XML where <root> is the root tag.
// This is until HPCC can accept application/json response in HTTPCALL.

EXPORT Layouts := MODULE
	
	EXPORT data_result_layout := RECORD
		STRING date  {XPATH('date')};
		STRING data_type  {XPATH('datatype')};
		STRING station {XPATH('station')};
		STRING attributes {XPATH('attributes')};
		INTEGER value {XPATH('value')};
	END;
	
	EXPORT location_result_layout := RECORD
		STRING min_date  {XPATH('mindate')};
		STRING max_date  {XPATH('maxdate')};
		STRING name {XPATH('name')};
		DECIMAL10_3 data_coverage {XPATH('datacoverage')};
		STRING id {XPATH('id')};
	END;
	
	EXPORT location_category_result_layout := RECORD
		STRING name {XPATH('name')};
		STRING id {XPATH('id')};
	END;
	
	EXPORT data_type_result_layout := RECORD
		STRING min_date  {XPATH('mindate')};
		STRING max_date  {XPATH('maxdate')};
		STRING name {XPATH('name')};
		DECIMAL10_3 data_coverage {XPATH('datacoverage')};
		STRING id {XPATH('id')};
	END;
	
	EXPORT data_category_result_layout := RECORD
		STRING name {XPATH('name')};
		STRING id {XPATH('id')};
	END;
	
	EXPORT dataset_result_layout := RECORD
		STRING uid {XPATH('uid')};
		STRING min_date  {XPATH('mindate')};
		STRING max_date  {XPATH('maxdate')};
		STRING name {XPATH('name')};
		DECIMAL10_3 data_coverage {XPATH('datacoverage')};
		STRING id {XPATH('id')};
	END;
	
	EXPORT station_result_layout := RECORD
		DECIMAL7_2 elevation {XPATH('elevation')};
		STRING min_date  {XPATH('mindate')};
		STRING max_date  {XPATH('maxdate')};
		REAL latitude  {XPATH('latitude')};
		STRING name  {XPATH('name')};
		REAL data_coverage  {XPATH('datacoverage')};
		STRING id  {XPATH('id')};
		STRING elevation_unit  {XPATH('elevationUnit')};
		REAL longitude  {XPATH('longitude')};
	END;

	EXPORT metadata_layout := RECORD
		INTEGER offset {XPATH('offset')};
		INTEGER count  {XPATH('count')};
		INTEGER limit  {XPATH('limit')};
	END;
	
	EXPORT stations_layout := RECORD
		metadata_layout metadata {XPATH('/root/metadata/resultset')};
		DATASET(station_result_layout) results {XPATH('//results')};
	END;
	
	EXPORT data_layout := RECORD
		metadata_layout metadata {XPATH('/root/metadata/resultset')};
		DATASET(data_result_layout) results {XPATH('//results')};
	END;
	
	EXPORT locations_layout := RECORD
		metadata_layout metadata {XPATH('/root/metadata/resultset')};
		DATASET(location_result_layout) results {XPATH('//results')};
	END;
	
	EXPORT location_categories_layout := RECORD
		metadata_layout metadata {XPATH('/root/metadata/resultset')};
		DATASET(station_result_layout) results {XPATH('//results')};
	END;
	
	EXPORT datasets_layout := RECORD
		metadata_layout metadata {XPATH('/root/metadata/resultset')};
		DATASET(dataset_result_layout) results {XPATH('//results')};
	END;
	
	EXPORT data_categories_layout := RECORD
		metadata_layout metadata {XPATH('/root/metadata/resultset')};
		DATASET(data_category_result_layout) results {XPATH('//results')};
	END;
	
	EXPORT data_types_layout := RECORD
		metadata_layout metadata {XPATH('/root/metadata/resultset')};
		DATASET(data_type_result_layout) results {XPATH('//results')};
	END;

END;