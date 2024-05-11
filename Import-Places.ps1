param (
    [Parameter(Mandatory)]  [string]$csvPath,
    [Parameter(Mandatory)]  [string]$jsonPath,
    [Parameter(Mandatory)]  [string]$jsonOutputPath
)


# $csvPath = "output-cn-1.csv"
# $jsonPath = "d:\whlc.json"
# $jsonOutputPath = "output.json"
Write-Host "Importing '$csvPath'..."

$csvData = Import-Csv $csvPath | Where-Object { $_.Region -notmatch '^-+$' }
$jsonData = Get-Content $jsonPath -Encoding UTF8 | ForEach-Object { $_ | ConvertFrom-Json }
$result = @()
$handledPlaces = @()

$maxGrampsId = 0
foreach ($item in $result) {
    if ($item._class -eq 'Place' -and $item.gramps_id -match '^P(\d{4})$') {
        $idNumber = [int]($item.gramps_id -replace '^P', '')
        if ($idNumber -gt $maxGrampsId) {
            $maxGrampsId = $idNumber
        }
    }
}

$placeJson = $jsonData | Where-Object { $_._class -eq 'Place' }
$nonPlaceJson = $jsonData | Where-Object { $_._class -ne 'Place' }
$result += $nonPlaceJson

$newUrlType = @{ _class = 'UrlType'; string = 'Wikipedia' }

function New-Handle {
    $unixTime = [int64](Get-Date -UFormat %s)
    $timeComponent = $unixTime * 10000
    $randomComponent = Get-Random -Minimum 0 -Maximum 0x7FFFFFFF

    return ("{0:x8}{1:x8}" -f $timeComponent, $randomComponent)
}

function FindEnclosingPlaceHandle {
    param (
        [Parameter(Mandatory = $true)]
        [string[]]$enclosureLevels
    )

    if ($enclosureLevels.Length -ne 4) { return $null }

    $currentPlaces = $placeJson
    $lastValidPlace = $null

    for ($i = 0; $i -lt $enclosureLevels.Length; $i++) {
        if ($null -ne $enclosureLevels[$i]) {
            $currentPlace = $currentPlaces | Where-Object { $_.name.value -eq $enclosureLevels[$i] }
            if ($currentPlace) {
                $lastValidPlace = $currentPlace

                if ($i -lt $enclosureLevels.Length - 1 -and $null -ne $enclosureLevels[$i + 1]) {
                    $currentPlaces = $currentPlace.placeref_list | ForEach-Object {
                        $placeJson | Where-Object { $_.handle -eq $_.ref }
                    }
                }
                else {
                    #Write-Host "no final match"
                }
            }
            else {
                #Write-Host "currentPlace is null"
            }
        }
        else {
            #Write-Host "enclosureLevels[$i] is null"
        }
    }
    
    if ($lastValidPlace) {
        return $lastValidPlace.handle
    }

    return $null
}


function Update-Property {
    param (
        [Parameter(Mandatory = $true)][psobject]$Object,
        [Parameter(Mandatory = $true)][string]$PropertyName,
        [Parameter(Mandatory = $true)][object]$Value
    )

    if ($Object.psobject.Properties.Match($PropertyName).Count -eq 0) {
        $Object | Add-Member -MemberType NoteProperty -Name $PropertyName -Value $Value -Force
    }
    else {
        $Object.$PropertyName = $Value
    }
}

try {    
    foreach ($csvRow in $csvData) {
        $shortName = $csvRow.Region.Trim()
        #Write-Host "Region = $($csvRow.Region)"
        #Write-Host "Region_Native = $($csvRow.Region_Native)"

        if ($csvRow.Region -and $csvRow.Region_Native -and ($csvRow.Region_Native.Trim() -eq 'NULL' -or (($csvRow.Region.Trim() -eq $csvRow.Region_Native.Trim())))) {
            $longName = $shortName
        }
        else {
            $longName = ($csvRow.Region + ' ' + $csvRow.Region_Native).Trim()
        }

        if (($longName -match $shortName) -or (@('United States', 'Canada', 'United Kingdom of Great Britain and Northern Ireland', 'Commonwealth of Australia', 'New Zealand') -contains $shortName)) {
            $longName = $shortName
        }

        #Write-Host "short = $shortName"
        #Write-Host "long = $longName"

        $shortName = $shortName -replace '’'  '’'
        $longName = $longName -replace '’'  '’'

        $matchedJsonItem = $placeJson | Where-Object { ($_.name.value -eq $shortName) -or ($_.name.value -eq $longName) }

        #Write-Host "match = $matchedJsonItem"

        $urlsArray = @()
        $newUrl = @{ _class = 'Url'; private = $false; path = $csvRow.Wikipedia_URL; type = $newUrlType }
        $urlsArray += $newUrl

        $altNamesArray = @()
        $newAltName = @{ _class = 'PlaceName'; date = $null; value = $csvRow.Region_Native; lang = $csvRow.Language }
        $altNamesArray += $newAltName

        $csvRow.Enclosed_By_Level3 = if ($csvRow.Enclosed_By_Level3 -eq '') { $null } else { $csvRow.Enclosed_By_Level3 }
        $csvRow.Enclosed_By_Level2 = if ($csvRow.Enclosed_By_Level2 -eq '') { $null } else { $csvRow.Enclosed_By_Level2 }
        $csvRow.Enclosed_By_Level1 = if ($csvRow.Enclosed_By_Level1 -eq '') { $null } else { $csvRow.Enclosed_By_Level1 }
        $csvRow.Enclosed_By_Level0 = if ($csvRow.Enclosed_By_Level0 -eq '') { $null } else { $csvRow.Enclosed_By_Level0 }

        $enclosureLevels = @($csvRow.Enclosed_By_Level3, $csvRow.Enclosed_By_Level2, $csvRow.Enclosed_By_Level1, $csvRow.Enclosed_By_Level0) -ne $null
        $enclosureLevels = $enclosureLevels + @($null, $null, $null, $null) | Select-Object -First 4

        $enclosureHandle = FindEnclosingPlaceHandle -enclosureLevels $enclosureLevels

        if ($enclosureHandle) {
            $placeRefArray = @(@{ _class = 'PlaceRef'; ref = $enclosureHandle; date = $null })
        }
        else {
            $placeRefArray = @()
        }
    
        if ($matchedJsonItem) {
            Update-Property -Object $matchedJsonItem -PropertyName 'change' -Value ([int][double]::Parse((Get-Date -UFormat %s)))
            Update-Property -Object $matchedJsonItem -PropertyName 'long' -Value "$($csvRow.Longitude)E"
            Update-Property -Object $matchedJsonItem -PropertyName 'lat' -Value "$($csvRow.Latitude)N"
            Update-Property -Object $matchedJsonItem -PropertyName 'title' -Value ''
            Update-Property -Object $matchedJsonItem -PropertyName 'name' -Value @{ _class = 'PlaceName'; date = $null; value = $longName; lang = '' }
            Update-Property -Object $matchedJsonItem -PropertyName 'alt_names' -Value $altNamesArray
            Update-Property -Object $matchedJsonItem -PropertyName 'urls' -Value $urlsArray
            Update-Property -Object $matchedJsonItem -PropertyName 'placeref_list' -Value $placeRefArray

            # Add to results
            $result += $matchedJsonItem
            $handledPlaces += $matchedJsonItem.handle
        }
        else {
            $maxGrampsId++
            $newGrampsId = "P{0:D4}" -f $maxGrampsId

            $newPlace = @{
                _class        = 'Place'
                handle        = New-Handle
                change        = [int][double]::Parse((Get-Date -UFormat %s))
                private       = $false
                tag_list      = @()
                gramps_id     = $newGrampsId
                citation_list = @()
                note_list     = @()
                media_list    = @()
                long          = "$($csvRow.Longitude)E"
                lat           = "$($csvRow.Latitude)N"
                title         = ''
                name          = @{ _class = 'PlaceName'; date = $null; value = $longName; lang = '' }
                alt_names     = $altNamesArray
                placeref_list = $placeRefArray
                place_type    = @{ _class = 'PlaceType'; string = $csvRow.Type }
                code          = ''
                alt_loc       = @()
                urls          = $urlsArray
            }
            $result += $newPlace
            $handledPlaces += $newPlace.handle
        }
    }
}
catch {
    Write-Host "Error: $_"
    exit
}
foreach ($jsonPlace in $placeJson) {
    if ($jsonPlace.handle -notin $handledPlaces) {
        $result += $jsonPlace
    }
}

if (Test-Path -Path $jsonOutputPath) {
    Remove-Item -Path $jsonOutputPath
}

$result | ForEach-Object {
    $_ | ConvertTo-Json -Depth 10 -Compress | Add-Content -Path $jsonOutputPath -Encoding UTF8
}