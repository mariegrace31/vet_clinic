/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
  id INT PRIMARY KEY,
  name varchar(255),
  date_of_birth date,
  escape_attempts integer,
  neutered boolean,
  weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species VARCHAR(200);

-- Create the 'owners' table
CREATE TABLE owners (
  id serial PRIMARY KEY,
  full_name VARCHAR(200),
  age INT
);

-- Create the 'species' table
CREATE TABLE species (
  id serial PRIMARY KEY,
  name VARCHAR(200)
);

-- Modify the 'animals' table
ALTER TABLE animals DROP COLUMN species,
ADD COLUMN species_id INT REFERENCES species(id),
ADD COLUMN owner_id INT REFERENCES owners(id);