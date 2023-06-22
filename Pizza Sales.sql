use Project3
Select* from dbo.pizzas
Select* from dbo.pizza_types
Select * from dbo.orders order by CAST(order_id as int)
Select* from dbo.order_details


--What day do the pizza place tends to be the busiest?
Select Datename(weekday,"date") as weekday_name,count(*) as numbers_of_orders from dbo.orders group by Datename(weekday,"date")

--What time do the pizza place tends to be the busiest?
Select 
Case when cast("time" as time) between '09:00:00' and '12:00:00' then 'Morning'
            when cast("time" as time) between '12:00:00' and '16:00:00' then 'Afternoon'
			when cast("time" as time) between '16:00:00' and '19:00:00' then 'Evening'
			when cast("time" as time) between '19:00:00' and '23:00:00' then 'Night'
		 Else 'Midnight'
	   End as Time_slot ,
count(*) as numbers_of_orders
from dbo.orders group by Case when cast("time" as time) between '09:00:00' and '12:00:00' then 'Morning'
            when cast("time" as time) between '12:00:00' and '16:00:00' then 'Afternoon'
			when cast("time" as time) between '16:00:00' and '19:00:00' then 'Evening'
			when cast("time" as time) between '19:00:00' and '23:00:00' then 'Night'
		 Else 'Midnight'
		 End



	--What is our best selling pizza? 
select top 1 dbo.pizza_types."name", sum(cast(dbo.order_details.quantity as int)) as numer_of_pizzas_ordered from dbo.order_details right join dbo.pizzas on dbo.order_details.pizza_id=dbo.pizzas.pizza_id 
right join dbo.pizza_types on dbo.pizzas.pizza_type_id=dbo.pizza_types.pizza_type_id
group by dbo.pizza_types."name" order by sum(cast(dbo.order_details.quantity as int)) desc



--What is our worst selling pizza? 
select top 1 dbo.pizza_types."name", sum(cast(dbo.order_details.quantity as int)) as numer_of_pizzas_ordered from dbo.order_details right join dbo.pizzas on dbo.order_details.pizza_id=dbo.pizzas.pizza_id 
right join dbo.pizza_types on dbo.pizzas.pizza_type_id=dbo.pizza_types.pizza_type_id
group by dbo.pizza_types."name" order by sum(cast(dbo.order_details.quantity as int))

--What's our average order value?
select Sum((cast(dbo.order_details.quantity as int)*cast(dbo.pizzas.price as float)))/Count(distinct dbo.order_details.order_id) as average_order_value 
from dbo.pizzas 
inner join dbo.order_details on dbo.pizzas.pizza_id=dbo.order_details.pizza_id




--How many customers do we have each day? 
select ((count(*))/(count(distinct "date"))) as average_orders_per_day from dbo.orders


--How many pizzas are typically in an order?
select count(order_id),sum(cast(quantity as int)) from dbo.order_details group by sum(cast(quantity as int)) order by cast(order_id as int)











