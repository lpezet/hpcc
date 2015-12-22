IMPORT Linux.BinUtils;
// First, install wgrib2:
// http://ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/INSTALLING
// Then:
// mv grib2 /usr/local/share
// ln -s /usr/local/share/grib2/wgrib2/wgrib2 /usr/bin/wgrib2


EXPORT WGrib2 := MODULE

	EXPORT inventory_layout := RECORD
		UNSIGNED message_number;
		UNSIGNED sub_message_number;
		UNSIGNED location;
		UNSIGNED reference_time;
		STRING variable;
		STRING z;
		STRING dtime;
		STRING other_information;
	END;
	
	SHARED inventory_layout line_to_inventory(BinUtils.line_layout pRecord) := TRANSFORM
		SELF.message_number := (UNSIGNED) REGEXFIND('^[^,:]+', pRecord.line, 0);
		SELF.sub_message_number := (UNSIGNED) REGEXFIND('(^[^,:]+),([^:]+)', pRecord.line, 2);
		SELF.location := (UNSIGNED) REGEXFIND('(:([^:]+)){1}', pRecord.line, 2);
		SELF.reference_time := (UNSIGNED) REGEXFIND('d=([^:]+)', pRecord.line, 1);
		SELF.variable := REGEXFIND('(:([^:]+)){3}', pRecord.line, 2);
		SELF.z := REGEXFIND('(:([^:]+)){4}', pRecord.line, 2);
		SELF.dtime := REGEXFIND('(:([^:]+)){5}', pRecord.line, 2);
		SELF.other_information := REGEXFIND('(:([^:]+)){6}', pRecord.line, 2);
	END;
	
	//TODO: pass some parameters...???
	// 1. operational vs experimental
	// 2. area of data: CONUS; 1 of 16 overlapping NDFD CONUS subsectors; Alaska; Hawaii; Guam; or Puerto Rico/the Virgin Islands; Northern Hemisphere; North Pacific Ocean 
	// 3. Valid Period: could be 001-003 covers Days 1-3; 004-007 covers days 4-7, 008-450 covers days 8-450
	// 4. FILE NAME = data subcategory containing abbreviated NDFD element names. The current file for each element will be kept until overwritten by a new file for the same element
	EXPORT download() := MACRO
	
	ENDMACRO;
	
	EXPORT inventory( STRING localUri ) := FUNCTION
		A := PIPE('wgrib2 -v ' + localUri, BinUtils.line_layout, CSV(SEPARATOR(''), QUOTE('')) );
		B := PROJECT(A, line_to_inventory(LEFT) );
		RETURN B;
	END;
	
	EXPORT to_csv( STRING sourceLocalUri, STRING targetLocalUri ) := FUNCTION
		A := PIPE('wgrib2 -v ' + sourceLocalUri + ' -csv ' + targetLocalUri, BinUtils.line_layout, CSV(SEPARATOR(''), QUOTE('')) );
		B := PROJECT(A, line_to_inventory(LEFT) );
		RETURN B;
	END;
	

END;