CREATE TABLE store (
  "KeyS" integer not null primary key,
  store varchar(255),
  type varchar(50),
  street_address varchar(255),
  phone varchar(50),
  city varchar(50),
  state varchar(50),
  country varchar(50)
);

CREATE TABLE customer (
  "KeyC" integer not null primary key,
  yearly_income integer,
  marital_status varchar(50),
  gender varchar(3),
  occupation varchar(50),
  education varchar(50),
  membership varchar(50),
  city varchar(50),
  state varchar(50),
  country varchar(50)
);

CREATE TABLE date(
  "keyD" integer NOT NULL PRIMARY KEY,
  date timestamp without time zone,
  quarter varchar(255),
  month varchar(255),
  dow varchar(255),
  year varchar(255)
);

CREATE TABLE product (
  "keyP" integer NOT NULL PRIMARY KEY, brand varchar(255),
  product varchar(255),
  "SKU" varchar(50),
  "SRP" real,
  gross_weight real,
  net_weight real,
  type varchar(50),
  category varchar(50),
  department varchar(50),
  family varchar(50),
  lowfat varchar(255)
);

CREATE TABLE sales (
  "keyD" integer,
  "keyC" integer,
  "keyP" integer,
  "keyS" integer,
  receipts real,
  cost real,
  quantity real,
  FOREIGN KEY(keyD) REFERENCES date(keyD),
  FOREIGN KEY(keyC) REFERENCES customer(keyC),
  FOREIGN KEY(keyP) REFERENCES product(keyP),
  FOREIGN KEY(keyS) REFERENCES store(keyS)
);

