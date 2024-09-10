drop table if exists history;
drop table if exists components;
drop table if exists people;

create table if not exists people (
  id integer primary key autoincrement,
  nickname text unique not null,  -- имя в телеграмме (уникальное)
  last_name text not null,  -- фамилия (обязательно)
  first_name text, -- имя
  middle_name text -- отчество
);

create table if not exists components (
  id integer primary key autoincrement,
  name text unique not null  -- наименование (уникальное)
);

create table if not exists history (
  id integer primary key autoincrement,
  human integer references people(id),
  component integer references components(id),
  quantity integer default 1,  -- кол-во (по умолчанию 1)
  created_at timestamp default (datetime('now','localtime'))
);

insert into people(nickname, last_name, first_name, middle_name)
values ('Galina', 'Басаргина', 'Галина', 'Александровна');
insert into people(nickname, last_name, first_name, middle_name)
values ('Bsrgin', 'Басаргин', 'Александр', null);
insert into people(nickname, last_name, first_name, middle_name)
values ('Art', 'Лебедев', 'Артем', null);

insert into components (name) values ('Винт');
insert into components (name) values ('Болт');
insert into components (name) values ('Пропеллер');
insert into components (name) values ('Двигатель');
insert into components (name) values ('Полетный контроллер');

-- поскольку база данных пустая, то id начинаются с 1 в этом тесте
insert into history (human, component, quantity) values (1, 3, 6);
insert into history (human, component, quantity) values (2, 5, 7);
insert into history (human, component, quantity) values (3, 1, 99);
insert into history (human, component, quantity) values (1, 2, 88);
insert into history (human, component, quantity) values (1, 2, 15);
insert into history (human, component, quantity) values (2, 5, 3);
insert into history (human, component, quantity) values (3, 3, 1);


-- выбрать всех людей:
select * from people;
-- выбрать всех людей отсортированных по имени
select * from people order by first_name; 
-- выбрать всех людей отсортированных по имени в обратном порядке
select * from people order by first_name desc; 
-- выбрать людей с отчеством
select * from people where middle_name is not null;

-- людей которые добавляли компоненты
select *
from people, history
where people.id = history.human;
-- тоже самое, но короче
select * 
from people as p, history as h
where p.id = h.human;
-- выберем только нужные нам данные
select
  p.id as human,
  p.nickname,
  p.last_name,
  p.first_name,
  p.middle_name,
  h.id as history,
  h.component,
  h.quantity,
  h.created_at 
from people as p, history as h
where p.id = h.human;
-- присоединяем компоненты
select
  p.id as human,
  p.nickname,
  p.last_name,
  p.first_name,
  p.middle_name,
  h.id as history,
  c.name,
  h.quantity,
  h.created_at 
from people as p, history as h, components as c
where p.id = h.human and c.id = h.component;
-- сколько компонентов на складе (полный список)
select
  c.id,
  c.name,
  h.quantity
from history as h, components as c
where c.id = h.component;
-- сколько компонентов на складе (суммарные количества)
select
  c.id,
  c.name,
  sum(h.quantity) as quantity 
from history as h, components as c
where c.id = h.component
group by c.id, c.name;

-- добавить и удалить новый пропеллер
insert into history (human, component, quantity) values (1, 3, -1);
-- проверяем что 1 пропеллер исчез
select
  c.id,
  c.name,
  sum(h.quantity) as quantity 
from history as h, components as c
where c.id = h.component
group by c.id, c.name;
-- удалим из истории запись
delete from history where id = 8;
-- проверяем что 1 пропеллер появился
select
  c.id,
  c.name,
  sum(h.quantity) as quantity 
from history as h, components as c
where c.id = h.component
group by c.id, c.name
order by c.name;

-- добавить новых персонажей
insert into people (nickname, first_name, last_name)
values ('Авокадик', 'Пупкин', 'Василий');
insert into people (nickname, first_name, last_name)
values ('Васька', 'Прекрасная', 'Василиса');
-- исправление
update people set
  first_name = last_name,
  last_name = first_name
where id = 5 or id = 4;
-- упрощение запроса
update people set
  first_name = last_name,
  last_name = first_name
where id in (4,5);
-- усложение запроса (вложенный запрос)
--update people set
--  first_name = last_name,
--  last_name = first_name
--where id in (
--  select id
--  from people
--  where middle_name is null
--);

-- простой запролс по людям
select
 id,
 nickname
from people;
-- усложним выборку по людям
select
 id,
 nickname,
 (select sum(history.quantity) from history where people.id=history.human) summa
from people;
-- с помощью группировки
select 
  people.id,
  nickname,
  count(quantity) as cnt,
  sum(quantity) as summ,
  min(quantity) as minimum,
  max(quantity) as maximum,
  avg(quantity) as "среднее"
from people, history
where people.id = human
group by people.id, nickname
   union
select 
  id, nickname, 0, null, null, null, null
from people
where id not in (select distinct human from history);
-- ерешение через соединение
select 
 p.nickname,
 c.name,
 sum(h.quantity) as summa
from people p
 left outer join history as h on (h.human=p.id)
 left outer join components as c on (c.id=h.component)
group by p.nickname, c.name;










