IMPORT Education.NCES.CCD.Universe._Layouts AS L;

EXPORT Layouts := MODULE


	//EXPORT school_raw_layout := L.Master.raw_layout;
	
	EXPORT school_raw_layout(UNSIGNED pYear) := L.School.raw_layout(pYear);
	


END;
