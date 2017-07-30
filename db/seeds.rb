# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

races = Race.create([
    { name: "Rattlesnake Ramble Odd-Year" },
    { name: "Rattlesnake Ramble Even-Year" },
    { name: "Rattlesnake Ramble Kidsr" },
  ])
  
currentRace = races.first

currentEdition = RaceEdition.create(race: currentRace, date: "2017-09-09")

products = Product.create([
    { description: "Men's Cotton 2017 Race Shirt, size small", quantity: 2 },
    { description: "Men's Cotton 2017 Race Shirt, size medium", quantity: 10 },
    { description: "Men's Cotton 2017 Race Shirt, size large", quantity: 10 },
    { description: "Men's Cotton 2017 Race Shirt, size extra-large", quantity: 3 },
    { description: "Women's Cotton 2017 Race Shirt, size small", quantity: 10 },
    { description: "Women's Cotton 2017 Race Shirt, size medium", quantity: 10 },
    { description: "Women's Cotton 2017 Race Shirt, size large", quantity: 5 },
    { description: "Black Cotton Hooded Sweatshirt, size small", quantity: 3 },
    { description: "Black Cotton Hooded Sweatshirt, size medium", quantity: 3 },
    { description: "Black Cotton Hooded Sweatshirt, size large", quantity: 3 },
    { description: "Black Cotton Hooded Sweatshirt, size extra-large", quantity: 3 },
  ])