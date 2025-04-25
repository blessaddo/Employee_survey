--Beginner-Level QUestions

--AVG age of employees
select 
	Gender,
	cast(avg(age) as INT) as age
--over(partition by gender order by gender)
from
	Employee_survey
group by gender
order by age;

--how many employees in each department
select
	dept,
	count(1) as num_employees
from
	Employee_survey
group by 
	dept
order by 
	num_employees;


--Gender distribution
select 
	gender
from 
	Employee_survey
group by gender
order by gender;


--different job levels and hw many employees fall into each
select 
	joblevel, 
	count(1) as num_of_employees
from
	Employee_survey
group by joblevel
order by num_of_employees desc;



--most common emptype
select 
	emptype,
	count(1) as most_common
from 
	Employee_survey
group by emptype
order by most_common desc;

--avg commute time by commutetype
select 
	commutemode,
	cast(avg(commutedistance) as INT) as commute_time
from 
	Employee_survey
group by commutemode
order by commute_time desc;


--distribution of marital status among employees
select
	maritalstatus,
	count(1) as num_employees,
	ROUND(100.0 * count(1) / SUM(count(1)) over (), 2) as percentage
from
	Employee_survey
group by 
	maritalstatus
order by num_employees desc;


--------Intermediate-Level Questions
--dept with higest stress lvl
select 
	 dept,
	 --count(*) num_dept,
	avg(stress) as avg_stress_lvl
from 
	Employee_survey
group by dept
order by avg_stress_lvl
limit 1;

--does marital status influence sleep hrs on average
--unlikeyly
select 
	maritalstatus,
	avg(sleephours) as avg_sleephours
from
	 Employee_survey
group by 
	maritalstatus
order by 
	avg_sleephours


--dept with the higest num of team members per employees
select 
	dept,
	count(teamsize) as teamsize
from 
	Employee_survey
	group by 
	dept
order by teamsize desc;



---
select 
	emptype,
	dept,
	ROUND(AVG(workload), 2) AS avg_work
	--avg(workload) as avg_work
from
	Employee_survey
group by emptype,dept
order by
	avg_work asc
limit 5;


-- avg num commute use by different job
select
	--DISTINCT(commutemode) as ds,
	joblevel,
	round(avg(commutedistance), 3) AS avg_num
from 
	Employee_survey
group by joblevel --, ds
order by avg_num desc;
	

--
select 
	edulevel,
	dept,
	round(avg(experience),0) as avg_experience
from
	Employee_survey
group by edulevel, dept
order by avg_experience desc
limit 1;
	

--Advanced level questions

--correlation between work_stress vs sleephours
select
	corr(workload, sleephours) as stress_lvl 
from
	Employee_survey; -- weak correlation


--top 5 employees with longest commute time and lowest job sat scores.
select
	empid,
	commutedistance,
	jobsatisfaction
from 
	Employee_survey
order by 
	commutedistance desc,
	jobsatisfaction asc
limit 5;


--dept above avg teamsize and belw avg physical workload
with overall_avg as (
	select 
		avg(teamsize) as avg_ts,
		avg(workload) as avg_wl
	from
		Employee_survey
),
dept_stats as (
	select
		dept,
		avg(teamsize) as dept_avg_ts,
		avg(workload) as dept_avg_wl
	from 
		Employee_survey
	group by
		dept		
)
select 
	d.dept,
	ROUND(d.dept_avg_ts,2) as avg_ts,
	ROUND(d.dept_avg_wl,2) as avg_wl
from
	dept_stats d, overall_avg o
where 
	d.dept_avg_ts > o.avg_ts and d.dept_avg_wl < o.avg_wl
order by
	d.dept_avg_ts
	


-- Rolling avg for joblevel across stress 
select 
	joblevel,
round(avg(stress) over(order by stress rows between 1  preceding  and 1 following ), 2) as rolling_avg
from
	employee_survey
group by joblevel, stress
order by joblevel;
---rolling avg for age across stress

select
	age,
	round(avg(stress) over( order by age rows between 3 preceding and 3 following ), 2) as rolling_avg_stress
from
	Employee_survey
group by age, stress, gender
order by age;

--
select
	age,
	round(avg(workload) over(order by age desc rows between 3 preceding and 3 following), 2) as roll_avg
from
	Employee_survey
group by age, workload;


--weighted job satisfaction score using sleephrs, stress, commutedistance

select 
	sum(jobsatisfaction * sleephours) / sum(jobsatisfaction) as weighted_avg1,
	sum(jobsatisfaction * stress) / sum(jobsatisfaction) as weighted_avg12	
from 
	employee_survey;
	
---weighted standard_deviation
select
    round(sqrt((sum(jobsatisfaction * sleephours^2) 
	- (sum(jobsatisfaction * sleephours))^2 / sum(jobsatisfaction)) 
	/ ((count(*) - 1) * sum(jobsatisfaction) / count(*))),4) AS weighted_standard_deviation
from employee_survey;
