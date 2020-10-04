-- Смотрим структуру пользователей
DESC users;

-- Анализируем данные
SELECT * FROM users LIMIT 10;

-- Приводим в порядок временные метки
UPDATE users SET created_at = (SELECT created_at FROM messages WHERE users.id = messages.id),
                 updated_at = (SELECT updated_at FROM messages WHERE users.id = messages.id);
                 
UPDATE users SET updated_at = NOW() WHERE updated_at < created_at;


-- Смотрим структуру профилей
DESC profiles;
-- Анализируем данные
SELECT * FROM profiles LIMIT 10;
 
-- Поправим столбец страны
-- Создаём временную таблицу значений стран
DROP TABLE IF EXISTS countries;
CREATE TEMPORARY TABLE countries (name VARCHAR(150));
-- Заполняем значениями
INSERT INTO countries VALUES ('Russia');
-- Проверяем
SELECT * FROM countries;
-- Обновляем страну
UPDATE profiles 
  SET country = (SELECT name FROM countries);
 
 -- Поправим столбец города
-- Создаём временную таблицу значений городов
DROP TABLE IF EXISTS cities;
CREATE TEMPORARY TABLE cities (name VARCHAR(150));
-- Заполняем значениями
INSERT INTO cities VALUES ('Moscow'), ('Saint Petersburg'), ('Ekaterinburg'), ('Novosibirsk'), ('Vladivostok');
-- Проверяем
SELECT * FROM cities;
-- Обновляем города
UPDATE profiles 
  SET city = (SELECT name FROM cities ORDER BY RAND() LIMIT 1);
 
 
 -- Смотрим структуру таблицы сообщений
DESC messages;

-- Анализируем данные
SELECT * FROM messages LIMIT 10;
-- Обновляем значения ссылок на отправителя и получателя сообщения
UPDATE messages SET 
  from_user_id = FLOOR(1 + RAND() * 100),
  to_user_id = FLOOR(1 + RAND() * 100);
 

 -- Смотрим структуру таблицы курсов
DESC courses;
 
-- Анализируем данные
SELECT * FROM courses LIMIT 20;
-- Приводим в порядок временные метки
UPDATE courses SET created_at = (SELECT created_at FROM messages WHERE courses.id = messages.id),
                 updated_at = (SELECT updated_at FROM messages WHERE courses.id = messages.id);
                 
UPDATE courses SET updated_at = NOW() WHERE updated_at < created_at;

-- Обновляем значения ссылок
UPDATE courses SET 
  user_id = FLOOR(1 + RAND() * 100);
 
 
 -- Поправим столбец цен
-- Создаём временную таблицу значений цен
DROP TABLE IF EXISTS prices;
CREATE TEMPORARY TABLE prices (numbers DECIMAL (11,2) UNSIGNED);
-- Заполняем значениями
INSERT INTO prices VALUES ('100000'), ('150000'), ('120000'), ('75000'), ('190000'), ('250000'), ('80000');
-- Проверяем
SELECT * FROM prices;
-- Обновляем цены
UPDATE courses 
  SET price = (SELECT numbers FROM prices ORDER BY RAND() LIMIT 1);
 
 
 -- Поправим столбец name
-- Создаём временную таблицу названий
DROP TABLE IF EXISTS names;
CREATE TEMPORARY TABLE names (num VARCHAR(50));
-- Заполняем значениями
INSERT INTO names VALUES ('Python'), ('Java'), ('Web development'), ('Javascript'), ('Data Science'), ('Big Data'), ('DevOps'), ('IOS developer'), ('Android developer');
-- Проверяем
SELECT * FROM names;
-- Обновляем name
UPDATE courses 
  SET name = (SELECT num FROM names ORDER BY RAND() LIMIT 1);



 -- Смотрим структуру таблицы заказов
DESC orders;

-- Анализируем данные
SELECT * FROM orders LIMIT 20;

UPDATE orders SET user_id = FLOOR(1 + RAND() * 100);

-- Приводим в порядок временные метки
UPDATE orders SET created_at = (SELECT created_at FROM messages WHERE orders.id = messages.id),
                 updated_at = (SELECT updated_at FROM messages WHERE orders.id = messages.id);
                 
UPDATE orders SET updated_at = NOW() WHERE updated_at < created_at;


-- Смотрим структуру таблицы состава заказа
DESC orders_courses;

-- Анализируем данные
SELECT * FROM orders_courses LIMIT 20;
UPDATE orders_courses SET order_id = FLOOR(1 + RAND() * 100);
UPDATE orders_courses SET courses_id = FLOOR(1 + RAND() * 100);
UPDATE orders_courses SET total = FLOOR(1 + RAND() * 1);


-- Смотрим структуру таблицы скидок
DESC discounts;

-- Анализируем данные
SELECT * FROM discounts LIMIT 20;
UPDATE discounts SET user_id = FLOOR(1 + RAND() * 100);
UPDATE discounts SET courses_id = FLOOR(1 + RAND() * 100);
UPDATE discounts SET discount = 40;
                
UPDATE discounts SET started_at = NOW();
UPDATE discounts SET finished_at = started_at + INTERVAL 2 WEEK;


-- Смотрим структуру таблицы вебинаров
DESC webinars;

-- Анализируем данные
SELECT * FROM webinars LIMIT 20;
UPDATE webinars SET courses_id = FLOOR(1 + RAND() * 100);


-- Смотрим структуру таблицы форумов
DESC forum;
-- Анализируем данные
SELECT * FROM forum LIMIT 20;

UPDATE forum SET created_at = (SELECT created_at FROM messages WHERE forum.id = messages.id),
                 updated_at = (SELECT updated_at FROM messages WHERE forum.id = messages.id);
                 
UPDATE forum SET updated_at = NOW() WHERE updated_at < created_at;


-- Смотрим структуру таблицы участников форума
DESC forum_users;

-- Анализируем данные
SELECT * FROM forum_users LIMIT 20;

UPDATE forum_users SET forum_id = FLOOR(1 + RAND() * 100);
UPDATE forum_users SET user_id = FLOOR(1 + RAND() * 100);


-- Смотрим структуру таблицы сообщений форума
DESC forum_posts;

-- Анализируем данные
SELECT * FROM forum_posts LIMIT 20;
UPDATE forum_posts SET forum_id = FLOOR(1 + RAND() * 100);
UPDATE forum_posts SET from_user_id = FLOOR(1 + RAND() * 100);
UPDATE forum_posts SET to_user_id = FLOOR(1 + RAND() * 100);


-- Смотрим структуру таблицы блогов
DESC blog;

-- Анализируем данные
SELECT * FROM blog LIMIT 20;
UPDATE blog SET user_id = FLOOR(1 + RAND() * 100);
