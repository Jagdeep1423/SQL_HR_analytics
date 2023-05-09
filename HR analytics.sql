use mainpro;
select * from sheet2 limit 5;

-- department wise average working years 

select sheet1.Department,avg(TotalWorkingYears)as avg_WorkingYears
 from sheet1 join  sheet2 on sheet1.Employeenumber = sheet2.Employeeid group by department order by avg_WorkingYears;

-- Department wise no of employee 

select Department, count(EmployeeCount) from sheet1 group by Department;

-- Educational Field Wise no of Employee

select EducationField, count(EmployeeCount) from sheet1 group by EducationField;

-- Department Wise Job Satisfaction

select Department, avg(JobSatisfaction) as AvgJobSatisfaction from sheet1 group by Department;

-- Avg hourly Rate of Male Research Scientist
select JobRole,Gender,avg(HourlyRate) from sheet1 where JobRole = "Research Scientist" and Gender = "Male";


-- Department wise attrition rate

alter table sheet1 add column attrition_num int;
update sheet1 set attrition_num=1 where attrition="yes";
update sheet1 set attrition_num = 0 where attrition= "No";
select department,(sum(attrition_num)/sum(Employeecount))*100 from sheet1 group by Department;

-- Job Role Vs Work life balance

select sheet1.JobRole, avg(WorklifeBalance) as Avg_Worklifebalance from sheet2 
join  sheet1 on sheet1.Employeenumber = sheet2.Employeeid group by JobRole order by avg_WorkLifeBalance;

SELECT 
    sheet2.YearsSinceLastPromotion,
    (SUM(attrition_num) / SUM(Employeecount)) * 100
FROM
    sheet1
GROUP BY YearsSinceLastPromotion;

-- Gender wise Percentage of Employee

select Gender,sum(Employeecount)/50000*100 as Percent_Employee from sheet1 group by Gender;

-- Monthly New Hire vs Attrition Trendline

select Monthofjoining,count(monthofjoining) As Hire,sum(attrition_num) As Attrion from sheet1 join sheet2 on sheet2.employeeid=sheet1.employeenumber  group by Monthofjoining order by Monthofjoining;


-- Attrition rate Vs Year since last promotion relation

select 
case 
when YearsSinceLastPromotion >=0 and YearsSinceLastPromotion <= 10 then '0-10'
when YearsSinceLastPromotion > 10 and YearsSinceLastPromotion <= 20 then '10-20'
when YearsSinceLastPromotion > 20 and YearsSinceLastPromotion <= 30 then '20-30'
when YearsSinceLastPromotion > 30 and YearsSinceLastPromotion <= 40 then '30-40'
end 
as yslp_bin,
concat(round(((sum(attrition_num)/sum(employeecount))*100),2),"%") 
as attrition_rate from sheet1 join sheet2 on sheet2.employeeid=sheet1.employeenumber group by yslp_bin;
