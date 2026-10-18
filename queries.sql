select  *from churn;

PRAGMA table_info(churn);

SELECT customerID,churn
from churn
where churn ='Yes';

SELECT customerID,tenure
from churn
where tenure>='24';

SELECT Contract, customerID, churn
FROM churn 
where Contract='Month-to-month'and churn='Yes';


SELECT MonthlyCharges, customerID, churn
from churn 
where MonthlyCharges>'70'
and churn='Yes';
SELECT customerID, InternetService
from churn 
where InternetService = 'DSL' 
or InternetService='Fiber optic';

SELECT customerID , churn ,MonthlyCharges
from churn
where churn ='Yes'
order by MonthlyCharges DESC;

select churn, count(*) as total_churned
from churn
group by churn;

select 
round( (select count(*) 
from churn  
where churn ='Yes') * 100.0/ (select count(*) from churn),
2) as churn_percentage; 

select contract,round
(sum(case when churn='Yes' then 1 else 0 end)*100.0 /count(*),2) as churn_percentage
from churn
group by contract
order by churn_percentage desc;

select InternetService, round
(sum(case when churn='Yes' then 1 else 0 end)* 100.0 / count(*),2)as churn_percentage
from churn
group by InternetService
order by churn_percentage desc;


SELECT tenure, COUNT(*) AS customers
FROM churn
GROUP BY tenure
ORDER BY tenure;






select 
 CASE
  when Monthlycharges<=30 then 'Low'
  when Monthlycharges<=70 then 'Medium'
  else 'High'
 end as charges_table,
 count(*) as total_customers,
 sum
 (case when churn ='Yes' then 1 else 0 end ) as total_churned,


 round(
 sum(case when churn ='Yes' then 1 else 0 end )*100.0/ count(*),2) as churn_rate 
 from churn
 group by charges_table 
 order by 
 case when chargeS_table ='Low'then 1
 when charges_table='Medium' then 2 
 when charges_table='High' then 3
  end ;


select 
case when tenure<=24 then 'New'
when tenure <=44 then 'Established'
else 'Loyal'
end as tenure_table 
, count(*) as total_customers
,sum(
case when churn = 'Yes' then 1 else 0 end ) as total_churned,
round(
sum(case when churn ='Yes' then 1 else 0 end ) *100.0 / count(*),2) as churn_rate 
 from churn 
 group by tenure_table
  order by 
   case when tenure_table='New' then 1 
   when tenure_table='Established' then 2 
   when tenure_table ='Loyal' then 3 
   end ;

 select PaymentMethod,

 count(*) as total_customers,
 sum(case when churn ='Yes' then 1 else 0 end ) as total_churned,
  round(sum(case when churn ='Yes' then 1 else 0 end )*100.0/ count(*) ,2) as churn_rate
  from churn
  group by PaymentMethod
  order by  case 
  when PaymentMethod ='Electronic check' then 1 
  when PaymentMethod ='Mailed check ' then 2
  when paymentMethod ='Bank tarnsfer (automatic)' then 3 
  when PaymentMethod ='Credit card (automatic)' then 4 
  end ;


select SeniorCitizen,
case when SeniorCitizen = 1 then 'senior' 
when SeniorCitizen = 0 then 'non_senior' 
end as senior_tabel ,
round( sum( case when churn = 'Yes' then 1 else 0 end ) *100.0 / count(*),2) as churn_percentage,
count(*) as total_customers, 
sum(case when churn ='Yes' then 1 else 0 end ) as total_churned 
from churn
group by SeniorCitizen
order by churn_percentage desc;


select TechSupport, count(*) as total_customers
,round( sum( case when churn = 'Yes' then 1 else 0 end ) *100.0 / count(*),2) as churn_percentage
,sum(case when churn ='Yes' then 1 else 0 end) as total_churned
from churn
group by TechSupport;


select contract , count(*) as total_customers
from churn
group by contract
having count(*) >1500
order by total_customers desc; 


select MonthlyCharges, count(*) as total_customers, customerID
from churn where MonthlyCharges >(select avg(MonthlyCharges) from churn)
group by MonthlyCharges
order by total_customers desc;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
        AS churned_customers,
    SUM(CASE WHEN churn = 'No' THEN 1 ELSE 0 END)
        AS retained_customers,
    ROUND(
        SUM(CASE WHEN churn = 'Yes' THEN 1.0 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM churn;

SELECT
  Contract,
  COUNT(*) AS total_customers,
  SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
    AS total_churned,
  ROUND(
      SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END)
      * 100.0 / COUNT(*),
       2
  ) AS churn_rate
FROM churn
GROUP BY Contract
ORDER BY churn_rate DESC;


select tenure||' months' as tenure,  count(*) as total_customers, 
sum( case when churn = 'Yes' then 1 else 0 end ) as total_churned,
round(sum(case  when churn ='Yes' then 1 else 0 end ) * 100.0 / count(*),2) as churn_rate

from churn
group by tenure
order by tenure desc;


select contract, count(*) as total_customers,TechSupport, 
sum(case when churn ='Yes' then 1 else 0 end ) as total_churned ,
round(sum(case when churn ='Yes' then 1 else 0 end ) *100.0 /count(*) ,2 ) as churn_rate
from churn 
where contract='Month-to-month' 
and TechSupport='Yes' or TechSupport='No'
group by contract , TechSupport
order by churn_rate desc;


SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT customerID) AS unique_customers,
    COUNT(*) - COUNT(DISTINCT customerID) AS duplicate_id_rows
FROM churn;