-- Q1: Last booked room per user
SELECT b.user_id, b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_date
    FROM bookings
    GROUP BY user_id
) t 
ON b.user_id = t.user_id 
AND b.booking_date = t.last_date;


-- Q2: Total billing for Nov 2021
SELECT 
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_bill
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%Y-%m', bc.bill_date) = '2021-11'
GROUP BY bc.booking_id;


-- Q3: Bills > 1000 in Oct 2021
SELECT 
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE strftime('%Y-%m', bc.bill_date) = '2021-10'
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;


-- Q4: Most ordered item per month
SELECT month, item_id, total_qty
FROM (
    SELECT 
        strftime('%Y-%m', bill_date) AS month,
        item_id,
        SUM(item_quantity) AS total_qty
    FROM booking_commercials
    WHERE strftime('%Y', bill_date) = '2021'
    GROUP BY month, item_id
) t
WHERE total_qty = (
    SELECT MAX(total_qty)
    FROM (
        SELECT 
            strftime('%Y-%m', bill_date) AS month,
            item_id,
            SUM(item_quantity) AS total_qty
        FROM booking_commercials
        GROUP BY month, item_id
    ) t2
    WHERE t2.month = t.month
);


-- Q5: 2nd highest bill per month
SELECT booking_id, month, total_bill
FROM (
    SELECT 
        bc.booking_id,
        strftime('%Y-%m', bc.bill_date) AS month,
        SUM(bc.item_quantity * i.item_rate) AS total_bill,
        DENSE_RANK() OVER (
            PARTITION BY strftime('%Y-%m', bc.bill_date)
            ORDER BY SUM(bc.item_quantity * i.item_rate) DESC
        ) AS rnk
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    GROUP BY bc.booking_id, month
) t
WHERE rnk = 2;
