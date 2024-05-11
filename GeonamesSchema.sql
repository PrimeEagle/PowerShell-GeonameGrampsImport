IF EXISTS (SELECT name FROM sys.databases WHERE name = N'Geonames')
BEGIN
    DROP DATABASE Geonames;
END

CREATE DATABASE Geonames
COLLATE Latin1_General_CI_AS -- Collation that supports Unicode
GO

ALTER DATABASE Geonames
MODIFY FILE 
(
    NAME = 'Geonames',
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 1024MB
)
GO

USE Geonames;
GO

drop table if exists geoname
create table geoname
(
	geonameid int primary key,	 --  integer id of record in geonames database
	name nvarchar(200),			 --  name of geographical point (utf8) varchar(200)
	asciiname varchar(200),		 --  name of geographical point in plain ascii characters, varchar(200)
	alternatenames varchar(max), --  alternatenames, comma separated, ascii names automatically transliterated, convenience attribute from alternatename table, varchar(10000)
	latitude decimal,			 --  latitude in decimal degrees (wgs84)
	longitude decimal,			 --  longitude in decimal degrees (wgs84)
	feature_class varchar(1),    --  see http://www.geonames.org/export/codes.html, char(1)
	feature_code  varchar(10),   --  see http://www.geonames.org/export/codes.html, varchar(10)
	country_code varchar(2),     --  ISO-3166 2-letter country code, 2 characters
	cc2 varchar(200),            --  alternate country codes, comma separated, ISO-3166 2-letter country code, 200 characters
	admin1_code varchar(20),     --  fipscode (subject to change to iso code), see exceptions below, see file admin1Codes.txt for display names of this code; varchar(20)
	admin2_code varchar(80),     --  code for the second administrative division, a county in the US, see file admin2Codes.txt; varchar(80) 
	admin3_code varchar(20),     --  code for third level administrative division, varchar(20)
	admin4_code varchar(20),     --  code for fourth level administrative division, varchar(20)
	population bigint,			 --  bigint (8 byte int) 
	elevation int,				 --  in meters, integer
	dem int,					 --  digital elevation model, srtm3 or gtopo30, average elevation of 3''x3'' (ca 90mx90m) or 30''x30'' (ca 900mx900m) area in meters, integer. srtm processed by cgiar/ciat.
	timezone varchar(40),		 --  the iana timezone id (see file timeZone.txt) varchar(40)
	modification date
)

CREATE INDEX index2 ON dbo.geoname (name)
CREATE INDEX index3 ON dbo.geoname (feature_code)
CREATE INDEX index4 ON dbo.geoname (feature_class)
CREATE INDEX index5 ON dbo.geoname (country_code)
CREATE INDEX index6 ON geoname(feature_code, country_code)
go

drop table if exists alternate_name
create table alternate_name
(
	alternateNameId int primary key,	  -- the id of this alternate name, int
	geonameid int,						  -- geonameId referring to id in table 'geoname', int
	isolanguage varchar(7),				  -- iso 639 language code 2- or 3-characters, optionally followed by a hyphen and a countrycode for country specific variants (ex:zh-CN) or by a variant name (ex: zh-Hant); 4-characters 'post' for postal codes and 'iata','icao' and faac for airport codes, fr_1793 for French Revolution names,  abbr for abbreviation, link to a website (mostly to wikipedia), wkdt for the wikidataid, varchar(7)
	alternate_name nvarchar(max),		  -- alternate name or name variant, varchar(400)
	isPreferredName bit,				  -- '1', if this alternate name is an official/preferred name
	isShortName bit,				      -- '1', if this is a short name like 'California' for 'State of California'
	isColloquial bit,					  -- '1', if this alternate name is a colloquial or slang term. Example: 'Big Apple' for 'New York'.
	isHistoric bit,						  -- '1', if this alternate name is historic and was used in the past. Example 'Bombay' for 'Mumbai'.
	[from] varchar(200),				  -- from period when the name was used
	[to] varchar(200)					  --  to period when the name was used
)

drop table if exists admin1_code
create table admin1_code
(
	code varchar(40) primary key,
	name nvarchar(400),
	ascii_name varchar(400),
	geonameid int
)

drop table if exists admin2_code
create table admin2_code
(
	code varchar(40) primary key,
	name varchar(400),
	ascii_name varchar(400),
	geonameid int
)

drop table if exists feature_code
create table feature_code
(
	code varchar(40) primary key,
	name varchar(400),
	details varchar(400)
)

drop table if exists hierarchy
create table hierarchy
(
	parentid int,
	childid int,
	type varchar(200)
)
go

CREATE INDEX index7 ON dbo.hierarchy (parentid)
CREATE INDEX index8 ON dbo.hierarchy (childid)
GO

drop table if exists countryInfo
create table countryInfo
(
	iso varchar(10),
	iso3 varchar(10),
	isoNumeric varchar(10),
	fips varchar(2),
	country nvarchar(100),
	capital nvarchar(200),
	area decimal,
	population bigint,
	continent varchar(2),
	tld varchar(5),
	currencyCode varchar(3),
	currencyName nvarchar(100),
	phone varchar(100),
	postalCodeFormat varchar(100),
	postalCodeRegex varchar(500),
	languages varchar(max),
	geonameid int,
	neighbours varchar(500),
	equivalentFipsCode varchar(2)
)

drop table if exists regionType
create table regionType
(
	[name] nvarchar(100) primary key,
	[type] nvarchar(100)
)

CREATE INDEX index9 ON dbo.regionType (name)

drop table if exists iso_language_code
create table iso_language_code
(
	ISO639_3 varchar(20),
	ISO639_2 varchar(20),
	ISO639_1 varchar(20),
	language_name varchar(250)
)

drop function if exists dbo.MatchWholeWord
go

CREATE FUNCTION dbo.MatchWholeWord
(
    @Data NVARCHAR(MAX),
    @Word NVARCHAR(100)
)
RETURNS BIT
AS
BEGIN
    SET @Data = ' ' + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Data, ',', ' '), '.', ' '), '!', ' '), '?', ' '), ';', ' ') + ' ';

    IF @Data LIKE N'%[^a-zA-Z0-9]' + @Word + N'[^a-zA-Z0-9]%'
        RETURN 1;
    ELSE
        RETURN 0;

	return 0;
END;
GO

drop function if exists dbo.ReplaceWholeWord
go

CREATE FUNCTION dbo.ReplaceWholeWord
(
    @Data NVARCHAR(MAX),
    @Word NVARCHAR(100),
    @Replacement NVARCHAR(100)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    SET @Data = ' ' + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Data, ',', ' , '), '.', ' . '), '!', ' ! '), '?', ' ? '), ';', ' ; ') + ' ';

    WHILE PATINDEX(N'%[^a-zA-Z0-9]' + @Word + N'[^a-zA-Z0-9]%', @Data) > 0
    BEGIN
        SET @Data = STUFF(
            @Data,
            PATINDEX(N'%[^a-zA-Z0-9]' + @Word + N'[^a-zA-Z0-9]%', @Data) + 1,
            LEN(@Word),
            @Replacement
        );
    END

    SET @Data = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@Data, ' , ', ','), ' . ', '.'), ' ! ', '!'), ' ? ', '?'), ' ; ', ';');

    RETURN LTRIM(RTRIM(@Data));
END;
GO


drop function if exists CleanRegionName
go

CREATE FUNCTION dbo.CleanRegionName (@geonameid int)
RETURNS NVARCHAR(200)
AS
BEGIN
	DECLARE @RegionName NVARCHAR(200);

    SELECT @RegionName = name FROM geoname WHERE geonameid = @geonameid;

    SELECT @RegionName = dbo.ReplaceWholeWord(@RegionName, name + ' of', '') 
    FROM regionType;

    SELECT @RegionName = dbo.ReplaceWholeWord(@RegionName, name, '') 
    FROM regionType;

    RETURN LTRIM(RTRIM(@RegionName));
END;
go

drop function if exists CleanAlternateRegionName
go

CREATE FUNCTION dbo.CleanAlternateRegionName (@alternateNameId int)
RETURNS NVARCHAR(200)
AS
BEGIN
	DECLARE @RegionName NVARCHAR(200);

    SELECT @RegionName = [alternate_name] FROM alternate_name WHERE alternateNameId = @alternateNameId;

    SELECT @RegionName = dbo.ReplaceWholeWord(@RegionName, name, '') 
    FROM regionType;

    RETURN LTRIM(RTRIM(@RegionName));
END;
go

drop function if exists GetEnclosedBy
go

CREATE FUNCTION dbo.GetEnclosedBy (@geonameid INT, @enclosingLevel INT)
RETURNS nvarchar(200)
AS
BEGIN
    DECLARE @targetFeatureCode VARCHAR(10);

    SET @targetFeatureCode = CASE @enclosingLevel
        WHEN 0 THEN 'PCLI'  -- Country level
        WHEN 1 THEN 'ADM1'  -- First administrative division
        WHEN 2 THEN 'ADM2'  -- Second administrative division
        WHEN 3 THEN 'ADM3'  -- Third administrative division
        ELSE NULL
    END;

    IF @targetFeatureCode IS NULL
        RETURN NULL;

    ;WITH RecursiveHierarchy AS (
        SELECT
            g.geonameid,
            g.feature_code,
            h.parentid
        FROM
            geoname g
            INNER JOIN hierarchy h ON g.geonameid = h.childid
        WHERE
            g.geonameid = @geonameid
			and h.type = 'ADM'

        UNION ALL

        SELECT
            g.geonameid,
            g.feature_code,
            h.parentid
        FROM
            geoname g
            INNER JOIN RecursiveHierarchy rh ON g.geonameid = rh.parentid
            INNER JOIN hierarchy h ON g.geonameid = h.childid
		WHERE
			h.type = 'ADM'
    )
	
	SELECT TOP 1 @geonameid = rh.geonameid
    FROM RecursiveHierarchy rh
    WHERE rh.feature_code = @targetFeatureCode
    ORDER BY (CASE WHEN rh.feature_code = @targetFeatureCode THEN 1 ELSE 0 END);

	declare @result nvarchar(200)

	if(@targetFeatureCode like 'ADM%')
		select @result = dbo.CleanRegionName(geonameid) from geoname where geonameid = @geonameid
	else
		select @result = name from geoname where geonameid = @geonameid

    RETURN @result;
END;
GO


GO

drop function if exists dbo.IncludeAdminLevel
go

CREATE FUNCTION dbo.IncludeAdminLevel (@AdminLevels varchar(50), @AdminLevel int)
RETURNS bit
AS
BEGIN
    DECLARE @Result bit = 0;

    IF @AdminLevels IS NULL OR LEN(@AdminLevels) = 0
        SET @Result = 1;
    ELSE
        IF EXISTS (SELECT 1 FROM STRING_SPLIT(@AdminLevels, ',') WHERE TRY_CONVERT(int, value) = @AdminLevel)
            SET @Result = 1;

    RETURN @Result;
END;
GO