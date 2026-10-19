
USE equipment_checkout;

-- Query 1: What students are registered in the system?
SELECT * FROM STUDENT;

-- Query 2: What equipment is in the system?
SELECT * FROM EQUIPMENT;

-- Query 3: What category does each equipment item belong to?
SELECT e.equipment_name, c.category_name
FROM EQUIPMENT e
JOIN CATEGORY c
ON e.category_id = c.category_id;

-- Query 4: What equipment has student 101 checked out?
SELECT s.first_name, s.last_name,
       e.equipment_name, ch.checkout_date,
       ch.due_date, ch.return_date
FROM CHECKOUT ch
JOIN STUDENT s
ON ch.student_id = s.student_id
JOIN EQUIPMENT e
ON ch.equipment_id = e.equipment_id
WHERE s.student_id = 101;

-- Query 5: Which students have borrowed equipment?
SELECT DISTINCT s.student_id, s.first_name, s.last_name
FROM STUDENT s
JOIN CHECKOUT ch
ON s.student_id = ch.student_id;

-- Query 6: Which equipment items are currently checked out?
SELECT e.equipment_name, s.first_name,
       s.last_name, ch.checkout_date, ch.due_date
FROM CHECKOUT ch
JOIN EQUIPMENT e
ON ch.equipment_id = e.equipment_id
JOIN STUDENT s
ON ch.student_id = s.student_id
WHERE ch.return_date IS NULL;

-- Query 7: Which equipment items have never been checked out?
SELECT e.equipment_id, e.equipment_name
FROM EQUIPMENT e
LEFT JOIN CHECKOUT ch
ON e.equipment_id = ch.equipment_id
WHERE ch.checkout_id IS NULL;

-- Query 8: Which equipment items were returned late?
SELECT e.equipment_name, ch.due_date,
       ch.return_date
FROM CHECKOUT ch
JOIN EQUIPMENT e
ON ch.equipment_id = e.equipment_id
WHERE ch.return_date > ch.due_date;
