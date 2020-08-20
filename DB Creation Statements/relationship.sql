drop table relationship;
create table relationship
(
Id bigint,
effectiveTime datetime,
active tinyint,
moduleid bigint,
sourceId bigint,
destinationId bigint,
relationshipGroup int,
typeId bigint,
characteristicTypeId bigint,
modifierId bigint,
Primary Key (Id, effectiveTime)
);

LOAD DATA LOCAL INFILE '/Users/xiaoyangwu/Desktop/relationship.csv' into table relationship
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 lines;