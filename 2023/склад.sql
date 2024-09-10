DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS vendors;
DROP TABLE IF EXISTS cells;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS workers;


CREATE TABLE workers (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	second_name TEXT(20) NOT NULL,
	name TEXT(20) NOT NULL,
	patronymic TEXT(20) NOT NULL,
	pay INTEGER NOT NULL,
	start_date DATETIME NOT NULL
);

CREATE TABLE rooms (
	id INTEGER NOT NULL PRIMARY KEY,
	main_worker INTEGER NOT NULL,
	FOREIGN KEY(main_worker) REFERENCES workers(id)
);

CREATE TABLE cells (
	id INTEGER NOT NULL PRIMARY KEY,
	room INTEGER NOT NULL,
	height INTEGER NOT NULL,
	weight INTEGER NOT NULL,
	"depth" INTEGER NOT NULL,
	product_code INTEGER,
	FOREIGN KEY(room) REFERENCES rooms(id)
);

CREATE TABLE vendors (
	id INTEGER NOT NULL PRIMARY KEY,
	phone TEXT(18) NOT NULL -- +012(345)678-90-12
);

CREATE TABLE products (
	id INTEGER NOT NULL PRIMARY KEY,
	vendor INTEGER NOT NULL,
	rest INTEGER NOT NULL,
	price INTEGER NOT NULL,
	FOREIGN KEY(vendor) REFERENCES vendors(id)
);

CREATE TABLE clients (
	id INTEGER NOT NULL PRIMARY KEY,
	address TEXT(30) NOT NULL,
	phone TEXT(18) NOT NULL -- +012(345)678-90-12
);

CREATE TABLE orders (
	id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	client INTEGER NOT NULL,
	product INTEGER NOT NULL,
	cell INTEGER NOT NULL,
	"count" INTEGER NOT NULL,
	price INTEGER NOT NULL,
	"date" DATETIME NOT NULL,
	FOREIGN KEY(client) REFERENCES clients(id),
	FOREIGN KEY(product) REFERENCES products(id),
	FOREIGN KEY(cell) REFERENCES cells(id)
);

-----------------------------------------------------

INSERT INTO clients(id, address, phone) VALUES (0, 'ул. Ватутина д 58', '+7(578)357-34-76');
INSERT INTO clients(id, address, phone) VALUES (1, 'Невский пр. д 67', '7459873');
INSERT INTO clients(id, address, phone) VALUES (2, 'Невский пр. д 66', '7677309');
INSERT INTO clients(id, address, phone) VALUES (3, 'Невский пр. д 65', '7578973');
INSERT INTO clients(id, address, phone) VALUES (4, 'ул. Пулковская д 1', '4120001');
INSERT INTO clients(id, address, phone) VALUES (5, 'ул. Орджоникидзе д 45', '4103535');
INSERT INTO clients(id, address, phone) VALUES (6, 'ул. Орджоникидзе д 45', '4103536');

INSERT INTO vendors(id, phone) VALUES (10, '+79213888916');
INSERT INTO vendors(id, phone) VALUES (11, '+79210909634');
INSERT INTO vendors(id, phone) VALUES (12, '+79219841482');

INSERT INTO products VALUES (100, 10, 99, 42);
INSERT INTO products VALUES (101, 10, 13, 1);
INSERT INTO products VALUES (102, 11, 65, 8585);
INSERT INTO products VALUES (103, 12, 5094, 2);

-------------------------------------------------------

SELECT * FROM vendors;
SELECT phone, id FROM vendors;

SELECT *
FROM vendors AS v;

SELECT * 
FROM vendors v, products p
WHERE v.id = p.vendor ;

SELECT * 
FROM vendors v, products p
WHERE v.id = p.vendor;

SELECT
 p.id AS product,
 p.vendor,
 p.rest,
 p.price,
 v.phone,
 p.rest * p.price AS total
FROM
 vendors v,
 products p
WHERE
 v.id = p.vendor
ORDER BY
 6 DESC;

SELECT
 v.id vendor,
 v.phone,
 AVG(v.id) 
FROM vendors v, products p 
WHERE v.id = p.vendor
GROUP BY v.id, v.phone;

SELECT 
 p.vendor,
 v.phone,
 --p.price,
 --p.rest,
 SUM(p.rest * p.price) AS total
FROM products p, vendors v
WHERE v.id = p.vendor 
GROUP BY vendor, phone
ORDER BY 3 ASC;

---------------------------------------------

INSERT INTO workers(second_name, name, patronymic, pay, start_date) VALUES ('Пупкин', 'Вася', 'Иваныч', 100, DATE());
INSERT INTO workers(second_name, name, patronymic, pay, start_date) VALUES ('Вупсень', 'Гусеница', 'Оно', 1, '2023-12-31');
INSERT INTO workers(second_name, name, patronymic, pay, start_date) VALUES ('Сидоров', 'Петя', 'Иваныч', 1000, DATE());
INSERT INTO workers(second_name, name, patronymic, pay, start_date) VALUES ('Премудрая', 'Василиса', 'Батьковна', 10000, '2000-01-01');

INSERT INTO rooms VALUES (56, 1);
INSERT INTO rooms VALUES (13, 2);
INSERT INTO rooms VALUES (66, 3);
INSERT INTO rooms VALUES (8, 4);
INSERT INTO rooms VALUES (1, 1);
INSERT INTO rooms VALUES (4, 2);

INSERT INTO cells VALUES (1, 56, 1, 1, 1, null);
INSERT INTO cells VALUES (2, 13, 1, 1, 1, null);
INSERT INTO cells VALUES (3, 13, 1, 1, 1, null);
INSERT INTO cells VALUES (57, 66, 1, 1, 1, null);
INSERT INTO cells VALUES (9, 13, 1, 1, 1, null);
INSERT INTO cells VALUES (23, 8, 1, 1, 1, null);
INSERT INTO cells VALUES (98, 8, 1, 1, 1, null);
INSERT INTO cells VALUES (35, 1, 1, 1, 1, null);
INSERT INTO cells VALUES (94, 1, 1, 1, 1, null);
INSERT INTO cells VALUES (4, 13, 1, 1, 1, null);
INSERT INTO cells VALUES (5, 13, 1, 1, 1, null);
INSERT INTO cells VALUES (6, 13, 1, 1, 1, null);
INSERT INTO cells VALUES (7, 13, 1, 1, 1, null);


SELECT *
FROM workers w, rooms r, cells c
WHERE w.id = r.main_worker AND r.id = c.room;

SELECT null is null;

SELECT *
FROM
 cells c 
  FULL OUTER JOIN rooms AS r ON (r.id = c.room) 
  FULL OUTER JOIN workers AS w ON (w.id = r.main_worker);
  
 
----- 

DROP TABLE a;
CREATE TABLE a (x integer, y integer);
CREATE TABLE b (i integer, j integer);

INSERT INTO a VALUES(1, null);
INSERT INTO a VALUES(2, null);
INSERT INTO a VALUES(3, 10);
INSERT INTO a VALUES(4, 11);

INSERT INTO b VALUES(null, 100);
INSERT INTO b VALUES(null, 101);
INSERT INTO b VALUES(10, 102);
INSERT INTO b VALUES(11, 103);

select * from a;
select * from b;

select a.*,b.* FROM a full join b on (a.y=b.i);
select * FROM a full outer join b on (a.y=b.i);
select b.j,b.i,a.y,a.x FROM b full join a on (a.y=b.i);

----- 

SELECT 
 r.id room,
 c.id cell
FROM
 rooms r FULL OUTER JOIN cells c ON (r.id = c.room);
 
SELECT 
 r.id room,
 --c.id cell
 COUNT(1),
 MIN(c.room)
FROM
 rooms r FULL OUTER JOIN cells c ON (r.id = c.room)
GROUP BY r.id;

SELECT
 r.id,
 (SELECT MIN(c.id) FROM cells c WHERE r.id=c.room),
 (SELECT COUNT(c.id) FROM cells c WHERE r.id=c.room)
 -- , (SELECT COUNT(1) FROM cells WHERE r.id=cells.room) AS "???"
FROM rooms r;

------------

SELECT y.room, y.cnt * y.mul
FROM (
  SELECT x.room, x.cnt, x.mn is not null as mul
  FROM (
    SELECT 
     r.id room,
     --c.id cell
     count(1) cnt,
     min(c.room) mn
    FROM
     rooms r FULL OUTER JOIN cells c ON (r.id = c.room)
    GROUP BY r.id
  ) AS x
) AS y;


--------------------------------------

SELECT 
 r.id AS room,
 (SELECT MIN(c.id) FROM cells c WHERE c.room = r.id) AS min_cell,
 (SELECT MAX(c.id) FROM cells c WHERE c.room = r.id) AS max_cell,
 (SELECT COUNT(c.id) FROM cells c WHERE c.room = r.id) AS cell_count,
 (SELECT SUM(c.height * c.weight * c.depth) FROM cells c WHERE c.room = r.id) AS volume
FROM rooms r ;


SELECT * FROM cells c ;


