EXPORT Datasets := MODULE

	EXPORT area := ENUM(Conus, Alaska, Puerto_Rico, Hawaii, Guam, North_America_Tropical, North_Pacific_Ocean_Tropical,
		Pacific_North_West, Pacific_South_West, Northern_Rockies, Central_Rockies, Southern_Rockies, 
		Northern_Plains, Central_Plains, Southern_Plains, Upper_Mississippi_Valley, Central_Mississippi_Valley, Southern_Mississippi_Valley,
		Central_Great_Lakes, Estern_Great_Lakes, North_East, South_East, Mid_Atlantic );
	
	EXPORT valid_period := ENUM(Days_001_003, Days_004_007, Days_008_450);
	
	
	EXPORT elements_xml := '<root>' +
		'<element>maxt</element>' +
		'<element>mint</element>' +
		'<element>pop12</element>' +
		'<element>qpf</element>' +
		'<element>sky</element>' +
		'<element>snow</element>' +
		'<element>temp</element>' +
		'<element>td</element>' +
		'<element>wdir</element>' +
		'<element>wspd</element>' +
		'<element>wx</element>' +
		'<element>waveh</element>' +
		'<element>apt</element>' +
		'<element>rhm</element>' +
		'<element>wgust</element>' +
		'<element>wwa</element>' +
		'<element>maxrh</element>' +
		'<element>minrh</element>' +
		'<element>mixh</element>' +
		'<element>twdir</element>' +
		'<element>twspd</element>' +
		'<element>lal</element>' +
		'<element>haines</element>' +
		'<element>fwspd</element>' +
		'<element>clrg</element>' +
		'<element>cwr</element>' +
		'<element>maxvr</element>' +
		'<element>minvr</element>' +
		'<element>ventr</element>' +
		'<element>iceaccum</element>' +
		'<element>visby</element>' +
		'<element>icecvg</element>' +
		'<element>swhgt</element>' +
		'<element>swdir</element>' +
		'<element>tmpabv14d</element>' +
		'<element>tmpblw14d</element>' +
		'<element>prcpabv14d</element>' +
		'<element>prcpblw14d</element>' +
		'<element>tmpabv30d</element>' +
		'<element>tmpblw30d</element>' +
		'<element>prcpabv30d</element>' +
		'<element>prcpblw30d</element>' +
		'<element>tmpabv90d</element>' +
		'<element>tmpblw90d</element>' +
		'<element>prcpabv90d</element>' +
		'<element>prcpblw90d</element>' +
		'<element>tcwspdabv34i</element>' +
		'<element>tcwspdabv34c</element>' +
		'<element>tcwspdabv50i</element>' +
		'<element>tcwspdabv50c</element>' +
		'<element>tcwspdabv64i</element>' +
		'<element>tcwspdabv64c</element>' +
		'<element>ptornado</element>' +
		'<element>phail</element>' +
		'<element>ptstmwinds</element>' +
		'<element>pxtornado</element>' +
		'<element>pxhail</element>' +
		'<element>pxtstmwinds</element>' +
		'<element>ptotsvrtstm</element>' +
		'<element>ptotxsvrtstm</element>' +
		'<element>conhazo</element>' +
		'<element>critfireo</element>' +
		'<element>dryfireo</element>' +
	'</root>';
	
	EXPORT element := ENUM(
		maxt, 			// Maximum Temperature
		mint, 			// Minimum Temperature
		pop12, 			// 12-hour Probability of Precipitation
		qpf, 				// Quantitative Precipitation Forecast
		sky, 				// Sky Cover
		snow, 			// Snow Amount
		temp, 			// Temperature
		td,					// Dewpoint
		wdir, 			// Wind Direction
		wspd, 			// Wind Speed
		wx, 				// Weather
		waveh, 			// Significant Wave Height
		apt, 				// Apparent Temperature
		rhm, 				// Relative Humidity
		wgust, 			// Wind Gust Speed
		wwa, 				// Hazards
		maxrh,			// Maximum Relative Humidity
		minrh, 			// Minimum Relative Humidity
		mixh, 			// Mixing Height
		twdir, 			// Transport Wind Direction
		twspd,			// Transport Wind Speed
		lal, 				// Lightning Activity Level
		haines, 		// Haines Index
		fwspd, 			// 20 ft Wind Speed
		clrg, 			// Clearing Index
		cwr, 				// Chance of Wetting Rain
		maxvr, 			// Maximum Ventilation Rate
		minvr, 			// Minimum Ventilation Rate
		ventr, 			// Ventilation Rate
		iceaccum, 	// Ice Accumulation
		visby,			// Visibility
		icecvg,			// Ice Coverage
		swhgt, 			// Swell Height
		swdir, 			// Swell Direction
		tmpabv14d, 	// 8-14 Day Temperature Above Normal Climate Outlook
		tmpblw14d, 	// 8-14 Day Temperature Below Normal Climate Outlook
		prcpabv14d,	// 8-14 Day Precipitation Above Normal Climate Outlook
		prcpblw14d, // 8-14 Day Precipitation Below Normal Climate Outlook
		tmpabv30d,	// 30 Day Temperature Above Normal Climate Outlook
		tmpblw30d,  // 30 Day Temperature Below Normal Climate Outlook
		prcpabv30d, // 30 Day Precipitation Above Normal Climate Outlook
		prcpblw30d, // 30 Day Precipitation Below Normal Climate Outlook
		tmpabv90d, 	// 90 Day Temperature Above Normal Climate Outlook
		tmpblw90d, 	// 90 Day Temperature Below Normal Climate Outlook
		prcpabv90d, // 90 Day Precipitation Above Normal Climate Outlook
		prcpblw90d, // 90 Day Precipitation Below Normal Climate Outlook
		tcwspdabv34i,	// Probabilistic Tropical Cyclone Surface Wind Speeds >34kts (incremental)
		tcwspdabv34c, // Probabilistic Tropical Cyclone Surface Wind Speeds >34kts (cumulative)
		tcwspdabv50i, // Probabilistic Tropical Cyclone Surface Wind Speeds >50kts (incremental)
		tcwspdabv50c, // Probabilistic Tropical Cyclone Surface Wind Speeds >50kts (cumulative)
		tcwspdabv64i, // Probabilistic Tropical Cyclone Surface Wind Speeds >64kts  (incremental)
		tcwspdabv64c, // Probabilistic Tropical Cyclone Surface Wind Speeds >64kts  (cumulative)
		ptornado,			// Probability of Tornadoes
		phail, 				// Probability of Hail
		ptstmwinds,		// Probability of Damaging Thunderstorm Winds
		pxtornado, 		// Probability of Extreme Tornadoes
		pxhail,				// Probability of Extreme Hail
		pxtstmwinds, 	// Probability of Extreme Thunderstorm Winds
		ptotsvrtstm,	// Total Probability of Severe Thunderstorms
		ptotxsvrtstm, // Total Probability of Extreme Severe Thunderstorms
		conhazo,			// Convective Hazard Outlook
		critfireo, 		// Critical/Extreme-Critical Risk Fire Weather Outlook
		dryfireo			// Dry Lightning Thunderstorm Risk Fire Weather Outlook
	);
END;