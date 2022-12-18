


USE DATABASE "ASSIGNMENTS_DATABASE";

--QUESTION 1:-  Load the given dataset into snowflake with a primary key to Order Date column.


CREATE OR REPLACE TABLE MD_SALES_DATA_FINAL
    (
      order_id VARCHAR(15) ,  
      order_date DATE  NOT NULL PRIMARY KEY,	                           
      ship_date DATE,	
      ship_mode STRING,	
      customer_name VARCHAR(50),
      segment	STRING,
      state VARCHAR(40),	
      country	STRING,
      market STRING,	
      region STRING,	
      product_id 	VARCHAR(25),
      category STRING,	
      sub_category STRING,	
      product_name VARCHAR(200),	
      sales NUMBER(10,2),	
      quantity NUMBER(10,2),	
      discount NUMBER(10,5),	
      profit NUMBER(10,5),
      shipping_cost NUMBER(10,5),	
      order_priority STRING,
      year STRING
    );  
    
DESCRIBE TABLE MD_SALES_DATA_FINAL;
    
SELECT * FROM  MD_SALES_DATA_FINAL LIMIT 100; 
------------------------------------------------------------------------------------------------------------------------------------------------------------

--QUESTION 2:- Change the Primary key to Order Id Column.

ALTER TABLE MD_SALES_DATA_FINAL 
DROP PRIMARY KEY;

DESCRIBE TABLE MD_SALES_DATA_FINAL;

ALTER TABLE MD_SALES_DATA_FINAL
ADD PRIMARY KEY (ORDER_ID);
--------------------------------------------------------------------------------------------------------------------------------------------------------------

--QUESTION 3:- Check the data type for Order date and Ship date and mention in what data type it should be?

-- LOADING TIME I USE 'DATE' FORMAT. I CAN CHANGE THIS FORMAT IN 'DD-MM-YYYY' FORMAT, BUT I DON'T WANT TO CHANGE 'DATE' FORMAT IN MAIN TABLE.



SELECT TO_CHAR(ORDER_DATE,'DD-MM-YYYY') AS DATE_DD_MM_YYYY FROM MD_SALES_DATA_FINAL;

SELECT TO_CHAR(SHIP_DATE,'DD-MM-YYYY') AS DATE_DD_MM_YYYY FROM MD_SALES_DATA_FINAL;


SELECT * FROM MD_SALES_DATA_FINAL LIMIT 100;


---------------------------------------------------------------------------------------------------------------------------------------------------------------
--QUESTION 4:- Create a new column called order_extract and extract the number after the last ‘–‘from Order ID column.

SELECT SUBSTRING(ORDER_ID,9,10) FROM MD_SALES_DATA_FINAL ;
  
ALTER TABLE MD_SALES_DATA_FINAL
ADD COLUMN ORDER_EXTRACT INT;

UPDATE MD_SALES_DATA_FINAL
SET ORDER_EXTRACT =  (SELECT SUBSTRING(ORDER_ID,9,10)) ;

DESCRIBE TABLE MD_SALES_DATA_FINAL;

SELECT * FROM MD_SALES_DATA_FINAL LIMIT 100;

---------------------------------------------------------------------------------------------------------------------------------------------------------------

--QUESTION NO 5:- Create a new column called Discount Flag and categorize it based on discount.Use ‘Yes’ if the discount is greater than zero else ‘No’.

CREATE OR REPLACE TABLE MD_SALES_DATA_FINAL AS
SELECT *,
      CASE
      WHEN DISCOUNT > '0' THEN 'YES'
      ELSE 'NO'
      END DISCOUNT_FLAG
FROM MD_SALES_DATA_FINAL;
------------------------------------------------------------------------------------------------------------------

----QUESTION NO 6:- Create a new column called process days and calculate how many days it takes for each order id to process from the order to its shipment.

SELECT DATEDIFF('DAY',ORDER_DATE,SHIP_DATE) FROM MD_SALES_DATA_FINAL;

ALTER TABLE MD_SALES_DATA_FINAL
ADD COLUMN PROCESS_DAYS INT;

UPDATE MD_SALES_DATA_FINAL
SET PROCESS_DAYS = (SELECT DATEDIFF('DAY',ORDER_DATE,SHIP_DATE));

DESCRIBE TABLE MD_SALES_DATA_FINAL;

SELECT * FROM MD_SALES_DATA_FINAL LIMIT 100;
-----------------------------------------------------------------------------------------------------------------

----QUESTION NO 7:- Create a new column called Rating and then based on the Process dates give rating like given below.
----a. If process days less than or equal to 3days then rating should be 5
----b. If process days are greater than 3 and less than or equal to 6 then rating should be 4
----c. If process days are greater than 6 and less than or equal to 10 then rating should be 3
----d. If process days are greater than 10 then the rating should be 2.

CREATE OR REPLACE TABLE MD_SALES_DATA_FINAL AS
SELECT *,
      CASE
      WHEN PROCESS_DAYS <= '3' THEN '5'
      WHEN PROCESS_DAYS <= '6' AND PROCESS_DAYS > '3' THEN '4'
      WHEN PROCESS_DAYS <= '10' AND PROCESS_DAYS > '6' THEN '3'
      ELSE '2'
      END RATING
FROM MD_SALES_DATA_FINAL;

DESCRIBE TABLE MD_SALES_DATA_FINAL; 

SELECT * FROM MD_SALES_DATA_FINAL LIMIT 100;


-------------------------------------------------------------------------------------------------- 