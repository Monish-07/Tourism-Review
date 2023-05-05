select district, avg(cagr) as CAGR
from
(
	select district, year, visitors,
    visitors/prev_visitors - 1 as cagr
	from
	   (
			select *, lag(visitors, 1) over 
		    (partition by district order by year) as prev_visitors
			from domestic_data
	)a
)b
group by district
order by CAGR
limit 3;


