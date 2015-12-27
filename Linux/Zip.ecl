IMPORT Linux.BinUtils;

EXPORT Zip := MODULE

	EXPORT unzip(STRING localUri, STRING targetUri = '') := FUNCTION
		A := 'unzip ';
		B := A + localUri;
		C := B + IF(LENGTH(targetUri) > 0, ' -d ' + targetUri, '');
		oCmd := C;
		RETURN PIPE(oCmd, BinUtils.line_layout, CSV(SEPARATOR(''), QUOTE('')) );
	END;
END;