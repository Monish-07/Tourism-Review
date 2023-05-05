with ratio_table as (
	select d.district, d.visitors as dom_visitors, f.visitors as for_visitors
	from domestic_data d
	join foreign_data f
	on d.date = f.date and d.month = f.month and d.year = f.year
	group by d.district
)
select 
	district, 
    round(dom_visitors / nullif(for_visitors, 0),1) as dom_to_for_ratio
from ratio_table
order by dom_to_for_ratio desc
limit 3;



