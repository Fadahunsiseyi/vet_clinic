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


CREATE TABLE owners(id INT GENERATED ALWAYS AS IDENTITY, full_name CHAR, age INT);


CREATE TABLE species(id INT GENERATED ALWAYS AS IDENTITY, name CHAR);
