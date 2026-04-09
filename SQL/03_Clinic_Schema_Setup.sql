CREATE TABLE clinics (
    cid TEXT,
    clinic_name TEXT,
    city TEXT,
    state TEXT,
    country TEXT
);

CREATE TABLE customer (
    uid TEXT,
    name TEXT,
    mobile TEXT
);

CREATE TABLE clinic_sales (
    oid TEXT,
    uid TEXT,
    cid TEXT,
    amount INTEGER,
    datetime TEXT,
    sales_channel TEXT
);

CREATE TABLE expenses (
    eid TEXT,
    cid TEXT,
    description TEXT,
    amount INTEGER,
    datetime TEXT
);

INSERT INTO clinics VALUES 
('c1','Clinic A','City1','State1','India'),
('c2','Clinic B','City1','State1','India');

INSERT INTO customer VALUES 
('u1','John','999'),
('u2','Sam','888');

INSERT INTO clinic_sales VALUES 
('o1','u1','c1',2000,'2021-09-10','online'),
('o2','u2','c2',3000,'2021-09-15','offline'),
('o3','u1','c1',1500,'2021-10-10','online');

INSERT INTO expenses VALUES 
('e1','c1','supplies',1000,'2021-09-12'),
('e2','c2','rent',1500,'2021-09-18'),
('e3','c1','staff',500,'2021-10-12');
