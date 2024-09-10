drop table if exists bridges;
drop table if exists rivers;

create table rivers(
	id int primary key,
	name text not null
);

create table bridges(
	name text primary key,
	river int not null references rivers(id),
	year_open int, -- а вдруг не сохранилась информация?
	length float not null, 
	width float not null
);

delete from bridges;
delete from rivers;

insert into rivers values
  (0, 'Большая Нева'),
  (1, 'Нева'),
  (2, 'Малая Нева'),
  (3, 'Канал Грибоедова'),
  (4, 'Фонтанка'),
  (5, 'Мойка'),
  (6, 'Зимняя Канавка');

insert into bridges values ('Дворцовый', 0, 1916, 265.5, 31.6);
insert into bridges values ('Троицкий', 1, 1903, 582.0, 23.5);
insert into bridges values ('Литейный', 1, 1879, 394.3, 34.6);
insert into bridges values ('Биржевой', 2, 1960, 239.0, 27.3);
insert into bridges values ('Банковский', 3, 1826, 28.0, 3.1);
insert into bridges values ('Львиный', 3, 1826, 27.3, 3.9);
insert into bridges values ('Аничков', 4, 1841, 50.0, 38.2);
insert into bridges values ('Александра Невского', 1, 1965, 907.7, 35.8);
insert into bridges values ('Египедский', 4, 1826, 53.3, 27.6);
insert into bridges values ('Синий', 5, 1842, 29.4, 113.85);
insert into bridges values ('Эрмитажный', 6, 1934, 12.2, 28.1);

select 
 b."name" as "Название", 
 r."name" as "Река",
 b.year_open as "Год открытия",
 b.length as "Длина, м",
 b.width as "Ширина, м"
from 
 bridges b, 
 rivers r
where 
 b.river = r.id ;

