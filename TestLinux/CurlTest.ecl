IMPORT Linux.Curl;


oCurl := Curl.download('http://www1.ncdc.noaa.gov/pub/data/ghcn/daily/readme.txt', '/dev/null', false);
ASSERT(oCurl, http_code = '200'); 