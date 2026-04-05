USE project3;
/*
CREATE DATABASE project3;


CREATE TABLE retail_data (
    invoice_no VARCHAR(20),
    stock_code VARCHAR(20),
    description VARCHAR(255),
    quantity INT,
    invoice_date DATETIME,
    unit_price FLOAT,
    customer_id INT,
    country VARCHAR(50)
);


*/

select * from retail_data limit 20;

select count(*) from retail_data;
select * from retail_data where quantity < 0;
select * from retail_data where unit_price = 0;
select * from retail_data where unit_price < 0;
select * from retail_data where description = "Adjust bad debt";

CREATE TABLE retail_cleaned AS
SELECT 
    invoice_no,
    stock_code,
    description,
    ABS(quantity) AS quantity,
    invoice_date,
    ABS(unit_price) AS unit_price,
    (quantity * unit_price) as total_price,
    customer_id,
    country
FROM retail_data;

select * from retail_cleaned where total_price < 0;

update retail_cleaned
set total_price = abs(total_price)
where total_price < 0 ;


select * from retail_cleaned where total_price = 0;

delete from retail_cleaned
where total_price = 0 ;

select count(*) from retail_cleaned;

select * from retail_cleaned where trim(customer_id) = "" or customer_id is null;

/* still there are 132605 null rows are here in customerid column deleting those rows will gonna damage the dataset and replacing null with default value 
like eg(1,2) will also gonna change results in many questions but still i'm going to change all null values to default value 1 so that means now 
if i replace this huge amount of customer id null rows to 1 this will be the top customer obviously customer but at least we know customer id 1 is the sum of 
all null rows not an individual customers id.*/

update retail_cleaned
set customer_id = 1
where trim(customer_id) = "" or customer_id is null;

select sum(total_price) from retail_cleaned where customer_id = 1;




