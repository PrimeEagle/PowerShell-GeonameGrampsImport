WITH ParsedLanguages AS (
SELECT
    countryInfo.iso,
    FirstLanguage = COALESCE(
        (SELECT TOP 1 LEFT(value, CHARINDEX('-', value) - 1) 
         FROM STRING_SPLIT(countryInfo.languages, ',') 
         WHERE RTRIM(value) <> '' AND CHARINDEX('-', value) > 0 AND RTRIM(value) NOT LIKE 'en%'
         ORDER BY CASE WHEN value LIKE N'%[^ -~]%' THEN 0 ELSE 1 END),
        (SELECT TOP 1 value
         FROM STRING_SPLIT(countryInfo.languages, ',')
         WHERE RTRIM(value) <> '' AND CHARINDEX('-', value) = 0 AND RTRIM(value) NOT LIKE 'en%')
    )
FROM countryInfo

)
SELECT 
    g.name AS [Region],
    (select top 1 alternate_name from alternate_name where geonameid = g.geonameid and isolanguage = pl.FirstLanguage) AS [Region_Native],
    (SELECT language_name FROM iso_language_code WHERE ISO639_1 = pl.FirstLanguage) as [Language],
    'Country' as [Type],
    g.latitude as [Latitude],
    g.longitude as [Longitude],
    null as [Enclosed_By_Level0],
    null as [Enclosed_By_Level1],
    null as [Enclosed_By_Level2],
    null as [Enclosed_By_Level3],
    (SELECT TOP 1 alternate_name FROM alternate_name 
     WHERE isolanguage = 'link' AND geonameid = g.geonameid AND alternate_name LIKE 'https://en.wikipedia%') as [Wikipedia_URL]
FROM 
    geoname g
    LEFT JOIN ParsedLanguages pl ON g.country_code = pl.iso
WHERE 
    g.feature_code = 'PCLI'
ORDER BY 
    g.name;