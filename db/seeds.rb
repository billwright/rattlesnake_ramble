# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

races = Race.create([
    { name: "Rattlesnake Ramble Trail Race", description: "A 4.25-mile Y-course that goes out-and-back on the Fowler Trail before doing the same on the Eldorado Trail." },
    { name: "Rattlesnake Ramble Trail Race Even-Year", description: "A 4.25-mile Y-course that goes out-and-back on the Eldorado Trail before doing the same on the Fowler Trail." },
    { name: "Rattlesnake Ramble Kids Race", description: "A 1.7-mile out-and-back course on the main road through Eldorado Canyon. The Kids Race is for 12 & Under only." },
  ])
  
currentRace = races.first
kidsRace = races.last

currentEdition = RaceEdition.create(race: currentRace, date: "2017-09-09", entry_fee: 25)
kidsEdition = RaceEdition.create(race: kidsRace, date: "2017-09-09", entry_fee: 10)

racer_bill = Racer.create(first_name: "Bill", last_name: "Wright", email: "bill@wwwright.com", gender: :male, birth_date: "1962-04-26", city: "Superior", state: "Colorado")
racer_sheri = Racer.create(first_name: "Sheri", last_name: "Wright", email: "sheri_wright@oracle.com", gender: :female, birth_date: "1963-12-18", city: "Superior", state: "Colorado")
racer_derek = Racer.create(first_name: "Derek", last_name: "Wright", email: "poochito@gmail.com", gender: :male, birth_date: "1998-01-29", city: "Superior", state: "Colorado")
    
RaceEntry.create(racer: racer_bill, race_edition: currentEdition, paid: true)
RaceEntry.create(racer: racer_sheri, race_edition: currentEdition, paid: true)
RaceEntry.create(racer: racer_derek, race_edition: currentEdition, paid: false)


# 2017 Merchandise

Product.all.each do |prod|
    prod.destroy
end

prod = Product.create(description: "Men's Cotton 2017 Race Shirt, size medium", quantity: 10, price: 25)
ProductImage.create(product: prod, url: 'RR2017MensShirtFront.jpg', alt_text: "Men's Race Shirt Front")
prod = Product.create(description: "Men's Cotton 2017 Race Shirt, size large", quantity: 10, price: 25)
ProductImage.create(product: prod, url: 'RR2017MensShirtFront.jpg', alt_text: "Men's Race Shirt Front")
prod = Product.create(description: "Men's Cotton 2017 Race Shirt, size extra-large", quantity: 3, price: 25)
ProductImage.create(product: prod, url: 'RR2017MensShirtFront.jpg', alt_text: "Men's Race Shirt Front")

prod = Product.create(description: "Women's Cotton 2017 Race Shirt, size small", quantity: 10, price: 25)
ProductImage.create(product: prod, url: 'RR2017WomensShirtFront.jpg', alt_text: "Women's Race Shirt Front")
ProductImage.create(product: prod, url: 'RR2017WomensShirtBack.png', alt_text: "Women's Race Shirt Back")
prod = Product.create(description: "Women's Cotton 2017 Race Shirt, size medium", quantity: 10, price: 25)
ProductImage.create(product: prod, url: 'RR2017WomensShirtFront.jpg', alt_text: "Women's Race Shirt Front")
ProductImage.create(product: prod, url: 'RR2017WomensShirtBack.png', alt_text: "Women's Race Shirt Back")
prod = Product.create(description: "Women's Cotton 2017 Race Shirt, size large", quantity: 5, price: 25)
ProductImage.create(product: prod, url: 'RR2017WomensShirtFront.jpg', alt_text: "Women's Race Shirt Front")
ProductImage.create(product: prod, url: 'RR2017WomensShirtBack.png', alt_text: "Women's Race Shirt Back")

prod = Product.create(description: "Men's Cotton 2017 Race Shirt, size medium", quantity: 10, price: 25)
ProductImage.create(product: prod, url: 'RRMainLogoMensShirtFront.png', alt_text: "Men's Race Shirt Front")
prod = Product.create(description: "Men's Cotton 2017 Race Shirt, size large", quantity: 10, price: 25)
ProductImage.create(product: prod, url: 'RRMainLogoMensShirtFront.png', alt_text: "Men's Race Shirt Front")
prod = Product.create(description: "Men's Cotton 2017 Race Shirt, size extra-large", quantity: 3, price: 25)
ProductImage.create(product: prod, url: 'RRMainLogoMensShirtFront.png', alt_text: "Men's Race Shirt Front")

prod = Product.create(description: "Women's Rattlesnake Ramble Shirt, size small", quantity: 10, price: 25)
ProductImage.create(product: prod, url: 'RRMainLogoWomensShirtFront.png', alt_text: "Women's Race Shirt Front")
ProductImage.create(product: prod, url: 'RRMainLogoWomensShirtBack.png', alt_text: "Women's Race Shirt Back")
prod = Product.create(description: "Women's Rattlesnake Ramble Shirt, size medium", quantity: 10, price: 25)
ProductImage.create(product: prod, url: 'RRMainLogoWomensShirtFront.png', alt_text: "Women's Race Shirt Front")
ProductImage.create(product: prod, url: 'RRMainLogoWomensShirtBack.png', alt_text: "Women's Race Shirt Back")
prod = Product.create(description: "Women's Rattlesnake Ramble Shirt, size large", quantity: 3, price: 25)
ProductImage.create(product: prod, url: 'RRMainLogoWomensShirtFront.png', alt_text: "Women's Race Shirt Front")
ProductImage.create(product: prod, url: 'RRMainLogoWomensShirtBack.png', alt_text: "Women's Race Shirt Back")

prod = Product.create(description: "Black, Cotton, Hooded, Uni-Sex Sweatshirt, size small", quantity: 5, price: 40)
ProductImage.create(product: prod, url: 'RattlesnakeRambleHoodie.png', alt_text: "Sweatshirt Front")
prod = Product.create(description: "Black, Cotton, Hooded, Uni-Sex Sweatshirt, size medium", quantity: 5, price: 40)
ProductImage.create(product: prod, url: 'RattlesnakeRambleHoodie.png', alt_text: "Sweatshirt Front")
prod = Product.create(description: "Black, Cotton, Hooded, Uni-Sex Sweatshirt, size large", quantity: 5, price: 40)
ProductImage.create(product: prod, url: 'RattlesnakeRambleHoodie.png', alt_text: "Sweatshirt Front")
prod = Product.create(description: "Black, Cotton, Hooded, Uni-Sex Sweatshirt, size extra-large", quantity: 3, price: 40)
ProductImage.create(product: prod, url: 'RattlesnakeRambleHoodie.png', alt_text: "Sweatshirt Front")
  