create schema sql_projects

use sql_projects

1
select emp_name,department_name
from employees as e left join 
departments as d 
on e.dept_id = d.department_id

2
select * from employees
where join_date > '2021-12-31'

3
select * from employees
where salary > 50000

4
select emp_name , department_name
from employees as e left join 
departments as d 
on e.dept_id = d.department_id
where department_name = 'IT'

5
select department_name,count(id) 
as emp_count
from employees as e left join 
departments as d 
on e.dept_id = d.department_id
group by department_name

6
select a.employee_id,e.emp_name,
a.days_present as present_days 
from attendance as a
inner join employees as e
on e.id=a.employee_id

7
select emp_name,days as
leave_days from employees
as e left join leavess as l 
on e.id = l.employee_id
where days > 2

8
select department_name,avg(salary)
as avg_salary from departments as d
left join employees as e 
on e.dept_id = d.department_id
group by department_name

9
select department_name,count(emp_name)
as emp_count from departments as d
left join employees as e 
on e.dept_id = d.department_id
group by department_name
having emp_count > 3

10
select a.employee_id,e.emp_name,
a.days_present as present_days 
from attendance as a
inner join employees as e
on e.id=a.employee_id 
where days_present = 22

11
select e.emp_name, SUM(l.days) as total_leave_days
from employees e
left join leavess l on e.id = l.employee_id
group by e.emp_name
having SUM(l.days) > 2

12
select e.emp_name,
ROUND((a.days_present * 100.0) / a.working_days , 2
) as attendance_percentage
from employees e
left join attendance a
on e.id = a.employee_id

13
select e.emp_name from employees e
left join attendance a on e.id = a.employee_id
where (a.days_present * 100.0 / a.working_days) < 80

14
select e.emp_name from employees e
left join attendance a on e.id = a.employee_id
where a.days_present = a.working_days

15
select e.emp_name,
(p.rating * p.projects_completed) as performance_score
from employees e
left join performance p on e.id = p.employee_id
order by performance_score desc
limit 3

16
select d.department_name,
avg(p.rating * p.projects_completed) as avg_performance
from employees e
left join performance p on e.id = p.employee_id
left join departments d on e.dept_id = d.department_id
group by d.department_name

17
select e.emp_name, d.department_name
from employees e
left join performance p on e.id = p.employee_id
left join departments d on e.dept_id = d.department_id
where (p.rating * p.projects_completed) >
(select avg(p2.rating * p2.projects_completed)
from employees e2 left join performance p2 on e2.id = p2.employee_id
where e2.dept_id = e.dept_id)

18
select emp_name,department_name,
performance_score,
dense_rank() 
over (partition by dept_id
order by performance_score desc) as perf_rank
from ( select e.emp_name,e.dept_id,d.department_name,
(p.rating * p.projects_completed) as performance_score
from employees e left join performance p on e.id = p.employee_id
left join departments d on e.dept_id = d.department_id) as t

19
select e.emp_name from employees e
left join performance p on e.id = p.employee_id
where e.salary > (select avg (salary) from employees)
and (p.rating * p.projects_completed) <
(select avg(rating * projects_completed) from performance)
    
20
select distinct e.emp_name from employees e
left join leavess l on e.id = l.employee_id
left join performance p on e.id = p.employee_id
where (p.rating * p.projects_completed) >
(select avg (rating * projects_completed) from performance)
      
21
select d.department_name from employees e
left join attendance a on e.id = a.employee_id
left join departments d on e.dept_id = d.department_id
group by d.department_name
having avg(a.days_present * 100.0 / a.working_days) < 80

22
select e.emp_name from employees e
left join attendance a on e.id = a.employee_id
left join performance p on e.id = p.employee_id
where (a.days_present * 100.0 / a.working_days) > 90
and (p.rating * p.projects_completed) >
(select avg (rating * projects_completed) from performance)
      
23
select e.emp_name from employees e
left join attendance a on e.id = a.employee_id
left join performance p on e.id = p.employee_id
where (a.days_present * 100.0 / a.working_days) < 80
and (p.rating * p.projects_completed) <
(select avg(rating * projects_completed) from performance)
      
24
select emp_name,salary,
dense_rank() 
over (partition by dept_id order by salary desc
) as salary_rank from employees;

25
select employee_id,days,
SUM(days) over (partition by employee_id
order by employee_id) as running_leave_days
from leavess

26
select * from (
select e.emp_name,d.department_name,
(a.days_present * 100.0 / a.working_days) as attendance_percent,
dense_rank() over (partition by d.department_id
order by (a.days_present * 100.0 / a.working_days) desc
) as rnk from employees e
left join attendance a on e.id = a.employee_id
left join departments d on e.dept_id = d.department_id
) t where rnk <= 2

27
select emp_name from employees
where id not in (
select employee_id from attendance)

28
select e.emp_name from employees e
left join leavess l on e.id = l.employee_id
where l.days >(select avg(l2.days)
from employees e2
left join leavess l2 on e2.id = l2.employee_id
where e2.dept_id = e.dept_id)

29
select emp_name, department_name
from (select e.emp_name,d.department_name,
rank() over (
partition by d.department_id
order by (p.rating * p.projects_completed) desc) as rnk
from employees e left join performance p on e.id = p.employee_id
left join departments d on e.dept_id = d.department_id) t
where rnk = 1

30
select e.emp_name from employees e
left join employees m on e.manager_id = m.id
left join performance p1 on e.id = p1.employee_id
left join performance p2 on m.id = p2.employee_id
where (p1.rating * p1.projects_completed) >
(p2.rating * p2.projects_completed)
