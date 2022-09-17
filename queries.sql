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


vet_clinic=# BEGIN;
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


vet_clinic=# SELECT COUNT(*) FROM animals;
 count
-------
    10
(1 row)


vet_clinic=# SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
 count
-------
     2
(1 row)

vet_clinic=# SELECT AVG(weight_kg) FROM animals;
         avg
---------------------
 15.5500000000000000
(1 row)


vet_clinic=# SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
 neutered | max
----------+-----
 f        |   3
 t        |   7
(2 rows)


vet_clinic=#  SELECT species, MAX(weight_kg) FROM animals GROUP BY species;
                      species                       | max
----------------------------------------------------+-----
 pokemon                                            |  17
 digimon                                            |  45
(2 rows)


vet_clinic=# SELECT species, MIN(weight_kg) FROM animals GROUP BY species;
                      species                       | min
----------------------------------------------------+-----
 pokemon                                            |  11
 digimon                                            | 5.7
(2 rows)

vet_clinic=# SELECT species, ROUND(AVG(escape_attempts),2) FROM animals GROUP BY species, date_of_birth HAVING date_of_birth BETWEEN '1990-01-01' AND '2000-12-31';
                      species                       | round
----------------------------------------------------+-------
 pokemon                                            |  3.00
 pokemon                                            |  3.00
(2 rows)


vet_clinic=#  select animals.name,owners.full_name from animals join owners on animals.owner_id = owners.id
vet_clinic-# where owners.full_name = 'Melody Pond';
    name    |                      full_name
------------+------------------------------------------------------
 Squirtle   | Melody Pond
 Charmander | Melody Pond
 Blossom    | Melody Pond
(3 rows)


vet_clinic=# select animals.name, species.name from animals join species
vet_clinic-#  on animals.species_id = species.id
vet_clinic-#  where species.name = 'Pokemon';
    name    |                         name
------------+------------------------------------------------------
 Squirtle   | Pokemon
 Charmander | Pokemon
 Blossom    | Pokemon
 Pikachu    | Pokemon
(4 rows)

vet_clinic=# select owners.full_name, animals.name from animals right join owners on animals.owner_id = owners.id;
                      full_name                       |    name
------------------------------------------------------+------------
 Sam Smith                                            | Agumon
 Jennifer Orwell                                      | Gabumon
 Jennifer Orwell                                      | Pikachu
 Bob                                                  | Plantmon
 Bob                                                  | Devimon
 Melody Pond                                          | Squirtle
 Melody Pond                                          | Charmander
 Melody Pond                                          | Blossom
 Dean Winchester                                      | Angemon
 Dean Winchester                                      | Boarmon
 Joddie Whittaker                                     |
(11 rows)


vet_clinic=#  select count(animals.name), species.name from animals join species on animals.species_id = species.id group by species.name;
 count |                         name
-------+------------------------------------------------------
     4 | Pokemon
     6 | Digimon
(2 rows)

vet_clinic=# select owners.full_name, species.name from animals join owners on animals.owner_id = owners.id
vet_clinic-# join species on animals.species_id = species.id where species.name = 'Digimon' and owners.full_name = 'Jennifer Orwell';
                      full_name                       |                         name
------------------------------------------------------+------------------------------------------------------
 Jennifer Orwell                                      | Digimon
(1 row)


vet_clinic=# select animals.name, owners.full_name from animals join owners on animals.owner_id = owners.id where animals.escape_attempts=0
vet_clinic-# and owners.full_name = 'Dean Winchester';
 name | full_name
------+-----------
(0 rows)

vet_clinic=#  select count(*), owners.full_name from animals join owners on
vet_clinic-# animals.owner_id = owners.id group by owners.full_name order by count desc;
 count |                      full_name
-------+------------------------------------------------------
     3 | Melody Pond
     2 | Dean Winchester
     2 | Bob
     2 | Jennifer Orwell
     1 | Sam Smith
(5 rows)


vet_clinic=# select visits.date_of_visit, animals.name, vets.name from animals
vet_clinic-# join visits on animals.id = visits.animals_id
vet_clinic-# join vets on visits.vet_id = vets.id
vet_clinic-# where vets.name = 'William Tatcher'
vet_clinic-# order by visits.date_of_visit desc limit 1;
 date_of_visit |  name   |      name
---------------+---------+-----------------
 2021-01-11    | Blossom | William Tatcher
(1 row)


vet_clinic=# select visits.date_of_visit, animals.name, vets.name from animals
vet_clinic-# join visits on animals.id = visits.animals_id
vet_clinic-# join vets on visits.vet_id = vets.id
vet_clinic-# where vets.name = 'William Tatcher'
vet_clinic-# order by visits.date_of_visit desc limit 1;
 date_of_visit |  name   |      name
---------------+---------+-----------------
 2021-01-11    | Blossom | William Tatcher
(1 row)


vet_clinic=# select vets.name, species.name from vets
vet_clinic-# left join specializations on specializations.vet_id = vets.id
vet_clinic-# left join species on specializations.species_id = species.id;
       name       |                         name
------------------+------------------------------------------------------
 William Tatcher  | Pokemon
 Stephanie Mendez | Pokemon
 Stephanie Mendez | Digimon
 Jack Harness     | Digimon
 Maisy SMith      |
(5 rows)


vet_clinic=# select count(animals.name), vets.name from animals
vet_clinic-# join visits on visits.animals_id = animals.id
vet_clinic-# join vets on vets.id = visits.vet_id
vet_clinic-# where vets.name = 'Stephanie Mendez'
vet_clinic-# group by vets.name;
 count |       name
-------+------------------
     4 | Stephanie Mendez
(1 row)


vet_clinic=# select animals.name, vets.name, visits.date_of_visit from animals
vet_clinic-# join visits on visits.animals_id = animals.id
vet_clinic-# join vets on vets.id = visits.vet_id
vet_clinic-# where vets.name = 'Stephanie Mendez' and visits.date_of_visit between '2020-04-01' and '2020-08-30';
  name   |       name       | date_of_visit
---------+------------------+---------------
 Agumon  | Stephanie Mendez | 2020-07-22
 Blossom | Stephanie Mendez | 2020-05-24
(2 rows)


vet_clinic=# select animals.name, count(*) from animals join visits on visits.animals_id = animals.id
vet_clinic-# group by animals.name
vet_clinic-# order by count desc limit 1;
  name   | count
---------+-------
 Boarmon |     4
(1 row)


vet_clinic=# select visits.date_of_visit, animals.name, vets.name from animals
vet_clinic-# join visits on visits.animals_id = animals.id
vet_clinic-# join vets on vets.id = visits.vet_id
vet_clinic-# where vets.name = 'Maisy SMith'
vet_clinic-# order by visits.date_of_visit asc
vet_clinic-# limit 1;
 date_of_visit |  name   |    name
---------------+---------+-------------
 2019-01-24    | Boarmon | Maisy SMith
(1 row)


vet_clinic=# select animals.name, vets.name, visits.date_of_visit from animals
vet_clinic-# join visits on visits.animals_id = animals.id
vet_clinic-# join vets on vets.id = visits.vet_id
vet_clinic-# order by visits.date_of_visit desc limit 1;
  name   |       name       | date_of_visit
---------+------------------+---------------
 Devimon | Stephanie Mendez | 2021-05-04
(1 row)


vet_clinic=# select vets.name, species.name, count(species.name) from vets
vet_clinic-# join visits on visits.vet_id = vets.id
vet_clinic-# join animals on visits.animals_id = animals.id
vet_clinic-# join species on animals.species_id = species.id
vet_clinic-# where vets.name = 'Maisy SMith'
vet_clinic-# group by species.name, vets.name
vet_clinic-# order by count desc limit 1;
    name     |                         name                         | count
-------------+------------------------------------------------------+-------
 Maisy SMith | Digimon                                              |     6
(1 row)


vet_clinic=# select visits.vet_id as "Vets ID",
vet_clinic-# specializations.species_id as "specialized in",
vet_clinic-# animals.species_id as "Visited Species",
vet_clinic-# count(*), SUM(COUNT(*)) OVER() AS unspecialize_visits
vet_clinic-# from visits left join specializations on specializations.vet_id=visits.vet_id
vet_clinic-# join animals on visits.animals_id=animals.id
vet_clinic-# where ((animals.species_id!=specializations.species_id or specializations.species_id is null)
vet_clinic(# and visits.vet_id!=3) group by visits.vet_id,specializations.species_id,animals.species_id;
 Vets ID | specialized in | Visited Species | count | unspecialize_visits
---------+----------------+-----------------+-------+---------------------
       2 |                |               2 |     6 |                  10
       1 |              1 |               2 |     1 |                  10
       4 |              2 |               1 |     1 |                  10
       2 |                |               1 |     2 |                  10
(4 rows)