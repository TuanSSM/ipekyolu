-- Select all customers and
-- each customer's total orders
SELECT  c."customer_id",
        c."name",
		c."surname",
        COUNT(b."customer_id") totalOrders
FROM    "Customers" c
        LEFT JOIN "Orders" o
            ON c."customer_id" = o."customer_id"
GROUP   BY c."customer_id",
        c."name",
		c."surname"

-- Show Total Stocks
SELECT ps."product_id", SUM(ps."product_stock") total_stock
FROM "Product_Supplier" ps
GROUP BY ps."product_id"

-- revise
select amount
from price_history 
where product_id = X and option_id = Y 
and date_from <= NOW() and NOW() <= date_to;
