create database Ecommerce;
use Ecommerce;

drop table if exists `Supplier`;
create table Supplier
(
Supp_id int primary key auto_increment,
Supp_name varchar(50) not null,
Supp_city varchar(50) not null,
Supp_phone varchar(50) not null
);

insert into Supplier(Supp_name,supp_city,Supp_phone) values("Rajesh Retails","Delhi",1234567890);
insert into Supplier(Supp_name,supp_city,Supp_phone) values("Appario Ltd.","Mumbai",2589631470);
insert into Supplier(Supp_name,supp_city,Supp_phone) values("Knome products","Banglore",9785462315);
insert into Supplier(Supp_name,supp_city,Supp_phone) values("Bansal Retails","Kochi",8975463285);
insert into Supplier(Supp_name,supp_city,Supp_phone) values("Mittal Ltd.","Lucknow",7898456532);

drop table if exists `Customer`;	
create table Customer
(
Cus_id int primary key auto_increment,
Cus_name varchar(20) not null,
Cus_phone varchar(10) not null,
Cus_city varchar(30) not null,
Cus_gender enum('M','F')
);

insert into Customer(Cus_name,Cus_phone,Cus_city,Cus_gender) values("AAKASH",9999999999,"DELHI","M");

insert into Customer(Cus_name,Cus_phone,Cus_city,Cus_gender) values
("AMAN",9785463215,"NOIDA","M"),
("NEHA","9999999999","MUMBAI","F"),
("MEGHA","9994562399","KOLKATA","F"),
("PULKIT","7895999999","LUCKNOW","M");


drop table if exists `Category`;
create table Category
(
Cat_id int primary key auto_increment,
Cat_name varchar(20) not null
);


insert into Category(Cat_name) values
("BOOKS"),("GAMES"),("GROCERIES"),("ELECTRONICS"),("CLOTHES");


drop table if exists `Product`;
create table Product
(
Pro_id int primary key auto_increment,
Pro_Name varchar(20) not null default "Dummy",
Pro_desc varchar(60),
Cat_id int,
foreign key (Cat_id) references Category(Cat_id)
);


insert into Product(Pro_name,Pro_desc,Cat_id) values
("GTA V","Windows 7 and above with i5 processor and 8GB RAM",2),
("TSHIRT","SIZE-L with Black, Blue and White variations",5),
("ROG LAPTOP","Windows 10 with 15inch screen, i7 processor, 1TB SSD",4),
("OATS","Highly Nutritious from Nestle",3),
("HARRY POTTER","Best Collection of all time by J.K Rowling",1),
("MILK","1L Toned MIlk",3),
("Boat Earphones","1.5Meter long Dolby Atmos",4),
("Jeans","Stretchable Denim Jeans with various sizes and color",5),
("Project IGI","compatible with windows 7 and above",2),
("Hoodie","Black GUCCI for 13 yrs and above",5),
("Rich Dad Poor Dad","Written by RObert Kiyosaki",1),
("Train Your Brain","By Shireen Stephen",1);


drop table if exists `Supplier_pricing`;
create table Supplier_pricing
(
Pricing_id int primary key auto_increment,
Pro_id int,
Supp_id int,
Supp_price int default 0,
foreign key (Pro_id) references Product(Pro_id),
foreign key (Supp_id) references Supplier(Supp_id)
);

insert into Supplier_pricing(Pro_id,Supp_id,Supp_price) values
(1,2,1500),
(3,5,30000),
(5,1,3000),
(2,3,2500),
(4,1,1000);


drop table if exists `Order`;
create table `Order`
(
Ord_id int primary key auto_increment,
Ord_amount int not null,
Ord_date date not null,
Cus_id int,
Pricing_id int,
foreign key (Cus_id) references Customer(Cus_id),
foreign key (Pricing_id) references Supplier_pricing(Pricing_id)
);
alter table `Order` auto_increment = 101;
insert into `order` (Ord_amount, Ord_date, Cus_id, Pricing_id) values
(1500 	,"2021/10/06", 2, 1),
(1000 	,"2021/10/12", 3, 5),
(30000	,"2021/09/16", 5, 2),
(1500 	,"2021/10/05", 1, 1),
(3000 	,"2021/08/16", 4, 3),
(1450 	,"2021/08/18", 1, 3),
(789 	,"2021/09/01", 3, 2),
(780 	,"2021/09/07", 5, 5),
(3000 	,"2021/00/10", 5, 3),
(2500 	,"2021/09/10", 2, 4),
(1000 	,"2021/09/15", 4, 5),
(789 	,"2021/09/16", 4, 1),
(31000	,"2021/09/16", 1, 2),
(1000 	,"2021/09/16", 3, 5),
(3000 	,"2021/09/16", 5, 3),
(99 	,"2021/09/17", 2, 4);


drop table if exists `Rating`;
create table Rating
(
Rat_id int unsigned not null primary key auto_increment,
Ord_id int not null,
Rat_ratstars int not null,
CONSTRAINT `fk_Ord_id` FOREIGN KEY (`Ord_id`) REFERENCES `order` (`Ord_id`)
);
insert into Rating (Ord_id, Rat_ratstars) values (101, 4),
(102,3),
(103,1),
(104,2),
(105,4),
(106,3),
(107,4),
(108,4),
(109,3),
(110,5),
(111,3),
(112,4),
(113,2),
(114,1),
(115,1),
(116,0);

-- Queries

-- 3. Display the total number of customers based on gender who have placed orders of worth at least Rs.3000.

select c.Cus_Gender,count(*) from ecommerce.customer as c inner join ecommerce.`order` as o on c.CUS_ID = o.CUS_ID where o.Ord_amount>=3000 group by c.Cus_gender;

-- 4) Display all the orders along with product name ordered by a customer having Customer_Id=2

Select customer.Cus_id,customer.Cus_name,`order`.Ord_id,Supplier_pricing.Supp_id,product.Pro_id,product.Pro_Name from ecommerce.`order`
inner join ecommerce.customer on `order`.Cus_id = customer.Cus_id
inner join ecommerce.supplier_pricing on `order`.Pricing_id = supplier_pricing.Pricing_id
inner join ecommerce.supplier on supplier.Supp_id = supplier_pricing.Supp_id
inner join ecommerce.product on supplier_pricing.Pro_id = product.Pro_id
where ecommerce.`order`.Cus_id = 2;

-- 5) Display the Supplier details who can supply more than one product.

select s.Supp_name,count(p.Pro_name) as product_count from ecommerce.supplier as s inner join ecommerce.supplier_pricing as sp on s.Supp_id=sp.Supp_id
inner join ecommerce.product as p on p.Pro_id=sp.Pro_id group by s.Supp_name having count(p.Pro_name)>1;

-- 6) Find the least expensive product from each category and print the table with category id, name, product name and price of the product

select cat.Cat_id, cat.Cat_name, p.Pro_name, sp.Supp_price from ecommerce.category as cat
inner join ecommerce.product as p on cat.Cat_id=p.Cat_id
inner join ecommerce.supplier_pricing as sp on sp.Pro_id=p.Pro_id
group by cat.Cat_name having min(sp.Supp_price);

-- 7) Display the Id and Name of the Product ordered after “2021-10-05”.

select Pro_id, Pro_name from ecommerce.product where Pro_id in (select Pro_id from ecommerce.supplier_pricing where PRICING_ID in (select Pricing_id from ecommerce.`order` where Ord_date > '2021-10-05'));

-- 8) Display customer name and gender whose names start or end with character 'A'.

select Cus_name, Cus_gender from ecommerce.customer where Cus_name like "A%" or Cus_name like "%A";

-- 9) Create a stored procedure to display supplier id, name, rating and Type_of_Service. For Type_of_Service, If rating =5, print “Excellent Service”,If rating >4 print “Good Service”, If rating >2 print “Average Service” else print “Poor Service”.

select `order`.Pricing_id, avg(rating.Rat_Ratstars) as rating, case 
when avg(rating.Rat_Ratstars)=5 then 'Excellent Service'
when avg(rating.Rat_Ratstars)>4 then 'Good Service'
when avg(rating.Rat_Ratstars)>2 then 'Average Service'
else 'Poor Service' end as Type_of_Service from ecommerce.`order` 
inner join ecommerce.rating where `order`.Ord_id=rating.Ord_id group by `order`.Pricing_id;