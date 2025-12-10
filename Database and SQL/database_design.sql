create table ku_user_status (
    id SERIAL PRIMARY KEY,
    name TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table ku_user_location_type (
    id SERIAL PRIMARY KEY,
    name TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table ku_user_location_status (
    id SERIAL PRIMARY KEY,
    name TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table ku_user (
    id SERIAL PRIMARY KEY,
    name TEXT,
    email TEXT,
    phone TEXT,
    password_hash TEXT,
    salt TEXT,
    photo TEXT,
    status INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    CONSTRAINT fk_user_status
    FOREIGN KEY (status) REFERENCES ku_user_status(id)
);

create table ku_order_status (
    id SERIAL PRIMARY KEY,
    name TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table ku_product_status (
    id SERIAL PRIMARY KEY,
    name TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table ku_user_location (
    id SERIAL PRIMARY KEY,
    type INT,
    status INT,
    user_id INT,
    location TEXT,
    address TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    CONSTRAINT fk_location_type
    FOREIGN KEY (type) REFERENCES ku_user_location_type(id),
    CONSTRAINT fk_location_status
    FOREIGN KEY (status) REFERENCES ku_user_location_status(id),
    CONSTRAINT fk_location_user
    FOREIGN KEY (user_id) REFERENCES ku_user(id)
);

create table ku_order (
    id SERIAL PRIMARY KEY,
    user_id INT,
    status INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    CONSTRAINT fk_order_user
    FOREIGN KEY (user_id) REFERENCES ku_user(id),
    CONSTRAINT fk_order_status
    FOREIGN KEY (status) REFERENCES ku_order_status(id)
);

create table ku_product (
    id SERIAL PRIMARY KEY,
    name TEXT,
    effective_date DATE,
    effective_until DATE,
    photo TEXT,
    price NUMERIC(12,2),
    status INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    CONSTRAINT fk_product_status
    FOREIGN KEY (status) REFERENCES ku_product_status(id)
);

create table ku_category (
    id SERIAL PRIMARY KEY,
    name TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table ku_product_category (
    id SERIAL PRIMARY KEY,
    product_id INT,
    category_id INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    CONSTRAINT fk_pc_product
    FOREIGN KEY (product_id) REFERENCES ku_product(id),
    CONSTRAINT fk_pc_category
    FOREIGN KEY (category_id) REFERENCES ku_category(id)
);

create table ku_order_detail_status (
    id SERIAL PRIMARY KEY,
    name TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

create table ku_order_detail (
    id SERIAL PRIMARY KEY,
    user_location_id INT,
    order_id INT,
    product_id INT,
    quantity INT,
    delivery_date DATE,
    status INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    CONSTRAINT fk_od_location
    FOREIGN KEY (user_location_id) REFERENCES ku_user_location(id),
    CONSTRAINT fk_od_order
    FOREIGN KEY (order_id) REFERENCES ku_order(id),
    CONSTRAINT fk_od_product
    FOREIGN KEY (product_id) REFERENCES ku_product(id),
    CONSTRAINT fk_od_status
    FOREIGN KEY (status) REFERENCES ku_order_detail_status(id)
);
