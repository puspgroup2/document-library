-- script to create all tables and insert some data into the 
-- database 

SET FOREIGN_KEY_CHECKS = 0;
drop table if exists Users;
drop table if exists TimeReports;
drop table if exists ActivityReports;
drop table if exists DocumentTimeD;
drop table if exists DocumentTimeI;
drop table if exists DocumentTimeF;
drop table if exists DocumentTimeR;

SET FOREIGN_KEY_CHECKS = 1;


CREATE TABLE Users (
userName varChar(20) NOT NULL,
password varChar(50) NOT NULL,
email varChar(100),
role varChar(30),
salt varChar(32) UNIQUE,
PRIMARY KEY(userName)
);

CREATE TABLE TimeReports (
reportID Integer AUTO_INCREMENT NOT NULL,
userName varChar(20) NOT NULL,
totalMinutes Integer,
signature varChar(20),
week Integer NOT NULL,
PRIMARY KEY(reportID),
FOREIGN KEY(userName) REFERENCES Users(userName)
ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY(signature) REFERENCES Users(userName)
ON UPDATE CASCADE ON DELETE SET NULL,
UNIQUE(week, userName)
);

CREATE TABLE ActivityReports (
reportID Integer NOT NULL,
totalMinutes Integer,
functionalTest Integer,
systemTest Integer,
regressionTest Integer,
meeting Integer,
lecture Integer,
exercise Integer,
computerExercise Integer,
homeReading Integer,
other Integer,
PRIMARY KEY(reportID),
FOREIGN KEY(reportID) REFERENCES TimeReports(reportID)
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DocumentTimeD (
reportID Integer NOT NULL,
totalMinutes Integer,
SDP Integer,
SRS Integer,
SVVS Integer,
STLDD Integer,
SVVI Integer,
SDDD Integer,
SVVR Integer,
SSD Integer,
finalReport Integer,
PRIMARY KEY(reportID),
FOREIGN KEY(reportID) REFERENCES TimeReports(reportID)
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DocumentTimeI (
reportID Integer NOT NULL,
totalMinutes Integer,
SDP Integer,
SRS Integer,
SVVS Integer,
STLDD Integer,
SVVI Integer,
SDDD Integer,
SVVR Integer,
SSD Integer,
finalReport Integer,
PRIMARY KEY(reportID),
FOREIGN KEY(reportID) REFERENCES TimeReports(reportID)
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DocumentTimeR (
reportID Integer NOT NULL,
totalMinutes Integer,
SDP Integer,
SRS Integer,
SVVS Integer,
STLDD Integer,
SVVI Integer,
SDDD Integer,
SVVR Integer,
SSD Integer,
finalReport Integer,
PRIMARY KEY(reportID),
FOREIGN KEY(reportID) REFERENCES TimeReports(reportID)
ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE DocumentTimeF (
reportID Integer NOT NULL,
totalMinutes Integer,
SDP Integer,
SRS Integer,
SVVS Integer,
STLDD Integer,
SVVI Integer,
SDDD Integer,
SVVR Integer,
SSD Integer,
finalReport Integer,
PRIMARY KEY(reportID),
FOREIGN KEY(reportID) REFERENCES TimeReports(reportID)
ON UPDATE CASCADE ON DELETE CASCADE
);


-- ---------- Add Example Users ----------------------
-- Password: adminpw
insert into Users(userName, password, role, salt)
values('admin', 'PZd75jzQtGXOxFsLQQwD1q1BIdAk0dxFZn/UwDHCdlU=', 'ADMIN', 'DitnkxxWz+e7/0kEFUCz7Q==');
-- Password: t7FYBbp9
insert into Users(userName, password, email, role, salt)
values('ExampleUser1', '8xN0tdx0Gg9jhzBbsnJLHOWm6BONplyWaJbC+i2bRhM=', 'emelie.engstrom@cs.lth.se', 'PG', 'Rwe8H4tsvhiMPx/gPxo1Sw==');
-- Password: plp8P1WX
insert into Users(userName, password, email, role, salt)
values('ExampleUser2', '9ou8qBEC0N8Gu/MoxeQCo4lMeP7FA2dANchv3CGcpeU=', 'emelie.engstrom@cs.lth.se', 'UG', '11y3hYdf1cf1R/9h0t4wUQ==');

-- ---------- Add Example Time Report -------


insert into TimeReports(userName, totalMinutes, week)
values('ExampleUser1', 170, 9);

insert into TimeReports(userName, totalMinutes, week)
values('ExampleUser1', 225, 10);

insert into TimeReports(userName, totalMinutes, week)
values('ExampleUser2', 170, 9);

insert into TimeReports(userName, totalMinutes, week)
values('ExampleUser2', 170, 10);


-- Need to add each of the report types for each Time Report.

-- Report 1
insert into ActivityReports values
(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

insert into DocumentTimeD(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(1, 60, 0, 0, 0, 0, 0, 0, 0, 0);

insert into DocumentTimeR(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(1, 0, 0, 0, 0, 45, 0, 0, 0, 0);

insert into DocumentTimeI(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(1, 0, 0, 0, 0, 45, 0, 0, 0, 0);

insert into DocumentTimeF(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(1, 0, 0, 0, 0, 0, 0, 20, 0, 0);

-- Report 2
insert into ActivityReports values
(2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

insert into DocumentTimeD(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(2, 60, 0, 0, 0, 60, 0, 0, 0, 0);

insert into DocumentTimeR(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(2, 65, 0, 0, 0, 45, 20, 0, 0, 0);

insert into DocumentTimeI(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(2, 60, 0, 0, 0, 45, 0, 15, 0, 0);

insert into DocumentTimeF(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(2, 40, 0, 0, 0, 20, 0, 20, 0, 0);

-- Report 3
insert into ActivityReports values
(3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

insert into DocumentTimeD(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(3, 60, 0, 0, 0, 0, 0, 60, 0, 0);

insert into DocumentTimeR(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(3, 45, 0, 0, 0, 45, 0, 0, 0, 0);

insert into DocumentTimeI(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(3, 45, 0, 0, 0, 45, 0, 0, 0, 0);

insert into DocumentTimeF(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(3, 20, 0, 0, 0, 0, 0, 20, 0, 0);

-- Report 4
insert into ActivityReports values
(4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

insert into DocumentTimeD(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(4, 60, 0, 0, 0, 0, 0, 60, 0, 0);

insert into DocumentTimeR(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(4, 45, 0, 0, 0, 45, 0, 0, 0, 0);

insert into DocumentTimeI(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(4, 45, 0, 0, 0, 45, 0, 0, 0, 0);

insert into DocumentTimeF(reportID, totalMinutes, SDP, SRS, SVVS, STLDD, SVVI, SDDD, SVVR, SSD)
values(4, 20, 0, 0, 0, 0, 0, 20, 0, 0);