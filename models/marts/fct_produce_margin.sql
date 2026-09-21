with sales as (

    select
        store_id,
        product_category,
        business_date,
        sum(net_sales) as net_sales,
        sum(product_cost) as product_cost
    from {{ ref('stg_sales') }}
    where product_category = 'produce'
    group by 1, 2, 3

),

shrink as (

    select
        store_id,
        product_category,
        business_date,
        sum(shrink_cost) as shrink_cost
    from {{ ref('stg_shrink') }}
    where product_category = 'produce'
    group by 1, 2, 3

)

select
    sales.store_id,
    sales.product_category,
    sales.business_date,
    sales.net_sales,
    sales.product_cost,
    coalesce(shrink.shrink_cost, 0) as shrink_cost,
    (sales.net_sales - sales.product_cost - coalesce(shrink.shrink_cost, 0))
        / nullif(sales.net_sales, 0) as gross_margin
from sales
left join shrink
    using (store_id, product_category, business_date)
