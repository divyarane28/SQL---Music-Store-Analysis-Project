
--- Create table Artist
Create table Artist(
ArtistId bigint identity(1,1) primary key,
Name varchar(200)
)

--- Create table Album 
Create table Album (
AlbumId bigint  primary key,
Title varchar(200),
ArtistId bigint 
)

--- Create table Track 
Create Table Track (
TrackId bigint identity(1,1) primary key,
Name varchar(300),
AlbumId bigint,
MediaTypeId bigint,
GenreId bigint,
Composer varchar(300),
MilliSeconds bigint,
Bytes bigint,
UnitPrice decimal(5,2)
)

--- Create table MediaType
create table MediaType(
MediaTypeId bigint identity(1,1) primary key,
Name varchar(200)
)

--- Create table Genre
create table Genre(
Genre bigint identity(1,1) primary key,
Name varchar(200)
)

--- Create table PlayList
create table PlayList(
PlayListid bigint identity(1,1) primary key,
Name varchar(200)
)

--- Create table PlayListTrack
create table PlayListTrack(
PlayListid bigint ,
TrackId bigint
)


--- Create table InVoiceLine
create table InVoiceLine (
InVoiceLineId bigint identity(1,1) primary key,
InVoiceId bigint,
TrackId bigint,
UnitPrice decimal(5,2),
Quantity int
)

--- Create table Invoice 
Create table Invoice (
InvoiceId bigint identity(1,1) primary key,
CustomerId bigint,
InvoiceDate varchar(20),
BillingAddress varchar(200),
BillingCity varchar(100),
BillingState varchar(100),
BillingCountry varchar(100),
BillingPosatalCode varchar(50),
Total decimal(5,2)
)


--- Create table Customer 
Create Table Customer (
CustomerId bigint identity(1,1) primary key,
FirstName varchar(200),
LastName varchar(200),
Company varchar(200),
Address varchar(200),
City varchar(100),
State varchar(100),
Country varchar(100),
PostalCode varchar(10),
Fax varchar(50),
Email varchar (50),
SupportRepId bigint,
Phone varchar(20)
)


--- Create table Employee 
Create Table Employee (
EmployeeId bigint identity(1,1) primary key,
LastName varchar(100),
FirstName varchar(100),
Title varchar(200),
ReportsTo bigint,
BirthDate varchar(20),
HireDate varchar(20),
Address varchar(200),
City varchar(100),
State varchar(100),
Country varchar(50),
PostalCode varchar(20),
Phone varchar(20),
Fax varchar (50),
Email varchar (50),
Levels varchar(10)
)