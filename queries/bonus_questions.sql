-- Qn. Recreate the table output with the available data

select customer_id, order_date,product_name, price, 
case 
    when join_date <= order_date then 'Y'
    when join_date > order_date then 'N'
    else 'N'
end as Is_member
from dannys_diner.sales s
left join dannys_diner.members m using(customer_id)
join dannys_diner.menu me using(product_id)
order by customer_id, order_date;

-- Qn. Danny also requires further information about the ranking of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ranking values for the records when customers are not yet part of the loyalty program.

with customerData as (
	select customer_id, order_date,product_name, price, 
	case 
		when join_date <= order_date then 'Y'
		when join_date > order_date then 'N'
		else 'N'
	end as Is_member
	from dannys_diner.sales s
	left join dannys_diner.members m using(customer_id)
	join dannys_diner.menu me using(product_id)
	order by customer_id, order_date
    )
    select customer_id, order_date,product_name, price, Is_member, 
    case 
		when Is_member ='N' then Null
        else rank() over (partition by customer_id,Is_member order by order_date  )
	end as ranking 
    from customerData
    order by customer_id, order_date;