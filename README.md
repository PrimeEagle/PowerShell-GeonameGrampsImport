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


## Step 4: Convert to Gramps JSON


## Step $: Import into Gramps
Before proceeding, you will need the "JSON Import" addon installed in Gramps.
