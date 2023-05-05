with total_visitors_table as (
	select d.district, (d.visitors + f.visitors) as total_visitors
	from domestic_data d
	join foreign_data f
	on d.date = f.date and d.month = f.month and d.year = f.year
	group by d.district
)
select
	a.district,
	(a.total_visitors / b.Est_population_2019) as tourist_footfall_ratio
from total_visitors_table a, telengana_population b
where a.district = b.district
group by district
order by tourist_footfall_ratio desc
limit 5;





