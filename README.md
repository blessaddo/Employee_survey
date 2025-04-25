# Employee_survey
Employee Life Experience and Job Satisfaction Insights

##About data
| Column name  | Description |
| ------------- | ------------- |
| EmpId  | Unique identifier for each employee. |
| Gender | Gender of the employee (e.g., Male, Female, Other).|
| Age       |  Age of the employee.         |
| MaritalStatus       | Marital status of the employee (e.g., Single, Married, Divorced, Widowed). |
| JobLevel  | Job level of the employee (e.g., Intern/Fresher, Junior, Mid, Senior, Lead).         |
| Experience | Number of years of work experience the employee has.          |
| Dept      | Department where the employee works (e.g., IT, HR, Finance, Marketing, Sales, Legal, Operations, Customer Service).          |
| Emptype       | Type of employment (e.g., Full-Time, Part-Time, Contract).         |
| WLB       | Work-life balance rating (scale from 1 to 5).         |
| WorkEnv       | Work environment rating (scale from 1 to 5).        |
| PhysicalActivityHours       | Number of hours of physical activity per week.          |
| Workload       | Workload rating (scale from 1 to 5).          |
| Stress       | Stress level rating (scale from 1 to 5).          |
| SleepHours       | Number of hours of sleep per night.          |
| CommuteMode       | Mode of commute (e.g., Car, Public Transport, Bike, Walk, Motorbike).          |
| CommuteDistance       | Distance traveled during the commute (in kilometers).          |
| NumCompanies       | Number of different companies the employee has worked for.          |
| Teamsize| Size of the team the employee is part of.|
| NumReports| Number of people reported to by the employee (only applicable for Senior and Lead levels).|
| EduLevel| Highest level of education achieved by the employee (e.g., High School, Bachelor, Master, PhD).|
| haveOT| Indicator if the employee has overtime (True/False). |
| TrainingHoursPerYear  | Number of hours of training received per year.  |
| JobSatisfaction  | Rating of job satisfaction (scale from 1 to 5).  |

### References

https://www.kaggle.com/datasets/lainguyn123/employee-survey/data

### Basic
````
Basic code

select
	maritalstatus,
	count(1) as num_employees,
	ROUND(100.0 * count(1) / SUM(count(1)) over (), 2) as percentage
from
	Employee_survey
group by 
	maritalstatus
order by num_employees desc;
````

## Indermediate
````
select 
	edulevel,
	dept,
	round(avg(experience),0) as avg_experience
from
	Employee_survey
group by edulevel, dept
order by avg_experience desc
limit 1
````

### Advance code
```
---rolling avg for age across stress

select
	age,
	round(avg(stress) over( order by age rows between 3 preceding and 3 following ), 2) as rolling_avg_stress
from
	Employee_survey
group by age, stress, gender
order by age;
```


### Insight through visualization using generated code from postgreSQL

![age by mv](https://github.com/user-attachments/assets/d386fc9e-cb73-4fee-a468-f868a9caecb7)


![cnt by joblvl](https://github.com/user-attachments/assets/9c5e729a-829e-4666-b9a9-ee8913786dd6)


![mary vs %cnt](https://github.com/user-attachments/assets/a329a267-0ebd-4ca2-a291-560c0acbd2cf)


![jb vs avg](https://github.com/user-attachments/assets/ec040f4b-8ac1-4b77-a87f-9af4036b918c)

![age by avg](https://github.com/user-attachments/assets/f668c277-3872-4a10-a19e-9656e25a0db4)

![dept vs wl](https://github.com/user-attachments/assets/f6aea231-9be4-4cf2-a68a-de1648cc311d)

![age by rolavg](https://github.com/user-attachments/assets/cb1341fa-d5b9-47cf-9a35-74168bbcbd6f)

