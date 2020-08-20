drop table concepts;
create table concepts
(
Id bigint,
effectiveTime datetime,
active tinyint,
moduleId bigint,
definitionStatusId bigint,
PRIMARY KEY (Id, effectiveTime)
);

LOAD DATA LOCAL INFILE '/Users/xiaoyangwu/Desktop/concept.csv' into table concepts
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines;
