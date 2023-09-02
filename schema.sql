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

-- Create vets table
CREATE TABLE vets (
  id serial PRIMARY KEY,
  name VARCHAR(200),
  age INT,
  date_of_graduation date
);

-- Create a join table called specializations
CREATE TABLE specializations (
  species_id INT,
  vets_id INT,
  FOREIGN KEY(species_id) REFERENCES species(id),
  FOREIGN KEY (vets_id) REFERENCES vets(id)
  );

  -- Create a join table called visits
CREATE TABLE visits (
  animals_id INT,
  vets_id INT,
  FOREIGN KEY (animals_id) REFERENCES animals(id),
  FOREIGN KEY (vets_id) REFERENCES vets(id)
);

ALTER TABLE visits ADD COLUMN date_of_visit date;
