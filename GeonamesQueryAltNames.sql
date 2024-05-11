--:setvar CountryCode "cn"
--:setvar AdminLevel "1"

USE Geonames;


declare @countryCode varchar(2)
declare @adminLevels varchar(50)

set @countryCode = '$(CountryCode)'
set @adminLevels = '$(AdminLevel)'

drop table if exists #geoname_include
create table #geoname_include
(
	geonameid int primary key
)

if(dbo.IncludeAdminLevel(@adminLevels, 1) = 1)
begin
	insert #geoname_include
	select geonameid from geoname where feature_code = 'ADM1' and country_code = @countryCode
end

if(dbo.IncludeAdminLevel(@adminLevels, 2) = 1)
begin
	insert #geoname_include
	select geonameid from geoname where feature_code = 'ADM2' and country_code = @countryCode
end

if(dbo.IncludeAdminLevel(@adminLevels, 3) = 1)
begin
	insert #geoname_include
	select geonameid from geoname where feature_code = 'ADM3' and country_code = @countryCode
end

if(dbo.IncludeAdminLevel(@adminLevels, 4) = 1)
begin
	insert #geoname_include
	select geonameid from geoname where feature_code = 'ADM4' and country_code = @countryCode
end

if(dbo.IncludeAdminLevel(@adminLevels, 5) = 1)
begin
	insert #geoname_include
	select geonameid from geoname where feature_code = 'ADM5' and country_code = @countryCode
end

select dbo.CleanRegionName(g.geonameid) as [Region],
	   dbo.GetType(g.geonameid) as [Type], 
	   g.latitude as [Latitude],
	   g.longitude as [Longitude],
	   dbo.GetEnclosedBy(g.geonameid) as [Enclosed_By],
	   (select top 1 alternate_name from alternate_name where geonameid = g.geonameid and alternate_name like '%wikipedia%') as [Wikipedia_URL]
from geoname g
inner join #geoname_include gi on g.geonameid = gi.geonameid
order by g.feature_code, g.name