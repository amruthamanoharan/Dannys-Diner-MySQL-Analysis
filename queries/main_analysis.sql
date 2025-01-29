/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?

SELECT customer_id, sum(price) as total_amount FROM dannys_diner.sales
join dannys_diner.menu USING (product_id)
group by customer_id;

-- 2. How many days has each customer visited the restaurant?

SELECT customer_id, count(*) as no_of_days_visited FROM dannys_diner.sales 
group by customer_id;

-- 3. What was the first item from the menu purchased by each customer?

with first_order as (
					SELECT customer_id,  MIN(order_date) as first_order  
                    FROM dannys_diner.sales 
					group by customer_id
                    )
	select f.customer_id, menu.product_name, f.first_order 
    from first_order as f
    left join dannys_diner.sales as s on f.customer_id = s.customer_id and f.first_order = s.order_date
    join dannys_diner.menu on menu.product_id = s.product_id;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT product_name, count(*) as no_of_purchase 
FROM dannys_diner.sales 
join dannys_diner.menu  using (product_id)
group by product_name order by no_of_purchase DESC limit 1;

-- 5. Which item was the most popular for each customer?

with customer_popularity as (
	SELECT s.customer_id, m.product_name, count(*) as no_of_purchase , rank() over (partition by s.customer_id order by count(*) DESC ) as position   
	FROM dannys_diner.sales s
	JOIN dannys_diner.menu as m using (product_id)
	group by s.customer_id,m.product_name
    )
	select customer_id , GROUP_CONCAT(product_name SEPARATOR ', ') as popular_item
    from customer_popularity 
    where position=1
    GROUP BY customer_id;

-- 6. Which item was purchased first by the customer after they became a member?

With purchase_history as (
		SELECT s.customer_id, product_name, order_date, join_date, 
        rank() over(partition by customer_id order by order_date ASC)  as ranking 
        FROM dannys_diner.sales as s
		join dannys_diner.members m using(customer_id)
		join dannys_diner.menu as me using(product_id)
		where order_date >= join_date
        )
        select customer_id, GROUP_CONCAT(product_name SEPARATOR ', ') as item, MAX(order_date) AS order_date 
        from purchase_history 
        where ranking = 1
        group by customer_id;

-- 7. Which item was purchased just before the customer became a member?

With purchase_history as (
		select s.customer_id, product_name, order_date, join_date, 
        rank() over(partition by customer_id order by order_date DESC)  as ranking 
        from dannys_diner.sales as s
		join dannys_diner.members m using(customer_id)
		join dannys_diner.menu as me using(product_id)
		where order_date < join_date
        )
        select customer_id, GROUP_CONCAT(product_name SEPARATOR ', ') as item, MAX(order_date) AS order_date  
        from purchase_history 
        where ranking = 1
        group by customer_id;
        
-- 8. What is the total items and amount spent for each member before they became a member?

		SELECT s.customer_id, GROUP_CONCAT(DISTINCT product_name SEPARATOR ', ') as item, sum(price) AS price  
        FROM dannys_diner.sales as s
		join dannys_diner.members m using(customer_id)
		join dannys_diner.menu as me using(product_id)
		where order_date < join_date
        group by customer_id;

-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

with pt_multiplier as (
						SELECT customer_id,
							case 
								when product_name = 'sushi' then price*20
								else price*10
							end as points  
						FROM dannys_diner.sales s
						join dannys_diner.members m using(customer_id)
						join dannys_diner.menu me using(product_id)
                        )
                        select customer_id, sum(points) as total_points
                        from pt_multiplier
                        group by customer_id;

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
	
			select customer_id,
					sum(case
						WHEN s.order_date BETWEEN m.join_date AND DATE_ADD(m.join_date, INTERVAL 6 DAY) THEN price*20
						WHEN s.order_date > DATE_ADD(m.join_date, INTERVAL 6 DAY) AND product_name = 'sushi' then price*20
						ELSE price*10
					end )as points
			from dannys_diner.sales s
			join dannys_diner.members m using(customer_id)
			join dannys_diner.menu me using(product_id)
            where order_date BETWEEN '2021-01-01' AND '2021-01-31' and customer_id in ('A', 'B')
			group by customer_id;
            