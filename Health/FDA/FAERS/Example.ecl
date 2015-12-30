IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;

IMPORT Health.FDA.FAERS.Extract;
IMPORT Health.FDA.FAERS.Load;

// 1. Download and extract data
Extract.extract();

// 2. Load demo data
Load.demographic('FAERS/ascii/DEMO15Q3.txt');