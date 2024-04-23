
select * from cbr
where foja = 100251


select 
	format( fecha, 'yyyy-MM') as Mes,
	comprador,
	sum(UF) as Suma_UF
from cbr
where foja>=100251 and foja <=100500
group by format( fecha, 'yyyy-MM'), comprador

order by comprador