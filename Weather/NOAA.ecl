// My station id: GHCND:US1COEP0236, but it has only old data (decomissioned???)
// 3 others around: (using http://www.ncdc.noaa.gov/cdo-web/datatools/findstation)
// GHCND:USC00051784 (best)
// GHCND:US1COEP0282
// GHCND:US1COEP0165

// Interesting info:
// http://www.ncdc.noaa.gov/cdo-web/datasets/GHCNDMS/stations/GHCND:USC00051784/detail



NOAA(STRING pBaseUrl, STRING pToken) := MODULE

	SHARED mStationsUrl := pBaseUrl + '/stations';
	SHARED mDatasetsUrl := pBaseUrl + '/datasets';
	SHARED mDataCategoriesUrl := pBaseUrl + '/datacategories';
	SHARED mDataTypesUrl := pBaseUrl + '/datatypes';
	SHARED mLocationCategoriesUrl := pBaseUrl + '/locationcategories';
	SHARED mLocationsUrl := pBaseUrl + '/locations';
	SHARED mDataUrl := pBaseUrl + '/data';
	
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
	
	
	/*
	SHARED http_call(STRING pUrl, RECORD pLayout) := HTTPCALL(pUrl, 'GET', 'text/xml', pLayout, 
		//TIMEOUT(30), 
		RETRY(1),
		HTTPHEADER('token', pToken), 
		HTTPHEADER('host', 'www.ncdc.noaa.gov')
		//ONFAIL(SKIP)
		) 
	*/
	EXPORT get_data(
		STRING pDatasetId = '',
		STRING pDataTypeId = '',
		STRING pLocationId = '',
		STRING pStationId = '',
		STRING pStartDate = '',
		STRING pEndDate = '',
		STRING pSortField = '',
		STRING pSortOrder = '',
		INTEGER pLimit = 0,
		INTEGER pOffset = 0) := FUNCTION

		oQS_1 := '?';
		oQS_2 := IF(LENGTH(pDatasetId) > 0, oQS_1 + '&datasetid=' + pDatasetId, oQS_1);
		oQS_3 := IF(LENGTH(pDataTypeId) > 0, oQS_2 + '&datatypeid=' + pDataTypeId, oQS_2);
		oQS_4 := IF(LENGTH(pLocationId) > 0, oQS_3 + '&locationid=' + pLocationId, oQS_3);
		oQS_5 := IF(LENGTH(pStationId) > 0, oQS_4 + '&stationid=' + pStationId, oQS_4);
		oQS_6 := IF(LENGTH(pStartDate) > 0, oQS_5 + '&startdate=' + pStartDate, oQS_5);
		oQS_7 := IF(LENGTH(pEndDate) > 0, oQS_6 + '&enddate=' + pEndDate, oQS_6);
		oQS_8 := IF(LENGTH(pSortField) > 0, oQS_7 + '&sortfield=' + pSortField, oQS_7);
		oQS_9 := IF(LENGTH(pSortOrder) > 0, oQS_8 + '&sortorder=' + pSortOrder, oQS_8);
		oQS_10 := IF(pLimit > 0, oQS_9 + '&limit=' + pLimit, oQS_9);
		oQS_11 := IF(pOffset > 0, oQS_10 + '&offset=' + pOffset, oQS_10);
		
		oQS := oQS_11;
		
		RETURN HTTPCALL(mDataUrl + oQS, 'GET', 'text/xml', data_layout, 
			//TIMEOUT(30), 
			RETRY(1),
			HTTPHEADER('token', pToken), 
			HTTPHEADER('host', 'www.ncdc.noaa.gov')
			//ONFAIL(SKIP)
		);
	END;
	
	EXPORT get_locations(
		STRING pDatasetId = '',
		STRING pLocationCategoryId = '',
		STRING pDataCategoryId = '',
		STRING pStartDate = '',
		STRING pEndDate = '',
		STRING pSortField = '',
		STRING pSortOrder = '',
		INTEGER pLimit = 0,
		INTEGER pOffset = 0) := FUNCTION

		oQS_1 := '?';
		oQS_2 := IF(LENGTH(pDatasetId) > 0, oQS_1 + '&datasetid=' + pDatasetId, oQS_1);
		oQS_3 := IF(LENGTH(pLocationCategoryId) > 0, oQS_2 + '&locationcategoryid=' + pLocationCategoryId, oQS_2);
		oQS_4 := IF(LENGTH(pDataCategoryId) > 0, oQS_3 + '&datacategoryid=' + pDataCategoryId, oQS_3);
		oQS_5 := IF(LENGTH(pStartDate) > 0, oQS_4 + '&startdate=' + pStartDate, oQS_4);
		oQS_6 := IF(LENGTH(pEndDate) > 0, oQS_5 + '&enddate=' + pEndDate, oQS_5);
		oQS_7 := IF(LENGTH(pSortField) > 0, oQS_5 + '&sortfield=' + pSortField, oQS_5);
		oQS_8 := IF(LENGTH(pSortOrder) > 0, oQS_7 + '&sortorder=' + pSortOrder, oQS_7);
		oQS_9 := IF(pLimit > 0, oQS_8 + '&limit=' + pLimit, oQS_8);
		oQS_10 := IF(pOffset > 0, oQS_9 + '&offset=' + pOffset, oQS_9);
		
		oQS := oQS_10;
		
		RETURN HTTPCALL(mLocationsUrl + oQS, 'GET', 'text/xml', locations_layout, 
			//TIMEOUT(30), 
			RETRY(1),
			HTTPHEADER('token', pToken), 
			HTTPHEADER('host', 'www.ncdc.noaa.gov')
			//ONFAIL(SKIP)
		);
	END;
	
	EXPORT get_location_categories(
		STRING pDatasetId = '',
		STRING pStartDate = '',
		STRING pEndDate = '',
		STRING pSortField = '',
		STRING pSortOrder = '',
		INTEGER pLimit = 0,
		INTEGER pOffset = 0) := FUNCTION

		oQS_1 := '?';
		oQS_2 := IF(LENGTH(pDatasetId) > 0, oQS_1 + '&datasetid=' + pDatasetId, oQS_1);
		oQS_3 := IF(LENGTH(pStartDate) > 0, oQS_2 + '&startdate=' + pStartDate, oQS_2);
		oQS_4 := IF(LENGTH(pEndDate) > 0, oQS_3 + '&enddate=' + pEndDate, oQS_3);
		oQS_5 := IF(LENGTH(pSortField) > 0, oQS_4 + '&sortfield=' + pSortField, oQS_4);
		oQS_6 := IF(LENGTH(pSortOrder) > 0, oQS_5 + '&sortorder=' + pSortOrder, oQS_5);
		oQS_7 := IF(pLimit > 0, oQS_6 + '&limit=' + pLimit, oQS_6);
		oQS_8 := IF(pOffset > 0, oQS_7 + '&offset=' + pOffset, oQS_7);
		
		oQS := oQS_8;
		
		RETURN HTTPCALL(mLocationCategoriesUrl + oQS, 'GET', 'text/xml', location_categories_layout, 
			//TIMEOUT(30), 
			RETRY(1),
			HTTPHEADER('token', pToken), 
			HTTPHEADER('host', 'www.ncdc.noaa.gov')
			//ONFAIL(SKIP)
		);
	END;
	
	EXPORT get_data_types(
		STRING pDatasetId = '',
		STRING pLocationId = '',
		STRING pStationId = '',
		STRING pStartDate = '',
		STRING pEndDate = '',
		STRING pSortField = '',
		STRING pSortOrder = '',
		INTEGER pLimit = 0,
		INTEGER pOffset = 0) := FUNCTION

		oQS_1 := '?';
		oQS_2 := IF(LENGTH(pDatasetId) > 0, oQS_1 + '&datasetid=' + pDatasetId, oQS_1);
		oQS_3 := IF(LENGTH(pLocationId) > 0, oQS_2 + '&locationid=' + pLocationId, oQS_2);
		oQS_4 := IF(LENGTH(pStationId) > 0, oQS_3 + '&stationid=' + pStationId, oQS_3);
		oQS_5 := IF(LENGTH(pStartDate) > 0, oQS_4 + '&startdate=' + pStartDate, oQS_4);
		oQS_6 := IF(LENGTH(pEndDate) > 0, oQS_5 + '&enddate=' + pEndDate, oQS_5);
		oQS_7 := IF(LENGTH(pSortField) > 0, oQS_5 + '&sortfield=' + pSortField, oQS_5);
		oQS_8 := IF(LENGTH(pSortOrder) > 0, oQS_7 + '&sortorder=' + pSortOrder, oQS_7);
		oQS_9 := IF(pLimit > 0, oQS_8 + '&limit=' + pLimit, oQS_8);
		oQS_10 := IF(pOffset > 0, oQS_9 + '&offset=' + pOffset, oQS_9);
		
		oQS := oQS_10;
		
		RETURN HTTPCALL(mDataTypesUrl + oQS, 'GET', 'text/xml', data_types_layout, 
			//TIMEOUT(30), 
			RETRY(1),
			HTTPHEADER('token', pToken), 
			HTTPHEADER('host', 'www.ncdc.noaa.gov')
			//ONFAIL(SKIP)
		);
	END;
	
	EXPORT get_data_categories(
		STRING pDatasetId = '',
		STRING pLocationId = '',
		STRING pStationId = '',
		STRING pStartDate = '',
		STRING pEndDate = '',
		STRING pSortField = '',
		STRING pSortOrder = '',
		INTEGER pLimit = 0,
		INTEGER pOffset = 0) := FUNCTION

		oQS_1 := '?';
		oQS_2 := IF(LENGTH(pDatasetId) > 0, oQS_1 + '&datasetid=' + pDatasetId, oQS_1);
		oQS_3 := IF(LENGTH(pLocationId) > 0, oQS_2 + '&locationid=' + pLocationId, oQS_2);
		oQS_4 := IF(LENGTH(pStationId) > 0, oQS_3 + '&stationid=' + pStationId, oQS_3);
		oQS_5 := IF(LENGTH(pStartDate) > 0, oQS_4 + '&startdate=' + pStartDate, oQS_4);
		oQS_6 := IF(LENGTH(pEndDate) > 0, oQS_5 + '&enddate=' + pEndDate, oQS_5);
		oQS_7 := IF(LENGTH(pSortField) > 0, oQS_5 + '&sortfield=' + pSortField, oQS_5);
		oQS_8 := IF(LENGTH(pSortOrder) > 0, oQS_7 + '&sortorder=' + pSortOrder, oQS_7);
		oQS_9 := IF(pLimit > 0, oQS_8 + '&limit=' + pLimit, oQS_8);
		oQS_10 := IF(pOffset > 0, oQS_9 + '&offset=' + pOffset, oQS_9);
		
		oQS := oQS_10;
		
		RETURN HTTPCALL(mDataCategoriesUrl + oQS, 'GET', 'text/xml', data_categories_layout, 
			//TIMEOUT(30), 
			RETRY(1),
			HTTPHEADER('token', pToken), 
			HTTPHEADER('host', 'www.ncdc.noaa.gov')
			//ONFAIL(SKIP)
		);
	END;
	
	EXPORT get_datasets(
		STRING pDataTypeId = '',
		STRING pLocationId = '',
		STRING pStationId = '',
		STRING pStartDate = '',
		STRING pEndDate = '',
		STRING pSortField = '',
		STRING pSortOrder = '',
		INTEGER pLimit = 0,
		INTEGER pOffset = 0) := FUNCTION

		oQS_1 := '?';
		oQS_2 := IF(LENGTH(pDataTypeId) > 0, oQS_1 + '&datatypeid=' + pDataTypeId, oQS_1);
		oQS_3 := IF(LENGTH(pLocationId) > 0, oQS_2 + '&locationid=' + pLocationId, oQS_2);
		oQS_4 := IF(LENGTH(pStationId) > 0, oQS_3 + '&stationid=' + pStationId, oQS_3);
		oQS_5 := IF(LENGTH(pStartDate) > 0, oQS_4 + '&startdate=' + pStartDate, oQS_4);
		oQS_6 := IF(LENGTH(pEndDate) > 0, oQS_5 + '&enddate=' + pEndDate, oQS_5);
		oQS_7 := IF(LENGTH(pSortField) > 0, oQS_5 + '&sortfield=' + pSortField, oQS_5);
		oQS_8 := IF(LENGTH(pSortOrder) > 0, oQS_7 + '&sortorder=' + pSortOrder, oQS_7);
		oQS_9 := IF(pLimit > 0, oQS_8 + '&limit=' + pLimit, oQS_8);
		oQS_10 := IF(pOffset > 0, oQS_9 + '&offset=' + pOffset, oQS_9);
		
		oQS := oQS_10;
		
		RETURN HTTPCALL(mDatasetsUrl + oQS, 'GET', 'text/xml', datasets_layout, 
			//TIMEOUT(30), 
			RETRY(1),
			HTTPHEADER('token', pToken), 
			HTTPHEADER('host', 'www.ncdc.noaa.gov')
			//ONFAIL(SKIP)
		);
	END;
	
	EXPORT get_stations(
		STRING pDatasetId = '',
		STRING pLocationId = '',
		STRING pDataCategoryId = '',
		STRING pDataTypeId = '',
		STRING pExtent = '',
		STRING pStartDate = '',
		STRING pEndDate = '',
		STRING pSortOrder = '',
		INTEGER pLimit = 0,
		INTEGER pOffset = 0) := FUNCTION
		oQS_1 := '?';
		oQS_2 := IF(LENGTH(pDatasetId) > 0, oQS_1 + '&datasetid=' + pDatasetId, oQS_1);
		oQS_3 := IF(LENGTH(pLocationId) > 0, oQS_2 + '&locationid=' + pLocationId, oQS_2);
		oQS_4 := IF(LENGTH(pDataCategoryId) > 0, oQS_3 + '&datacategoryid=' + pDataCategoryId, oQS_3);
		oQS_5 := IF(LENGTH(pDataTypeId) > 0, oQS_4 + '&datatypeid=' + pDataTypeId, oQS_4);
		oQS_6 := IF(LENGTH(pExtent) > 0, oQS_5 + '&extent=' + pExtent, oQS_5);
		oQS_7 := IF(LENGTH(pStartDate) > 0, oQS_6 + '&startdate=' + pStartDate, oQS_6);
		oQS_8 := IF(LENGTH(pEndDate) > 0, oQS_7 + '&enddate=' + pEndDate, oQS_7);
		oQS_9 := IF(LENGTH(pSortOrder) > 0, oQS_8 + '&sortorder=' + pSortOrder, oQS_8);
		oQS_10 := IF(pLimit > 0, oQS_9 + '&limit=' + pLimit, oQS_9);
		oQS_11 := IF(pOffset > 0, oQS_10 + '&offset=' + pOffset, oQS_10);
		
		oQS := oQS_11;
		
		RETURN HTTPCALL(mStationsUrl + oQS, 'GET', 'text/xml', stations_layout, 
			//TIMEOUT(30), 
			RETRY(1),
			HTTPHEADER('token', pToken), 
			HTTPHEADER('host', 'www.ncdc.noaa.gov')
			//ONFAIL(SKIP)
		);
	END;
END;

/*
	"elevation": 139,
			"mindate": "1948-01-01",
			"maxdate": "2014-01-01",
			"latitude": 31.5702,
			"name": "ABBEVILLE, AL US",
			"datacoverage": 0.8813,
			"id": "COOP:010008",
			"elevationUnit": "METERS",
			"longitude": -85.2482
*/
/* 
"resultset": {
			"offset": 1,
			"count": 123765,
			"limit": 25
		}
*/


oClient := NOAA('http://192.168.0.29:8082/cdo-web/api/v2/', 'alpPJbBLKfjyqsycInlUmLsgLxhDNDAE');

oStations := oClient.get_stations(pLocationId := 'FIPS:37');
//oStations.metadata;
//oStations.results;

oDatasets := oClient.get_datasets(pStationId := 'GHCND:USC00051784');
//oDatasets.metadata;
//oDatasets.results;

oDataCategories := oClient.get_data_categories(pStationId := 'GHCND:USC00051784');
//oDataCategories.metadata;
//oDataCategories.results;

oDataTypes := oClient.get_data_types(pStationId := 'GHCND:USC00051784');
//oDataTypes.metadata;
//oDataTypes.results;

oLocationCategories := oClient.get_location_categories();
//oLocationCategories.metadata;
//oLocationCategories.results;

oLocations := oClient.get_locations();
//oLocations.metadata;
//oLocations.results;

oData := oClient.get_data( pDatasetId := 'GHCNDMS', pLocationId := 'ZIP:80923', pStartDate := '2015-01-01', pEndDate := '2015-10-02'); //, pStationId := 'GHCND:USC00051784');
oData.metadata;
oData.results;