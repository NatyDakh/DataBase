create TABLE tea_room (
    tea_id INTEGER NOT NULL UNIQUE,
    tea_room VARCHAR(100) NOT NULL,
    tea_room_contact VARCHAR(60) NOT NULL,
    owner VARCHAR(80) NOT NULL,
    all_num_employees INTEGER NOT NULL,
    address_office VARCHAR(80) NOT NULL,

    PRIMARY KEY(tea_id)
);

create TABLE shops (
    shop_id INTEGER UNIQUE,
    tea_id INTEGER NOT NULL,
    shop_address VARCHAR(80) NOT NULL,
    num_product INTEGER NOT NULL,
    num_employees INTEGER NOT NULL,
    shop_contact VARCHAR(60) NOT NULL,
    tableware BOOLEAN NOT NULL,
    tea_ceremony BOOLEAN NOT NULL,

    PRIMARY KEY (shop_id),
    FOREIGN KEY (tea_id) REFERENCES tea_room(tea_id)
);

create TABLE purchase(
    shop_id INTEGER,
    tea_type VARCHAR(10) NOT NULL,
    quantity FLOAT NOT NULL,
    price FLOAT NOT NULL,
    required_time INTEGER,

    PRIMARY KEY (shop_id, tea_type),
    FOREIGN KEY (shop_id) REFERENCES shops(shop_id)
);

create TABLE structure(
    product_id INTEGER,
    product_name VARCHAR(40) NOT NULL,
    type_tea VARCHAR(10),
    type_product VARCHAR(20) NOT NULL,
    other VARCHAR(100),

    PRIMARY KEY (product_id)
);

create TABLE person(
    person_id INTEGER,
    person_contact VARCHAR(40) NOT NULL,
    person_name VARCHAR(40) NOT NULL,
    second_name VARCHAR(40) NOT NULL,
    middle_name VARCHAR(40),
    sex VARCHAR(1) NOT NULL,
    age INTEGER NOT NULL,
    priority VARCHAR(50),

    PRIMARY KEY(person_id)
);

create TABLE assortment(
    product_id INTEGER,
    shop_id INTEGER,
    product_price FLOAT NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,

    CONSTRAINT pk_assortment PRIMARY KEY(product_id, shop_id),
    FOREIGN KEY(product_id) REFERENCES structure(product_id),
    FOREIGN KEY(shop_id) REFERENCES shops(shop_id)
);

create TABLE booking(
    booking_id INTEGER UNIQUE,
    person_id INTEGER,
    product_id INTEGER,

    CONSTRAINT pk_booking PRIMARY KEY(product_id, person_id, booking_id),
    FOREIGN KEY (product_id) REFERENCES structure(product_id),
    FOREIGN KEY (person_id) REFERENCES person(person_id)
);

create TABLE booking_in_shop(
    booking_id INTEGER,
    shop_id INTEGER,

    CONSTRAINT pk_booking_shop PRIMARY KEY (shop_id, booking_id),
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id),
    FOREIGN KEY (shop_id) REFERENCES shops(Shop_id)
);