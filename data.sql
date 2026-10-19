
USE equipment_checkout;

-- 10 Students
INSERT INTO STUDENT
(student_id, first_name, last_name, email, birth_date)
VALUES
(101, 'Maria', 'Lopez', 'maria@example.com', '2004-03-15'),
(102, 'James', 'Smith', 'james@example.com', '2003-07-22'),
(103, 'Ashley', 'Brown', 'ashley@example.com', '2005-01-10'),
(104, 'Michael', 'Johnson', 'michael@example.com', '2004-09-05'),
(105, 'Emily', 'Davis', 'emily@example.com', '2003-11-18'),
(106, 'Daniel', 'Wilson', 'daniel@example.com', '2005-06-30'),
(107, 'Sophia', 'Martinez', 'sophia@example.com', '2004-02-12'),
(108, 'David', 'Anderson', 'david@example.com', '2003-12-08'),
(109, 'Olivia', 'Taylor', 'olivia@example.com', '2005-04-20'),
(110, 'Noah', 'Thomas', 'noah@example.com', '2004-08-14');

-- Student phone numbers
INSERT INTO STUDENT_PHONE
(student_id, phone_number)
VALUES
(101, '202-555-0101'),
(101, '202-555-0102'),
(102, '202-555-0103'),
(103, '202-555-0104'),
(104, '202-555-0105'),
(105, '202-555-0106'),
(106, '202-555-0107'),
(107, '202-555-0108'),
(108, '202-555-0109'),
(109, '202-555-0110'),
(110, '202-555-0111');

-- 5 Equipment Categories
INSERT INTO CATEGORY
(category_id, category_name, description)
VALUES
(1, 'Laptops', 'Portable computers'),
(2, 'Cameras', 'Photography equipment'),
(3, 'Projectors', 'Presentation equipment'),
(4, 'Microphones', 'Audio recording equipment'),
(5, 'Networking', 'Networking devices');

-- 15 Equipment Items
INSERT INTO EQUIPMENT
(equipment_id, category_id, equipment_name,
 serial_number, purchase_date, status)
VALUES
(201, 1, 'Dell Laptop', 'DL1001', '2024-01-10', 'Available'),
(202, 1, 'HP Laptop', 'HP1002', '2024-02-15', 'Checked Out'),
(203, 1, 'MacBook', 'MB1003', '2024-03-20', 'Available'),
(204, 2, 'Canon Camera', 'CC1004', '2024-04-05', 'Checked Out'),
(205, 2, 'Nikon Camera', 'NC1005', '2024-05-12', 'Available'),
(206, 2, 'Sony Camera', 'SC1006', '2024-06-18', 'Available'),
(207, 3, 'Epson Projector', 'EP1007', '2024-07-10', 'Checked Out'),
(208, 3, 'BenQ Projector', 'BP1008', '2024-08-22', 'Available'),
(209, 3, 'ViewSonic Projector', 'VP1009', '2024-09-15', 'Available'),
(210, 4, 'Shure Microphone', 'SM1010', '2024-10-01', 'Available'),
(211, 4, 'Rode Microphone', 'RM1011', '2024-11-05', 'Available'),
(212, 4, 'Blue Microphone', 'BM1012', '2024-12-10', 'Available'),
(213, 5, 'Cisco Router', 'CR1013', '2025-01-15', 'Available'),
(214, 5, 'Netgear Switch', 'NS1014', '2025-02-20', 'Available'),
(215, 5, 'TP-Link Router', 'TR1015', '2025-03-25', 'Available');

-- 20 Checkout Transactions
-- NULL return_date means the equipment is still checked out.

INSERT INTO CHECKOUT
(checkout_id, student_id, equipment_id,
 checkout_date, due_date, return_date, return_condition)
VALUES
(301, 101, 201, '2026-01-05', '2026-01-12', '2026-01-11', 'Good'),
(302, 102, 202, '2026-01-08', '2026-01-15', '2026-01-14', 'Good'),
(303, 103, 203, '2026-01-10', '2026-01-17', '2026-01-20', 'Good'),
(304, 104, 204, '2026-01-12', '2026-01-19', '2026-01-18', 'Good'),
(305, 105, 205, '2026-01-15', '2026-01-22', '2026-01-21', 'Good'),
(306, 106, 206, '2026-01-18', '2026-01-25', '2026-01-24', 'Good'),
(307, 107, 207, '2026-02-01', '2026-02-08', '2026-02-10', 'Minor scratches'),
(308, 108, 208, '2026-02-05', '2026-02-12', '2026-02-11', 'Good'),
(309, 101, 209, '2026-02-10', '2026-02-17', '2026-02-16', 'Good'),
(310, 102, 210, '2026-02-15', '2026-02-22', '2026-02-20', 'Good'),
(311, 103, 211, '2026-03-01', '2026-03-08', '2026-03-07', 'Good'),
(312, 104, 212, '2026-03-05', '2026-03-12', '2026-03-14', 'Good'),
(313, 105, 213, '2026-03-10', '2026-03-17', '2026-03-16', 'Good'),
(314, 106, 201, '2026-04-01', '2026-04-08', '2026-04-07', 'Good'),
(315, 107, 203, '2026-04-05', '2026-04-12', '2026-04-11', 'Good'),
(316, 108, 205, '2026-04-10', '2026-04-17', '2026-04-16', 'Good'),
(317, 101, 202, '2026-10-12', '2026-10-25', NULL, NULL),
(318, 102, 204, '2026-10-13', '2026-10-26', NULL, NULL),
(319, 103, 207, '2026-10-14', '2026-10-27', NULL, NULL),
(320, 104, 210, '2026-10-15', '2026-10-28', NULL, NULL);

-- Update equipment status to match active checkouts
UPDATE EQUIPMENT
SET status = 'Checked Out'
WHERE equipment_id IN (202, 204, 207, 210);

-- Display the number of records
SELECT 'STUDENT' AS table_name, COUNT(*) AS total FROM STUDENT
UNION ALL
SELECT 'CATEGORY', COUNT(*) FROM CATEGORY
UNION ALL
SELECT 'EQUIPMENT', COUNT(*) FROM EQUIPMENT
UNION ALL
SELECT 'CHECKOUT', COUNT(*) FROM CHECKOUT;

