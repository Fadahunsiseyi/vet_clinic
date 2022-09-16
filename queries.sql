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