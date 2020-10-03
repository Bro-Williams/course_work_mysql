-- Вложенные запросы
SELECT
  first_name,
  last_name,
  (SELECT city FROM profiles WHERE user_id = 42) AS city,
  (SELECT name FROM courses WHERE id = 42) AS courses 
  FROM users
    WHERE id = 42; 
   
   

SELECT
  user_id, city, country
FROM
  profiles
WHERE
  user_id = (SELECT id FROM users WHERE first_name = "Eli");
 
  
 
   -- Выбираем сообщения пользователя с двух сторон
(SELECT to_user_id FROM messages WHERE from_user_id = 15)
UNION
(SELECT from_user_id FROM messages WHERE to_user_id = 15);
   
SELECT price FROM courses;


 
 -- Поиск пользователя по шаблонам имени  
SELECT CONCAT(first_name, ' ', last_name) AS fullname  
  FROM users
  WHERE first_name LIKE 'D%';


SELECT
  u.first_name, u.email, c.name
FROM
  users AS u
JOIN
  courses AS c
ON
  u.id = c.id;
 
 

SELECT
  p.id,
  p.name,
  p.price,
  d.discount
  FROM courses AS p
    LEFT JOIN discounts AS d
      ON p.id = d.user_id;
     
     
SELECT users.id, users.first_name, users.last_name, orders.id, orders.user_id
  FROM users
    JOIN orders
  ON users.id = orders.user_id;
 
 
 SELECT users.id, users.first_name, users.last_name, orders.id, orders.user_id
  FROM orders
    RIGHT JOIN users
  ON users.id = orders.user_id;
 
 
 -- Подсчёт заказов пользователя  
SELECT users.first_name, COUNT(orders.user_id) AS total_orders
  FROM users
    JOIN orders
  ON users.id = orders.user_id
  GROUP BY orders.user_id
  ORDER BY total_orders;
 

-- Выборка данных по пользователю
SELECT first_name, last_name, email, gender, birthday, city
  FROM users
    INNER JOIN profiles
      ON users.id = profiles.user_id
  WHERE users.id = 7;