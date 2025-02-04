--CREATE TABLE Categories(
--  category_id Serial PRIMARY KEY,
--  Name VARCHAR(100)  
--);

CREATE TABLE Products(
  product_id Serial PRIMARY KEY,
  name VARCHAR(100),
  price decimal(10,2),
  description VARCHAR(255),
  tags VARCHAR(255),
  category_id int,
  FOREIGN KEY(category_id) references Categories(category_id),
  supplier VARCHAR(100)
);