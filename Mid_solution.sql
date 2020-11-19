---  Select all the data from table house_price_data to check if the data was imported correctly
SELECT * FROM house_price_regression.project;


--- NO 5) Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
--- Select all the data from the table to verify if the command worked. # Limit your returned results to 10.

alter table house_price_regression.project
drop column date;

select distinct yr_renovated from house_price_regression.project;


--- NO 6) Use sql query to find how many rows of data you have

use house_price_regression;

select count(id) from project;
select distinct floors from house_price_regression.project;




--- Now we will try to find the unique values in some of the categorical columns:
#What are the unique values in the column bedrooms?
#What are the unique values in the column bathrooms?
#What are the unique values in the column floors?
#What are the unique values in the column condition?
#What are the unique values in the column grade

select  bedrooms,bathrooms,
floors,
grade,
project.condition
from house_price_regression.project group by bedrooms, bathrooms,floors,grade, regression_data_clean.condition;

       
--- Arrange the data in a decreasing order by the price of the house. 
--- Return only the IDs of the top 10 most expensive houses in your data.
 select id from house_price_regression.project order by price desc limit 10;
 
 --- What is the average price of all the properties in your data?
 select avg(price) from house_price_regression.project;
 
 --- In this exercise we will use simple group by to check the properties of some of the categorical variables in our data
--- --- What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.

 select bedrooms, avg(price) as "mean price" from house_price_regression.project group by bedrooms order by avg(price) asc;
 
 --- --- #What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. Use an alias to change the name of the second column.

select bedrooms, avg(sqft_living) as Mean_living from house_price_regression.project group by bedrooms order by avg(sqft_living)  asc;

--- --- What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. Use an alias to change the name of the second column.

select waterfront,avg(price) from house_price_regression.project group by waterfront;

--- --- Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
select project.condition, avg(grade) from  house_price_regression.project
group by project.condition order by project.condition asc;

--- One of the customers is only interested in the following houses:

--- Number of bedrooms either 3 or 4
--- Bathrooms more than 3
--- One Floor
--- No waterfront
--- Condition should be 3 at least
--- Grade should be 5 at least
--- Price less than 300000
--- For the rest of the things, they are not too concerned. 
--- Write a simple query to find what are the options available for them?

select bedrooms, bathrooms, Floors,waterfront,project.condition,grade,price from house_price_regression.project 
where (bedrooms = 3 or bedrooms = 4) and 
Bathrooms > 3 and
floors = 1 and
waterfront = 0 and
grade >= 5 and 
price < 300000;

 
 ---- Your manager wants to find out the list of properties whose prices are twice more than 
 --- the average of all the properties in the database. Write a query to show them the list of such properties.
 --- You might need to use a sub query for this problem.
 
 select * from house_price_regression.project where price > 2*(select avg(price) from house_price_regression.project) order by price asc;
 
 --- Since this is something that the senior management is regularly interested in, create a view of the same query.

CREATE VIEW twice_as_good AS
SELECT * from house_price_regression.project
where price >= 2*(select avg(price) from house_price_regression.project)
order by price asc;

--- Most customers are interested in properties with three or four bedrooms. 
--- What is the difference in average prices of the properties with three and four bedrooms?
select avg(price) from house_price_regression.project
 where bedrooms = 3 or bedrooms = 4 group by bedrooms 
order by bedrooms;
--- What are the different locations where properties are available in your database? (distinct zip codes)
select * from house_price_regression.project 

--- What are the different locations where properties are available in your database? (distinct zip codes)
select distinct(zipcode) from house_price_regression.project; 

--- Show the list of all the properties that were renovated.
select * from house_price_regression.project where yr_renovated <> 0;

--- Provide the details of the property that is the 11th most expensive property in your database.

select * from  house_price_regression.project order by price desc limit 11 ;















