-- Q1: Revenue by channel
SELECT sales_channel, SUM(amount) AS revenue
FROM clinic_sales
WHERE strftime('%Y', datetime) = '2021'
GROUP BY sales_channel;


-- Q2: Top 10 customers
SELECT uid, SUM(amount) AS total_spent
FROM clinic_sales
WHERE strftime('%Y', datetime) = '2021'
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;


-- Q3: Monthly profit
SELECT 
    strftime('%Y-%m', cs.datetime) AS month,
    SUM(cs.amount) AS revenue,
    SUM(e.amount) AS expense,
    SUM(cs.amount) - SUM(e.amount) AS profit,
    CASE 
        WHEN SUM(cs.amount) - SUM(e.amount) > 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM clinic_sales cs
JOIN expenses e ON cs.cid = e.cid
GROUP BY month;


-- Q4: Most profitable clinic per city
SELECT city, cid, profit
FROM (
    SELECT 
        c.city,
        c.cid,
        SUM(cs.amount) - SUM(e.amount) AS profit,
        RANK() OVER (PARTITION BY c.city ORDER BY SUM(cs.amount) - SUM(e.amount) DESC) AS rnk
    FROM clinics c
    JOIN clinic_sales cs ON c.cid = cs.cid
    JOIN expenses e ON c.cid = e.cid
    GROUP BY c.city, c.cid
) t
WHERE rnk = 1;


-- Q5: 2nd least profitable clinic per state
SELECT state, cid, profit
FROM (
    SELECT 
        c.state,
        c.cid,
        SUM(cs.amount) - SUM(e.amount) AS profit,
        DENSE_RANK() OVER (PARTITION BY c.state ORDER BY SUM(cs.amount) - SUM(e.amount) ASC) AS rnk
    FROM clinics c
    JOIN clinic_sales cs ON c.cid = cs.cid
    JOIN expenses e ON c.cid = e.cid
    GROUP BY c.state, c.cid
) t
WHERE rnk = 2;
