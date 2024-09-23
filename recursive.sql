------------------------------------------------
--sort_str |chief|id |level|?column?           |
-----------+-----+---+-----+-------------------+
--2        |     |  2|    1| Новиков, Павел    |
--2|1      |    2|  1|    2|  Белова, Мария    |
--2|3      |    2|  3|    2|  Бабкина, Ольга   |
--2|4      |    2|  4|    2|  Воронова, Дарья  |
--2|5      |    2|  5|    2|  Кротов, Андрей   |
--2|5|6    |    5|  6|    3|   Акбаев, Иван    |
--2|5|7    |    5|  7|    3|   Кралев, Петр    |
--2|5|8    |    5|  8|    3|   Крылова, Анна   |
--2|5|8|100|    8|100|    4|    Пупкин, Василий|
--2|9      |    2|  9|    2|  Ясенева, Инна    |
with recursive r(id) as (
 select
  *,
  1 AS level,
  id::varchar(255) as sort_str
 from employee
 where chief is null
   union
 select
  e.*,
  r.level + 1 AS level,
  (r.sort_str || '|' || e.id::varchar(255))::varchar(255)
 from employee e
      join r on (e.chief = r.id)
)
select
 sort_str,
 chief, 
 id, 
 level, 
 substring('           ' from 1 for level) || last_name || ', ' || first_name
from r
order by sort_str;
