IMPORT Weather.NOAA.Rest;

oClient := Rest.Services('http://192.168.0.29:8082/cdo-web/api/v2/', 'alpPJbBLKfjyqsycInlUmLsgLxhDNDAE');

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

oData := oClient.get_data( pDatasetId := 'GHCNDMS', pLocationId := 'ZIP:10025', pStartDate := '2015-01-01', pEndDate := '2015-10-02'); //, pStationId := 'GHCND:USC00051784');
oData.metadata;
oData.results;