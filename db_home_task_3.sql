CREATE TABLE if not exists Certifications(
    CertificationID INT PRIMARY KEY,
    CertificationName TEXT NOT NULL
);

CREATE TABLE if not exists Areas(
    AreaID INT PRIMARY KEY,
    AreaName TEXT UNIQUE NOT NULL
);

CREATE TABLE if not exists Countries(
    CountryID INT PRIMARY KEY,
    CountryName TEXT UNIQUE NOT NULL
);

CREATE TABLE if not exists City(
    CityID INT PRIMARY KEY,
    CityName TEXT NOT NULL,
	CityState TEXT NOT NULL,
	CountryID INT NOT NULL,
	CONSTRAINT fk_Country
        FOREIGN KEY(CountryID)
            REFERENCES Countries(CountryID)
);

CREATE TABLE if not exists Adresses (
    AdressID INT PRIMARY KEY,
	CityID INT NOT NULL,
    StreetAdress TEXT NOT NULL,
	ZipCode INT NOT NULL,
	CONSTRAINT fk_City
        FOREIGN KEY(CityID)
            REFERENCES City(CityID)
);

CREATE TABLE if not exists Climbers(
    ClimberID INT PRIMARY KEY,
    ClimberName TEXT NOT NULL,
	AdressID INT NOT NULL,
	CertificationID INT NOT NULL,
	ClimberGender TEXT,
	CONSTRAINT fk_Adress
        FOREIGN KEY(AdressID)
            REFERENCES Adresses(AdressID),
	CONSTRAINT fk_Certification
        FOREIGN KEY(CertificationID)
            REFERENCES Certifications(CertificationID),
	CONSTRAINT check_gender
		CHECK (ClimberGender in('male', 'female'))
);

CREATE TABLE if not exists Mountains(
    MountainID INT PRIMARY KEY,
    MountainName TEXT UNIQUE NOT NULL,
	Height INT NOT NULL,
	CountryID INT NOT NULL,
	AreaID INT NOT NULL,
	CONSTRAINT fk_Country
        FOREIGN KEY(CountryID)
            REFERENCES Countries(CountryID),
	CONSTRAINT fk_Area
        FOREIGN KEY(AreaID)
            REFERENCES Areas(AreaID)	
);

CREATE TABLE if not exists Climbs(
    ClimbID INT PRIMARY KEY,
    ClimberID INT NOT NULL,
    MountainID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
	CONSTRAINT fk_Climber
        FOREIGN KEY(ClimberID)
            REFERENCES Climbers(ClimberID),
	CONSTRAINT fk_Mountain
        FOREIGN KEY(MountainID)
            REFERENCES Mountains(MountainID),
	CONSTRAINT check_StartDate
		CHECK (StartDate > '2000-01-01'),
	CONSTRAINT check_EndDate
		CHECK (EndDate > '2000-01-01')
);

-- Inserting data into the 'areas' table
insert into Areas values(1, 'North America');
insert into Areas values(2, 'Africa');

-- Inserting data into the 'countries' table
insert into Countries values(1, 'United States');
insert into Countries values(2, 'South Africa');

-- Inserting data into the 'cities' table
insert into City values(1, 'New York', 'Manhattan', 1);
insert into City values(2, 'Cape Town', 'City Bowl', 2);

-- Inserting data into the 'addresses' table
insert into Adresses values(1, 1, 'Broadway', 10001);
insert into Adresses values(2, 2, 'Table Mountain Road', 8001);

-- Inserting data into the 'certifications' table
insert into Certifications values(1, 'Rock Climbing Certification');
insert into Certifications values(2, 'Mountain Climbing Certification');

-- Inserting data into the 'mountains' table
insert into Mountains values(1, 'Denali', 6190, 1, 1);
insert into Mountains values(2, 'Kilimanjaro', 5895, 2, 2);

-- Inserting data into the 'climbers' table
insert into Climbers values(1, 'John', 1, 1,'male');
insert into Climbers values(2, 'Nomvula', 2, 2, 'female');

-- Inserting data into the 'climbings' table
insert into Climbs values(1, 1, 1, '2018-08-15', '2018-08-25');
insert into Climbs values(2, 2, 2, '2020-04-10', '2020-04-20');

--Adding record_ts to all tables with default value current date
alter table areas add column record_ts date;
update areas
set record_ts = COALESCE(record_ts, current_date);

alter table countries add column record_ts date;
update countries
set record_ts = COALESCE(record_ts, current_date);

alter table city add column record_ts date;
update city
set record_ts = COALESCE(record_ts, current_date);

alter table adresses add column record_ts date;
update adresses
set record_ts = COALESCE(record_ts, current_date);

alter table certifications add column record_ts date;
update certifications
set record_ts = COALESCE(record_ts, current_date);

alter table mountains add column record_ts date;
update mountains
set record_ts = COALESCE(record_ts, current_date);

alter table climbers add column record_ts date;
update climbers
set record_ts = COALESCE(record_ts, current_date);

alter table climbs add column record_ts date;
update climbs
set record_ts = COALESCE(record_ts, current_date);



select * from areas
select * from countries
select * from city
select * from adresses
select * from certifications
select * from mountains
select * from climbers
select * from climbs