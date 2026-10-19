## Part 2 - Identify Entities

### STUDENT

STUDENT entity (set of students who are allowed to borrow equipment from the university department):

INSTANCES:

Student 201 - Maria Lopez

Student 202 - James Smith

List of attributes: student_id, first_name, last_name, email, birth_date, phone_number

### EQUIPMENT

EQUIPMENT entity (set of equipment that is owned by the university department and available for students to borrow):

INSTANCES:

Equipment 301 - Dell Laptop

Equipment 302 - Canon Camera

ATTRIBUTES: equipment_id, equipment_name, serial_number, purchase_date, status, category_id

### CATEGORY

CATEGORY entity (set of categories of equipment that are available for students):

INSTANCES:

Category 401 - Laptops

Category 402 - Cameras

ATTRIBUTES: category_id, category_name, description

### CHECKOUT

CHECKOUT entity (set of records for each time a student borrows equipment):

INSTANCES:

Checkout 501 - Student 201 borrows Equipment 301

Checkout 502 - Student 202 borrows Equipment 302

ATTRIBUTES: checkout_id, student_id, equipment_id, checkout_date, due_date, return_date, return_condition

## Part 3 - Attribute Analysis

### STUDENT

student_id: Key, Single Valued, Simple

name: Composite (first_name, last_name), Single Valued

first_name: Simple, Single Valued

last_name: Simple, Single Valued

email: Simple, Single Valued

birth_date: Simple, Single Valued

phone_number: Multivalued (since a student may have multiple numbers)

age: Derived (can be calculated from the birth_date attribute)

### EQUIPMENT

equipment_id: Key, Single Valued, Simple

equipment_name: Single Valued, Simple

serial_number: Single Valued, Simple

purchase_date: Single Valued, Simple

status: Single Valued, Simple

category_id: Single Valued, Simple

### CATEGORY

category_id: Key, Single Valued, Simple

category_name: Single Valued, Simple

description: Single Valued, Simple

### CHECKOUT

checkout_id: Key, Single Valued, Simple

student_id: Single Valued, Simple

equipment_id: Single Valued, Simple

checkout_date: Single Valued, Simple

due_date: Single Valued, Simple

return_date: Single Valued, Simple (could be blank until the item is returned)

return_condition: Single Valued, Simple (could be blank until the item is returned)

### Explanation of Special Attributes

**Composite Attribute:** The student name is composite because it is formed by two other attributes, which are first_name and last_name.

**Multivalued Attribute:** The student phone_number is multivalued since a student can have more than one phone number.

**Derived Attribute:** The student age is derived because it can be calculated from the student birth_date together with the current date.

**Key Attributes:** Each entity has its own key attribute. The key attributes are student_id for STUDENT, equipment_id for EQUIPMENT, category_id for CATEGORY, and checkout_id for CHECKOUT.
## Part 4 - Relationships

### Relationship 1: CATEGORY classifies EQUIPMENT

Participating Entities: CATEGORY and EQUIPMENT

Relationship Degree: Binary

Cardinality: 1:N

Participation: CATEGORY = Partial, EQUIPMENT = Total

Meaning: One category can classify many pieces of equipment, but a piece of equipment must belong to one and only one category. There might be categories that do not contain any equipment.

### Relationship 2: STUDENT participates in CHECKOUT

Participating Entities: STUDENT and CHECKOUT

Relationship Degree: Binary

Cardinality: 1:N

Participation: STUDENT = Partial, CHECKOUT = Total

Meaning: One student can have many checkouts over time, but each checkout belongs to one particular student. Some students might never check out equipment.

### Relationship 3: EQUIPMENT participates in CHECKOUT

Participating Entities: EQUIPMENT and CHECKOUT

Relationship Degree: Binary

Cardinality: 1:N

Participation: EQUIPMENT = Partial, CHECKOUT = Total

Meaning: One piece of equipment can be checked out many times over time, but each checkout contains only one piece of equipment. Some pieces of equipment might never be checked out.

A piece of equipment can have at most one active checkout at a time.

### Relationship Summary

| Relationship | Degree | Cardinality | Participation |
|---|---|---|---|
| CATEGORY classifies EQUIPMENT | Binary | 1:N | CATEGORY = Partial, EQUIPMENT = Total |
| STUDENT participates in CHECKOUT | Binary | 1:N | STUDENT = Partial, CHECKOUT = Total |
| EQUIPMENT participates in CHECKOUT | Binary | 1:N | EQUIPMENT = Partial, CHECKOUT = Total |

## Part 5 - Participation Constraints

### Relationship 1: CATEGORY and EQUIPMENT

PARTICIPATION STATUS: CATEGORY – Partial, EQUIPMENT – Total.

MIN/MAX NOTATION: CATEGORY (0,N) — EQUIPMENT (1,1).

MEANING: A category could exist without equipment, but equipment can never exist without a category. A category can have many pieces of equipment (N). However, categories do not always have equipment.

Every piece of equipment is assigned to only one category. This is the reason why the minimum and maximum for equipment are both 1.

### Relationship 2: STUDENT and CHECKOUT

PARTICIPATION STATUS: STUDENT – Partial, CHECKOUT – Total.

MIN/MAX NOTATION: STUDENT (0,N) — CHECKOUT (1,1).

MEANING: A student may have 0 or many checkout transactions. Thus, the participation status for the student is partial. However, each checkout always belongs to a specific student.

Every checkout belongs to only one student, and every student can make many checkouts, ranging from 0 to N.

### Relationship 3: EQUIPMENT and CHECKOUT

PARTICIPATION STATUS: EQUIPMENT – Partial, CHECKOUT – Total.

MIN/MAX NOTATION: EQUIPMENT (0,N) — CHECKOUT (1,1).

MEANING: A piece of equipment can be associated with up to N checkouts over time. However, there may also be equipment with no checkouts.

Every checkout is associated with only one piece of equipment, but one piece of equipment can be associated with many checkouts over time.

A piece of equipment can only have one active checkout at a time.

### PARTICIPATION STATUS TABLE

| Relationship | First Entity | Second Entity |
|---|---|---|
| CATEGORY — EQUIPMENT | CATEGORY (0,N) Partial | EQUIPMENT (1,1) Total |
| STUDENT — CHECKOUT | STUDENT (0,N) Partial | CHECKOUT (1,1) Total |
| EQUIPMENT — CHECKOUT | EQUIPMENT (0,N) Partial | CHECKOUT (1,1) Total |
## Part 7 - Logical Model
### CHECKOUT Table

| Column | Data Type | Key |
|---|---|---|
| checkout_id | INT | PK |
| student_id | INT | FK |
| equipment_id | INT | FK |
| checkout_date | DATE | |
| due_date | DATE | |
| return_date | DATE | |
| return_condition | VARCHAR(100) | |

### Explanation

The STUDENT table stores the data about university students, the EQUIPMENT table stores the equipment items, the CATEGORY table holds the categories of the equipment items, and the CHECKOUT table holds information about which student borrowed each piece of equipment. The STUDENT_PHONE table holds the list of phone numbers for the students. One student can have multiple phone numbers.
The composite name attribute is further divided into the first_name and last_name fields. The derived age field is omitted because it can be calculated from the birth_date field together with the current date. Therefore, there is no need to store it permanently.

The tables are connected through foreign key relationships. The EQUIPMENT table is linked to the CATEGORY table through category_id. The CHECKOUT table is linked to the STUDENT and EQUIPMENT tables through student_id and equipment_id. Finally, the STUDENT_PHONE table is linked to the STUDENT table through student_id.

The STUDENT_PHONE table uses a composite primary key consisting of student_id and phone_number. This allows one student to have multiple phone numbers without storing duplicate phone numbers for the same student.

Within the CHECKOUT table, one equipment item can have multiple checkout records over time. However, for each piece of equipment, only one checkout record may have the return_date field set to NULL at a time, indicating an active checkout. This rule must be enforced in the MySQL implementation.

The primary keys uniquely identify each record, while the foreign keys preserve the relationships between the tables. These relationships follow the cardinality and participation constraints identified in the conceptual design.
Part 12 — Database Design Questions

1. What is the mini-world?

Mini-world is a school equipment checkout system that stores information about students, equipment, category of the equipment, and checkout details.

2. What are the entity types?

Entity types are STUDENT, EQUIPMENT, CATEGORY, and CHECKOUT.

3. Give an example of an entity instance.

An example of an entity instance can be a student with student_id 101 and name Maria’s Lopez.

4. What are the keys?

The attributes that is defined as keys include student_id, equipment_id, category_id, checkout_id, and student_id in STUDENT_PHONE.

5. What are simple attributes?

Simple attributes or atomic attributes are those that cannot be further subdivided, for instance, email, equipment_name, serial_number.

6. What is a composite attribute?

Composite attribute, on the other hand, is composed of two or more simple attributes, for example, student’s name in STUDENT entity.

7. What is a multivalued attribute?

Multivalued attributes are attributes that can have several values, for instance, student’s phone number, which is why it is stored in a different STUDENT_PHONE table.

8. What is a derived attribute?

Derived attribute’s value is calculated/apportioned from another attribute, for instance, age in STUDENT entity is derived from the student’s birth_date.

9. Give an example of a one-to-many-relationship.

An example of a one-to-many-relationship is between category and equipment entities because one category can have many pieces of the equipment, but each piece of equipment can have only one category.

10. Explain total and partial participation.

Total participation means that all entity instances participate in the relationship, for instance, all CHECKOUT items are related to a student and equipment item. Partial participation, on the other hand, implies that only some entity instances participate in a relationship, which applies to STUDENT and EQUIPMENT entities in relation to CHECKOUT entity.

11. Explain one design decision made when converting the conceptual model into the logical model.

One of the design decisions I made was to separate student phone numbers from the STUDENT entity and store them in a different STUDENT_PHONE table because students can have multiple phone numbers. Another decision was to separate composite student name attribute into first_name and last_name and to store the student’s date of birth rather than age.
