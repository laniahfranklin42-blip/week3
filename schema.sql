
CREATE DATABASE IF NOT EXISTS equipment_checkout;
USE equipment_checkout;

DROP TABLE IF EXISTS CHECKOUT;
DROP TABLE IF EXISTS STUDENT_PHONE;
DROP TABLE IF EXISTS EQUIPMENT;
DROP TABLE IF EXISTS CATEGORY;
DROP TABLE IF EXISTS STUDENT;

-- STUDENT Table
CREATE TABLE STUDENT (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    birth_date DATE NOT NULL
);

-- STUDENT_PHONE Table
CREATE TABLE STUDENT_PHONE (
    student_id INT NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    PRIMARY KEY (student_id, phone_number),
    FOREIGN KEY (student_id)
        REFERENCES STUDENT(student_id)
);

-- CATEGORY Table
CREATE TABLE CATEGORY (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);

-- EQUIPMENT Table
CREATE TABLE EQUIPMENT (
    equipment_id INT PRIMARY KEY,
    category_id INT NOT NULL,
    equipment_name VARCHAR(100) NOT NULL,
    serial_number VARCHAR(100) NOT NULL UNIQUE,
    purchase_date DATE,
    status VARCHAR(30) NOT NULL,
    FOREIGN KEY (category_id)
        REFERENCES CATEGORY(category_id)
);

-- CHECKOUT Table
CREATE TABLE CHECKOUT (
    checkout_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    equipment_id INT NOT NULL,
    checkout_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    return_condition VARCHAR(100),

    active_equipment_id INT GENERATED ALWAYS AS (
        CASE
            WHEN return_date IS NULL THEN equipment_id
            ELSE NULL
        END
    ) STORED,

    FOREIGN KEY (student_id)
        REFERENCES STUDENT(student_id),

    FOREIGN KEY (equipment_id)
        REFERENCES EQUIPMENT(equipment_id),

    CONSTRAINT chk_checkout_dates
        CHECK (due_date >= checkout_date),

    CONSTRAINT chk_return_date
        CHECK (
            return_date IS NULL
            OR return_date >= checkout_date
        ),

    CONSTRAINT uq_active_equipment
        UNIQUE (active_equipment_id)
);
