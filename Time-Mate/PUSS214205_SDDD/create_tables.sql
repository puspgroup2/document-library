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