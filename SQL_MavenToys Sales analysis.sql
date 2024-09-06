
/* 1. Product and Category Analysis */

-- Question: How many different products are commercialised by the company?

select 
	count(product_name) as number_of_products
from 
	products


-- How many different products have been sold each year?
select
	YEAR(date) _year,
	count(distinct Product_ID) number_distinct_products_sold
from sales
group by YEAR(date)
order by _year


-- Question: What is the number of products by each category?
select 
	product_category, 
	count(product_name) as number_of_products
from 
	products
group by 
	product_category


-- Which products have not been sold in 2022?

select
	 Product_ID,
	 Product_Name
from products
where Product_ID not in
				(select Product_ID
				 from sales 
				 where YEAR(date) = 2022)


-- What is the higher and lower price proposed by the company for its toys?

select 
	MAX(product_price) higher_price,
	MIN(product_price) lower_price
from
	products


-- What is the average price and cost per product category?

select 
    product_category, 
    avg(product_price) AS average_price, 
    avg(product_cost) AS average_cost
from
    products
group by 
    product_category


-- What is the price-to-cost ratio for each product category?

SELECT 
    product_category, 
    AVG(product_price / product_cost) AS price_to_cost_ratio
FROM 
    products
GROUP BY 
    product_category;

/* 2. Sales Performance Analysis */

-- Question: what is the best seller product each year?

With CTE as
(
	select 
		YEAR(date) _year,
		product_name, 
		sum(units) total_units_sold,
		rank() over (partition by YEAR(date) order by  sum(units) desc) rnk_sales
	from 
		products p
		join sales s on p.product_id = s.product_id
	group by
		YEAR(date),
		product_name 
		)
select
	_year,
	Product_name,
	total_units_sold
from 
	CTE
where 
	rnk_sales = 1


-- Which product generated more revenue each year?

With CTE as
(
	select 
		YEAR(date) _year,
		product_name, 
		sum(units*product_price) total_revenue,
		rank() over (partition by YEAR(date) order by sum(units*product_price) desc) rnk_revenues
	from 
		products p
		join sales s on p.product_id = s.product_id
	group by
		YEAR(date),
		product_name 
		)
select
	_year,
	Product_name,
	total_revenue
from 
	CTE
where 
	rnk_revenues = 1


-- Question: How does each product rank in terms of sales within its category?

select 
	product_category, 
	product_name, 
	sum(units) total_unit_sold,
	rank() over (partition by product_category order by sum(units) desc) rnk_sales
from 
	products p
	join sales s on p.product_id = s.product_id
group by
	product_category, 
	product_name 


-- Question: What are the total sales revenue and total units sold by product category each month in 2022 and 2023?

select 
	year(date) _year, 
	datename(month,date) month_name, 
	product_category, 
	sum(units * product_price) total_revenues, 
	sum(units) total_units_sold
from 
	products p
	join sales s on p.Product_ID = s.Product_ID
group by 
	year(date), 
	datename(month,date),
	month(date),
	Product_Category
order by 
	_year, month(date), Product_Category


-- What is the total revenue and cumulative (running) revenue for each product category in 2022 and 2023, calculated separately for each year?

with cte as
	(
		select 
			year(date) _year,
			product_category,
			sum(units*product_price) as total_revenue
		from
			sales s
			join products p on s.product_id = p.product_id
		group by 
			year(date),
			product_category
			)
select
	_year,
	product_category,
	total_revenue,
	sum(total_revenue) over (partition by _year order by product_category) running_total_revenue
from 
	CTE
order by
	_year, Product_Category


	-- Question: How do monthly sales for each product compare to the previous month's sales on each year?

select 
	year(date) _year,
	datename(month,date) monthname,
	sum(units) Units_sold,
	lag(sum(units)) over (partition by year(date) order by month(date)) previous_month_Units_sold,
	sum(units) - lag(sum(units)) over (partition by year(date) order by month(date)) units_sold_change
from
	sales s
	join products p on s.product_id = p.product_id
group by
	year(date),
	month(date),
	datename(month,date)
order by
	_year, month(date)


-- Question: What is the year-over-year sales growth for each product category?

select 
	product_category,
	year(Date) _year,
	sum(units*product_price) as annual_revenue,
	lag(sum(units*product_price)) over(partition by product_category order by year(Date)) previous_year_revenue,
	(sum(units*product_price) - lag(sum(units*product_price)) over(partition by product_category order by year(Date))) /
	lag(sum(units*product_price)) over(partition by product_category order by year(Date)) * 100
from
	sales s
	join products p on s.product_id = p.product_id
group by
	product_category,
	year(Date)

	
/* 3. Inventory Management */

-- What is the stock level status for each product, based on total stock on hand, and how do the stock levels vary across product categories?
-- The stock levels are categorized as 'High' if the total stock is 1500 or more, 'Medium' if between 500 and 1499, and 'Low' if less than 500.

select 
	product_category, 
	product_name,
	sum(stock_on_hand) total_stock,
	case
		when sum(stock_on_hand) >= 1500 then 'High stock level'
		when sum(stock_on_hand) >= 500 then 'medium stock level'
		else 'low stock level'
		End stock_level_status
from 
	inventory i
	join products p
	on i.Product_ID = p.Product_ID
group by
    product_category, 
	product_name
order by
	total_stock desc


/* 4. Performance Comparison By store and by city */

-- Question: Which stores generated the most revenues?
	
select
	store_name, 
	sum(units*product_price) total_revenues
from 
	products p
	join sales s on p.product_id = s.product_id
	join stores st on s.store_id = st.store_id
group by  
	store_name
order by 
	total_revenues desc


-- Question: what is the average revenue per store by city?

select
	store_city,
	avg(total_revenue) avg_revenue
from
	(
		select
			store_city,
			store_name,
			sum(units*product_price) total_revenue
		from 
			stores st
			join sales s on st.store_id = s.store_id
			join products p on p.product_id = s.product_id
		group by 
			store_city,
			store_name) as store_revenue
group by 
	store_city
order by
	avg_revenue	desc
	

/* 5. Profitability Analysis */

--Question: What is the profitability of each product, and how does it vary by store?

select 
	store_name,
	product_name, 
	sum(units*(product_price - product_cost)) total_profit
from 
	stores st
	join sales s on st.store_id = s.store_id
	join products p on s.product_id = p.product_id
group by
	store_name,
	product_name
order by 
	total_profit desc


/* 6. Top-Selling Products */

-- Question: What are the top 10 best-selling products overall?

SELECT 
    p.Product_Name,
    SUM(s.Units) AS Total_Units_Sold
FROM 
    Sales s
    JOIN Products p ON s.Product_ID = p.Product_ID
GROUP BY 
    p.Product_Name
ORDER BY 
    Total_Units_Sold DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;

      
-- What are the top 3 best-selling products by category overall?

with ranked_product as
(
	select
		product_category,
		product_name,
		sum(units) total_units_sold,
		rank() over (partition by product_category order by sum(units) desc) rnk_units_sold
	from 
		products p
		join sales s on p.product_id = s.product_id
	group by 
		product_category,
		product_name)
select 
	product_category,
		product_name,
		total_units_sold
from
	ranked_product
where
	rnk_units_sold < 4


