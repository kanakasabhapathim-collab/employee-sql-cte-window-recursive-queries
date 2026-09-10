CREATE TABLE CTemployee (
	employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    manager_id INT,
    hire_date DATE);
	select * from CTemployee;
INSERT INTO CTemployee VALUES
(1, 'John', 'Management', 120000, NULL, '2018-01-10'),
(2, 'Sarah', 'HR', 90000, 1, '2019-03-15'),
(3, 'Priya', 'IT', 100000, 1, '2020-02-20'),
(4, 'David', 'Finance', 95000, 1, '2019-07-10'),
(5, 'Arun', 'IT', 80000, 3, '2021-01-15'),
(6, 'Meena', 'IT', 70000, 3, '2022-04-20'),
(7, 'Rahul', 'IT', 60000, 3, '2023-06-10'),
(8, 'Kumar', 'HR', 65000, 2, '2021-08-12'),
(9, 'Anitha', 'HR', 55000, 2, '2022-09-18'),
(10, 'Vijay', 'HR', 50000, 2, '2023-11-05'),
(11, 'Ravi', 'Finance', 85000, 4, '2020-05-20'),
(12, 'Divya', 'Finance', 75000, 4, '2021-10-15'),
(13, 'Suresh', 'Finance', 65000, 4, '2022-12-01'),
(14, 'Manoj', 'Sales', 90000, 1, '2019-02-10'),
(15, 'Kavya', 'Sales', 70000, 14, '2021-03-25'),
(16, 'Ajay', 'Sales', 60000, 14, '2022-07-15'),
(17, 'Nisha', 'Sales', 50000, 14, '2024-01-10'),
(18, 'Deepak', 'IT', 70000, 3, '2024-03-12'),
(19, 'Lakshmi', 'Finance', 75000, 4, '2023-05-18'),
(20, 'Gokul', 'Sales', 60000, 14, '2023-08-20');

With emps as(select employee_name,salary from CTemployee where salary >70000) select * from emps;
With emps as(select employee_name,department from CTemployee where department ='IT')
select * from emps;
With emps as (select employee_id,employee_name, salary,salary*0.1 as Bonus,salary+(salary*0.1) as 
Total_sal from CTemployee)select * from emps order by salary desc;
With emps as (select employee_id, employee_name,department, salary from CTemployee where salary>60000)
select * from emps where department ='IT';
With emps as (select department, avg(salary) as avg_sal from CTemployee group by department)
select * from emps order by avg_sal ;
with emps as (select department, max(salary) as Max_sal,min(salary) as Min_sal, avg(salary)
as Avg_sal, sum(salary) as Total_sal from CTemployee group by department) select * from emps;
with emps as (select distinct department, avg(salary) over (partition by department) as
Avg_sal from CTemployee)select  department from emps where Avg_sal > 70000;
with emps as (select distinct department, avg(salary) over (partition by department) as
Avg_sal from CTemployee)select * from emps order by Avg_sal desc limit 1;
with emps as (select  department, avg(salary) as
Avg_sal from CTemployee group by department)select * from emps order by Avg_sal desc limit 1;

with emps as (select distinct department, avg(salary) over (partition by department) as
Avg_sal from CTemployee)select * from emps order by Avg_sal  limit 1;
With emps as ( select department,count(employee_id) from CTemployee group by department)
select * from emps;
With emps as ( select department,count(employee_id) as emp_count from CTemployee group by department)
select * from emps where emp_count >2 ;
with emps as (select department, avg(salary) as Dept_avg_sal from CTemployee group by department)
select e.employee_name,e.department,e.salary,e2.Dept_avg_sal from CTemployee e
join emps e2 on e.department=e2.department order by e.department;
with emps as (select department, avg(salary) as Dept_avg_sal from CTemployee group by department)
select e.employee_name,e.department,e.salary,e2.Dept_avg_sal from CTemployee e
join emps e2 on e.department=e2.department where e.salary>e2.Dept_avg_sal order by e.department;
with emps as (select employee_name,department, salary,dense_rank() over(partition
by department order by salary desc)as Rn from CTemployee ) select* from emps where rn=1 ;
with emps as (select employee_name,department, salary,dense_rank() over(partition
by department order by salary )as Rn from CTemployee ) select* from emps where rn=1 ;
with emps as (select employee_id, employee_name,department,salary,avg(salary)over(partition by 
department) as Avg_sal, salary-Avg_sal as Sal_difference from CTemployee)select * from emps;
select employee_id, employee_name,department,salary,avg(salary)over(partition by 
department) as Avg_sal,salary - avg(salary)over(partition by 
department) as Sal_difference from CTemployee;
with emps as (select department, avg(salary) as Dept_avg_sal from CTemployee group by department)
select e.employee_name,e.department,e.salary,e2.Dept_avg_sal,e.salary-e2.Dept_avg_sal as sal_dif
from CTemployee e join emps e2 on e.department=e2.department order by e.department;

With Dept_avg as( select employee_id,employee_name,department,salary, avg(salary)over
(partition by department)as Avg_sal from CTemployee) , emp_sal as (select employee_id,
employee_name, department,salary, Avg_sal from Dept_avg where salary>Avg_sal) select*from emp_sal;
With Dept_avg as( select department,salary, avg(salary)over
(partition by department)as Avg_sal from CTemployee),Avgd_sal as(select distinct department,Avg_Sal 
from Dept_avg where Avg_sal>70000) select*from  Avgd_sal;
with d_count as (select department, count(employee_id) as e_count from CTemployee group by department),
D_avg as(select department, avg(salary) as e_avg from CTemployee group by department), combined as(
select c.department,c.e_count,a.e_avg from d_count c join D_avg a on c.department=a.department)
select* from combined;
with emps as (select employee_id,employee_name, hire_date from CTemployee where hire_date>'2020-01-01'),
emps_sal as (select employee_id,employee_name, salary from CTemployee where salary>65000), 
combined as (select e.employee_name,e.hire_date,s.salary from emps e inner join emps_sal s on
e.employee_id=s.employee_id) select*from combined;
with IT_emp as(select * from CTemployee where department='IT'),IT_above_60000 as (select * from
IT_emp where salary>60000),IT_Avg as (select department,avg(salary) from IT_above_60000
group by department) select * from IT_AVg;
With empssal as (select employee_name, department,salary,rank() over (partition by department order by salary
desc) as Rn from CTemployee) select * from empssal where Rn=1;
With emps as (select employee_name, department, salary, row_number() over(partition by department)
as RoN from CTemployee) select* from emps;
with emps as (select employee_name, department, salary, dense_rank() over(partition by department
order by salary desc)as Rn from CTemployee) select * from emps where Rn in ('1','2');
With empssal as (select employee_name, department,salary,rank() over (partition by department order by salary
desc) as Rn from CTemployee) select * from empssal where Rn=2;
with emps as (select employee_name, department,salary, avg(salary) over (partition by department)
as Avg_Sal from CTemployee)select employee_name, department, salary, salary-Avg_sal as Sal_diff
from emps;
with emps as(select employee_id,employee_name, salary from CTemployee)select*from emps where
salary>(select avg(salary) from CTemployee) order by salary;
with emps as(select employee_name, department, salary, avg(salary) over(partition by department)
as Avg_sal from CTemployee) select * from emps where salary>Avg_sal;
with emps as (select department, sum(salary) as Total from CTemployee group by department
order by Total desc) select * from emps  limit 1;
With emps as (select department, avg(salary) as Avg_sal from CTemployee group by 
department order by Avg_sal desc)select * from emps limit 1;
with emps as (select employee_name,department,salary from CTemployee Order by salary desc) 
select * from emps limit 1;

with recursive emp_h as (select employee_id,employee_name,department,salary,manager_id,hire_date from CTemployee
where manager_id is null union all select e.employee_id,e.employee_name,e.department,e.salary,
e.manager_id,e.hire_date from CTemployee e join emp_h h on e.manager_id=h.employee_id)
select * from emp_h;
with recursive emp_hier as (select employee_id,employee_name,department,manager_id, 1 as level 
from CTemployee where manager_id is null union all select e.employee_id,e.employee_name,e.department,
e.manager_id,eh.level+ 1 from CTemployee e join emp_hier eh on e.manager_id=eh.employee_id) select
* from emp_hier order by level, employee_id;
with recursive emps_John as(select employee_id,employee_name,manager_id from CTemployee where
employee_name='John' union all select e.employee_id,e.employee_name,e.manager_id from CTemployee e
join emps_John j on e.manager_id=j.employee_id) select * from emps_John order by employee_id;
with recursive emps_Sarah as(select employee_id,employee_name,manager_id from CTemployee where
employee_name='Sarah' union all select e.employee_id,e.employee_name,e.manager_id from CTemployee e
join emps_Sarah S on e.manager_id=s.employee_id) select * from emps_Sarah order by employee_id;
with recursive emps_Priya as(select employee_id,employee_name,manager_id from CTemployee where
employee_name='Priya' union all select e.employee_id,e.employee_name,e.manager_id from CTemployee e
join emps_Priya P on e.manager_id=P.employee_id) select * from emps_Priya order by employee_id;
With recursive emps as(select employee_id,manager_id from CTemployee where manager_id is not null 
union all select e2.employee_id,e.manager_id from CTemployee e join emps e2
on e.employee_id=e2.manager_id) select manager_id, count(*) as Total_emp from emps
group by manager_id order by manager_id;
With recursive emps as(select employee_id,manager_id from CTemployee where manager_id is not null 
union all select e2.employee_id,e.manager_id from CTemployee e join emps e2
on e.employee_id=e2.manager_id) select manager_id, count(*) as Total_emp from emps
group by manager_id having manager_id is not null order by total_emp desc limit 1;
select employee_id,employee_name from CTemployee where employee_id not in
(select distinct manager_id from CTemployee where manager_id is not null);
select employee_id,employee_name from CTemployee where employee_id  in
(select distinct manager_id from CTemployee where manager_id is not null);
With Top_lvl as(select * from CTemployee where manager_id is null)select* from Top_lvl;
with recursive Numbers_10 as(select 1 as n union all select n+1 from numbers_10 where n<10)
select* from Numbers_10;
with recursive Numbers_100 as(select 1 as n union all select n+1 from numbers_100 where n<100)
select* from Numbers_100;
with recursive Jan_date as (select date'2020-01-01' as dat union all select dat+1 from Jan_date
where dat<'2020-01-31') select * from Jan_date;

with recursive Jan_dates as (select date '2026-01-01'  as D_ate union all select D_ate + 1
from Jan_dates where D_ate < date '2026-01-31') select * from Jan_dates;


