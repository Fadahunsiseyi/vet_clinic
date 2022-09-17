/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT PRIMARY KEY, 
    name  VARCHAR, 
    date_of_birth DATE, 
    escape_attempts INT, 
    neutered BOOLEAN, 
    weight_kg Decimal
);
ALTER TABLE animals
ADD species CHAR(50);
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD species_id int;
ALTER TABLE animals ADD owner_id int;
ALTER TABLE animals ADD foreign key (species_id) references species(id);
ALTER TABLE animals ADD foreign key (owner_id) references owners(id);
ALTER TABLE owners ADD PRIMARY KEY(id);
ALTER TABLE species ADD PRIMARY KEY(id);


CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY, full_name CHAR, age INT);
CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY, name CHAR);


vet_clinic=# CREATE TABLE vets (
vet_clinic(# id INT GENERATED ALWAYS AS IDENTITY,
vet_clinic(# name VARCHAR,
vet_clinic(# age INT,
vet_clinic(# date_of_graduation DATE);
CREATE TABLE