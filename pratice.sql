use practice;

show tables;

 -- ----------------------------------------DATA TYPES --------DDL---CONSTRAINT-----------------------------
create table p1(
id int AUTO_INCREMENT not null,
salary decimal (10,2),
age float,
married bool,
mobile_number double,
primary key (id)
);

create table p5(
id5 int auto_increment unique,
salary decimal(3),
age double(2,1) check(age>=18),
name varchar (15),
sex char (1) not null default('3rd gender')
);

describe p5;

-- The error occurs because in MySQL,
-- an AUTO_INCREMENT column must always be part of a PRIMARY KEY or a UNIQUE key.
-- When you try to drop the primary key from the table, MySQL prevents the action since
-- it would leave the AUTO_INCREMENT column without the required constraint.

-- Remove AUTO_INCREMENT Before Dropping the Primary Key
-- 2: Assign a New Primary Key -- ALTER TABLE p1 DROP PRIMARY KEY, ADD PRIMARY KEY (another_column);
-- Use a Composite Key (if applicable) -- ALTER TABLE p1 DROP PRIMARY KEY, ADD PRIMARY KEY (id, another_column);


DESCRIBE p1;

alter table p1 add column js json;
alter table p1 add column geom geometry;

ALTER TABLE p1 MODIFY id INT ;
ALTER TABLE p1 MODIFY id INT AUTO_INCREMENT;

ALTER TABLE p5 drop column id5 ;
alter table p5 add column id5 int not null;

Alter table p1 drop primary key ;
ALTER TABLE p1 ADD PRIMARY KEY (id);


describe p5;
ALTER TABLE p5 MODIFY id5 iNT not null;
ALTER TABLE p5 MODIFY id5 INT ;
alter table p5 drop primary key ;
ALTER TABLE p5 ADD PRIMARY KEY (id5);

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE TABLE_NAME = 'p5' AND TABLE_SCHEMA = 'practice';

alter table p5 drop constraint id5;
alter table p1 add constraint chck_salary check (salary >20000);
alter table p1 drop constraint chck_salary;

create table p2(
id2 int not null,
name varchar(20),
sex char default 'N' ,
about text,
img blob,
img1 binary,
join_date timestamp default current_timestamp,
status enum ('active','inactive'),
activity set ('swim','dance','ride' ,'trek'),
foreign key (id2) references p1(id)
);

-- Insert sample data into p2 table
INSERT INTO p2 (id2, name, sex, about,img1, join_date, status, activity)
VALUES 
(1, 'John Doe', 'M', 'A passionate swimmer and traveler.',  NULL, '2024-11-20 10:00:00', 'active', 'swim,trek'),

(2, 'Jane Smith', 'F', 'Loves dancing and riding bikes.',  NULL, '2024-11-21 09:30:00', 'inactive', 'dance,ride'),

(3, 'Alice Brown', default, 'Enjoys swimming and trekking in nature.', NULL, default, 'active', 'swim,trek'),

(4, 'Bob Johnson', 'M', 'An avid cyclist and swimmer.', NULL, '2024-11-23 11:15:00', 'active', 'swim,ride'),

(5, 'Charlie Davis', 'M', 'A keen hiker and adventurer.',NULL, '2024-11-24 14:00:00', 'inactive', 'trek');


INSERT INTO p2 (id2, name, sex, about,img1, join_date, status, activity)
VALUES 
(1, 'John Doe', 'M', 'A passionate swimmer and traveler.',  NULL, '2024-11-20 10:00:00', 'active', 'swim,trek'),

(4, 'Bob Johnson', 'M', 'An avid cyclist and swimmer.', NULL, '2024-11-23 11:15:00', 'active', 'swim,ride'),

(5, 'Charlie Davis', 'M', 'A keen hiker and adventurer.',NULL, '2024-11-24 14:00:00', 'inactive', 'trek');

select * from p2;
SHOW CREATE TABLE p2;

alter table p2 modify column id2 int;
alter table p2 drop foreign key p2_ibfk_1;
alter table p2 add foreign key (id2) references p1(id);

ALTER TAble p2 drop img1;
ALTER TAble p2 modify img mediumblob;
DESCRIBE P2;

drop table p2;
drop database practice;
-- drop column img;
rollback;  -- drop cant be rollback

truncate table p2;
-- truncate column img;
rollback;  

alter table p2 rename column img to mg1;
rename table p22 to p2;
-- rename column img to mg1

 -- ------------------------------------------------DML -------------------------------
 
 describe p1;
 INSERT into p1 values(1,250000,23,false,89990,null,null);
 
INSERT INTO p1 (salary, age, married, mobile_number, js, geom)
VALUES
(50000.00, 30.5, TRUE, 9876543210, '{"role": "developer", "active": true}', ST_PointFromText('POINT(10 20)')),

(45000.75, 25.0, FALSE, 9876543211, '{"role": "tester", "active": false}', ST_PointFromText('POINT(15 25)')),

(60000.50, 35.2, TRUE, 9876543212, '{"role": "manager", "active": true}', ST_PointFromText('POINT(20 30)')),

(70000.25, 40.0, TRUE, 9876543213, '{"role": "analyst", "active": false}', ST_PointFromText('POINT(25 35)')),

(30000.10, 22.8, FALSE, 9876543214, '{"role": "intern", "active": true}', ST_PointFromText('POINT(30 40)'));

 select * from p1;
 describe p2;


insert into p1 (salary, age, married, mobile_number, js, geom)
values (30000.10, 22.8, FALSE, 9876543214, '{"role": "intern", "active": true}', ST_pointfromtext('POINT(30 40)'));
 
 update p1 set married =false where married = TRUE;
 -- SET autocommit = 0;
 rollback ;
 
 
 delete from p2 ;
 delete from p2 where sex ='M';
  
  ------------------
  
------------------------ Using SELECT to Insert Data from Another Table --------------------------------

INSERT INTO p222 (name, sex)
SELECT name, sex
FROM p2222
WHERE sex ='F';

select * from p2222;

-------------------  Syntax for Creating a Copy Using CREATE TABLE AS ----------------------- using as select
   
create table p22 as select id2,name,sex from p2 ;
select * from p22;

create table p222 as select * from p2 where 1 =0;
select * from p222;

create table p2222 as select * from p2 where 1 =1;
select * from p2222;


start TRANSACTION;

UPDATE P1
SET id = id + 1
WHERE id =79;

select * from p1;

UPDATE P2
SET id2 = id2 + 1
WHERE id2= 5;
-- If both operations are successful, commit the transaction
COMMIT;
rollback;

   

------------------------                    index --------------------------------------

SELECT *
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_NAME ='p1'
AND TABLE_SCHEMA = 'practice';  

 

create index idx_mobnum on p2(name,status);
create unique index idx_id on p22(id2);
create fulltext index  idx_name on p22(name);

drop index idx_name on p22;

ALTER TABLE p22 DROP INDEX idx_name;
ALTER TABLE p22 ADD INDEX idx_name (name);
-- ALTERINDEX idx_name on p22 rebuild);

---------------------------------  view ----------- as select

create view vw_name as select id,salary,age,married from p1 where age >20 with check option;
select * from vw_name; 
select * from p1; 
insert into vw_name values (78,89000,23,false);

drop view vw_name;

-- error handling 

/*begin TRY
    start TRANSACTION;

    -- Insert operation
    INSERT INTO employees (employee_id, name, salary)
    VALUES (10, 'John Doe', 50000);

    -- Commit the transaction if no errors
    COMMIT;
END TRY
BEGIN CATCH
    -- If an error occurs, rollback the transaction
    ROLLBACK;

    PRINT ERROR_MESSAGE();
END CATCH;
*/ -- my sql doesnt support try -catch


/*DELIMITER $$

BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback the transaction if an error occurs
        ROLLBACK;
        -- Optionally, you can use SELECT or other methods to log the error message
        SELECT 'An error occurred, transaction rolled back' AS error_message;
    END;

    -- Start the transaction
    START TRANSACTION;

    -- Insert operation
    INSERT INTO employees (employee_id, name, salary)
    VALUES (10, 'John Doe', 50000);

    -- Commit the transaction if no errors
    COMMIT;

END$$

DELIMITER ;
*/


/*start TRANSACTION;

-- Attempt to update a record
UPDATE employees
SET salary = salary * 1.10
WHERE employee_id = 5;

-- Check if the update was successful
IF @@ERROR <> 0
BEGIN
    -- Rollback the transaction if there is an error
    ROLLBACK;
END
ELSE
BEGIN
    -- Commit the transaction if no error
    COMMIT;
END;

/*