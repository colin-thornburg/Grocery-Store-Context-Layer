with source as (

    select * from {{ ref('shrink') }}

),

renamed as (

    select
        cast(shrink_id as integer) as shrink_id,
        cast(store_id as integer) as store_id,
        cast(product_category as varchar) as product_category,
        cast(business_date as date) as business_date,
        cast(shrink_cost as number(12, 2)) as shrink_cost
    from source

)

select * from renamed
