IMPORT Linux.Curl;
IMPORT Linux.Zip;
IMPORT Linux.BinUtils;

IMPORT Health.CMS.PUF.NPPES.Extract;
IMPORT Health.CMS.PUF.NPPES.Load;
// 1. Download and extract data
//#OPTION('targetClusterType','hthor');
//Extract.extract_full();
//Extract.extract_weekly();
Extract.extract_deactivation();

// 2. Load demo data
//Load.load('CMS/NPPES/npidata_20050523-20151213.csv', '~cms::nppes::full::20151213_20050523');
//Load.load('CMS/NPPES/npidata_20151214-20151220.csv', '~cms::nppes::weekly::20151220_20151214');
//Load.load('CMS/NPPES/npidata_20050523-20151213.csv', '~cms::nppes::deactivation::20151213_20050523');