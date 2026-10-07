use sports_analysis;

-- A1) list all competitions along with their category name:
select ct.*,cg.category_name from competitions ct
left join categories cg on ct.category_id=cg.category_id; 

-- A2) Count the number of competitions in each category:
select cg.category_name,count(ct.competition_id) as no_competitions from categories cg
left join competitions ct on cg.category_id=ct.category_id
group by cg.category_name; 

-- A3) Find all competitions of type 'doubles':
select * from competitions
where type='doubles'; 

-- A4) Get competitions that belong to a specific category (e.g., ITF Men):
select ct.competition_name,cg.category_name from competitions ct
left join categories cg on ct.category_id=cg.category_id
where cg.category_name='ITF Men';

-- A5) Identify parent competitions and their sub-competitions:
select 
    parent.competition_id as parent_competition_id,
    parent.competition_name as parent_competition_name,
    sub.competition_id as sub_competition_id,
    sub.competition_name as sub_competition_name,
    sub.type as sub_competition_type
from competitions sub
join competitions parent on sub.parent_id = parent.competition_id
order by parent.competition_name, sub.competition_name;

-- A6) Analyze the distribution of competition types by category:
select cg.category_name,ct.type,count(*) as total from categories cg
left join competitions ct on cg.category_id=ct.category_id
group by cg.category_name,ct.type;

-- A7) List all competitions with no parent (top-level competitions):
select competition_id,competition_name,parent_id from competitions
where parent_id = 'Root';

-- B1) List all venues along with their associated complex name:
select v.venue_name,c.complex_name from venues v
left join complexes c on v.complex_id=c.complex_id;

-- B2) Count the number of venues in each complex:
select c.complex_name,count(v.venue_id) as total from complexes c
left join venues v on c.complex_id=v.complex_id
group by c.complex_id,c.complex_name
order by count(v.venue_id) desc;

-- B3) Get details of venues in a specific country (e.g., Chile)
select * from venues
where country_name='chile'; 

-- B4)  Identify all venues and their timezones:
select venue_name,timezone from venues;

-- B5) Find complexes that have more than one venue
select c.complex_name,count(v.venue_id) as total from complexes c
left join venues v on c.complex_id=v.complex_id
group by c.complex_id,c.complex_name
having count(v.venue_id)>1
order by count(v.venue_id) desc;

-- B6) List venues grouped by country:
select country_name,venue_name from venues
group by country_name,venue_name
order by country_name;

-- B7) Find all venues for a specific complex (e.g., Nacional):
select v.venue_id,v.venue_name,c.complex_name from venues v
left join complexes c on v.complex_id=c.complex_id
where c.complex_name='Nacional';

-- C1) Get all competitors with their rank and points:
select c.competitor_id,c.name,r.rank_position,r.points from competitors c 
left join competitor_rankings r on c.competitor_id=r.competitor_id;

-- C2) Find competitors ranked in the top 5:
select c.competitor_id,c.name,r.rank_position from competitors c 
left join competitor_rankings r on c.competitor_id=r.competitor_id
order by rank_position asc limit 5;
 
-- C3) List competitors with no rank movement (stable rank):
select c.name,r.movement from competitors c
left join competitor_rankings r on c.competitor_id=r.competitor_id
where r.movement=0;  

-- C4) Get the total points of competitors from a specific country (e.g., Croatia)
select c.country,sum(r.points) as Total_Points from competitors c
left join competitor_rankings r on c.competitor_id=r.competitor_id
where country='croatia'; 

-- C5) Count the number of competitors per country
select country,count(competitor_id) as No_of_competitors from competitors
group by country
order by No_of_competitors desc; 

-- C6) Find competitors with the highest points in the current week
select c.competitor_id,c.name,c.country,
    r.type,r.gender,r.points,r.rank_position
from competitor_rankings r
left join competitors c on r.competitor_id = c.competitor_id
where r.points = (select MAX(points) from competitor_rankings);
















