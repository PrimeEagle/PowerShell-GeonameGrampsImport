# PowerShell-GeonameGrampsImport
PowerShell and SQL scripts are used to import Geonames and place data into Gramps family tree software.

The workflow is Geonames CSV files -> import into database -> SQL scripts to process into new CSV files -> PowerShell scripts to convert CSV data to JSON data -> Import into Gramps using JSON Import/Export Add-on.


## Step 1: Downloading or Updating Geonames Files
```
cd datafolder
.\Update-Geonames.ps1
```


## Step 2: Import into Database
The SQL scripts are written for SQL Server, but modifying them for other databases shouldn't be too difficult.
Run them in this order. Note that the second one might take quite a while. It does a lot of preprocessing for the next step.
```
GeonamesSchema.sql
GeonamesImport.sql
```


## Step 3: Export to CSV
```
sqlcmd -S servername\instancename -d databasename -U username -P password -i GeonamesQuery.sql
        -v CountryCode="us" -v AdminLevel="1" -o "output.csv" -s"," -W -u
```

Fill in the server name, instance name, database name, username, password, country code, administrative regions level, and the output file name.


## Step 4: Convert to Gramps JSON
```
.\Import-Places.ps1 -csvPath csvFile -jsonPath inputJsonFile -jsonOutputPath outputJsonFile
```
csvFile - the output file from Step 3
inputJsonFile - an input JSON file to merge with. Either use the included blank.json, or a .json file exported from Gramps.
outputJsonFile - the output JSON file, which consists of the csvFile merged with the inputJsonFile.


## Step 5: Import into Gramps
Before proceeding, you will need the "JSON Import" addon installed in Gramps.

Open Gramps, go to the Family Trees menu, then click on "Import..."
