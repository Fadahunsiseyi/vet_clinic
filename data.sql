/* Populate database with sample data. */

INSERT INTO animals VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals VALUES (4, 'Devimon', '2017-05-12', 5, true, 11);
INSERT INTO animals VALUES(5,'Charmander','2020-02-08',0,false,-11);
INSERT INTO animals VALUES(6,'Plantmon','2021-11-15',2,true,-5.7);
INSERT INTO animals VALUES(7,'Squirtle','1993-04-02',3,false,-12.13);
INSERT INTO animals VALUES(8,'Angemon','2005-06-12',1,true,-45);
INSERT INTO animals VALUES(9,'Boarmon','2005-06-07',7,true,20.4);
INSERT INTO animals VALUES(10,'Blossom','1998-10-13',3,true,17);
INSERT INTO animals VALUES(11,'Ditto','2022-05-14',4,true,22);


INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34),
 ('Jennifer Orwell', 19),
 ('Bob',45), ('Melody Pond', 77), 
 ('Dean Winchester', 14), 
 ('Joddie Whittaker', 38);


 INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');
 UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
 UPDATE animals SET species_id = 1 WHERE species_id IS NULL; 
 UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
 UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon','Pikachu');
 vet_clinic=*# update animals set owner_id = 3 where name in ('Devimon', 'Plantmon');
UPDATE 2
vet_clinic=*# update animals set owner_id = 4 where name in ('Charmander', 'Squirtle', 'Blossom');
UPDATE 3
vet_clinic=*# update animals set owner_id = 5 where name in ('Angemon', 'Boarmon');
UPDATE 2