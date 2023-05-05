select district, sum(visitors) as total_domestic_visitors
from domestic_data
group by district 
order by total_domestic_visitors desc
limit 10;