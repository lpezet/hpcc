IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;

IMPORT Education.NCES.CCD.Universe.School;
IMPORT Education.NCES.CCD.Universe.SchoolUtils;



//OUTPUT(BinUtils.cat('/var/lib/HPCCSystems/mydropzone/NCES/CCD/Layouts/sc121alay.txt'), ALL);
//SchoolUtils.downloadLayout( 2010 );
// 2013, 32
// 2012, 32
// 2011, 30
// 2010, 29
//OUTPUT( SchoolUtils.parseLayout( 2010, 29 ) , ALL );


//School.extract(2011);
//School.load(2011);
oDS := School.dsRaw(2012);
oDS(REGEXFIND('betsy', schnam, NOCASE));
