USE Geonames;

:setvar BasePath "D:\\geonames\\"

BULK INSERT admin1_code
FROM '$(BasePath)admin1CodesASCII.txt'
WITH
(
    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
    FIRSTROW = 1,
	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
    TABLOCK
);


BULK INSERT admin2_code
FROM '$(BasePath)admin2Codes.txt'
WITH
(
    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
    FIRSTROW = 1,
	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
    TABLOCK
);

BULK INSERT feature_code
FROM '$(BasePath)featureCodes_en.txt'
WITH
(
    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
    FIRSTROW = 1,
	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
    TABLOCK
);


BULK INSERT hierarchy
FROM '$(BasePath)hierarchy.txt'
WITH
(
    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
    FIRSTROW = 1,
	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
    TABLOCK
);

BULK INSERT countryInfo
FROM '$(BasePath)countryInfo.txt'
WITH
(
    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
    FIRSTROW = 51,
	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
    TABLOCK
);

BULK INSERT iso_language_code
FROM 'd:\geonames\iso-languagecodes.txt'
WITH
(
    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
    FIRSTROW = 2,
	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
    TABLOCK
);

BULK INSERT alternate_name
FROM '$(BasePath)alternateNamesV2.txt'
WITH
(
    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
    FIRSTROW = 1,
	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
    TABLOCK
);

BULK INSERT geoname
FROM '$(BasePath)allCountries.txt'
WITH
(
    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
    FIRSTROW = 1,
	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
    TABLOCK
);

--BULK INSERT geoname
--FROM '$(BasePath)cities500.txt'
--WITH
--(
--    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
--    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
--    FIRSTROW = 1,
--	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
--    TABLOCK
--);

--BULK INSERT geoname
--FROM '$(BasePath)cities1000.txt'
--WITH
--(
--    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
--    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
--    FIRSTROW = 1,
--	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
--    TABLOCK
--);

--BULK INSERT geoname
--FROM '$(BasePath)cities5000.txt'
--WITH
--(
--    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
--    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
--    FIRSTROW = 1,
--	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
--    TABLOCK
--);

--BULK INSERT geoname
--FROM '$(BasePath)cities15000.txt'
--WITH
--(
--    FIELDTERMINATOR = '\t',  -- Tab character as field delimiter
--    ROWTERMINATOR = '0x0A',   -- Line feed as row delimiter
--    FIRSTROW = 1,
--	CODEPAGE = '65001',     -- This specifies UTF-8 encoding
--    TABLOCK
--);

truncate table regionType
go

INSERT INTO regionType ([name], [type]) VALUES
('Administrative-Territorial Unit', 'Administrative-Territorial Unit'),
('Administrative-Territorial Units', 'Administrative-Territorial Unit'),
('Arrondissement', 'Arrondissement'),
('Arrondissements', 'Arrondissement'),
('Autonomous Banner', 'Autonomous Banner'),
('Autonomous Banners', 'Autonomous Banner'),
('Autonomous Counties', 'Autonomous County'),
('Autonomous County', 'Autonomous County'),
('Autonomous Prefecture', 'Autonomous Prefecture'),
('Autonomous Prefectures', 'Autonomous Prefecture'),
('Autonomous Region', 'Autonomous Region'), 
('Autonomous Regions', 'Autonomous Region'), 
('Autonomous Republic', 'Autonomous Republic'), 
('Autonomous Republics', 'Autonomous Republic'), 
('Banner', 'Banner'),
('Banners', 'Banner'),
('Borough', 'Borough'),
('Boroughs', 'Borough'),
('Canton', 'Canton'),
('Cantons', 'Canton'),
('Census Area', 'Census Area'),
('Census Areas', 'Census Area'),
('Charter Township', 'Township'),
('Charter Townships', 'Township'),
('Cities', 'City'),
('City', 'City'),
('Commune', 'Commune'),
('Communes', 'Commune'),
('Counties', 'County'),
--('County', 'County'),
('County-level Cities', 'County-level City'),
('County-level City', 'County-level City'),
('District', 'District'),
('Districts', 'District'),
('Federation', 'Federation'),
('Federations', 'Federation'),
('Forestry District', 'Forestry District'),
('Forestry Districts', 'Forestry District'),
('Free and Hanseatic Cities', 'City'),
('Free and Hanseatic City', 'City'),
('Governorate', 'Governorate'),
('Governorates', 'Governorate'),
('League', 'League'),
('Leagues', 'League'),
('Metropolitan Borough', 'Metropolitan Borough'),
('Metropolitan Boroughs', 'Metropolitan Borough'),
('Municipal District', 'Municipal District'),
('Municipal Districts', 'Municipal District'),
('Municipalities', 'Municipality'), 
('Municipality', 'Municipality'), 
('National Capital Territories', 'City'), 
('National Capital Territory', 'City'), 
('Parish', 'Parish'),
('Parishes', 'Parish'),
('Plantation', 'Plantation'),
('Plantations', 'Plantation'),
('Prefecture', 'Prefecture'),
('Prefecture-level Cities', 'Prefecture-level City'),
('Prefecture-level City', 'Prefecture-level City'),
('Prefectures', 'Prefecture'),
('Principalities', 'Principality'),
('Principality', 'Principality'), 
('Province', 'Province'), 
('Provinces', 'Province'),
('Regional District', 'Regional District'),
('Regional Districts', 'Regional District'),
('Regional Municipalities', 'Regional Municipality'),
('Regional Municipality', 'Regional Municipality'),
('Republic', 'Country'),
('Republics', 'Country'),
('Resort Town', 'Resort Town'),
('Resort Towns', 'Resort Town'),
('Royal Borough', 'Royal Borough'),
('Royal Boroughs', 'Royal Borough'),
('Special Administrative Region', 'Special Administrative Region'),
('Special Administrative Regions', 'Special Administrative Region'),
('Special District', 'Special District'),
('Special Districts', 'Special District'),
('State', 'State'),
--('States', 'State'),
('Town', 'Town'),
('Towns', 'Town'),
('Township', 'Township'),
('Townships', 'Township'),
('Union Territories', 'Union Territory'),
('Union Territory', 'Union Territory'),
('United Counties', 'United County'),
('United County', 'United County'),
('Unorganized Territories', 'Unorganized Territory'),
('Unorganized Territory', 'Unorganized Territory'),
('Vale', 'Vale'),
('Vales', 'Vale'),
('Village', 'Village'),
('Villages', 'Village'),
('Ward', 'Ward'),
('Wards', 'Ward'),
(N'Dijishi', 'Prefecture-level City'),
(N'Diqu', 'District'),
(N'Linqu', 'Forestry District'),
(N'Meng', 'League'),
(N'Qi', 'Banner'),
(N'Sheng', 'Province'),
(N'Shi', 'City'),
(N'Tebiexingzhengqu', 'Special Administrative Region'),
(N'Tequ', 'Special District'),
(N'Xian', 'County'),
(N'Xianjishi', 'County-level City'),
(N'Zizhiqi', 'Autonomous Banner'),
(N'Zizhiqu', 'Autonomous Region'),
(N'Zizhixian', 'Autonomous County'),
(N'Zizhizhou', 'Autonomous Prefecture'),
(N'县', 'County'),
(N'县级市', 'County-level City'),
(N'地区', 'District'),
(N'地级市', 'Prefecture-level City'),
(N'市', 'City'),
(N'旗', 'Banner'),
(N'林区', 'Forestry District'),
(N'特别行政区', 'Special Administrative Region'),
(N'特区', 'Special District'),
(N'盟', 'League'),
(N'省', 'Province'),
(N'自治区', 'Autonomous Region'),
(N'自治县', 'Autonomous County'),
(N'自治州', 'Autonomous Prefecture'),
(N'自治旗', 'Autonomous Banner');
go


truncate table mapGeonameidName
insert mapGeonameidName select 1803360, 'Linqu'
insert mapGeonameidName select 1797437, 'Qi'
insert mapGeonameidName select 1797435, 'Qi'
insert mapGeonameidName select 1797436, 'Qi'
insert mapGeonameidName select 1790360, 'Xian'
insert mapGeonameidName select 12746453, 'Xian''an'
go



ALTER TABLE geoname ADD regionType NVARCHAR(100);
go



drop table if exists UpdateLog
CREATE TABLE UpdateLog (
    BatchSize INT,
    RowsAffected INT,
    Comment NVARCHAR(4000)
);

DECLARE @BatchSize INT = 10000;
DECLARE @Rows INT;

SET @Rows = @BatchSize;

BEGIN TRY
    WHILE @Rows > 0
    BEGIN
        WITH CTE AS (
            SELECT TOP (@BatchSize) *
            FROM geoname
            WHERE feature_code in ('ADM1', 'ADM2', 'ADM3', 'ADM4')
			and regionType IS NULL
        )
        UPDATE CTE
        SET regionType = CASE
            WHEN country_code = 'us' AND feature_code = 'ADM1' AND dbo.MatchWholeWord(name, N'District') = 0 THEN 'State'
            WHEN country_code = 'ca' AND feature_code = 'ADM1' THEN 'Province'
            WHEN country_code = 'gb' AND feature_code = 'ADM1' THEN 'Country'
            ELSE COALESCE(
                (
                    SELECT TOP 1 type
                    FROM regionType
                    WHERE dbo.MatchWholeWord(CTE.name, regionType.name) = 1
                    ORDER BY LEN(regionType.name) DESC
                ),
                'Unknown ' + feature_code
            )
        END;

        SET @Rows = @@ROWCOUNT;

        INSERT INTO UpdateLog (BatchSize, RowsAffected, Comment)
        VALUES (@BatchSize, @Rows, 'Batch completed successfully');

        WAITFOR DELAY '00:00:01';
    END
END TRY
BEGIN CATCH
    INSERT INTO UpdateLog (BatchSize, RowsAffected, Comment)
    VALUES (@BatchSize, 0, ERROR_MESSAGE());

    SET @Rows = 0;
END CATCH
go


DECLARE @BatchSize INT = 1000;
DECLARE @Rows INT;
SET @Rows = @BatchSize;

BEGIN TRY
    WHILE @Rows > 0
    BEGIN
        WITH CTE AS (
            SELECT TOP (@BatchSize) *
            FROM geoname
            WHERE feature_code in ('ADM1', 'ADM2', 'ADM3', 'ADM4')
			and regionType like 'Unknown%'
        )
        UPDATE CTE
        SET regionType = (
							SELECT TOP 1 type
							FROM regionType
							WHERE dbo.MatchWholeWord(CTE.alternatenames, regionType.name) = 1
							ORDER BY LEN(regionType.name) DESC
						 )

        SET @Rows = @@ROWCOUNT;

        INSERT INTO UpdateLog (BatchSize, RowsAffected, Comment)
        VALUES (@BatchSize, @Rows, 'Batch for alternames completed successfully');

        WAITFOR DELAY '00:00:01';
    END
END TRY
BEGIN CATCH
    INSERT INTO UpdateLog (BatchSize, RowsAffected, Comment)
    VALUES (@BatchSize, 0, ERROR_MESSAGE());

    SET @Rows = 0;
END CATCH
go

insert countryInfo
select country_code, null, null, null, name, null, null, null, null, null, null, null, null, null, null, null, geonameid, null, null
from geoname
where feature_code = 'PCLI'
and geonameid not in (select geonameid from countryInfo)
go

update countryInfo set languages = '' where country = 'Bouvet Island'
update countryInfo set languages = '' where country = 'Heard Island and McDonald Islands'
update countryInfo set languages = 'ca-AD' where country = 'Principality of Andorra'
update countryInfo set languages = 'ar-AE' where country = 'United Arab Emirates'
update countryInfo set languages = 'fa-AF, ps-AF' where country = 'Islamic Republic of Afghanistan'
update countryInfo set languages = 'en-AG' where country = 'Antigua and Barbuda'
update countryInfo set languages = 'sq-AL' where country = 'Republic of Albania'
update countryInfo set languages = 'hy-AM' where country = 'Republic of Armenia'
update countryInfo set languages = 'pt-AO' where country = 'Republic of Angola'
update countryInfo set languages = 'es-AR' where country = 'Argentine Republic'
update countryInfo set languages = 'de-AT' where country = 'Republic of Austria'
update countryInfo set languages = 'en-AU' where country = 'Commonwealth of Australia'
update countryInfo set languages = 'az-AZ' where country = 'Republic of Azerbaijan'
update countryInfo set languages = 'bs-BA, hr-BA, sr-BA' where country = 'Bosnia and Herzegovina'
update countryInfo set languages = 'en-BB' where country = 'Barbados'
update countryInfo set languages = 'bn-BD' where country = 'Bangladesh'
update countryInfo set languages = 'nl-BE, fr-BE, de-BE' where country = 'Kingdom of Belgium'
update countryInfo set languages = 'fr-BF' where country = 'Burkina Faso'
update countryInfo set languages = 'bg-BG' where country = 'Republic of Bulgaria'
update countryInfo set languages = 'ar-BH' where country = 'Kingdom of Bahrain'
update countryInfo set languages = 'rn-BI, fr-BI' where country = 'Republic of Burundi'
update countryInfo set languages = 'fr-BJ' where country = 'Republic of Benin'
update countryInfo set languages = 'ms-BN' where country = 'Brunei Darussalam'
update countryInfo set languages = 'es-BO, qu-BO, ay-BO' where country = 'Plurinational State of Bolivia'
update countryInfo set languages = 'pt-BR' where country = 'Federative Republic of Brazil'
update countryInfo set languages = 'en-BS' where country = 'Commonwealth of The Bahamas'
go