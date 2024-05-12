SET NOCOUNT ON;

declare @countryCode varchar(2)
declare @adminLevels varchar(50)

set @countryCode = '$(CountryCode)'
set @adminLevels = '$(AdminLevel)'

--set @countryCode = 'us'
--set @adminLevels = '1'

drop table if exists #geoname_include
create table #geoname_include
(
	geonameid int,
	admin_level int
)

INSERT INTO #geoname_include (geonameid, admin_level)
SELECT geonameid, 
       CASE 
           WHEN feature_code = 'ADM1' THEN 1
           WHEN feature_code = 'ADM2' THEN 2
           WHEN feature_code = 'ADM3' THEN 3
           WHEN feature_code = 'ADM4' THEN 4
           ELSE NULL
       END as admin_level
FROM geoname
WHERE country_code = @countryCode AND
      (feature_code IN ('ADM1', 'ADM2', 'ADM3', 'ADM4') AND
       dbo.IncludeAdminLevel(@adminLevels, CAST(SUBSTRING(feature_code, 4, 1) AS int)) = 1);

DECLARE @languageCode varchar(10)
SELECT @languageCode = ISNULL(
    (
        SELECT TOP 1 value 
        FROM STRING_SPLIT(languages, ',') 
        WHERE LEFT(value, 2) <> 'en' OR (SELECT COUNT(*) FROM STRING_SPLIT(languages, ',')) = 1
        ORDER BY (CASE WHEN LEFT(value, 2) = 'en' THEN 1 ELSE 0 END)
    ),
    languages
)
FROM countryInfo
WHERE iso = @countryCode;

SET @languageCode = REPLACE(@languageCode, '-' + @countryCode, '');
if(@countryCode = 'in') set @languageCode = 'hi'
if(@countryCode in ('us', 'gb', 'ca', 'au', 'nz')) set @languageCode = 'en'

declare @language varchar(250)

select @language = ltrim(rtrim(replace(replace(language_name, char(10), ''), char(13), ''))) from iso_language_code where ISO639_1 = @languageCode

SELECT 
    dbo.CleanRegionName(g.geonameid) as [Region],
    MAX(CASE WHEN @languageCode = 'en' then null when an.isolanguage = @languageCode THEN dbo.CleanAlternateRegionName(an.alternateNameId) END) AS [Region_Native],
	@language as [Language],
    g.regionType AS [Type], 
    g.latitude AS [Latitude],
    g.longitude AS [Longitude],
	case when gi.admin_level in (1, 2, 3, 4) then dbo.GetEnclosedBy(g.geonameid, 0) else null end as [Enclosed_By_Level0],
	case when gi.admin_level in (2, 3, 4) then dbo.GetEnclosedBy(g.geonameid, 1) else null end as [Enclosed_By_Level1],
	case when gi.admin_level in (3, 4) then dbo.GetEnclosedBy(g.geonameid, 2) else null end as [Enclosed_By_Level2],
	case when gi.admin_level in (4) then dbo.GetEnclosedBy(g.geonameid, 3) else null end as [Enclosed_By_Level3],
    MAX(CASE WHEN an.geonameid = g.geonameid AND an.isolanguage = 'link' AND an.alternate_name LIKE 'https://en.wikipedia%' THEN an.alternate_name END) AS [Wikipedia_URL]
FROM 
    geoname g
INNER JOIN 
    #geoname_include gi ON g.geonameid = gi.geonameid
LEFT JOIN 
    alternate_name an ON an.geonameid = g.geonameid AND (an.isolanguage = 'en' OR an.isolanguage = @languageCode OR (an.isolanguage = 'link' AND an.alternate_name LIKE 'https://en.wikipedia%'))
GROUP BY 
    g.geonameid, g.regionType, g.latitude, g.longitude, g.feature_code, g.name, gi.admin_level
ORDER BY 
    g.feature_code, g.name;