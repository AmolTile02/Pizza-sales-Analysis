--Problem Statement- 1:
--KPi's Requirment- Design KPi's with respect to below measures.
--1. Total Revenue: Sum of the total price of all pizza orders.
--2. Average Order Value: The average amount spent per order, calulated by dividing the total revenue by the total number of orders.
--3. Total Pizzas Sold: The sum of all quantities of all pizzas sold.
--4. Total Orders: The total number of orders placed.
--5. Average Pizzas Per Order: The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders.
---------------------------------------------------------------------------------------------------------------------------------------------------------
--Problem Statement- 2:
--Charts Requirement- We would like to visualize various aspects of our pizza sales data to gain insights and understand key trends.
-- We have identified the following requirements for creating charts:
--1. Daily Trend For total Orders: Create a bar chart that displays the daily trend of total orders over a spedific time period. 
--This chart will help us identify any patterns or fluctuations in order volumes on a daily basis.
--2. Monthly Trend For Total Orders: Create a line chart that illustrates the hourly trend of total orders throgh out the day. 
--This chart will allow us to idetify peak hours or periods of hight order activity.
--3. Percentage Of Sales By Pizza Category: Create a Pie chart that shows the distribution of sales across different pizza categories.
--This chart will provide insights into the popularity of various pizza categories and their contribution to overall sales.
--4. Percentage Of Sales By Pizza Size: Generate a pie chart that represents the percentage of sales attribute to diff pizza size.
--This chart will help us to understand customer prefrences for pizza sizes and their impact on sales.
--5. Total Pizzas Sold by Pizza Category: Create a funnel chart that presents the total number of pizzas sold for each Pizza categories.
--This chart allow us to compare the sales performance of different pizza categories.
--6. Top 5 best sellers by Revenue, Total Quantity And Total Orders: Create a Bar chart highlighting the Top 5 best sellers pizzas
--based on the revenue, Total Quantity, Total Orders. This chart will help us identify the most popular pizza options.
--7. Bottom 5 best sellers by Revenue, Total Quantity and Total Orders: Create a bar chart showcasing the bottom 5 worst selling pizzas
--based on the the revenue, Total Quantity, Total Orders. This chart will enable us to idetify underperming or less popular pizza options.
---------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------
select * from pizza_sales

--Problem Statement- 1:
--1. Total Revenue:
select sum(total_price) as Total_Revenue from pizza_sales

--2. Average Order Value:
select SUM(total_price) / COUNT(distinct order_id) as Avg_Order_Value from pizza_sales

--3. Total Pizzas Sold:
select sum(quantity) as Total_Pizza from pizza_sales

--4. Total Orders:
select COUNT(distinct order_id) as total_Orders from pizza_sales

--5. Average Pizzas Per Order:
select cast(cast(SUM(quantity) as Decimal(10,2)) / cast(count(distinct order_id) as Decimal(10,2)) as Decimal(10,2)) as AVg_Pizzas_Per_Order from pizza_sales
select cast(SUM(quantity) as float) / cast(count(distinct order_id) as float) as AVg_Pizzas_Per_Order from pizza_sales


--Problem Statement- 2:
--1. Daily Trend For total Orders: Each day of week sales(daywise Pizza Sales)
select DATENAME(DW, order_date) as Order_day, COUNT(distinct order_id) as Total_Orders from pizza_sales
group by DATENAME(DW, order_date)

--2. Monthly Trend For Total Orders:
select DATENAME(MONTH, order_date) as Order_Month, count(distinct order_id) as Total_Orders from pizza_sales
group by DATENAME(MONTH, order_date)
order by Total_Orders desc

--3. Percentage Of Sales By Pizza Category:
select pizza_category, SUM(total_price)*100 / (select SUM(total_price) from pizza_sales)  as Per_sales_by_pizza_size from pizza_sales 
group by pizza_category

--4. Percentage Of Sales By Pizza Size:
select pizza_size, sum(total_price)*100 / (select sum(total_price) from pizza_sales) as Per_sales_by_pizza_size from pizza_sales
group by pizza_size
order by Per_sales_by_pizza_size

--5. Total Pizzas Sold by Pizza Category:
select pizza_category, sum(quantity) as Total_Pizza_Sold from pizza_sales
group by pizza_category
order by Total_Pizza_Sold desc
---------------------------------------------------------------------------------------------------------------------------------------------------------
--6. Top 5 best sellers by Revenue, Total Quantity And Total Orders:
--A. Top 5 best sellers by Revenue
select top 5 pizza_name, sum(total_price) as Total_Revenue, SUM(quantity) as Total_Quantity, count(order_id) as Total_Orders from pizza_sales
group by pizza_name
order by Total_Revenue desc

--B. Top 5 best sellers by Total Quantity
select top 5 pizza_name, SUM(quantity) as Total_Quantity from pizza_sales
group by pizza_name
order by Total_Quantity desc

--C. Top 5 best sellers by Total Orders
select top 5 pizza_name, count(distinct order_id) as Total_Orders from pizza_sales
group by pizza_name
order by Total_Orders desc
---------------------------------------------------------------------------------------------------------------------------------------------------------

--7. Bottom 5 best sellers by Revenue, Total Quantity and Total Orders:
--A. Bottom 5 best sellers by Revenue
select top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue asc

--B. Bottom 5 best sellers by Total Quantity
select top 5 pizza_name, SUM(quantity) as Total_Quantity from pizza_sales
group by pizza_name
order by Total_Quantity asc

--C. Bottom 5 best sellers by Total Orders
select top 5 pizza_name, count(distinct order_id) as Total_Orders from pizza_sales
group by pizza_name
order by Total_Orders asc
---------------------------------------------------------------------------------------------------------------------------------------------------------