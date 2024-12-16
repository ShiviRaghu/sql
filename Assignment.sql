use assignment;
show tables;


-- Assignment: Constraints in MySQL – Advanced Practice
-- Part 1: Create Tables with Constraints

-- Suppliers Table
create table Suppliers(
SupplierID INT  Primary Key,
SupplierName VARCHAR(50) NOT NULL,
ContactEmail VARCHAR(100) Unique NOT NULL,
Country VARCHAR(50) Default 'Unknown'
);

-- Shipments Table
create table Shipments (
ShipmentID INT Primary Key,
SupplierID INT,
ShipmentDate DATETIME Default CURRENT_TIMESTAMP,
TotalWeight DECIMAL(5,2) check (TotalWeight> 0),
Foreign Key (SupplierID)references Suppliers(SupplierID)
);

-- Items Table
create table Items (
ItemID INT Primary Key ,
ItemName VARCHAR(100) NOT NULL,
Price DECIMAL(10,2) CHECK (Price> 0),
StockQuantity INT  Default  50
);

-- SupplierItems Table
create table SupplierItems (
SupplierID INT ,
ItemID INT,
SupplyPrice DECIMAL(10,2) check (SupplyPrice>0),
AvailableQuantity INT Default 10,
 Foreign Key (SupplierID) references Suppliers(SupplierID),
  Foreign Key (ItemID )references Items(ItemID)
);




-- Part 2: Insert Sample Data
insert into Suppliers(SupplierID ,SupplierName ,ContactEmail ,Country)
values(1,'shii','1232@gmail','india'),
(2,'shivhi','123678@gmail','ice'),
(3,'aa','124432@gmail','india'),
(4,'bb','4444@gmail','');

select * from Suppliers;

insert into Shipments (ShipmentID ,SupplierID ,ShipmentDate ,TotalWeight )
values(113,4,'2022-03-13 17:51:11',12.1)
;

select * from Shipments;


insert into Items (ItemID ,ItemName ,Price ,StockQuantity)
values(10,'gold',9000.25,1234),
(100,'silver',10.25,null),
(10000,'plat',111.9,90),
(1000,'plat',9877.25,null)
;

insert into Items (ItemID ,ItemName ,Price ,StockQuantity)
values(10000000,'gold',9000.25,default);

select * from Items;

insert into SupplierItems (SupplierID ,ItemID ,SupplyPrice ,AvailableQuantity)
values(2,100,20000,default),
(3,10000,2,400),
(4,10,3000,default);
;

select * from SupplierItems;


-- Part 3: Practical Exercises
-- Check the Primary Key Constraint: Attempt to insert a duplicate SupplierID in the Suppliers table.
insert into Suppliers(SupplierID ,SupplierName ,ContactEmail ,Country)
values(1,'shii','1232@gmail','india');


-- Test the Foreign Key Constraint: Insert a row into SupplierItems with a non-existent SupplierID.
insert into SupplierItems (SupplierID ,ItemID ,SupplyPrice ,AvailableQuantity)
values(5,100,20000,default);

-- Test the Unique Constraint: Attempt to insert a duplicate email in the Suppliers table.
insert into Suppliers(SupplierID ,SupplierName ,ContactEmail ,Country)
values(145,'shii','1232@gmail','india');

-- Test the Default Value Constraint: Add a new row to Items without specifying StockQuantity and observe the default value.
insert into Items (ItemID ,ItemName ,Price ,StockQuantity)
values(10000000,'gold',9000.25,default);

-- Check the Check Constraint: Insert a row in Shipments with a TotalWeight of -5 and observe the result.
insert into Shipments (ShipmentID ,SupplierID ,ShipmentDate ,TotalWeight )
values(113,4,'2022-03-13 17:51:11',-5)
;

-- Verify Composite Primary Key Constraint: Insert a duplicate (existing SupplierID and ItemID combination) into SupplierItems.
insert into SupplierItems (SupplierID ,ItemID ,SupplyPrice ,AvailableQuantity)
values(2,100,20000,default);

-- Enforce Data Integrity: Try deleting a supplier from Suppliers that has entries in SupplierItems and observe the constraint behavior.
delete from Suppliers where SupplierID=2 ;
