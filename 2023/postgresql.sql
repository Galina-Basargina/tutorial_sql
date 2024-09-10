select
 b.sdeb_blueprint_type_id,
 -- b.sdeb_activity,
 m.sdebm_material_id, 
 t.sdet_type_name,
 m.sdebm_quantity 
from
 qi.eve_sde_blueprints as b
  inner join qi.eve_sde_blueprint_materials as m on (b.sdeb_blueprint_type_id = m.sdebm_blueprint_type_id and
                                                     b.sdeb_activity = m.sdebm_activity)
  inner join qi.eve_sde_type_ids as t on (m.sdebm_material_id  = t.sdet_type_id) 
where
 b.sdeb_blueprint_type_id = 32881 and
 b.sdeb_activity = 1;
 
select 
 m.sdebm_material_id,
 count(1)
from qi.eve_sde_blueprint_materials as m
group by m.sdebm_material_id
order by 2 desc;
 
select 
 m.sdebm_activity,
 m.sdebm_material_id,
 t.sdet_type_name,
 count(1)
from 
 qi.eve_sde_blueprint_materials as m
  inner join qi.eve_sde_type_ids as t on (m.sdebm_material_id = t.sdet_type_id)
--where m.sdebm_activity = 1
group by m.sdebm_material_id, t.sdet_type_name, m.sdebm_activity 
order by m.sdebm_activity, 4 desc, t.sdet_type_name ;


