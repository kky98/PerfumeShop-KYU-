CREATE TABLE bbs(
bbsID INT,
bbsTitle VARCHAR(50),
userID VARCHAR(20),
bbsDate DATETIME,
bbsContent VARCHAR(2048),
bbsAvailable INT,
PRIMARY KEY(bbsID)
)default CHARSET=utf8;