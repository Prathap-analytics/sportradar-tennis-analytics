create database sports_analysis;
use sports_analysis;

-- create categories table: 
create table categories(
category_id varchar(50) primary key,
category_name varchar(100) not null
);
select count(*) from categories;

-- create competiotions table:
create table competitions(
competition_id varchar(50) primary key,
competition_name varchar(150) not null,
parent_id varchar(50) not null,
type varchar(50) not null,
gender varchar(20) not null,
category_id varchar(50) not null,
is_root_competition varchar(10) not null,
parent_in_dataset varchar(10) not null,
foreign key (category_id) references categories(category_id)
);
 select count(*) from competitions;
 
-- create complexes table:
create table complexes(
complex_id varchar(50) primary key,
complex_name varchar(150) not null
);
select * from complexes limit 20; 
 
-- create venues table: 
create table venues(
venue_id varchar(50) primary key,
venue_name varchar(150) not null,
city_name varchar(100) not null,
country_name varchar(100) not null,
country_code varchar(3) not null,
timezone varchar (100) not null,
complex_id varchar(50) not null,
foreign key (complex_id) references complexes(complex_id)
);
select count(*) from venues; 
 
-- create competitors table: 
create table competitors(
competitor_id varchar(50) primary key,
name varchar(100) not null,
country varchar(100) not null,
country_code char(3) not null,
abbreviation varchar(10) not null,
inferred_country varchar(100) not null,
inferred_country_code char(3) not null
);
select count(*) from competitors;
 
-- create competitor_ranking table:  
 create table competitor_rankings(
 rank_id int primary key auto_increment,
 rank_position int not null,
 type varchar(50) not null,
 gender varchar(10) not null,
 movement int not null,
 points int not null,
 competitions_played int not null,
 competitor_id varchar(50) not null,
 foreign key (competitor_id) references competitors(competitor_id)
 );
 select count(*) from competitor_rankings; 
