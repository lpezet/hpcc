IMPORT Linux.BinUtils;
// First, install wgrib2:
// http://ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/INSTALLING
// Then:
// mv grib2 /usr/local/share
// ln -s /usr/local/share/grib2/wgrib2/wgrib2 /usr/bin/wgrib2

// OBSOLETE: (now using "bash -c")
// Create wrapper to handle missing files:
// NB: here we're assuming -v is the first argument, and the file to process is the second one!!!!
// #!/bin/sh
// [-f $2 ] && wgrib2 $@ || echo "1:0:d=0:ERR:file_not_found::"
// as /usr/bin/wgrib2_wrapper
// NB2: don't forget to make it executable


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
		STRING line;
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
		SELF.line := pRecord.line;
	END;
	
	EXPORT inventory( STRING localUri ) := FUNCTION
		A := PIPE('bash -c "[ -f ' + localUri + ' ] && wgrib2 -v ' + localUri + '|| echo 1:0:d=0:ERR:file_not_found::"', BinUtils.line_layout, CSV(SEPARATOR(''), QUOTE('')) );
		B := PROJECT(A, line_to_inventory(LEFT) );
		RETURN B;
	END;
	
	EXPORT to_csv( STRING sourceLocalUri, STRING targetLocalUri ) := FUNCTION
		A := PIPE('bash -c "[ -f ' + sourceLocalUri + ' ] && wgrib2 -v ' + sourceLocalUri + ' -csv ' + targetLocalUri + '|| echo 1:0:d=0:ERR:file_not_found::"', BinUtils.line_layout, CSV(SEPARATOR(''), QUOTE('')) );
		B := PROJECT(A, line_to_inventory(LEFT) );
		RETURN B;
	END;
	
	EXPORT batch_layout := RECORD
		STRING sourceUri;
		STRING targetUri;
	END;
	
	EXPORT batch_result_layout := RECORD
		STRING sourceUri;
		STRING targetUri;
		inventory_layout;
	END;
	
	SHARED batch_result_layout BatchCSV (batch_layout pInput) := TRANSFORM
		SELF.sourceUri := pInput.sourceUri;
		SELF.targetUri := pInput.targetUri;
		SELF := to_csv(pInput.sourceUri, pInput.targetUri)[1];
	END;

	EXPORT batch_to_csv( DATASET(batch_layout) batch ) := NORMALIZE( batch, 1, BatchCSV(LEFT) );
	
END;