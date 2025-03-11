
--- select all the data from 2012-2020
select * from readmission;

--- which state and area type are the most affected between 2012 to 2019 

select top 1 max(state) as higheststate, min(state) as loweststate, min(area_type) as area
from readmission
group by primary_race
---- 
select max(state) as state, area_type, min(value) as value, year 
from readmission
group by state, area_type,year
having min(value) > 15;


--- readmission in specific state between 2012 and 2020


select count(primary_race) as readmission,
     (count(primary_race) * 100.0)/ sum(count(primary_race)) over() as percentage
from readmission
where state= 'california' AND (year >= 2020 or year BETWEEN 2012and 2020)
group by primary_race;
 
--- denserank
select state, year, value, county, 
Dense_RANK() over(order by state) as denserank
from readmission
order by state


---top five state readmission rate in the top five states
select top 5 state, avg(value) as percentage 
from readmission
group by state 
order by state asc

--- race-wise readmission percentage all over the state  
select primary_race, avg(value) as percentage
from readmission
group by primary_race
order by primary_race desc

----- top 5 county with the highest readmission
select top 5 county, state, area_type, 
       primary_race, value as percentage,
     case 
          when value >= 20 then 'high risk'
         when value between 15 and 19 then 'modertae risk'
         when value <= 15 then 'low risk'
       Else 'death'
end as catagori
from readmission;

--- find county with readmission above 20%
select county , primary_race, state, value as percentage
from readmission
where value > 20
order by value desc;

-----readmission trend 2012-2020
select top 10 state, primary_race, count(*) as  readmission
from readmission
where year BETWEEN 2012 AND 2020
group by state, primary_race
order by primary_race, state 

---percentage contibution of each race per state 
select top 10 state, primary_race, sum(value) * 100.0 / (select sum(value)
from readmission where readmission.state = r.state)as percentage 
from readmission r
group by state, primary_race
order by state, percentage desc 