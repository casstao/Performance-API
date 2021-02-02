# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
1.times do
  Cage.create({
    max_capacity: 3,
    status: "ACTIVE",
    })
end
1.times do
  Dino.create({
    name: "Sam",
    species: "Brachiosaurus",
    cage_id: 1
    })
end
