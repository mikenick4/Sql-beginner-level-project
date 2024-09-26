CREATE DATABASE SALES_PRODUCTS1;
CREATE TABLE cusotmers (cusmtomers_id int primary key auto_increment,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(100) unique,
phone varchar(20) unique,
adress text,
created_at timestamp default current_timestamp); 

create table products(product_id int primary key auto_increment,
name varchar(100) not null,
price decimal(10, 2) not null,
category_id int,
foreign key (category_id) references categories(category_id));

create table categories (category_id int primary key auto_increment,
name varchar(50) unique not null);
create table  orders( order_id int primary key auto_increment,
cusmtomers_id int,
order_date timestamp default current_timestamp,
total_amount decimal(10, 2) not null,
foreign key (cusmtomers_id) references cusotmers(cusmtomers_id));

create table order_items( order_item_id int primary key auto_increment,
order_id int,
product_id int,
quantity int not null,
unit_price decimal(10, 2) not null,
foreign key(order_id) references orders(order_id),
foreign key(product_id) references products(product_id));

CREATE TABLE discounts (
discount_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
type ENUM('percentage', 'fixed_amount'),
amount DECIMAL(10, 2) NOT NULL,
start_date DATE,
end_date DATE);

CREATE TABLE order_discounts (
order_discount_id INT PRIMARY KEY AUTO_INCREMENT,
order_id INT, -- Foreign key referencing orders
discount_id INT, -- Foreign key referencing discounts
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (discount_id) REFERENCES discounts(discount_id));
