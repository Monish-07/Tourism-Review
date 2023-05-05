with hyd_table as (
	select
		d.district,
		d.year,
		(sum(d.visitors) + sum(f.visitors)) as total_hyd_visitors
	from domestic_data d
	join foreign_data f
	on d.year = f.year and d.month = f.month and d.date = f.date
	where d.district = "Hyderabad"
	group by d.year
),
yoy_est_table as (
	select
		h1.district,
		avg(((h2.total_hyd_visitors - h1.total_hyd_visitors)/h1.total_hyd_visitors) * 100)
		as YoY_change
	from hyd_table h1
	join hyd_table h2 on h1.year = h2.year - 1
)
select
	h.district,
    round((h.total_hyd_visitors * power((1 + y.YoY_change/100), 6)), 2)
    as Est_visitors_2025
from hyd_table h, yoy_est_table as y
where h.year = 2019;

