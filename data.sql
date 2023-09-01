/* Populate database with sample data. */
 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Agumon', DATE '2020-02-03', 0, true, 10.23);

 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Gabumon', DATE '2018-11-15', 2, true, 8);

 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Pikachu', DATE '2021-01-7', 1, false, 15.04);

 INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
 VALUES ('Devimon', DATE '2017-05-12', 5, true, 11);

/* New data */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander', DATE '2020-02-08', 0, false, -11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Plantmon', DATE '2021-11-15', 2, true, -5.7);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Squirtle', DATE '1993-04-02', 3, false, -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Angemon', DATE '2005-06-12', 1, true, -45);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Boarmon', DATE '2005-06-07', 7, true, 20.4);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Blossom', DATE '1998-10-13', 3, true, 17);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Ditto', DATE '2022-05-14', 4, true, 22);

-- Insert data in the owners table
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Insert data in the species table
INSERT INTO species (name)
VALUES ('Pokemon'),
('Digimon');

-- Update the species_id column
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

-- Update the owner_id column
UPDATE animals SET owner_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owner_id = 2 WHERE name IN ('Gabumon', 'Pikachu');
UPDATE animals SET owner_id = 3 WHERE name IN ('Devimon', 'Plantmon');
UPDATE animals SET owner_id = 4 WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
UPDATE animals SET owner_id = 5 WHERE name IN ('Angemon', 'Boarmon');