--Retrieving all orders with a total amount greater than the average order value
SELECT o.order_id, o.total_amount
FROM orders o
WHERE o.total_amount > (SELECT AVG(total_amount) FROM orders);
--Listing customers who have not placed any orders
SELECT c.first_name, c.last_name
FROM cusotmers c
LEFT JOIN orders o ON c.cusmtomers_id = o.customer_id
WHERE o.order_id IS NULL;
--Finding the most frequently purchased product
SELECT p.name, SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id
ORDER BY total_quantity DESC
LIMIT 1;
--Finding all customers who spent more than 5000 RON in total
SELECT c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
FROM cusotmers c
JOIN orders o ON c.cusmtomers_id = o.cusmtomers_id
GROUP BY c.cusmtomers_id
HAVING SUM(o.total_amount) > 5000; 
--Finding all products that have never been purchased
SELECT p.name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.order_id IS NULL;
--Get the average order value for each customer 
SELECT c.first_name, c.last_name, round(AVG(o.total_amount)) AS average_order_value
FROM cusotmers c
JOIN orders o ON c.cusmtomers_id = o.cusmtomers_id
GROUP BY c.cusmtomers_id;
--Listing customers who have not placed any orders
SELECT c.first_name, c.last_name
FROM cusotmers c
LEFT JOIN orders o ON c.cusmtomers_id = o.customer_id
WHERE o.order_id IS NULL; 
--List the top 3 products by revenue in each category 
SELECT cat.name AS category_name, p.name AS product_name, SUM(oi.quantity * p.price) AS total_revenue
FROM categories cat
JOIN products p ON cat.category_id = p.category_id
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY cat.category_id, p.product_id
ORDER BY cat.category_id, total_revenue DESC
LIMIT 3;
--Get the total revenue and total discount given by each salesperson
SELECT s.first_name, s.last_name, SUM(o.total_amount) AS total_revenue, SUM(d.amount) AS total_discount
FROM salespeople s
JOIN orders o ON s.salesperson_id = o.salesperson_id
LEFT JOIN order_discounts od ON o.order_id = od.order_id
LEFT JOIN discounts d ON od.discount_id = d.discount_id
GROUP BY s.salesperson_id;
--Average order value per category
SELECT cat.name AS category_name, AVG(oi.quantity * oi.unit_price) AS avg_order_value
FROM categories cat
JOIN products p ON cat.id = p.category_id
JOIN order_items oi ON p.id = oi.product_id
GROUP BY cat.id, cat.name
ORDER BY avg_order_value DESC;
