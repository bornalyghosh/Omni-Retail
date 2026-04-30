CREATE TABLE public.clean_sales_data_2 AS
WITH numbered AS (
    SELECT 
        row_number() OVER () AS original_row_num,
        column_1,
        column_2,
        column_3,
        column_4,
        column_5,
        column_6
    FROM public.sales_data
),
unpivoted AS (
    -- 1. Sale_ID
    SELECT ((original_row_num - 1) / 12)::integer + 1 AS block_id, 1 AS source_col, column_2 AS sale_id, 
           NULL::date AS sale_date, NULL AS customer_id, NULL AS product_id, NULL AS product_category, 
           NULL::integer AS quantity_sold, NULL AS store_id, NULL AS region, NULL::numeric AS unit_price, 
           NULL AS payment_method, NULL AS returned, NULL::numeric AS total_sale_amount
    FROM numbered WHERE column_1 = 'Sale_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, column_3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
    FROM numbered WHERE column_1 = 'Sale_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, column_4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
    FROM numbered WHERE column_1 = 'Sale_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, column_5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
    FROM numbered WHERE column_1 = 'Sale_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, column_6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL 
    FROM numbered WHERE column_1 = 'Sale_ID'

    UNION ALL

    -- 2. Sale_Date
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, TO_DATE('1899-12-30','YYYY-MM-DD') + column_2::integer, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Sale_Date' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, TO_DATE('1899-12-30','YYYY-MM-DD') + column_3::integer, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Sale_Date' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, TO_DATE('1899-12-30','YYYY-MM-DD') + column_4::integer, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Sale_Date' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, TO_DATE('1899-12-30','YYYY-MM-DD') + column_5::integer, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Sale_Date' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, TO_DATE('1899-12-30','YYYY-MM-DD') + column_6::integer, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Sale_Date'

    UNION ALL

    -- 3. Customer_ID
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, NULL, column_2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Customer_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, NULL, column_3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Customer_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, NULL, column_4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Customer_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, NULL, column_5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Customer_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, NULL, column_6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Customer_ID'

    UNION ALL

    -- 4. Product_ID
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, NULL, NULL, column_2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Product_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, NULL, NULL, column_3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Product_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, NULL, NULL, column_4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Product_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, NULL, NULL, column_5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Product_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, NULL, NULL, column_6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Product_ID'

    UNION ALL

    -- 5. Product_Category
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, NULL, NULL, NULL, column_2, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Product_Category' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, NULL, NULL, NULL, column_3, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Product_Category' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, NULL, NULL, NULL, column_4, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Product_Category' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, NULL, NULL, NULL, column_5, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Product_Category' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, NULL, NULL, NULL, column_6, NULL, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Product_Category'

    UNION ALL

    -- 6. Store_ID
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, column_2, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Store_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, column_3, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Store_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, column_4, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Store_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, column_5, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Store_ID' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, NULL, NULL, NULL, NULL, NULL, column_6, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Store_ID'

    UNION ALL

    -- 7. Region
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_2, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Region' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_3, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Region' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_4, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Region' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_5, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Region' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_6, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Region'

    UNION ALL

    -- 8. Quantity_Sold
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, NULL, NULL, NULL, NULL, column_2::integer, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Quantity_Sold' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, NULL, NULL, NULL, NULL, column_3::integer, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Quantity_Sold' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, NULL, NULL, NULL, NULL, column_4::integer, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Quantity_Sold' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, NULL, NULL, NULL, NULL, column_5::integer, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Quantity_Sold' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, NULL, NULL, NULL, NULL, column_6::integer, NULL, NULL, NULL, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Quantity_Sold'

    UNION ALL

    -- 9. Unit_Price
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_2::numeric, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Unit_Price' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_3::numeric, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Unit_Price' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_4::numeric, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Unit_Price' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_5::numeric, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Unit_Price' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_6::numeric, NULL, NULL, NULL
    FROM numbered WHERE column_1 = 'Unit_Price'

    UNION ALL

    -- 10. Payment_Method
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_2, NULL, NULL
    FROM numbered WHERE column_1 = 'Payment_Method' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_3, NULL, NULL
    FROM numbered WHERE column_1 = 'Payment_Method' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_4, NULL, NULL
    FROM numbered WHERE column_1 = 'Payment_Method' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_5, NULL, NULL
    FROM numbered WHERE column_1 = 'Payment_Method' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_6, NULL, NULL
    FROM numbered WHERE column_1 = 'Payment_Method'

    UNION ALL

    -- 11. Returned  ← FIXED: added missing comma
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_2, NULL
    FROM numbered WHERE column_1 = 'Returned' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_3, NULL
    FROM numbered WHERE column_1 = 'Returned' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_4, NULL
    FROM numbered WHERE column_1 = 'Returned' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_5, NULL
    FROM numbered WHERE column_1 = 'Returned' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_6, NULL
    FROM numbered WHERE column_1 = 'Returned'

    UNION ALL

    -- 12. Total_Sale_Amount
    SELECT ((original_row_num - 1) / 12)::integer + 1, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_2::numeric
    FROM numbered WHERE column_1 = 'Total_Sale_Amount' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_3::numeric
    FROM numbered WHERE column_1 = 'Total_Sale_Amount' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_4::numeric
    FROM numbered WHERE column_1 = 'Total_Sale_Amount' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_5::numeric
    FROM numbered WHERE column_1 = 'Total_Sale_Amount' UNION ALL
    SELECT ((original_row_num - 1) / 12)::integer + 1, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, column_6::numeric
    FROM numbered WHERE column_1 = 'Total_Sale_Amount'
)
SELECT 
    block_id,
    row_number() OVER (PARTITION BY Block_ID ORDER BY source_col) AS Sale_Position,
    MAX(sale_id)           AS Sale_ID,
    MAX(sale_date)         AS Sale_Date,
    MAX(customer_id)       AS Customer_ID,
    MAX(product_id)        AS Product_ID,
    MAX(product_category)  AS Product_Category,
    MAX(quantity_sold)     AS Quantity_Sold,
    MAX(store_id)          AS Store_ID,
    MAX(region)            AS Region,
    MAX(unit_price)        AS Unit_Price,
    MAX(payment_method)    AS Payment_Method,
    MAX(returned)          AS Returned,
    MAX(total_sale_amount) AS Total_Sale_Amount
FROM unpivoted
GROUP BY Block_ID, source_col
ORDER BY Block_ID, Sale_Position;