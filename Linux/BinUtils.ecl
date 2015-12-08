


BinUtils := MODULE

	EXPORT line_layout := RECORD
		STRING line;
		STRING2 nl := '\r\n';
	END;

	EXPORT cat( STRING localUri ) := PIPE('cat ' + localUri,  line_layout, CSV(SEPARATOR(''), QUOTE('')) );
	
END;
