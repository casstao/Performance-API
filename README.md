# README

# Ruby on Rails Dinosaur-Cages API

## Database initialization

* rake db:create db:schema:load

## How to run the test suite

Start rails server:

* rails s

## Requirements
* Cages must have a maximum capacity for how many dinosaurs it can hold => "max_capacity"
* Cages know how many dinosaurs are contained => "current_capacity"
* Cages have a power status of ACTIVE or DOW => "status
* Cages cannot be powered off if they contain dinosaurs.
* Dinosaurs cannot be moved into a cage that is powered down.
* Each dinosaur must have a name => "name"
* Each dinosaur must have a species => "species"
* Each dinosaur is considered an herbivore or a carnivore, depending on its species.
* Herbivores cannot be in the same cage as carnivores.
* Carnivores can only be in a cage with other dinosaurs of the same species.
* Must be able to query a listing of dinosaurs in a specific cage.
* When querying dinosaurs or cages they should be filterable on their attributes (Cages on their power status and dinosaurs on species).
* All requests should be respond with the correct HTTP status codes and a response, if necessary, representing either the success or error conditions.

Carnivores:
Tyrannosaurus
Velociraptor
Spinosaurus
Megalosaurus

Herbivores:
Brachiosaurus
Stegosaurus
Ankylosaurus
Triceratops

## Deployment instructions

//User must create cage before creating dinosaur to be placed in cage//
### Create cage

endpoint: http://localhost:3000/api/v1/cages

HTTP POST with body as:

{
    "max_capacity": 3,
    "status": "ACTIVE"    
}

### Create Dino

endpoint: http://localhost:3000/api/v1/dinos

HTTP POST with body as:

{
  "name": "Richard",
  "species": "Stegosaurus",
  "cage_id": 1
}

### Query specific cage/dino with id

http://localhost:3000/api/v1/cages/:id

http://localhost:3000/api/v1/dinos/:id

ex: http://localhost:3000/api/v1/dinos/1


### Filter by status for cage and species for dino

http://localhost:3000/api/v1/cages/:species

ex: http://localhost:3000/api/v1/dinos/Stegosaurus

ex: http://localhost:3000/api/v1/cages/ACTIVE


# Comments:
### RSPEC-
to run base test cases, run on console: rspec
rspec cant create two class instances to thoroughly test business logic in rails 5.0+
if I had more time, I would try to donwgrade to rails 3.0 and try implementing a different version of rspec that supports multiple instance creation for API

### Functions-
If i had more time, I would implement an edge case where deleting a cage would delete all the dinos in them
Currently, the application handles most edge cases i.e. invalid inputs, placing the wrong species into a cage, limit on cage capacity.
Each HTTP response has a status and a message along with the data if the status is a SUCCESS

