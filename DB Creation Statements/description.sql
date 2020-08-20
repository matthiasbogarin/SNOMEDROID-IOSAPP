drop table description;
create table description
(
id bigint,
effectiveTime datetime,
active tinyint,
moduleid bigint,
conceptId bigint,
languageCode varchar(3),
typeId bigint,
term text,
caseSignificantId bigint,
Primary Key (Id, effectiveTime)
);

LOAD DATA LOCAL INFILE '/Users/xiaoyangwu/Desktop/description.csv' into table description
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines;