-- Представления
 
CREATE VIEW users1 AS SELECT * FROM users ORDER BY first_name;


CREATE VIEW users_reverse (up, cr, ph, em, las, fir, id)
AS SELECT updated_at, created_at, phone, email, last_name, first_name, id FROM users;


CREATE OR REPLACE VIEW us AS
SELECT id, first_name, last_name, email, phone 
FROM users
ORDER BY id, first_name;