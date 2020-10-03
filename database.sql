Модель хранения данных популярного веб-сайта Geekbrains.
Количество таблиц - 12. С первичными ключами, индексами, внешними ключами;


-- Создаём БД
CREATE DATABASE geekbrains;


-- Делаем её текущей
USE geekbrains;


DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(70) NOT NULL,
  last_name VARCHAR(70) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  phone VARCHAR(30) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пользователи';


-- Создаём индексы
CREATE INDEX users_first_name_idx ON users(first_name);
CREATE INDEX users_last_name_idx ON users(last_name);


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
  user_id INT UNSIGNED NOT NULL PRIMARY KEY, 
  gender ENUM ('m', 'f'),
  birthday DATE,
  city VARCHAR(50),
  country VARCHAR(50),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT "Профили";

-- Добавляем внешний ключ
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
-- Создаём индекс
CREATE INDEX profiles_birthday_idx ON profiles(birthday);



DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  name VARCHAR(50),
  desription TEXT,
  price DECIMAL (11,2) UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Курсы';

-- Добавляем внешний ключ
ALTER TABLE courses
  ADD CONSTRAINT courses_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
-- Создаём индекс
CREATE INDEX courses_name_idx ON courses(name);
CREATE INDEX courses_price_idx ON courses(price);



DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Заказы курсов';

-- Добавляем внешний ключ
ALTER TABLE orders
  ADD CONSTRAINT orders_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;

     
     
DROP TABLE IF EXISTS orders_courses;
CREATE TABLE orders_courses (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  order_id INT UNSIGNED NOT NULL,
  courses_id INT UNSIGNED NOT NULL,
  total INT UNSIGNED DEFAULT 1,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

-- Добавляем внешние ключи
ALTER TABLE orders_courses
  ADD CONSTRAINT orders_courses_order_id_fk 
    FOREIGN KEY (order_id) REFERENCES orders(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT orders_courses_courses_id_fk
    FOREIGN KEY (courses_id) REFERENCES courses(id)
      ON DELETE CASCADE;


     
DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  courses_id INT UNSIGNED NOT NULL,
  discount DECIMAL(8,4) UNSIGNED,
  finished_at DATETIME NULL,
  started_at DATETIME NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Скидки';

-- Добавляем внешние ключи
ALTER TABLE discounts
  ADD CONSTRAINT discounts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT discounts_courses_id_fk
    FOREIGN KEY (courses_id) REFERENCES courses(id)
      ON DELETE CASCADE;
     
-- Создаём индекс
CREATE INDEX discounts_discount_idx ON discounts(discount);


	
DROP TABLE IF EXISTS webinars;
CREATE TABLE webinars (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  courses_id INT UNSIGNED NOT NULL,
  video VARCHAR(150),
  desription TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Вебинары';

-- Добавляем внешний ключ
ALTER TABLE webinars
  ADD CONSTRAINT webinars_courses_id_fk 
    FOREIGN KEY (courses_id) REFERENCES courses(id)
      ON DELETE CASCADE;
     
-- Создаём индекс
CREATE INDEX webinars_video_idx ON webinars(video);


DROP TABLE IF EXISTS forum;
CREATE TABLE forum  (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(70) NOT NULL,
  body TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,  
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  
) COMMENT "форум";	


DROP TABLE IF EXISTS forum_users;
CREATE TABLE forum_users  (
  forum_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
  PRIMARY KEY (forum_id, user_id)
) COMMENT "Участники форума, связь между пользователями и форумами";

-- Добавляем внешние ключи
ALTER TABLE forum_users
  ADD CONSTRAINT forum_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT forum_users_forum_id_fk
    FOREIGN KEY (forum_id) REFERENCES forum(id)
      ON DELETE CASCADE;


DROP TABLE IF EXISTS forum_posts;
CREATE TABLE forum_posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  forum_id INT UNSIGNED NOT NULL,
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT "Сообщения форума";

-- Добавляем внешние ключи
ALTER TABLE forum_posts
  ADD CONSTRAINT forum_posts_forum_id_fk 
    FOREIGN KEY (forum_id) REFERENCES forum(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT forum_posts_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT forum_posts_to_user_id_fk
    FOREIGN KEY (to_user_id) REFERENCES users(id)
      ON DELETE CASCADE;


     
DROP TABLE IF EXISTS blog;
CREATE TABLE blog (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  title VARCHAR(70),
  body TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'блог';

-- Добавляем внешний ключ
ALTER TABLE blog
  ADD CONSTRAINT blog_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;


     
DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  from_user_id INT UNSIGNED NOT NULL,
  to_user_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT "Сообщения";

-- Добавляем внешние ключи
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT messages_to_user_id_fk
    FOREIGN KEY (to_user_id) REFERENCES users(id)
      ON DELETE CASCADE;