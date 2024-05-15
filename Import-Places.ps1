param (
    [Parameter(Mandatory)]  [string]$csvPath,
    [Parameter(Mandatory)]  [string]$jsonPath,
    [Parameter(Mandatory)]  [string]$jsonOutputPath,
    [Parameter(Mandatory)]  [int]$adminLevel
)


# $csvPath = "output-cn-1.csv"
# $jsonPath = "d:\whlc.json"
# $jsonOutputPath = "output.json"
Write-Host "Importing '$csvPath'...outputting '$jsonOutputPath'"

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

$jsonData = $jsonData | Where-Object { $_.handle.Length -in @(26, 27) }
$placeJson = $jsonData | Where-Object { $_._class -eq 'Place' }
$nonPlaceJson = $jsonData | Where-Object { $_._class -ne 'Place' }
$result += $nonPlaceJson

$newUrlType = @{ _class = 'UrlType'; string = 'Wikipedia' }
function New-Handle {
    $unixTime = [int64](Get-Date -UFormat %s)
    $timeComponent = $unixTime * 10000  # Back to 10000 if higher multipliers produce overly long outputs
    $formattedTime = "{0:x11}" -f $timeComponent
    $maxInt = [int32]::MaxValue

    $randomComponent1 = Get-Random -Minimum 0 -Maximum $maxInt
    $randomComponent2 = Get-Random -Minimum 0 -Maximum $maxInt

    $formattedRandom1 = "{0:x8}" -f $randomComponent1
    $formattedRandom2 = "{0:x8}" -f $randomComponent2

    return $formattedTime + $formattedRandom1 + $formattedRandom2
}

function FindEnclosingPlaceHandle {
    param (
        [Parameter(Mandatory = $true)]
        [string[]]$enclosureLevels
    )

    if ($enclosureLevels.Length -ne 4) { return $null }

    $currentPlaces = $placeJson
    $firstValidHandle = $null
    Write-Host "  Checking enclosure levels: $($enclosureLevels | Format-List | Out-String)"

    for ($i = 0; $i -lt $enclosureLevels.Length; $i++) {
        Write-Host "  Checking level $($i): $($enclosureLevels[$i])"
        if (-not [string]::IsNullOrEmpty($enclosureLevels[$i]) -and $enclosureLevels[$i] -ne 'NULL') {
            $placeMatches = $currentPlaces | Where-Object { $_.name.value -eq $enclosureLevels[$i] -and ((Get-AdminLevel -Handle $_.handle) -eq (3 - $i)) }

            if ($placeMatches) {
                if($placeMatches -is [array]) {
                    $placeMatches = $placeMatches[0]
                }
                Write-Host ($placeMatches | Format-List | Out-String)
                
                if (-not $firstValidHandle) {
                    $firstValidHandle = $placeMatches.handle
                }
                Write-Host "    Found match for $($enclosureLevels[$i]) with handle $($placeMatches.handle)"
                if ($i -lt $enclosureLevels.Length - 1) {
                    $nextLevelPlaces = @()
                    foreach ($match in $placeMatches) {
                        foreach ($placeref in $match.placeref_list) {
                            $refMatches = $placeJson | Where-Object { $_.handle -eq $placeref.ref }
                            $nextLevelPlaces += $refMatches
                        }
                    }
                    $currentPlaces = $nextLevelPlaces
                }
            }
            else {
                Write-Host "    No match found for $($enclosureLevels[$i])"
                return $null
            }
        }
        else {
            Write-Host "    Skipping null or 'NULL' value"
        }
    }

    if ($firstValidHandle) {
        Write-Host "    Returning first valid handle: $firstValidHandle"
        return $firstValidHandle
    }
    else {
        Write-Host "    No valid path found for the given names"
        return $null
    }
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
        if ($Value -is [array]) {
            #Write-Host "Updating array property '$PropertyName':"
            #$Value | ConvertTo-Json -Compress | Write-Host
        }
        $Object.$PropertyName = $Value
    }
}

function Get-AdminLevel {
    param (
        [Parameter(Mandatory = $true)][string]$Handle
    )

    $matchItems = $placeJson | Where-Object { $_.handle -eq $Handle }
    $matchItems | ForEach-Object {
        $foundRoot = $false
        $currHandle = $_.handle
        $foundLevel = 0

        while (-not $foundRoot) {
            $refs = ($placeJson | Where-Object { $_.handle -eq $currHandle }).placeref_list
            if ($refs.Length -eq 0) {
                $foundRoot = $true
            }
            else {
                $currHandle = $refs[0].ref
                $foundLevel++
            }
        }
    }

    return $foundLevel
}

function Find-Match {
    param (
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][int]$Level
    )

    $matchItems = $placeJson | Where-Object { $_.name.value -eq $Name }
    $matchItems | ForEach-Object {
        $foundRoot = $false
        $currHandle = $_.handle
        $foundLevel = 0

        while(-not $foundRoot) {
            $refs = ($placeJson | Where-Object { $_.handle -eq $currHandle }).placeref_list
            if($refs.Length -eq 0) {
                $foundRoot = $true
            }
            else {
                $currHandle = $refs[0].ref
                $foundLevel++
            }
        }

        if ($Level -eq $foundLevel) {
            return $_
        }
    }
}

try {    
    foreach ($csvRow in $csvData) {
        #Write-Host "CSV: $csvRow"
        $name = $csvRow.Region.Trim()
        Write-Host $name

        $name = $name.Trim().Replace("[", "").Replace("]", "").Replace("’", "'")
        #$matchPattern = "(?<=^|\s)***(?=$|\s)"
        #$matchedJsonItem = $placeJson | Where-Object { ($_.name.value -eq $name) }
        if([string]::IsNullOrEmpty($name)) {
            Write-Host "Skipping empty name"
            Write-Host "CSV: $csvRow"
            $a = Read-Host "Press Enter to continue"
        }
        $matchedJsonItem = Find-Match -Name $name -Level $adminLevel

        if($matchedJsonItem.Length -gt 1) {
            Write-Host "ERROR: Multiple matches found for '$name'"
            Write-Host $csvRow
            $matchedJsonItem = $matchedJsonItem[0]
        }

        $urlsArray = @()
        if ($csvRow.Wikipedia_URL -and $csvRow.Wikipedia_URL -ne 'NULL') {
            $newUrl = [PSCustomObject]@{
                _class  = 'Url'
                desc    = ''
                private = $false
                path    = $csvRow.Wikipedia_URL
                type    = $newUrlType
            }
            $urlsArray += $newUrl
        }

        $altNamesArray = @()
        $newAltName = @{ _class = 'PlaceName'; date = $null; value = $csvRow.Region_Native; lang = $csvRow.Language }
        $altNamesArray += $newAltName


        $csvRow.Enclosed_By_Level3 = if ($csvRow.Enclosed_By_Level3.Trim() -eq '' -or $csvRow.Enclosed_By_Level3 -eq $shortName) { 'NULL' } else { $csvRow.Enclosed_By_Level3 }
        $csvRow.Enclosed_By_Level2 = if ($csvRow.Enclosed_By_Level2.Trim() -eq '' -or $csvRow.Enclosed_By_Level2 -eq $shortName) { 'NULL' } else { $csvRow.Enclosed_By_Level2 }
        $csvRow.Enclosed_By_Level1 = if ($csvRow.Enclosed_By_Level1.Trim() -eq '' -or $csvRow.Enclosed_By_Level1 -eq $shortName) { 'NULL' } else { $csvRow.Enclosed_By_Level1 }
        $csvRow.Enclosed_By_Level0 = if ($csvRow.Enclosed_By_Level0.Trim() -eq '' -or $csvRow.Enclosed_By_Level0 -eq $shortName) { 'NULL' } else { $csvRow.Enclosed_By_Level0 }

        $enclosureLevels = @($csvRow.Enclosed_By_Level3.Replace("’", "'"), $csvRow.Enclosed_By_Level2.Replace("’", "'"), $csvRow.Enclosed_By_Level1.Replace("’", "'"), $csvRow.Enclosed_By_Level0.Replace("’", "'")) -ne $null
        $enclosureLevels = $enclosureLevels + @($null, $null, $null, $null) | Select-Object -First 4
        $enclosureHandle = FindEnclosingPlaceHandle -enclosureLevels $enclosureLevels

        if($enclosureHandle -is [array] -and $enclosureHandle.Length -gt 1) {
            Write-Host "ERROR: Multiple handles found for '$name'"
            Write-Host $csvRow
            $enclosureHandle = $enclosureHandle[0]
            $a = Read-Host "Press Enter to continue"
        }

        $placeRefArray = @()
        if ($enclosureHandle) {
            $newPlaceRef = [PSCustomObject]@{
                _class = 'PlaceRef'
                ref    = $enclosureHandle
                date   = $null
            }
            $placeRefArray += $newPlaceRef
        }

        if ($matchedJsonItem) {
            Update-Property -Object $matchedJsonItem -PropertyName 'change' -Value ([int][double]::Parse((Get-Date -UFormat %s)))
            Update-Property -Object $matchedJsonItem -PropertyName 'long' -Value "$($csvRow.Longitude)E"
            Update-Property -Object $matchedJsonItem -PropertyName 'lat' -Value "$($csvRow.Latitude)N"
            Update-Property -Object $matchedJsonItem -PropertyName 'title' -Value ''
            Update-Property -Object $matchedJsonItem -PropertyName 'name' -Value @{ _class = 'PlaceName'; date = $null; value = $name; lang = "$($csvRow.Language)" }
            Update-Property -Object $matchedJsonItem -PropertyName 'alt_names' -Value $altNamesArray
            Update-Property -Object $matchedJsonItem -PropertyName 'urls' -Value $urlsArray
            Update-Property -Object $matchedJsonItem -PropertyName 'placeref_list' -Value $placeRefArray
            
            if ($matchedJsonItem -isnot [PSCustomObject]) {
                Write-Host "ERROR result (type 1): $($matchedJsonItem | ConvertTo-Json -Depth 10 -Compress)"
            }
            $result += $matchedJsonItem
            $handledPlaces += $matchedJsonItem.handle
        }
        else {
            $maxGrampsId++
            $newGrampsId = "P{0:D4}" -f $maxGrampsId
            $newHandle = New-Handle

            $newPlace = [PSCustomObject]@{
                _class        = 'Place'
                handle        = $newHandle
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
                name          = [PSCustomObject]@{
                    _class = 'PlaceName'
                    date   = $null
                    value  = $name
                    lang   = $csvRow.Language
                }
                alt_names     = $altNamesArray
                placeref_list = $placeRefArray
                place_type    = [PSCustomObject]@{
                    _class = 'PlaceType'
                    string = $csvRow.Type
                }
                code          = ''
                alt_loc       = @()
                urls          = $urlsArray
            }

            if ($newPlace -isnot [PSCustomObject]) {
                Write-Host "ERROR result (type 2): $($newPlace | ConvertTo-Json -Depth 10 -Compress)"
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
        if ($jsonPlace -isnot [PSCustomObject]) {
            Write-Host "ERROR result (type 2): $($jsonPlace | ConvertTo-Json -Depth 10 -Compress)"
        }
        $result += $jsonPlace
    }
}

$newResult = @()
foreach ($item in $result) {
    if ($item -is [PSCustomObject]) {
        if ($item -isnot [PSCustomObject]) {
            Write-Host "ERROR to result (type 3): $($item | ConvertTo-Json -Depth 10 -Compress)"
        }
        $newResult += $item
    }
}

if (Test-Path -Path $jsonOutputPath) {
    Remove-Item -Path $jsonOutputPath
}

$newResult | ForEach-Object {
    $_ | ConvertTo-Json -Depth 10 -Compress | Add-Content -Path $jsonOutputPath -Encoding UTF8
}