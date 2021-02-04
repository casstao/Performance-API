# Ruby on Rails Dinosaur-Cages API

## Setup

`bundle`

## Database initialization

 `rake db:create db:schema:load`

## How to run the test suite

Start rails server:

 `rails s`

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
Rules:

1. User must create cage before creating dinosaur to be placed in cage

2. status must be in all caps: "ACTIVE" or "DOWN"

3. species must be in enumerated list and first letter capitalized: "Brachiosaurus"

4. cage_id is the cage you want to put your dinosaur into when creating dinosaur

### Create cage

endpoint: http://localhost:3000/api/v1/cages

HTTP POST with body as:

```
{
    "max_capacity": 3,
    "status": "ACTIVE"
}

```

### Create Dino

endpoint: http://localhost:3000/api/v1/dinos

HTTP POST with body as:
```
{
  "name": "Richard",
  "species": "Stegosaurus",
  "cage_id": 1
}
```

### Query specific cage/dino with id

shows all dinosaurs in the respective cage

http://localhost:3000/api/v1/cages/:id

ex: http://localhost:3000/api/v1/cages/1

shows desired dinosaur details

http://localhost:3000/api/v1/dinos/:id

ex: http://localhost:3000/api/v1/dinos/1


### Filter by status for cage and species for dino

http://localhost:3000/api/v1/cages/:status

ex: http://localhost:3000/api/v1/cages/ACTIVE

http://localhost:3000/api/v1/dinos/:species

ex: http://localhost:3000/api/v1/dinos/Stegosaurus


### Update power status

endpoint: http://localhost:3000/api/v1/cages/:id

HTTP PUT with body as:

```
{
    "status": "DOWN"
}

```

### Delete dinos/cages

HTTP DELETE 

endpoint: http://localhost:3000/api/v1/cages/:id

http://localhost:3000/api/v1/dinos/:id

### Test dino compatibility in certain cages

create a carnivore 

endpoint: http://localhost:3000/api/v1/dinos

HTTP POST with body as:
```
{
  "name": "Henry",
  "species": "Velociraptor",
  "cage_id": 1
}
```

should be invalid because carnivores cannot join a cage with herbivores



# Comments:
### Assumptions-

I did not include extensive user input type/error checking for cage/dino fields API requests because I am assuming this API would function after recieving data from radio button/dropdown menu user inputs when they select the different options for creating the cages/dinosaurs from the front-end webpage. If that is the case, the Webapp should be sending proper API calls without the need to deal with user type-check. However, I have included most basic type checking including misspelled species, missing arguments, and invalid cage_id.
### RSPEC-

To run base test cases, run on console: `rspec`

rspec cant create two class instances to thoroughly test business logic in rails 5.0+
if I had more time, I would try to donwgrade to rails 3.0 and try implementing a different version of rspec that supports multiple instance creation for API

### Future add-ons-
If i had more time, I would implement an edge case where deleting a cage would delete all the dinos in them.
Currently, the application handles most edge cases i.e. invalid inputs, placing the wrong species into a cage, limit on cage capacity. Some cool add-ons are auth0 authentication protocol to verify the user and an encrypted hashkey implementation for cage/dinosaur IDs. Each SUCCESS/ERROR HTTP return may also be logged onto a file using a singleton pattern design.

### Takeaways-
If my application were to be ran in a concurrent environment, load balancers and an SQL database could be integrated. Currently it is using SQLlite. Hosting the API on a cloud server for constant access would also be needed.



