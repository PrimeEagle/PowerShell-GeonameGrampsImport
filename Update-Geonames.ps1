Invoke-WebRequest https://download.geonames.org/export/dump/admin1CodesASCII.txt -OutFile admin1CodesASCII.txt -Force
Invoke-WebRequest https://download.geonames.org/export/dump/admin2Codes.txt -OutFile admin2Codes.txt -Force
Invoke-WebRequest https://download.geonames.org/export/dump/allCountries.zip   -OutFile allCountries.zip -Force
Invoke-WebRequest https://download.geonames.org/export/dump/alternateNamesV2.zip -OutFile alternateNamesV2.zip -Force
Invoke-WebRequest https://download.geonames.org/export/dump/countryInfo.txt -OutFile countryInfo.txt -Force
Invoke-WebRequest https://download.geonames.org/export/dump/featureCodes_en.txt -OutFile featureCodes_en.txt -Force
Invoke-WebRequest https://download.geonames.org/export/dump/hierarchy.zip  -OutFile hierarchy.zip  -Force
Invoke-WebRequest https://download.geonames.org/export/dump/iso-languagecodes.txt -OutFile iso-languagecodes.txt -Force


Expand-Archive -Path "allCountries.zip " -DestinationPath "." -Force
Expand-Archive -Path "alternateNamesV2.zip " -DestinationPath "." -Force
Expand-Archive -Path "hierarchy.zip " -DestinationPath "." -Force