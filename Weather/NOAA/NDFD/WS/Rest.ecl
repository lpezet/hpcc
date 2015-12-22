// Resources
// Explanations on grib files:
// http://www.ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/intro_grib2.pdf
// Still not sure how to use that one:
// http://www.nco.ncep.noaa.gov/pmb/docs/grib2/grib2_doc.shtml

// Access to NDFD elements and more
// http://graphical.weather.gov/docs/datamanagement.php
// E.g.: can find definition of "ssss" in ds.ssss (filenames) in "NDFD Elements" sheet in http://graphical.weather.gov/docs/NDFDelem_complete.xls


/*
<product srsName="WGS 1984" concise-name="dwmlByDay" operational-mode="official">
	<title>
NOAA's National Weather Service Forecast by 24 Hour Period
	</title>
	<field>meteorological</field>
	<category>forecast</category>
	<creation-date refresh-frequency="PT1H">2015-12-20T03:08:32Z</creation-date>
</product>
*/
product_layout := RECORD
	STRING srs_name {XPATH('@srsName')};
	STRING consice_name {XPATH('@concise-name')};
	STRING operational_mode {XPATH('@operational-mode')};
	STRING title {XPATH('title')};
	STRING field {XPATH('field')};
	STRING category {XPATH('category')};
	STRING creation_date {XPATH('creation-date')};
	STRING refresh_frequency {XPATH('creation-date/@refresh-frequency')};
END;

/*
<source>
	<more-information>http://www.nws.noaa.gov/forecasts/xml/</more-information>
	<production-center>
		Meteorological Development Laboratory
		<sub-center>Product Generation Branch</sub-center>
	</production-center>
	<disclaimer>http://www.nws.noaa.gov/disclaimer.html</disclaimer>
	<credit>http://www.weather.gov/</credit>
	<credit-logo>http://www.weather.gov/images/xml_logo.gif</credit-logo>
	<feedback>http://www.weather.gov/feedback.php</feedback>
</source>
*/
source_layout := RECORD
	STRING more_information {XPATH('more-information')};
	STRING production_center {XPATH('production-center')};
	STRING production_sub_center {XPATH('production-center/sub-center')};
	STRING disclaimer {XPATH('disclaimer')};
	STRING credit {XPATH('credit')};
	STRING credit_logo {XPATH('credit-logo')};
	STRING feedback {XPATH('feedback')};
END;

/*
<location>
	<location-key>point1</location-key>
	<point latitude="38.99" longitude="-77.01"/>
</location>
*/
location_layout := RECORD
	STRING key {XPATH('location-key')};
	DECIMAL12_9 latitude {XPATH('point/@latitude')};
	DECIMAL12_9 longitude {XPATH('point/@longitude')};
END;

/*
<moreWeatherInformation applicable-location="point1">
	http://forecast.weather.gov/MapClick.php?textField1=38.99&textField2=-77.01
</moreWeatherInformation>
*/
more_weather_information_layout := RECORD
	STRING val {XPATH('/')};
	STRING applicable_location_key {XPATH('@applicable-location')};
END;

/*
<time-layout time-coordinate="local" summarization="24hourly">
	<layout-key>k-p24h-n7-1</layout-key>
	<start-valid-time>2015-12-20T06:00:00-05:00</start-valid-time>
	<end-valid-time>2015-12-21T06:00:00-05:00</end-valid-time>
	<start-valid-time>2015-12-21T06:00:00-05:00</start-valid-time>
	<end-valid-time>2015-12-22T06:00:00-05:00</end-valid-time>
	...
</time-layout>
*/
valid_time_layout := RECORD
	STRING time {XPATH('/')};
END;
time_layout := RECORD
	STRING time_coordinate {XPATH('@time-coordinate')};
	STRING summarization {XPATH('@summarization')};
	STRING layout_key {XPATH('layout-key')};
	//TODO: Why this one doesn't work???
	//DATASET(valid_time_layout) start_valid_times	{XPATH('start-valid-time')};
	SET OF STRING start_valid_times	{XPATH('/start-valid-time')};
	//TODO: Why this one doesn't work???
	//DATASET(valid_time_layout) end_valid_times {XPATH('/end-valid-time')};
	SET OF STRING end_valid_times	{XPATH('/start-valid-time')};
END;

/*
<temperature type="maximum" units="Fahrenheit" time-layout="k-p24h-n7-1">
<name>Daily Maximum Temperature</name>
<value>44</value>
<value>53</value>
...
</temperature>
*/
temperature_layout := RECORD
	STRING typ {XPATH('@type')};
	STRING units {XPATH('@units')};
	STRING time_layout {XPATH('@time-layout')};
	STRING name {XPATH('name')};
	SET OF STRING values {XPATH('value')};
END;
/*
<probability-of-precipitation type="12 hour" units="percent" time-layout="k-p12h-n14-2">
<name>12 Hourly Probability of Precipitation</name>
<value>1</value>
<value>5</value>
...
<value xsi:nil="true"/>
</probability-of-precipitation>
*/
probability_of_precipitation_layout := RECORD
	STRING typ {XPATH('@type')};
	STRING time_layout {XPATH('@time-layout')};
	STRING units {XPATH('@units')};
	STRING name {XPATH('name')};
	SET OF STRING values {XPATH('/value')};

END;
/*
<weather time-layout="k-p24h-n7-1">
<name>Weather Type, Coverage, and Intensity</name>
<weather-conditions weather-summary="Increasing Clouds"/>
<weather-conditions weather-summary="Chance Rain Showers">
<value coverage="chance" intensity="light" weather-type="rain showers" qualifier="none"/>
</weather-conditions>
<weather-conditions weather-summary="Rain Showers Likely">
<value coverage="likely" intensity="light" weather-type="rain showers" qualifier="none"/>
</weather-conditions>
...
</weather>
*/
weather_conditions_layout := RECORD
	STRING summary {XPATH('@weather-summary')};
	STRING coverage {XPATH('/value/@coverage')};
	STRING intensity {XPATH('/value/@intensity')};
	STRING weather_type {XPATH('/value/@weather-type')};
	STRING qualifier {XPATH('/value/@qualifier')};
END;
weather_layout := RECORD
	STRING time_layout {XPATH('@time-layout')};
	STRING name {XPATH('/name')};
	DATASET(weather_conditions_layout) weather_conditions {XPATH('/weather-conditions')};
END;
/*
<conditions-icon type="forecast-NWS" time-layout="k-p24h-n7-1">
<name>Conditions Icons</name>
<icon-link>
http://www.nws.noaa.gov/weather/images/fcicons/sct.jpg
</icon-link>
<icon-link>
http://www.nws.noaa.gov/weather/images/fcicons/hi_shwrs50.jpg
</icon-link>
...
</conditions-icon>
*/

conditions_icon_layout := RECORD
	STRING time_layout {XPATH('@time-layout')};
	STRING typ {XPATH('@type')};	
	SET OF STRING icon_links {XPATH('/icon-link')};
END;

/*
<hazards time-layout="k-p7d-n1-3">
<name>Watches, Warnings, and Advisories</name>
<hazard-conditions xsi:nil="true"/>
</hazards>
*/
hazards_layout := RECORD
	STRING time_layout {XPATH('@time-layout')};
	STRING name {XPATH('/name')};
	//TODO: more?
END;
parameters_layout := RECORD
	temperature_layout maximum_temperature {XPATH('/temperature[@type="maximum"]')};
	temperature_layout minimum_temperature {XPATH('/temperature[@type="minimum"]')};
	probability_of_precipitation_layout probability_of_precipitation {XPATH('/probability-of-precipitation')};
	weather_layout weather {XPATH('/weather')};
	conditions_icon_layout conditions_icons {XPATH('/condition-icons')};
	hazards_layout hazards {XPATH('/hazards')};
END;

data_layout := RECORD
	product_layout product {XPATH('/dwml/head/product')};
	source_layout source {XPATH('/dwml/head/source')};
	location_layout location {XPATH('/dwml/data/location')};
	more_weather_information_layout more_weather_information {XPATH('/dwml/data/moreWeatherInformation')};
	DATASET(time_layout) time_layouts {XPATH('/dwml/data/time-layout')};
	parameters_layout parameters {XPATH('/dwml/data/parameters')};
	//TODO: parameters:
	// temperature
	// probability_of_precipitation
	// weather
	// conditions_icon
	// hazards
END;

oUrl := 'http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?lat=38.99&lon=-77.01&format=24+hourly&numDays=7';
oCall := HTTPCALL(oUrl, 'GET', 'text/xml', data_layout, 
			//TIMEOUT(30), 
			RETRY(1)
			//HTTPHEADER('token', pToken), 
			//HTTPHEADER('host', 'www.ncdc.noaa.gov')
			//ONFAIL(SKIP)
		) : STORED('httpcall');
oCall.product;
oCall.source;
oCall.location;
oCall.more_weather_information;
oCall.time_layouts[1].start_valid_times;
oCall.parameters;
oCall.parameters.minimum_temperature.values[7];
oCall.parameters.maximum_temperature;
oCall.parameters.probability_of_precipitation;
oCall.parameters.weather;
oCall.parameters.conditions_icons;
oCall.parameters.hazards;


final_temperature_layout := RECORD
	STRING start_time;
	STRING end_time;
	STRING units;
	STRING time_layout;
	STRING typ;
	STRING val;
END;


/*
#DECLARE (buffer)
#DECLARE (n)
#SET (buffer, '[');    //initialize SetString to [
#SET (n, 1);            //initialize Ndx to 1
#LOOP
	#IF (%n% > 100 OR oCall.time_layouts[%n%] <> '')   //if we've iterated 9 times
		 #BREAK         // break out of the loop
	#ELSE             //otherwise
		 #APPEND (SetString, %'Ndx'% + ',');
									 //append Ndx and comma to SetString
#SET (Ndx, %Ndx% + 1)
									 //and increment the value of Ndx
	 #END
#END

#APPEND (buffer, %'buffer'% + ']'); //add 10th element and closing ]
*/
