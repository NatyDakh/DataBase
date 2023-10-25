INSERT INTO structure VALUES
(11, 'Чай Малина-Земленика', 'Зеленый', 'Пакетированный', 'Малина, Земленика');

INSERT INTO person VALUES
(11, '+7(934)327-45-43', 'Леонид', 'Васильев', NULL, 'М', 43, 'Чай с ягодами; Аллергия на орехи');

UPDATE person set priority = NULL
where second_name like 'Васильев';

UPDATE booking_in_shop set booking_id = 3
where shop_id = 0000301;

SELECT tea_type, price
FROM purchase
WHERE price < 2000
ORDER BY price;

SELECT product_name, type_tea
FROM structure;

SELECT person_name, priority
FROM person
WHERE priority IS NOT NULL or age > 50;

SELECT tea_room
FROM tea_room, shops
WHERE tea_room.tea_room_contact = shops.shop_contact;

SELECT max(product_price), product_id
FROM assortment
GROUP BY product_id
ORDER BY product_id;

DELETE FROM person
WHERE person_contact LIKE '%33';


-- Осмысленные вопросы

--Вывсети все номера телефон и фамили людей, который сделали заказы в Россыпь

SELECT person_contact as Contact, concat(person_name, second_name) as Name
FROM (SELECT person_id, person_contact, peson_name, secon_name, )