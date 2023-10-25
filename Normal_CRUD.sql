-- Выводит все чайные и количество магазинов в них, и которых больше 1
SELECT tea_room.tea_room, count(shops.shop_id) as num_shops
FROM tea_room
JOIN shops ON tea_room.tea_id = shops.tea_id
GROUP BY tea_room.tea_room
HAVING  count(shops.shop_id) > 1;

-- Выводит ФИ челова, чайную, название тоавра, который он заказал и отсортировывает все в правильном порядке
SELECT concat(second_name, ' ',person_name), tea_room, product_name
FROM booking
JOIN booking_in_shop bis on booking.booking_id = bis.booking_id
JOIN person p on p.person_id = booking.person_id
JOIN shops s on s.shop_id = bis.shop_id
JOIN tea_room tr on tr.tea_id = s.tea_id
JOIN assortment a on s.shop_id = a.shop_id
JOIN structure s2 on s2.product_id = a.product_id
ORDER BY concat(second_name, ' ',person_name), tea_room, product_name;


SELECT distinct tea_room, s.shop_id, sum(price) OVER (PARTITION BY p.shop_id) as Price,
       sum(quantity) OVER (PARTITION BY p.shop_id) as Quantity
FROM purchase as p
JOIN shops s on s.shop_id = p.shop_id
JOIN tea_room tr on tr.tea_id = s.tea_id;

SELECT row_number() OVER (ORDER BY (person_name)), person_contact, booking_id
FROM person
JOIN booking b on person.person_id = b.person_id;


SELECT DISTINCT count(booking_id) OVER (PARTITION BY product_name ORDER BY product_name) as count,
                concat(person_name, ' ',second_name) as Name
FROM booking as b
JOIN person p on p.person_id = b.person_id
JOIN structure s on s.product_id = b.product_id;

SELECT row_number() over (ORDER BY product_name), avg(product_price) over(PARTITION BY a.shop_id)as Price, a.shop_id as Shop,
       lag(bis.booking_id, 1, 0) over (ORDER BY bis.booking_id) as booking_id
FROM booking
JOIN booking_in_shop bis on booking.booking_id = bis.booking_id
JOIN person p on p.person_id = booking.person_id
JOIN shops s on s.shop_id = bis.shop_id
JOIN tea_room tr on tr.tea_id = s.tea_id
JOIN assortment a on s.shop_id = a.shop_id
JOIN structure s2 on s2.product_id = a.product_id;