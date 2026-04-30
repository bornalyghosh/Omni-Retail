-- Which region has the highest total revenue
SELECT 
    region,
    SUM(total_sale_amount) AS total_revenue,
    RANK() OVER (ORDER BY SUM(total_sale_amount) DESC) AS revenue_rank
FROM public.clean_sales_data_2 
GROUP BY region
ORDER BY revenue_rank;

WITH revenue_by_region AS (
    SELECT 
        region,
        SUM(total_sale_amount) AS total_revenue,
        COUNT(*) AS sale_count
    FROM public.clean_sales_data_2
    GROUP BY region
),
max_revenue AS (
    SELECT MAX(total_revenue) AS highest_revenue
    FROM revenue_by_region
)
SELECT 
    r.region,
    r.total_revenue,
    r.sale_count,
    ROUND(r.total_revenue / mr.highest_revenue * 100, 1) AS percent_of_max
FROM revenue_by_region r
CROSS JOIN max_revenue mr
ORDER BY r.total_revenue desc;

-- Which product category generates the highest revenue on average per sale
SELECT 
    product_category,
    ROUND(AVG(total_sale_amount), 2) AS avg_revenue_per_sale,
    COUNT(*) AS number_of_sales,
    SUM(total_sale_amount) AS total_revenue,
    RANK() OVER (ORDER BY AVG(total_sale_amount) DESC) AS rank_by_avg_revenue
FROM public.clean_sales_data_2
GROUP BY product_category
ORDER BY avg_revenue_per_sale DESC;

-- What is the return rate per product category
SELECT 
    product_category,
    COUNT(*) AS total_sales,
    SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) AS returned_count,
    ROUND(
        100.0 * SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) 
        / COUNT(*) 
        , 2
    ) AS return_rate_pct
FROM public.clean_sales_data_2
GROUP BY product_category
ORDER BY return_rate_pct DESC;

-- Identify the top 5 products with the highest total sales by quantity.
SELECT 
    product_id,
    product_category,
    SUM(quantity_sold) AS total_quantity_sold,
    COUNT(*) AS number_of_sales,
    ROUND(SUM(total_sale_amount), 2) AS total_revenue,
    ROUND(AVG(total_sale_amount), 2) AS avg_sale_amount
FROM public.clean_sales_data_2
GROUP BY product_id, product_category
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Which store has the lowest revenue but highest number of sales
WITH store_stats AS (
    SELECT 
        store_id,
        COUNT(*) AS number_of_sales,
        SUM(total_sale_amount) AS total_revenue,
        ROUND(AVG(total_sale_amount), 2) AS avg_sale_amount
    FROM public.clean_sales_data_2
    GROUP BY store_id
)
SELECT 
    store_id,
    number_of_sales,
    total_revenue,
    avg_sale_amount,
    RANK() OVER (ORDER BY total_revenue ASC) AS revenue_rank_asc,
    RANK() OVER (ORDER BY number_of_sales DESC) AS sales_rank_desc,
    ROUND(100.0 * total_revenue / SUM(total_revenue) OVER (), 2) AS percent_of_total_revenue
FROM store_stats
ORDER BY total_revenue ASC, number_of_sales DESC
LIMIT 10;

-- How do different payment methods impact total revenue
SELECT 
    payment_method,
    COUNT(*) AS number_of_sales,
    ROUND(SUM(total_sale_amount), 2) AS total_revenue,
    ROUND(AVG(total_sale_amount), 2) AS avg_revenue_per_sale,
    ROUND(100.0 * SUM(total_sale_amount) / SUM(SUM(total_sale_amount)) OVER (), 2) AS percent_of_total_revenue
FROM public.clean_sales_data_2
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- Which customers have made the most purchases in terms of total amount spent
SELECT 
    customer_id,
    COUNT(*) AS number_of_purchases,
    ROUND(SUM(total_sale_amount), 2) AS total_amount_spent,
    ROUND(AVG(total_sale_amount), 2) AS average_amount_per_purchase,
    MIN(sale_date) AS first_purchase_date,
    MAX(sale_date) AS last_purchase_date
FROM public.clean_sales_data_2
GROUP BY customer_id
ORDER BY total_amount_spent DESC
LIMIT 10;

-- including return impact
SELECT 
    customer_id,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN returned = 'No' THEN total_sale_amount ELSE 0 END) AS net_amount_spent,
    SUM(total_sale_amount) AS gross_amount_spent,
    SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) AS returns_count,
    ROUND(100.0 * SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS return_rate_pct
FROM public.clean_sales_data_2
GROUP BY customer_id
ORDER BY net_amount_spent DESC
LIMIT 10;

-- Which quarter sees the highest sales
SELECT 
    EXTRACT(QUARTER FROM sale_date) AS quarter,
    TO_CHAR(sale_date, 'YYYY') AS year,
    ROUND(SUM(total_sale_amount), 2) AS total_revenue,
    COUNT(*) AS transaction_count,
    ROUND(AVG(total_sale_amount), 2) AS avg_transaction_value,
    RANK() OVER (ORDER BY SUM(total_sale_amount) DESC) AS revenue_rank
FROM public.clean_sales_data_2
GROUP BY EXTRACT(QUARTER FROM sale_date), TO_CHAR(sale_date, 'YYYY')
ORDER BY revenue_rank;

-- What is the average unit price per product category
SELECT 
    product_category,
    ROUND(AVG(unit_price), 2) AS avg_unit_price,
    SUM(quantity_sold) AS total_units_sold,
    ROUND(SUM(total_sale_amount), 2) AS total_revenue,
    ROUND(SUM(total_sale_amount) / SUM(quantity_sold), 2) AS effective_avg_price_sold
FROM public.clean_sales_data_2
GROUP BY product_category
ORDER BY avg_unit_price DESC;

-- Which product categories have the highest return percentage
SELECT 
    product_category,
    ROUND(
        100.0 * SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) 
        / COUNT(*) 
        , 2
    ) AS return_percentage,
    COUNT(*) AS total_transactions,
    SUM(CASE WHEN returned = 'Yes' THEN 1 ELSE 0 END) AS returns
FROM public.clean_sales_data_2
GROUP BY product_category
ORDER BY return_percentage desc;
