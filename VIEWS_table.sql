-- Таблица с данными о заказе и пользователе
CREATE VIEW tea_order AS
    SELECT concat(second_name, ' ',person_name), tea_room, product_name
    FROM booking
    INNER JOIN booking_in_shop bis on booking.booking_id = bis.booking_id
    INNER JOIN person p on p.person_id = booking.person_id
    INNER JOIN shops s on s.shop_id = bis.shop_id
    INNER JOIN tea_room tr on tr.tea_id = s.tea_id
    INNER JOIN assortment a on s.shop_id = a.shop_id
    INNER JOIN structure s2 on s2.product_id = a.product_id
    ORDER BY concat(second_name, ' ',person_name), tea_room, product_name;

-- Таблица с данными клиентов
 CREATE VIEW person_date AS
    SELECT concat(second_name, ' ', person_name, ' ' , middle_name) as name, sex, age,
           concat(SUBSTRING(person_contact, 1, 4),
               '**)*********', SUBSTRING(person_contact, 13, 4))
    FROM person;

-- Представитель с общим количеством заказаного чая и стоимости в чайных
CREATE VIEW summary_order AS
    SELECT distinct tea_room, s.shop_id, sum(price) OVER (PARTITION BY p.shop_id) as Price,
           sum(quantity) OVER (PARTITION BY p.shop_id) as Quantity
    FROM purchase as p
    JOIN shops s on s.shop_id = p.shop_id
    JOIN tea_room tr on tr.tea_id = s.tea_id;

-- Представитель с каждым заказом и его стоимостью в чайной
CREATE VIEW orders_in_shop AS
    SELECT tea_room,  product_name, sum(product_price) as summary_price
    FROM booking_in_shop bsh
    INNER JOIN shops s on s.shop_id = bsh.shop_id
    INNER JOIN tea_room t on s.tea_id = t.tea_id
    INNER JOIN booking b on b.booking_id = bsh.booking_id
    INNER JOIN assortment a on a.product_id = b.product_id
    INNER JOIN structure st on st.product_id = a.product_id
    GROUP BY (tea_room, product_name);

-- Представитель с данными об чайных
CREATE VIEW tea_room_date AS
    SELECT tea_room, tea_room_contact, address_office
    FROM tea_room;

-- Представитель с навзанием продукта и через сколько времени для него привезут чай
CREATE VIEW product_price AS
    SELECT product_name, st.type_tea, required_time
    FROM structure st
    INNER JOIN assortment a on st.product_id = a.product_id
    INNER JOIN purchase p on p.shop_id = a.shop_id
    ORDER BY type_tea, product_name, required_time DESC;