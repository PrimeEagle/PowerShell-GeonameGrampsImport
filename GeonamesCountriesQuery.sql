--WITH LanguageInfo AS (
--    SELECT 
--        geonameid,
--        primary_language = CASE 
--            WHEN CHARINDEX('-', primary_lang) > 0 THEN LEFT(primary_lang, CHARINDEX('-', primary_lang) - 1)
--            ELSE primary_lang
--        END
--    FROM (
--        SELECT 
--            g.geonameid,
--            primary_lang = CASE 
--                WHEN CHARINDEX(',', c.languages) > 0 THEN LEFT(c.languages, CHARINDEX(',', c.languages) - 1)
--                ELSE c.languages
--            END
--        FROM 
--            geoname g
--            JOIN countryInfo c ON g.country_code = c.iso
--        WHERE 
--            g.feature_code = 'PCLI'
--    ) AS derived_table
--)
--SELECT 
--    g.name AS [Region],
--    an.alternate_name AS [Region_Native],
--    ilc.language_name AS [Language],
--    'Country' AS [Type],
--    g.latitude AS [Latitude],
--    g.longitude AS [Longitude],
--    NULL AS [Enclosed_By_Level0],
--    NULL AS [Enclosed_By_Level1],
--    NULL AS [Enclosed_By_Level2],
--    NULL AS [Enclosed_By_Level3],
--    (SELECT TOP 1 alternate_name FROM alternate_name WHERE isolanguage = 'link' AND geonameid = g.geonameid AND alternate_name LIKE 'https://en.wikipedia%') AS [Wikipedia_URL]
--FROM 
--    geoname g
--    LEFT JOIN LanguageInfo li ON g.geonameid = li.geonameid
--    LEFT JOIN alternate_name an ON an.geonameid = g.geonameid AND an.isolanguage <> 'en' AND an.isolanguage = li.primary_language
--    LEFT JOIN iso_language_code ilc ON ilc.ISO639_1 = li.primary_language AND ilc.ISO639_1 <> 'en'
--WHERE 
--    g.feature_code = 'PCLI'
--ORDER BY 
--    g.name;


--select 
--	  g.name as [Region],
--	  (select top 1 alternate_name from alternate_name where isolanguage <> 'en' and isolanguage = 
--		  (select top 1 * from string_split(
--				(select top 1 * from string_split(
--					(select top 1 languages from countryInfo where iso = g.country_code)
--					, ',')
--				)
--			, '-')
--			--ORDER BY
--			--	CASE WHEN alternate_name COLLATE Latin1_General_BIN LIKE '%[^a-zA-Z0-9]%' THEN 0 ELSE 1 END,
--			--	alternate_name
--			)
--	  ) as [Region_Native],
--	  (
--		select language_name from iso_language_code where ISO639_1 <> 'en' and ISO639_1 = (
--		select top 1 * from string_split(
--			(select top 1 * from string_split(
--				(select top 1 languages from countryInfo where iso = g.country_code)
--				, ',')
--			)
--		, '-')
--		--ORDER BY
--		--	CASE WHEN language_name COLLATE Latin1_General_BIN LIKE '%[^a-zA-Z0-9]%' THEN 0 ELSE 1 END,
--		--	language_name
--		)
--	  ) as [Language],
--	  'Country' as [Type],
--	  g.latitude as [Latitude],
--	  g.longitude as [Longitude],
--	  null as [Enclosed_By_Level0],
--	  null as [Enclosed_By_Level1],
--	  null as [Enclosed_By_Level2],
--	  null as [Enclosed_By_Level3],
--	  (select top 1 alternate_name from alternate_name where isolanguage = 'link' and geonameid = g.geonameid and alternate_name like 'https://en.wikipedia%') as [Wikipedia_URL]
--from geoname g
--where g.feature_code = 'PCLI'
--order by name




WITH ParsedLanguages AS (
    SELECT
        countryInfo.iso,
        FirstLanguage = (SELECT TOP 1 LEFT(value, CHARINDEX('-', value) - 1) 
                         FROM STRING_SPLIT(countryInfo.languages, ',') 
                         WHERE RTRIM(value) <> '' AND CHARINDEX('-', value) > 0
                         ORDER BY CASE WHEN value LIKE N'%[^ -~]%' THEN 0 ELSE 1 END)
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