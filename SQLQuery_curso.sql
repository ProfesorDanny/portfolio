--- consulta de tablas

Use Negocio
select * from cbr
select * from DETALLE_SII$
select * from MATERIALIDAD$



--- agrupación para calcular la suma por Mes- Año y comprador
select 
	format( fecha, 'yyyy-MM') as Mes,
	comprador,
	sum(UF) as Suma_UF
from cbr
where foja>=100251 and foja <=100500
group by format( fecha, 'yyyy-MM'), comprador

order by comprador

--- agrupación de  superficie de construccion por material

select 
	S.Material,
	sum ( cast( Superfie_Construccion as float) ) as SuperficieC 
from 
	DETALLE_SII$ as S
where s.material is not null
group by s.material
order by SuperficieC desc

--- Left Join de Detalle SII y Materialidad para encontrar el Material en DetalleSII

select s.material, s.Superfie_Construccion, m.descripcion, m.codigo
from DETALLE_SII$ as S
left join MATERIALIDAD$ as M
on s.material =m.codigo

---- SubQuery para encontrar la descripción del material de la tabla agrupada por codigo de material y suma de superficie

select a.material, a.SuperficieC , m.descripcion
from(
	select 
		S.Material,
		sum ( cast( Superfie_Construccion as float) ) as SuperficieC 
	from 
		DETALLE_SII$ as S
	where s.material is not null
	group by s.material
) as A
left join MATERIALIDAD$ as M
on A.material = m.codigo
order by SuperficieC desc
