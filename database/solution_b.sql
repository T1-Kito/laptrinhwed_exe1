-- 1. Liệt kê các hóa đơn của khách hàng
SELECT users.user_id, users.user_name, orders.order_id 
FROM users 
JOIN orders ON users.user_id = orders.user_id;

-- 2. Liệt kê số lượng đơn hàng của mỗi khách hàng
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS total_orders 
FROM users 
JOIN orders ON users.user_id = orders.user_id 
GROUP BY users.user_id;

-- 3. Liệt kê thông tin hóa đơn (mã đơn hàng, số sản phẩm)
SELECT orders.order_id, COUNT(order_details.product_id) AS total_products 
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id 
GROUP BY orders.order_id;

-- 4. Liệt kê thông tin mua hàng của người dùng (gom nhóm theo đơn hàng)
SELECT users.user_id, users.user_name, orders.order_id, products.product_name 
FROM users 
JOIN orders ON users.user_id = orders.user_id 
JOIN order_details ON orders.order_id = order_details.order_id 
JOIN products ON order_details.product_id = products.product_id 
ORDER BY orders.order_id;

-- 5. Lấy 7 người dùng có nhiều đơn hàng nhất
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS total_orders 
FROM users 
JOIN orders ON users.user_id = orders.user_id 
GROUP BY users.user_id 
ORDER BY total_orders DESC 
LIMIT 7;

-- 6. Lấy 7 người dùng mua sản phẩm Samsung hoặc Apple
SELECT DISTINCT users.user_id, users.user_name, orders.order_id, products.product_name 
FROM users 
JOIN orders ON users.user_id = orders.user_id 
JOIN order_details ON orders.order_id = order_details.order_id 
JOIN products ON order_details.product_id = products.product_id 
WHERE products.product_name LIKE '%Samsung%' OR products.product_name LIKE '%Apple%'
LIMIT 7;

-- 7. Danh sách mua hàng gồm giá tiền của mỗi đơn hàng
SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_price 
FROM users 
JOIN orders ON users.user_id = orders.user_id 
JOIN order_details ON orders.order_id = order_details.order_id 
JOIN products ON order_details.product_id = products.product_id 
GROUP BY orders.order_id;

-- 8. Lấy đơn hàng có giá trị lớn nhất của mỗi user
SELECT users.user_id, users.user_name, orders.order_id, MAX(total_price) AS max_price 
FROM (
    SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_price 
    FROM users 
    JOIN orders ON users.user_id = orders.user_id 
    JOIN order_details ON orders.order_id = order_details.order_id 
    JOIN products ON order_details.product_id = products.product_id 
    GROUP BY orders.order_id
) AS user_orders 
GROUP BY users.user_id;

-- 9 & 10. Các truy vấn tương tự nhưng lấy giá trị nhỏ nhất hoặc có nhiều sản phẩm nhất
