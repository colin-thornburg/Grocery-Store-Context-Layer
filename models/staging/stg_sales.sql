with source as (

    select * from {{ ref('sales') }}

),

renamed as (

    select
        cast(sale_id as integer) as sale_id,
        cast(store_id as integer) as store_id,
        cast(product_category as varchar) as product_category,
        cast(business_date as date) as business_date,
        cast(net_sales as number(12, 2)) as net_sales,
        cast(product_cost as number(12, 2)) as product_cost
    from source

)

select * from renamed
