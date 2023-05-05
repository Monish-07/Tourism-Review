with
dom_hyd as ( select district, year, sum(visitors) as dom_hyd_visitors from domestic_data where district = "Hyderabad" group by year ),

yoy_dom_hyd as ( select h1.district, avg(((h2.dom_hyd_visitors - h1.dom_hyd_visitors)/h1.dom_hyd_visitors) * 100)
	as YoY_change_dom from dom_hyd h1 join dom_hyd h2 on h1.year = h2.year - 1 ),

for_hyd as ( select district, year, sum(visitors) as for_hyd_visitors
	from foreign_data where district = "Hyderabad" group by year ),
    
yoy_for_hyd as ( select h1.district, avg(((h2.for_hyd_visitors - h1.for_hyd_visitors)/h1.for_hyd_visitors) * 100)
	as YoY_change_for from for_hyd h1 join for_hyd h2 on h1.year = h2.year - 1 )
    
select
	dv.district,
    round((dv.dom_hyd_visitors * power((1 + dy.YoY_change_dom/100), 6)), 2) * 1200 as "Est_Domestic_Revenue_2025(in Rs.)",
    round((fv.for_hyd_visitors * power((1 + fy.YoY_change_for/100), 6)), 2) * 1200 as "Est_Foreign_Revenue_2025(in Rs.)"
from
	dom_hyd as dv, yoy_dom_hyd as dy,
    for_hyd as fv, yoy_for_hyd as fy
where 
	dv.year = 2019 and fv.year = 2019;
    
    
    