# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

races = Race.create!([
                       { name: "Rattlesnake Ramble Trail Race - Odd Years", short_name: 'Full Course', description: "A 4.25-mile Y-course that goes out-and-back on the Fowler Trail before doing the same on the Eldorado Trail." },
                       { name: "Rattlesnake Ramble Trail Race - Even Years", short_name: 'Full Course', description: "A 4.25-mile Y-course that goes out-and-back on the Eldorado Trail before doing the same on the Fowler Trail." },
                       { name: "Rattlesnake Ramble Kids Race", short_name: 'Kids Course', description: "A 1.7-mile out-and-back course on the main road through Eldorado Canyon. The Kids Race is for 12 & Under only." },
                     ])

odd_year_race = races.first
even_year_race = races[1]
current_race = even_year_race
kids_race = races.last

RaceEdition.create!(race: odd_year_race, date: "2021-09-17", default_start_time_male: "2024-09-21 7:47:00-0600", default_start_time_female: "2024-09-21 7:52:00-0600", entry_fee: 35)
current_edition = RaceEdition.create!(race: current_race, date: "2024-09-21", default_start_time_male: "2024-09-21 7:47:00-0600", default_start_time_female: "2024-09-21 7:52:00-0600", entry_fee: 35, selling_merchandise: true, merchandise_description: 'Buy a limited-edition 20th anniversary race shirt before we sell out!', merchandise_image_file_name: 'Ramble20thAnniversaryShirt.png', merchandise_price: 25)
kids_edition = RaceEdition.create!(race: kids_race, date: "2024-09-21", default_start_time_male: "2024-09-21 7:45:00-0600", default_start_time_female: "2024-09-21 7:45:00-0600", entry_fee: 15)

adult_racers = [
  Racer.create!(first_name: "Bill", last_name: "Wright", email: "bill@wwwright.com", gender: :male, birth_date: "1962-04-26", city: "Superior", state: "Colorado"),
  Racer.create!(first_name: "Sheri", last_name: "Wright", email: "sheri_wright@oracle.com", gender: :female, birth_date: "1963-12-18", city: "Superior", state: "Colorado"),
]
unpaid_racers = [
  Racer.create!(first_name: "Derek", last_name: "Wright", email: "poochito@gmail.com", gender: :male, birth_date: "1998-01-29", city: "Superior", state: "Colorado"),
  Racer.create!(first_name: "Jake", last_name: "DiSanto", email: "jake.disanto@gmail.com", gender: :male, birth_date: "1992-01-29", city: "Boulder", state: "Colorado")
]
kid_racers = [
  Racer.create!(first_name: "Jason", last_name: "Oveson", email: "jason@example.com", gender: :male, birth_date: "2014-01-01", city: "Louisville", state: "Colorado"),
  Racer.create!(first_name: "Spencer", last_name: "Oveson", email: "spencer@example.com", gender: :male, birth_date: "2014-01-01", city: "Louisville", state: "Colorado")
]

print "Unique racers created..."

bib_number = 123
adult_racers.each do |racer|
  RaceEntry.create!(racer: racer, race_edition: current_edition, bib_number: bib_number, paid: true)
  bib_number += 1
end
print "Unique racers added to current race..."

unpaid_racers.each do |racer|
  RaceEntry.create!(racer: racer, race_edition: current_edition, bib_number: bib_number, paid: false)
  bib_number += 1
end
print "Unpaid racers added to current race..."

kid_racers.each do |racer|
  RaceEntry.create!(racer: racer, race_edition: kids_edition, bib_number: bib_number, paid: true)
  bib_number += 1
end
print "Kids added to kids race..."

# More racers for testing checkin printout sheet
40.times do |i|
  last_name = "Smith" + i.to_s
  first_name = "John" + i.to_s
  email = first_name + "@example.com"
  bib_number = i + 1
  racer = Racer.create!(first_name: first_name, last_name: last_name, email: email, gender: :male, birth_date: "1990-01-01", city: "Anytown", state: "Colorado")
  RaceEntry.create!(racer: racer, race_edition: current_edition, bib_number: bib_number, paid: true)
end
print "Automatic racers created and added to current race..."

# 2017 Merchandise

Product.all.each do |prod|
  prod.destroy
end

prod = Product.create!(description: "Men's Cotton 2017 Race Shirt, size medium", quantity: 10, price: 25)
ProductImage.create!(product: prod, url: 'RR2017MensShirtFront.png', alt_text: "Men's Race Shirt Front")
prod = Product.create!(description: "Men's Cotton 2017 Race Shirt, size large", quantity: 10, price: 25)
ProductImage.create!(product: prod, url: 'RR2017MensShirtFront.png', alt_text: "Men's Race Shirt Front")
prod = Product.create!(description: "Men's Cotton 2017 Race Shirt, size extra-large", quantity: 3, price: 25)
ProductImage.create!(product: prod, url: 'RR2017MensShirtFront.png', alt_text: "Men's Race Shirt Front")

prod = Product.create!(description: "Women's Cotton 2017 Race Shirt, size small", quantity: 10, price: 25)
ProductImage.create!(product: prod, url: 'RR2017WomensShirtFront.png', alt_text: "Women's Race Shirt Front")
ProductImage.create!(product: prod, url: 'RR2017WomensShirtBack.png', alt_text: "Women's Race Shirt Back")
prod = Product.create!(description: "Women's Cotton 2017 Race Shirt, size medium", quantity: 10, price: 25)
ProductImage.create!(product: prod, url: 'RR2017WomensShirtFront.png', alt_text: "Women's Race Shirt Front")
ProductImage.create!(product: prod, url: 'RR2017WomensShirtBack.png', alt_text: "Women's Race Shirt Back")
prod = Product.create!(description: "Women's Cotton 2017 Race Shirt, size large", quantity: 5, price: 25)
ProductImage.create!(product: prod, url: 'RR2017WomensShirtFront.png', alt_text: "Women's Race Shirt Front")
ProductImage.create!(product: prod, url: 'RR2017WomensShirtBack.png', alt_text: "Women's Race Shirt Back")

prod = Product.create!(description: "Men's Cotton 2017 Race Shirt, size medium", quantity: 10, price: 25)
ProductImage.create!(product: prod, url: 'RRMainLogoMensShirtFront.png', alt_text: "Men's Race Shirt Front")
prod = Product.create!(description: "Men's Cotton 2017 Race Shirt, size large", quantity: 10, price: 25)
ProductImage.create!(product: prod, url: 'RRMainLogoMensShirtFront.png', alt_text: "Men's Race Shirt Front")
prod = Product.create!(description: "Men's Cotton 2017 Race Shirt, size extra-large", quantity: 3, price: 25)
ProductImage.create!(product: prod, url: 'RRMainLogoMensShirtFront.png', alt_text: "Men's Race Shirt Front")

prod = Product.create!(description: "Women's Rattlesnake Ramble Shirt, size small", quantity: 10, price: 25)
ProductImage.create!(product: prod, url: 'RRMainLogoWomensShirtFront.png', alt_text: "Women's Race Shirt Front")
ProductImage.create!(product: prod, url: 'RRMainLogoWomensShirtBack.png', alt_text: "Women's Race Shirt Back")
prod = Product.create!(description: "Women's Rattlesnake Ramble Shirt, size medium", quantity: 10, price: 25)
ProductImage.create!(product: prod, url: 'RRMainLogoWomensShirtFront.png', alt_text: "Women's Race Shirt Front")
ProductImage.create!(product: prod, url: 'RRMainLogoWomensShirtBack.png', alt_text: "Women's Race Shirt Back")
prod = Product.create!(description: "Women's Rattlesnake Ramble Shirt, size large", quantity: 3, price: 25)
ProductImage.create!(product: prod, url: 'RRMainLogoWomensShirtFront.png', alt_text: "Women's Race Shirt Front")
ProductImage.create!(product: prod, url: 'RRMainLogoWomensShirtBack.png', alt_text: "Women's Race Shirt Back")

prod = Product.create!(description: "Black, Cotton, Hooded, Uni-Sex Sweatshirt, size small", quantity: 5, price: 40)
ProductImage.create!(product: prod, url: 'RattlesnakeRambleHoodie.png', alt_text: "Sweatshirt Front")
prod = Product.create!(description: "Black, Cotton, Hooded, Uni-Sex Sweatshirt, size medium", quantity: 5, price: 40)
ProductImage.create!(product: prod, url: 'RattlesnakeRambleHoodie.png', alt_text: "Sweatshirt Front")
prod = Product.create!(description: "Black, Cotton, Hooded, Uni-Sex Sweatshirt, size large", quantity: 5, price: 40)
ProductImage.create!(product: prod, url: 'RattlesnakeRambleHoodie.png', alt_text: "Sweatshirt Front")
prod = Product.create!(description: "Black, Cotton, Hooded, Uni-Sex Sweatshirt, size extra-large", quantity: 3, price: 40)
ProductImage.create!(product: prod, url: 'RattlesnakeRambleHoodie.png', alt_text: "Sweatshirt Front")

User.create!(email: 'admin@example.com', password: 'password', admin: true)
