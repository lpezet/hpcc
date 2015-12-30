


EXPORT BinUtils := MODULE

	EXPORT line_layout := RECORD
		STRING line;
		STRING2 nl := '\r\n';
	END;
	
	EXPORT checksum_layout := RECORD
		STRING md5;
		STRING uri;
	END;

	EXPORT cat( STRING localUri ) := PIPE('cat ' + localUri, line_layout, CSV(SEPARATOR(''), QUOTE('')) );
	
	EXPORT mkdir( STRING localUri , BOOLEAN makeParents = false) := FUNCTION
		A := 'mkdir ';
		B := A + IF(makeParents, '-p ', '');
		oCmd := B;
		RETURN PIPE(oCmd + localUri, line_layout, CSV(SEPARATOR(''), QUOTE('')) );
	END;
	
	EXPORT rm( STRING localUri ) := PIPE('rm -v ' + localUri, line_layout, CSV(SEPARATOR(''), QUOTE('')) );
	
	EXPORT checksum( STRING localUri ) := PIPE('md5sum ' + localUri, checksum_layout, CSV(SEPARATOR('  ')) );
	
	//EXPORT cron( STRING schedule, STRING job ) := PIPE('cron
END;
