-- Хранимые процедуры / Триггеры;


-- хранимые процедуры
DELIMITER //
DROP PROCEDURE IF EXISTS numusers//
CREATE PROCEDURE numusers (OUT total INT)
BEGIN
  SELECT COUNT(*) INTO total FROM users;
END//
CALL numusers(@a)//
SELECT @a//
DELIMITER ;



-- тригеры

CREATE TRIGGER users_count AFTER INSERT ON users
FOR EACH ROW
BEGIN
  SELECT COUNT(*) INTO @total FROM users;
END//


CREATE TRIGGER check_last_users BEFORE DELETE ON users
FOR EACH ROW BEGIN
  DECLARE total INT;
  SELECT COUNT(*) INTO total FROM users;
  IF total <= 1 THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'DELETE canceled';
  END IF;
END//