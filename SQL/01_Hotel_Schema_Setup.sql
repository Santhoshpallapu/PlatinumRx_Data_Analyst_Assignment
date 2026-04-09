-- Create tables

CREATE TABLE users (
    user_id TEXT PRIMARY KEY,
    name TEXT,
    phone_number TEXT,
    mail_id TEXT,
    billing_address TEXT
);

CREATE TABLE bookings (
    booking_id TEXT PRIMARY KEY,
    booking_date TEXT,
    room_no TEXT,
    user_id TEXT
);

CREATE TABLE items (
    item_id TEXT PRIMARY KEY,
    item_name TEXT,
    item_rate INTEGER
);

CREATE TABLE booking_commercials (
    id TEXT PRIMARY KEY,
    booking_id TEXT,
    bill_id TEXT,
    bill_date TEXT,
    item_id TEXT,
    item_quantity REAL
);

-- Insert sample data

INSERT INTO users VALUES 
('u1','John','999','john@mail','addr1'),
('u2','Sam','888','sam@mail','addr2');

INSERT INTO bookings VALUES 
('b1','2021-11-10','r1','u1'),
('b2','2021-10-05','r2','u2');

INSERT INTO items VALUES 
('i1','Paratha',20),
('i2','Veg',100);

INSERT INTO booking_commercials VALUES 
('c1','b1','bill1','2021-11-10','i1',2),
('c2','b1','bill1','2021-11-10','i2',1),
('c3','b2','bill2','2021-10-05','i2',20);
