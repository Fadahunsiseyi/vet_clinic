/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01'
 AND '2019-12-31';
SELECT * FROM animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Pikachu' OR name = 'Agumon';
SELECT name,escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered;
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
SELECT * FROM animals WHERE name != 'Gabumon';


-- TRANSACTIONS

BEGIN;
UPDATE animals
SET species = 'unspecifed';
ROLLBACK;


BEGIN;
UPDATE animals
SET species = 'digimon' WHERE name LIKE '%mon'
UPDATE animals
SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

BEGIN;
DELETE FROM animals;
ROLLBACK;


 BEGIN;
BEGIN
vet_clinic=*# DELETE FROM animals WHERE date_of_birth > '2022-01-01';
DELETE 1
vet_clinic=*# SAVEPOINT update1;
SAVEPOINT
vet_clinic=*# UPDATE animals SET weight_kg = weight_kg*-1;
UPDATE 10
vet_clinic=*# ROLLBACK to update1;
ROLLBACK
vet_clinic=*# UPDATE animals SET weight_kg = weight_kg*-1 WHERE weight_kg < 0;
UPDATE 4
vet_clinic=*# COMMIT;
COMMIT


-- QUERIES


 SELECT COUNT(*) FROM animals;



 SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;


 SELECT AVG(weight_kg) FROM animals;



 SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;



  SELECT species, MAX(weight_kg) FROM animals GROUP BY species;



 SELECT species, MIN(weight_kg) FROM animals GROUP BY species;


 SELECT species, ROUND(AVG(escape_attempts),2) FROM animals GROUP BY species, date_of_birth HAVING date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';



  select animals.name,owners.full_name from animals join owners on animals.owner_id = owners.id
 where owners.full_name = 'Melody Pond';



 select animals.name, species.name from animals join species
  on animals.species_id = species.id
  where species.name = 'Pokemon';


 select owners.full_name, animals.name from animals right join owners on animals.owner_id = owners.id;



  select count(animals.name), species.name from animals join species on animals.species_id = species.id group by species.name;


 select owners.full_name, species.name from animals join owners on animals.owner_id = owners.id
 join species on animals.species_id = species.id where species.name = 'Digimon' and owners.full_name = 'Jennifer Orwell';



 select animals.name, owners.full_name from animals join owners on animals.owner_id = owners.id where animals.escape_attempts=0
 and owners.full_name = 'Dean Winchester';


  select count(*), owners.full_name from animals join owners on
 animals.owner_id = owners.id group by owners.full_name order by count desc;


select visits.date_of_visit, animals.name, vets.name from animals 
join visits on animals.id = visits.animals_id 
join vets on visits.vet_id = vets.id 
where vets.name = 'William Tatcher' 
order by visits.date_of_visit desc limit 1;


select vets.name, species.name from vets
left join specializations on specializations.vet_id = vets.id
left join species on specializations.species_id = species.id;


select count(animals.name), vets.name from animals 
join visits on visits.animals_id = animals.id
join vets on vets.id = visits.vet_id
where vets.name = 'Stephanie Mendez'
group by vets.name;


select animals.name, vets.name, visits.date_of_visit from animals 
join visits on visits.animals_id = animals.id
join vets on vets.id = visits.vet_id
where vets.name = 'Stephanie Mendez' and visits.date_of_visit between '2020-04-01' and '2020-08-30';


select animals.name, count(*) from animals join visits on visits.animals_id = animals.id
group by animals.name
order by count desc limit 1;


select visits.date_of_visit, animals.name, vets.name from animals
join visits on visits.animals_id = animals.id
join vets on vets.id = visits.vet_id
where vets.name = 'Maisy SMith'
order by visits.date_of_visit asc
limit 1;


select animals.name, vets.name, visits.date_of_visit from animals 
join visits on visits.animals_id = animals.id
join vets on vets.id = visits.vet_id 
order by visits.date_of_visit desc limit 1;


select vets.name, species.name, count(species.name) from vets 
join visits on visits.vet_id = vets.id 
join animals on visits.animals_id = animals.id 
join species on animals.species_id = species.id 
where vets.name = 'Maisy SMith' 
group by species.name, vets.name 
order by count desc limit 1;


select visits.vet_id as "Vets ID",
specializations.species_id as "specialized in",
animals.species_id as "Visited Species",
count(*), SUM(COUNT(*)) OVER() AS unspecialize_visits 
from visits left join specializations on specializations.vet_id=visits.vet_id 
join animals on visits.animals_id=animals.id 
where ((animals.species_id!=specializations.species_id or specializations.species_id is null) 
and visits.vet_id!=3) group by visits.vet_id,specializations.species_id,animals.species_id;

