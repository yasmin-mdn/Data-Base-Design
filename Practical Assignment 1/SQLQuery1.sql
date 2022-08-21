CREATE TABLE waiter(
	waiter_id int NOT NULL primary key,
	f_name nvarchar(50),
	l_name nvarchar(50),
	SSN int NOT NULL,
	salary money NOT NULL,
	phone int ,
	address nvarchar(50),
	manager_id int not null
      , FOREIGN KEY (manager_id)
        REFERENCES T_Manager(manager_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
   )
;

CREATE TABLE customer(
	customer_id int NOT NULL primary key,
	f_name nvarchar(50),
	l_name nvarchar(50),
	SSN int NOT NULL,
	phone int ,
	address nvarchar(50),
	birthdate date
   )
;

CREATE TABLE food(
	food_id int NOT NULL primary key,
	name nvarchar(50),
	price money NOT NULL,
	amount int ,
	remainOrnot bit NOT NULL
   )
;

CREATE TABLE accountant(
	accountant_id int NOT NULL primary key,
	f_name nvarchar(50),
	l_name nvarchar(50),
	SSN int NOT NULL,
	phone int ,
	address nvarchar(50),
	salary money not null,
	degree nvarchar(50),
	manager_id int not null
      , FOREIGN KEY (manager_id)
        REFERENCES T_Manager(manager_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
   )
;

CREATE TABLE payment(
	payment_id int NOT NULL primary key,
	paydate date NOT NULL ,
	amount money NOT NULL,
	payment_type  nvarchar(50),
	customer_id int NOT NULL,
	accountant_id int  not null,
	FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
      FOREIGN KEY (accountant_id)
        REFERENCES accountant(accountant_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
   )
;
CREATE TABLE factor(
	factor_id int NOT NULL primary key,
	factordate date NOT NULL ,
	total_price money NOT NULL,
	number int not null,
	type  nvarchar(50),
	customer_id int NOT NULL,
	waiter_id int  not null,
	food_id int NOT NULL,
	FOREIGN KEY (waiter_id)
        REFERENCES waiter(waiter_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (food_id)
        REFERENCES food(food_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
      FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
   )
;

ALTER TABLE accountant
ADD manager_id int not null
      , FOREIGN KEY (manager_id)
        REFERENCES T_Manager(manager_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE