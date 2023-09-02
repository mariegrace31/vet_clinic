/*Queries that provide answers to the questions from all projects.*/

SELECT name FROM animals WHERE name LIKE '%mon';

SELECT name from animals WHERE EXTRACT(YEAR FROM date_of_birth) BETWEEN 2016 AND 2019;

SELECT name FROM animals WHERE neutered = 'true' AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = 'true';

SELECT * FROM animals WHERE name <> 'Gabumon';

SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- TRANSACTIONS

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;

BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
COMMIT;
SELECT * FROM animals;


BEGIN;
SAVEPOINT bmg1;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * FROM animals;
ROLLBACK TO bmg1;
SELECT * FROM animals;

BEGIN;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

-- Number of animals
SELECT COUNT(*) FROM animals;

-- No escape
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- Average weight of animals
SELECT AVG(weight_kg) from animals;

-- Who escapes the most, neutered or not-neitered
SELECT neutered, SUM(escape_attempts) AS total_escapes FROM animals GROUP BY neutered;

-- Minimum and maximum weight of each type of animal
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

-- Average number of escape attempts per animal type of those born between 1990 and 2000
SELECT species, AVG(escape_attempts) AS avg_num_of_escape FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- What animals belong to Melody Pond?
SELECT a.name FROM animals a JOIN owners b ON a.owner_id = b.id WHERE b.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT a.name FROM animals a LEFT JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT species.name, COUNT(*) FROM animals LEFT JOIN species ON animals.species_id = species.id GROUP BY species.name

-- How many animals are there per species?
SELECT s.name, COUNT(*) AS animal_count FROM species s JOIN animals a ON s.id = a.species_id GROUP BY s.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.* FROM animals LEFT JOIN owners ON animals.owner_id = owners.id LEFT JOIN species ON animals.species_id = species.id WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

-- Who owns the most animals?
SELECT o.full_name, COUNT(*) AS animal_count FROM owners o JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY animal_count DESC LIMIT 1;

-- JOIN TABLE

-- Who was the last animal seen by William Tatcher?
SELECT animals.name FROM visits JOIN vets ON visits.vets_id = vets.id  JOIN animals ON visits.animals_id = animals.id WHERE vets.name = 'Vet William Tatcher' ORDER BY date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT DISTINCT animals.name FROM visits LEFT JOIN animals ON animals.id = visits.animal_id LEFT JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets LEFT JOIN specializations ON vets.id = vets_id LEFT JOIN species ON species.id = species_id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name,visits.date_of_visit FROM visits  JOIN vets ON visits.vets_id = vets.id  JOIN animals ON visits.animals_id = animals.id WHERE vets.name = 'Vet Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT animals.name FROM visits JOIN animals ON animals_id = animals.id GROUP BY animals.name ORDER BY COUNT(animals.id) DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name,visits.date_of_visit FROM visits JOIN animals ON animals_id = animals.id JOIN vets ON vets_id = vets.id WHERE vets.name = 'Vet Maisy Smith' ORDER BY date_of_visit LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit
SELECT animals.name,vets.name,date_of_visit FROM visits JOIN animals ON animals_id = animals.id JOIN vets ON vets_id = vets.id ORDER BY date_of_visit DESC LIMIT 1;
--  How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits JOIN animals ON animals_id = animals.id JOIN vets ON vets_id = vets.id JOIN specializations ON vets.id = specializations.vets_id WHERE animals.species_id != specializations.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name FROM visits JOIN animals ON animals_id = animals.id JOIN species ON animals.species_id = species.id JOIN vets ON vets_id = vets.id WHERE vets.name = 'Vet Maisy Smith' GROUP BY species.name ORDER BY COUNT(species.id) DESC LIMIT 1;