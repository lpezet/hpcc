IMPORT Linux.Curl;


oCurl := Curl.download('http://www1.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt', '/tmp/hpcc_linux_curl_test.txt', false);
ASSERT(oCurl, http_code = '200'); 